FROM debian:bullseye-slim

# Install necessary tools (Sysbench and PostgreSQL client)
RUN apt-get update && apt-get install -y \
    sysbench \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Add sysbench Lua scripts
COPY ./mnt /mnt
