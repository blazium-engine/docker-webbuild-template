# Docker WebBuild Template

This repository provides a template for deploying web-exported game builds of the Blazium Game Engine as Discord Embedded Applications. It includes all the necessary configurations and scripts to meet Discord's embedding restrictions, such as the requirement for `.proxy` in URIs for loading assets. The setup simplifies deployment to Docker and ensures compatibility with Discord's embedded environment.

---

## Features

- **Dockerized Deployment**: Build, tag, and push Docker images using a `Makefile` with a single command.
- **Discord Embedding Support**: Includes Nginx configurations to handle `.proxy` URIs for Discord compatibility.
- **Environment Variable Integration**: Easy customization through a `.env` file for project-specific settings.
- **Pre-configured Directory Structure**:
  - `Dockerfile`: Defines the Docker image for the project.
  - `scripts/`: Contains reusable Bash scripts for deployment and management.
  - `nginx/`: Holds the Nginx configuration file (`nginx.conf`).
  - `static/`: Drop your Blazium web-exported game builds here for inclusion in the Docker image.
  - `Makefile`: Automates deployment tasks.

---

## Addition: 2/22/2025

### Support for YouTube Playables

YouTube Playables requires that the initial game bundle be **less than 15 MiB**. To meet this requirement, **WebAssembly (WASM) files must be compressed** before serving. This configuration enables **gzip compression** for `.wasm` files and ensures that browsers capable of handling gzip receive the compressed `.wasm.gz` file instead of the uncompressed version.

### How It Works
- If the browser **supports gzip encoding**, Nginx serves the precompressed `.wasm.gz` file **as if it were** a `.wasm` file.
- If the browser **does not support gzip**, Nginx falls back to serving the original `.wasm` file.
- This behavior helps ensure compatibility while keeping the initial bundle size under the **15 MiB limit** required by YouTube Playables.

### Implementation Details
- Nginx detects the client's `Accept-Encoding` header.
- If gzip is supported, `.wasm.gz` is served with the correct **`Content-Type: application/wasm`** and **`Content-Encoding: gzip`** headers.
- The configuration automatically rewrites requests for `.wasm` to `.wasm.gz` when applicable.

This ensures that **web-exported games** can be deployed on **YouTube Playables** while remaining within the required file size constraints.

---

## Directory Structure

```plaintext
.
├── Dockerfile              # Defines the Docker image
├── scripts/                # Contains Bash scripts
│   ├── deploy.sh           # Deploys the Docker image
│   └── credits.sh          # Exports author and project metadata
├── nginx/                  # Contains Nginx configuration files
│   └── nginx.conf          # Nginx configuration for Discord Embedded Applications
├── static/                 # Drop your exported Blazium web builds here
│   └── .keep               # Placeholder file to keep the directory in Git
├── Makefile                # Automates Docker build and deployment
├── .env                    # Environment variables file
└── README.md               # Project documentation
```

---

## Requirements

- Docker installed on your system.
- A `.env` file with the following variables:

```plaintext
PROJECT_NAME=hangman                   # The name of your project
DOCKER_REGISTRY=registry.digitalocean.com  # Docker registry URL
REGISTRY_PATH=blazium                  # Registry path for the project
TAG=latest                             # Image tag (default: latest)
```

---

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/blazium-engine/docker-webbuild-template.git
cd docker-webbuild-template
```

### 2. Create the `.env` File
Create a `.env` file in the root directory and set the environment variables:
```plaintext
PROJECT_NAME=hangman
DOCKER_REGISTRY=registry.digitalocean.com
REGISTRY_PATH=blazium
TAG=latest
```

### 3. Drop Your Web Build into the `static/` Folder
Export your Blazium game build to a local directory, then copy all the exported files into the `static/` folder in this repository:
```bash
cp -r /path/to/your/blazium-build/* static/
```

- **Important**: The `.keep` file in the `static/` folder is there to ensure the folder is tracked in Git. It will **not** be included in the Docker build.

During the build process, all files in the `static/` folder will be copied into the Docker image under `/usr/share/nginx/html`.

### 4. Deploy the Project
Run the following command to build, tag, and push the Docker image:
```bash
make deploy-docker
```

This command uses the `deploy.sh` script located in the `scripts/` folder, which reads the `.env` file and handles the deployment process.

---

## Nginx Configuration

The `nginx/nginx.conf` file is pre-configured to support `.proxy` URIs required by Discord Embedded Applications. Key features of the configuration:
- Serves assets from the `/usr/share/nginx/html` directory.
- Ensures compatibility with Discord's restrictions through the `.proxy` location block.
- Includes CORS headers:
  ```nginx
  add_header Cross-Origin-Opener-Policy "same-origin" always;
  add_header Cross-Origin-Embedder-Policy "require-corp" always;
  ```

---

## Author

- **Name**: Randolph William Aarseth II  
- **Email**: randolph@divine.games  
- **Organization**: Divine Games  

---

## Contributing

Feel free to fork the repository and submit pull requests to improve the template. Contributions are welcome!

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Acknowledgments

This template is designed for deploying Blazium Game Engine web builds and ensuring compliance with Discord's embedding requirements. Special thanks to the Divine Games team for their efforts in game development and deployment optimization.