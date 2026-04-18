import random
import statistics

# -----------------------------
# Environment
# -----------------------------
# True objective is hidden.
# Agent only sees proxy metric.

class Environment:
    def __init__(self):
        self.state = 0

    def step(self, action):
        # Action pushes system state
        self.state += action

        # TRUE objective (unknown to agent)
        true_value = - (self.state ** 2) + 50  # peak at state = 0

        # PROXY metric (what agent sees)
        proxy = true_value + (self.state * 2)  # becomes misleading as state drifts

        # Add noise
        proxy += random.gauss(0, 2)

        return proxy, true_value


# -----------------------------
# Agents
# -----------------------------

class NaiveAgent:
    # Always pushes in direction that increases proxy
    def choose(self):
        return 1  # blindly push forward


class RobustAgent:
    def __init__(self):
        self.history = []

    def choose(self):
        # If instability detected, reverse
        if len(self.history) > 5:
            recent = self.history[-5:]
            variance = statistics.variance(recent)

            # Constraint logic:
            # High variance = unreliable signal → stop pushing
            if variance > 10:
                return -1

        return 1

    def observe(self, proxy):
        self.history.append(proxy)


# -----------------------------
# Simulation
# -----------------------------

def run_episode(agent, steps=50, use_constraint=False):
    env = Environment()
    proxy_history = []
    true_history = []

    for _ in range(steps):
        action = agent.choose()
        proxy, true = env.step(action)

        proxy_history.append(proxy)
        true_history.append(true)

        if use_constraint:
            agent.observe(proxy)

    return proxy_history, true_history


# -----------------------------
# Experiment
# -----------------------------

def run_experiment(trials=100):
    naive_true_totals = []
    robust_true_totals = []

    for _ in range(trials):
        # Naive
        naive = NaiveAgent()
        _, naive_true = run_episode(naive)
        naive_true_totals.append(sum(naive_true))

        # Robust
        robust = RobustAgent()
        _, robust_true = run_episode(robust, use_constraint=True)
        robust_true_totals.append(sum(robust_true))

    return naive_true_totals, robust_true_totals


# -----------------------------
# Reporting
# -----------------------------

def summarize(label, data):
    print(f"\n{label}")
    print(f"Mean: {round(statistics.mean(data), 2)}")
    print(f"Min:  {round(min(data), 2)}")
    print(f"Max:  {round(max(data), 2)}")


def main():
    random.seed(42)

    naive, robust = run_experiment()

    print("\n=== GOODHART DRIFT DEMO ===")

    summarize("Naive Agent (proxy maximization)", naive)
    summarize("Robust Agent (constraint-aware)", robust)

    wins = sum(1 for n, r in zip(naive, robust) if r > n)
    print(f"\nRobust wins {wins} / {len(naive)} trials")

    print("\n--- Explanation ---")
    print("Naive agent maximizes proxy and drifts away from true optimum.")
    print("Robust agent detects instability (variance) and corrects course.")
    print("This demonstrates Goodhart's Law: optimizing proxy breaks alignment.")


if __name__ == "__main__":
    main()
