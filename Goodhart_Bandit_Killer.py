
#!/usr/bin/env python3
"""
goodhart_bandit_killer_demo.py

A self-contained demo of Goodhart drift in a learning loop.

Structure:
1) A hidden environment state ("pressure") rises when the learner over-selects the aggressive arm.
2) The aggressive arm makes the proxy reward look better as pressure rises, while true reward falls.
3) A naive learner trains on proxy reward only.
4) A guarded learner trains on the same proxy reward stream, but applies a live constraint:
   uncertainty penalty + over-concentration penalty.

The result is a visible separation:
- naive policy tends to over-commit to the proxy-gaming arm
- guarded policy stays more balanced and preserves true reward

No third-party dependencies.
"""

from __future__ import annotations

import argparse
import copy
import math
import random
import statistics
from collections import defaultdict, deque
from dataclasses import dataclass, field
from typing import Deque, Dict, List, Tuple

ARMS = ("safe", "balanced", "aggressive")


def clamp(x: float, lo: float, hi: float) -> float:
    return max(lo, min(hi, x))


class DriftingProxyEnv:
    """
    Hidden pressure rises with aggressive selection.
    The proxy rewards increasingly favor aggressive selection even as true reward degrades.
    """

    def __init__(self) -> None:
        self.pressure = 0.15

    def step(self, action: str) -> Tuple[float, float, float]:
        if action not in ARMS:
            raise ValueError(f"Unknown action: {action}")

        pressure_delta = {
            "safe": -0.08,
            "balanced": 0.03,
            "aggressive": 0.11,
        }[action]
        self.pressure = clamp(self.pressure + pressure_delta + random.gauss(0.0, 0.01), 0.0, 1.5)

        # True reward: balanced is the sane long-run choice.
        true_base = {
            "safe": 5.0,
            "balanced": 6.8,
            "aggressive": 7.9,
        }[action]
        true_pressure_penalty = {
            "safe": 0.4,
            "balanced": 0.9,
            "aggressive": 6.0,
        }[action]
        true_noise_sd = {
            "safe": 0.18,
            "balanced": 0.28,
            "aggressive": 0.42,
        }[action]

        true_reward = (
            true_base
            - true_pressure_penalty * (self.pressure ** 2)
            + random.gauss(0.0, true_noise_sd)
        )

        # Proxy reward: aggressive gets more attractive as pressure rises.
        proxy_base = {
            "safe": 5.0,
            "balanced": 6.2,
            "aggressive": 6.9,
        }[action]
        proxy_pressure_boost = {
            "safe": 0.20,
            "balanced": 1.00,
            "aggressive": 3.10,
        }[action]
        proxy_noise_sd = {
            "safe": 0.25,
            "balanced": 0.40,
            "aggressive": 0.60 + 0.22 * self.pressure,
        }[action]

        proxy_reward = (
            proxy_base
            + proxy_pressure_boost * self.pressure
            + random.gauss(0.0, proxy_noise_sd)
        )

        return proxy_reward, true_reward, self.pressure


@dataclass
class AgentState:
    q: Dict[str, float] = field(default_factory=lambda: defaultdict(lambda: 6.0))
    proxy_history: Dict[str, Deque[float]] = field(
        default_factory=lambda: defaultdict(lambda: deque(maxlen=30))
    )
    recent_actions: Deque[str] = field(default_factory=lambda: deque(maxlen=30))


