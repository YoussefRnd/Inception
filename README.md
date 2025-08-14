# Inception

This project sets up a complete web server environment using Docker. It includes a WordPress installation with a MariaDB database, an Nginx web server, and several bonus services.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   [Docker](https://docs.docker.com/get-docker/)
*   [Docker Compose](https://docs.docker.com/compose/install/)

### Setup

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/inception.git
    cd inception
    ```

2.  **Create the `.env` file:**

    Copy the example `.env` file and modify it as needed.

    ```bash
    cp srcs/.env.example srcs/.env
    ```

3.  **Create the secret files:**

    Create the following files in the `srcs/secrets/` directory with your desired passwords:

    ```bash
    echo "your_db_root_password" > srcs/secrets/db_root_password.txt
    echo "your_db_user_password" > srcs/secrets/db_user_password.txt
    echo "your_wp_admin_password" > srcs/secrets/wp_admin_password.txt
    echo "your_wp_secondary_password" > srcs/secrets/wp_secondary_password.txt
    echo "your_ftp_password" > srcs/secrets/ftp_password.txt
    ```

4.  **Build and run the services:**

    Use the `make` command to build and start all the services.

    ```bash
    make all
    ```

## Usage

This project uses a `Makefile` for easy management of the Docker containers.

*   `make all`: Builds and starts all services in detached mode.
*   `make clean`: Stops and removes all services.
*   `make fclean`: Stops and removes all services, deletes the data volumes, and prunes the Docker system.
*   `make re`: A shortcut for `make fclean all`.

## Services

The following services are included in this project:

| Service         | Port | URL / Access                                    | Description                                     |
| --------------- | ---- | ----------------------------------------------- | ----------------------------------------------- |
| **Nginx**       | 443  | `https://<your-domain-name>`                    | The main web server, serving the WordPress site. |
| **WordPress**   | -    | `https://<your-domain-name>`                    | The WordPress CMS.                              |
| **MariaDB**     | -    | -                                               | The database for WordPress.                     |
| **Adminer**     | 8080 | `http://localhost:8080`                         | A database management tool.                     |
| **FTP**         | 21   | `ftp://<your-domain-name>`                      | An FTP server to transfer files to WordPress.   |
| **Static Site** | 80   | `http://localhost`                              | A simple static website.                        |
| **Grafana**     | 3000 | `http://localhost:3000`                         | A monitoring and observability platform.        |
| **Redis**       | -    | -                                               | An in-memory data structure store.              |

## Configuration

### Environment Variables

The environment variables are defined in the `srcs/.env` file. These variables are used to configure the services.

### Secrets

This project uses Docker Secrets to manage sensitive information like passwords. The secret files are located in the `srcs/secrets/` directory.

## Data

The persistent data for the services is stored in the following directories on your host machine:

*   **MariaDB:** `~/data/mariadb`
*   **WordPress:** `~/data/wordpress`
*   **Grafana:** `~/data/grafana`
