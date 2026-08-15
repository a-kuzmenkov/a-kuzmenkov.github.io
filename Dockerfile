# Multi-stage build for Hugo Blox development environment
FROM node:20-bookworm

# Install Hugo (extended version required for Sass/SCSS) and Go directly without apt-get update
RUN apt-get update && apt-get install -y --no-install-recommends curl tar wget git && \
    # Install Hugo 0.165.0 to match the project's expected version
    curl -L https://github.com/gohugoio/hugo/releases/download/v0.165.0/hugo_extended_0.165.0_linux-amd64.tar.gz | tar xz -C /usr/local/bin && \
    # Install Go 1.21 (needed for module resolution)
    wget -O /tmp/go1.21.0.linux-amd64.tar.gz https://go.dev/dl/go1.21.0.linux-amd64.tar.gz && \
    tar -xzf /tmp/go1.21.0.linux-amd64.tar.gz -C /usr/local && \
    rm -f /tmp/go1.21.0.linux-amd64.tar.gz && \
    apt-get purge -y curl wget && apt-get autoremove -y && apt-get clean

# Set Go environment variables
ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Install pnpm globally
RUN corepack enable && corepack prepare pnpm@10.14.0 --activate

# Set working directory
WORKDIR /app

# Copy project files first (before installing dependencies)
COPY . .

# Install frontend dependencies
RUN pnpm install --frozen-lockfile

# Expose Hugo dev server port
EXPOSE 1313

# Development entrypoint with hot-reload disabled (for cleaner debug output) 
CMD ["hugo", "server", "--ignoreVendorPaths", "--disableFastRender", "--bind", "0.0.0.0", "--port", "1313", "--noHTTPCache", "--minify", "--enableGitInfo"]