class QLearner:
    def __init__(
        self,
        name: str,
        epsilon: float = 0.12,
        alpha: float = 0.14,
        guard_beta: float = 0.35,
        guard_gamma: float = 18.0,
        use_guard: bool = False,
    ) -> None:
        self.name = name
        self.epsilon = epsilon
        self.alpha = alpha
        self.guard_beta = guard_beta
        self.guard_gamma = guard_gamma
        self.use_guard = use_guard
        self.state = AgentState()

    def clone(self) -> "QLearner":
        return copy.deepcopy(self)

    def _recent_share(self, arm: str) -> float:
        if not self.state.recent_actions:
            return 0.0
        return sum(1 for a in self.state.recent_actions if a == arm) / len(self.state.recent_actions)

    def _arm_uncertainty(self, arm: str) -> float:
        hist = self.state.proxy_history[arm]
        if len(hist) < 2:
            return 1.0
        return statistics.pstdev(hist)

    def _guard_penalty(self, arm: str) -> float:
        if not self.use_guard:
            return 0.0

        uncertainty = self._arm_uncertainty(arm)
        concentration = self._recent_share(arm)

        # Soft penalty used when no arm crosses the hard constraint.
        return self.guard_beta * uncertainty + self.guard_gamma * concentration

    def _blocked(self, arm: str) -> bool:
        if not self.use_guard:
            return False
        uncertainty = self._arm_uncertainty(arm)
        concentration = self._recent_share(arm)
        return concentration >= 0.30 and uncertainty >= 0.80

    def select_action(self, greedy: bool = False) -> str:
        if (not greedy) and random.random() < self.epsilon:
            return random.choice(ARMS)

        if self.use_guard:
            unblocked = [arm for arm in ARMS if not self._blocked(arm)]
            if unblocked:
                scored = {arm: self.state.q[arm] - self._guard_penalty(arm) for arm in unblocked}
            else:
                # If everything is risky, pick the least risky arm instead of forcing the worst proxy score.
                scored = {
                    arm: -(
                        1.5 * self._arm_uncertainty(arm)
                        + 3.0 * self._recent_share(arm)
                    )
                    for arm in ARMS
                }
        else:
            scored = {arm: self.state.q[arm] for arm in ARMS}

        best = max(scored.values())
        best_arms = [arm for arm, score in scored.items() if math.isclose(score, best, rel_tol=1e-12, abs_tol=1e-12)]
        return random.choice(best_arms)

    def observe(self, arm: str, proxy_reward: float) -> None:
        self.state.q[arm] += self.alpha * (proxy_reward - self.state.q[arm])
        self.state.proxy_history[arm].append(proxy_reward)
        self.state.recent_actions.append(arm)

    def snapshot_scores(self) -> Dict[str, float]:
        return {arm: self.state.q[arm] - self._guard_penalty(arm) for arm in ARMS}


def run_episode(agent: QLearner, steps: int, greedy: bool = False, learn: bool = True) -> Dict[str, float]:
    env = DriftingProxyEnv()
    proxy_total = 0.0
    true_total = 0.0
    pressure_total = 0.0
    counts = defaultdict(int)

    for _ in range(steps):
        action = agent.select_action(greedy=greedy)
        proxy_reward, true_reward, pressure = env.step(action)

        if learn:
            agent.observe(action, proxy_reward)

        proxy_total += proxy_reward
        true_total += true_reward
        pressure_total += pressure
        counts[action] += 1

    return {
        "proxy_total": proxy_total,
        "true_total": true_total,
        "avg_pressure": pressure_total / steps,
        "safe_count": counts["safe"],
        "balanced_count": counts["balanced"],
        "aggressive_count": counts["aggressive"],
    }


def train(agent: QLearner, episodes: int, steps: int, seed: int) -> None:
    for ep in range(episodes):
        random.seed(seed + 10000 + ep)
        run_episode(agent, steps=steps, greedy=False, learn=True)


def evaluate(agent: QLearner, episodes: int, steps: int, seed: int) -> List[Dict[str, float]]:
    rows = []
    for ep in range(episodes):
        random.seed(seed + 20000 + ep)
        rows.append(run_episode(agent.clone(), steps=steps, greedy=True, learn=False))
    return rows


def summarize(values: List[float]) -> Dict[str, float]:
    return {
        "mean": statistics.mean(values),
        "stdev": statistics.pstdev(values) if len(values) > 1 else 0.0,
        "min": min(values),
        "max": max(values),
    }


def pct(n: int, d: int) -> float:
    return 100.0 * n / d if d else 0.0


def print_eval_summary(label: str, rows: List[Dict[str, float]]) -> None:
    true_scores = [r["true_total"] for r in rows]
    proxy_scores = [r["proxy_total"] for r in rows]
    pressures = [r["avg_pressure"] for r in rows]
    aggr_share = [r["aggressive_count"] / (r["safe_count"] + r["balanced_count"] + r["aggressive_count"]) for r in rows]

    print(f"\n=== {label} ===")
    print(f"true total   : {summarize(true_scores)}")
    print(f"proxy total  : {summarize(proxy_scores)}")
    print(f"avg pressure : {summarize(pressures)}")
    print(f"aggr share   : {summarize(aggr_share)}")


