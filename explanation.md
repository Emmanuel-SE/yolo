# Web Setup 

This document outlines the setup process for a web application using Docker. The setup involves building a Docker image for the application based on a multi-stage Dockerfile, which incorporates separate stages for the backend and client components of the application.

## Dockerfile Overview

The Dockerfile provided in this project employs multi-stage builds to optimize the size of the final Docker image. It consists of the following stages:

### Backend Stage
- **Base Image**: Utilizes the official Node.js Docker image tagged `18-alpine`.
- **Work Directory**: Sets the working directory for the backend component of the application.
- **Copy Files**: Copies the `package.json` and `package-lock.json` files into the container.
- **Dependency Installation**: Installs production dependencies using npm.
- **Copy Application Code**: Copies the backend application code into the container.

### Client Stage
- **Base Image**: Utilizes the same Node.js Docker image tagged `18-alpine`.
- **Work Directory**: Sets the working directory for the client component of the application.
- **Copy Files**: Copies the `package.json` and `package-lock.json` files into the container.
- **Dependency Installation**: Installs production dependencies using npm.
- **Copy Application Code**: Copies the client application code into the container.

### Final Production Stage
- **Base Image**: Uses the same Node.js Docker image tagged `18-alpine`.
- **Work Directory**: Sets the working directory for the final production image.
- **Copy Files from Previous Stages**: Copies the built client and backend code from their respective stages into the final production image.
- **Expose Ports**: Exposes ports 3000 for client ui acccess and 5001 for backend access from client requests.
- **Command**: Specifies the command to run when the container starts, which in this case is `npm dev` on the root of the backend folder

## Additional Details

- **Optimization**: By using multi-stage builds, unnecessary dependencies and development-related files are not included in the final production image, resulting in a smaller image size and improved security.
- **Port Configuration**: Ensure that the ports exposed in the Dockerfile match the ports your application listens on and that they are appropriately configured in any networking setups.
- **Image versioning**: We can use date and time of build as away of keeping trak of image version here is the format
*v<year><month><day><hour>*


By following this setup process and considering the additional details provided, you can effectively containerize your web application using Docker, making it more portable, scalable, and easier to manage across different environments.


## Database Setup

For the database setup, we will configure both a local development environment and a production environment using MongoDB.

### Local Development Setup

For the local development environment, we will:

- **Use Official MongoDB Image**: Pull the latest official MongoDB image from Docker Hub to set up the database.
- **Mongo Express for GUI**: Utilize MongoDB Express as a GUI tool to enable users to visualize and interact with the database. We will also use the official MongoDB Express image from Docker Hub.
- **Volumes Creation**: Create two volumes specific to our database:
  - *mongo_data*: for storing the database data.
  - *mongo_config*: for storing database configurations.
  We will use the local driver for volumes since we will be running them on the local server.
- **Network Creation**: Establish a Docker network named *mongo_net* to facilitate communication between the MongoDB database and MongoDB Express services. We will use the bridge driver, which is Docker's default driver, for the network.
- **Database Initialization**: Configure the setup process to automatically create a database upon spinning up the services.

### Production Environment

In production, the application will utilize a remote database provided by MongoDB. This remote database will handle the storage and management of production data, ensuring scalability, reliability, and ease of maintenance.

By following this database setup process, we can seamlessly manage both local development and production environments, providing a robust foundation for our application's data management needs.
