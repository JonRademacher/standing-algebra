FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl git ca-certificates build-essential && rm -rf /var/lib/apt/lists/*
RUN useradd -m solver
USER solver
ENV PATH="/home/solver/.elan/bin:/home/solver/.local/bin:$PATH"
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
WORKDIR /opt/sigmasolve
COPY --chown=solver:solver . .
RUN python -m pip install --user -e ".[dev,research]"
# Project-specific lean-toolchain files take precedence at runtime.
RUN elan toolchain install stable && elan default stable
ENTRYPOINT ["sigmasolve"]