def print_policy(agent: QLearner, label: str) -> None:
    snap = agent.snapshot_scores()
    print(f"\n{label} policy scores:")
    print(f"safe      : q={agent.state.q['safe']:.2f}, adjusted={snap['safe']:.2f}")
    print(f"balanced  : q={agent.state.q['balanced']:.2f}, adjusted={snap['balanced']:.2f}")
    print(f"aggressive: q={agent.state.q['aggressive']:.2f}, adjusted={snap['aggressive']:.2f}")


def trace_episode(agent: QLearner, steps: int, seed: int, greedy: bool, title: str) -> None:
    random.seed(seed)
    env = DriftingProxyEnv()
    print(f"\n--- {title} ---")
    for t in range(1, steps + 1):
        action = agent.select_action(greedy=greedy)
        proxy_reward, true_reward, pressure = env.step(action)
        agent.observe(action, proxy_reward)
        if t == 1 or t % 20 == 0 or t == steps:
            scores = agent.snapshot_scores()
            print(
                f"t={t:03d}  action={action:10s}  pressure={pressure:5.2f}  "
                f"proxy={proxy_reward:6.2f}  true={true_reward:6.2f}  "
                f"scores=[safe:{scores['safe']:.2f}, balanced:{scores['balanced']:.2f}, aggressive:{scores['aggressive']:.2f}]"
            )


def main() -> None:
    parser = argparse.ArgumentParser(description="Goodhart drift demo with a live constraint layer.")
    parser.add_argument("--episodes", type=int, default=250, help="Training episodes per agent.")
    parser.add_argument("--steps", type=int, default=80, help="Steps per episode.")
    parser.add_argument("--seed", type=int, default=42, help="Random seed.")
    args = parser.parse_args()

    random.seed(args.seed)

    naive = QLearner("naive", use_guard=False)
    guarded = QLearner("guarded", use_guard=True)

    print("\nGOODHART DRIFT / LIVE CONSTRAINT DEMO")
    print("Naive learner trains on proxy reward only.")
    print("Guarded learner trains on the same proxy reward stream plus a live uncertainty + concentration constraint.")
    print("The hidden environment state is not shown to the agents.\n")

    # A short pre-training trace so people can see the same starting point.
    trace_episode(naive.clone(), steps=40, seed=args.seed, greedy=False, title="naive: pre-training trace")
    trace_episode(guarded.clone(), steps=40, seed=args.seed, greedy=False, title="guarded: pre-training trace")

    # Train both agents on the same sequence family.
    train(naive, episodes=args.episodes, steps=args.steps, seed=args.seed)
    train(guarded, episodes=args.episodes, steps=args.steps, seed=args.seed)

    print_policy(naive, "naive")
    print_policy(guarded, "guarded")

    # Post-training greedy traces show the learned policy in action.
    trace_episode(naive.clone(), steps=40, seed=args.seed + 1, greedy=True, title="naive: post-training greedy trace")
    trace_episode(guarded.clone(), steps=40, seed=args.seed + 1, greedy=True, title="guarded: post-training greedy trace")

    # Evaluate on fresh episodes.
    naive_rows = evaluate(naive, episodes=120, steps=args.steps, seed=args.seed)
    guarded_rows = evaluate(guarded, episodes=120, steps=args.steps, seed=args.seed)

    print_eval_summary("NAIVE", naive_rows)
    print_eval_summary("GUARDED", guarded_rows)

    naive_true = [r["true_total"] for r in naive_rows]
    guarded_true = [r["true_total"] for r in guarded_rows]
    naive_proxy = [r["proxy_total"] for r in naive_rows]
    guarded_proxy = [r["proxy_total"] for r in guarded_rows]

    guard_wins = sum(1 for n, g in zip(naive_true, guarded_true) if g > n)
    naive_proxy_wins = sum(1 for n, g in zip(naive_proxy, guarded_proxy) if n > g)

    print("\nHeadline result:")
    print(f"Guarded wins on true reward in {guard_wins}/120 episodes ({pct(guard_wins, 120):.1f}%).")
    print(f"Naive has higher proxy total in {naive_proxy_wins}/120 episodes ({pct(naive_proxy_wins, 120):.1f}%).")

    print("\nInterpretation:")
    print("- The naive learner discovers the proxy-shaped aggressive arm and over-commits to it.")
    print("- That raises hidden pressure, so true reward slides even while the proxy keeps looking good.")
    print("- The guarded learner applies a live constraint on uncertainty and over-concentration, which dampens Goodhart drift.")
    print("- The guard never reads the true reward during action selection; it only uses the same live proxy stream and its own history.")


if __name__ == "__main__":
    main()
