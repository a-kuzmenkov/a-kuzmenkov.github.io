# How to run 

## First run after clone

```
npm i 
hugo server
```

## Debug mode with Docker (recommended for development)

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) v2+

### Quick start

```bash
# Build and start the dev server (foreground mode)
docker compose up

# Start in detached (background) mode
docker compose up -d

# Stop the server
docker compose down
```

After starting, open **http://localhost:1313** in your browser.

### Hot-reload support

The Docker setup mounts the following directories as volumes, so any file changes are reflected instantly:

| Host directory | Container path | Purpose |
|---|---|---|
| `content/` | `/app/content` | Page content (Markdown) |
| `config/` | `/app/config` | Hugo configuration |
| `layouts/` | `/app/layouts` | Custom templates |
| `assets/` | `/app/assets` | Static assets, images, authors |
| `data/` | `/app/data` | Data files (authors, etc.) |
| `static/` | `/app/static` | Static files served as-is |

### Useful commands

```bash
# View live logs
docker compose logs -f academic-cv

# Rebuild after changing Dockerfile
docker compose up --build

# Run Hugo commands inside the container
docker compose exec academic-cv hugo version

# Install new npm packages while running
docker compose exec academic-cv pnpm add <package-name>
```

### Configuration details

- **Hugo version**: 0.162.0 (extended)
- **Dev server flag**: `--disableFastRender` for full rebuilds during development
- **Port**: 1313 (mapped to host)
- **Debug output**: `HUGO_DISABLEFASTRENDER=1` ensures complete build logs
