import random
import statistics

# -----------------------------
# Environment
# -----------------------------

class Environment:
    def __init__(self):
        self.state = 0

    def step(self, action):
        self.state += action

        true_value = - (self.state ** 2) + 50

        # Proxy drifts as state increases
        proxy = true_value + (self.state * 2)

        proxy += random.gauss(0, 2)

        return proxy, true_value


# -----------------------------
# Utility
# -----------------------------

def correlation(xs, ys):
    if len(xs) < 2:
        return 1.0
    try:
        return statistics.correlation(xs, ys)
    except:
        return 0


# -----------------------------
# Agents
# -----------------------------

class NaiveAgent:
    def choose(self):
        return 1


class ConstraintAgent:
    def __init__(self):
        self.proxy_hist = []
        self.true_hist = []  # only for analysis (not used in decisions)

    def choose(self):
        # Not enough data yet → explore
        if len(self.proxy_hist) < 10:
            return 1

        # Estimate reliability via proxy self-consistency
        recent = self.proxy_hist[-10:]
        trend = recent[-1] - recent[0]
        variance = statistics.variance(recent)

        # Adaptive constraint:
        # If signal is unstable OR growth is suspiciously fast → stop pushing
        if variance > abs(trend):
            return -1

        return 1

    def observe(self, proxy, true):
        self.proxy_hist.append(proxy)
        self.true_hist.append(true)


# -----------------------------
# Single Run (for visualization)
# -----------------------------

def run_episode(agent, steps=60, track=False):
    env = Environment()

    proxy_hist = []
    true_hist = []
    actions = []

    for t in range(steps):
        action = agent.choose()
        proxy, true = env.step(action)

        proxy_hist.append(proxy)
        true_hist.append(true)
        actions.append(action)

        if hasattr(agent, "observe"):
            agent.observe(proxy, true)

        # Live debug
        if track and t % 10 == 0 and t > 0:
            corr = correlation(proxy_hist[-10:], true_hist[-10:])
            print(f"Step {t}: state={env.state:.2f}, corr={round(corr,2)}")

    return proxy_hist, true_hist, actions


# -----------------------------
# Experiment
# -----------------------------

def run_experiment(trials=200):
    naive_scores = []
    robust_scores = []

    for _ in range(trials):
        # Naive
        n_agent = NaiveAgent()
        _, n_true, _ = run_episode(n_agent)
        naive_scores.append(sum(n_true))

        # Constraint
        r_agent = ConstraintAgent()
        _, r_true, _ = run_episode(r_agent)
        robust_scores.append(sum(r_true))

    return naive_scores, robust_scores


# -----------------------------
# Reporting
# -----------------------------

def summarize(name, data):
    print(f"\n{name}")
    print(f"Mean: {round(statistics.mean(data),2)}")
    print(f"Min:  {round(min(data),2)}")
    print(f"Max:  {round(max(data),2)}")


def main():
    random.seed(42)

    print("\n=== LIVE GOODHART DEMO ===")

    print("\n--- Single Run (Naive) ---")
    run_episode(NaiveAgent(), track=True)

    print("\n--- Single Run (Constraint Agent) ---")
    run_episode(ConstraintAgent(), track=True)

    naive, robust = run_experiment()

    print("\n=== AGGREGATE RESULTS ===")

    summarize("Naive", naive)
    summarize("Constraint", robust)

    wins = sum(1 for n, r in zip(naive, robust) if r > n)
    print(f"\nConstraint wins {wins}/{len(naive)} trials")

    print("\n--- Interpretation ---")
    print("Naive agent follows proxy into drift.")
    print("Constraint agent reacts to instability and avoids divergence.")
    print("No access to true objective is used for control.")


if __name__ == "__main__":
    main()
