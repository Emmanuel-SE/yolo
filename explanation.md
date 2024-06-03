## Detailed Kubernetes Deployment Configuration

This section provides a detailed explanation of the Kubernetes deployment configuration for the `yolo-app` as defined in the `charts/web-deployment.yaml` file.

### Deployment Configuration Overview

The deployment configuration for `yolo-app` is defined in a YAML file which specifies how the application should be deployed and managed within the Kubernetes cluster.

### Key Elements of the Deployment Configuration

- **apiVersion**: `apps/v1` - Indicates the version of the Kubernetes API that the deployment is using.
- **kind**: `Deployment` - Specifies that the resource type is a deployment.
- **metadata**:
  - **name**: `yolo-app` - The name of the deployment.
- **spec**:
  - **replicas**: `3` - Specifies that three instances of the application should be running.
  - **minReadySeconds**: `10` - Ensures that a pod must be ready for at least 10 seconds before it is considered available.
  - **strategy**:
    - **type**: `RollingUpdate` - The deployment updates pods in a rolling update fashion.
    - **rollingUpdate**:
      - **maxUnavailable**: `1` - Only one pod can be unavailable during the update process.
      - **maxSurge**: `1` - Allows one extra pod to be created above the desired number of pods during an update.
  - **selector**:
    - **matchLabels**:
      - **app**: `yolo-app` - Selector that determines which pods belong to the deployment.
- **template**:
  - **metadata**:
    - **labels**:
      - **app**: `yolo-app` - Labels applied to all pods in the deployment.
  - **spec**:
    - **containers**:
      - **name**: `yolo-app` - Name of the container within the pod.
      - **image**: `tytye/yolo-app:latest` - The Docker image to use for the container.
      - **ports**:
        - **containerPort**: `3000` - The port that the container exposes.
      - **env**:
        - **name**: `mongoURI`
        - **value**: `"mongodb://adminuser:password123@mongo-nodeport-svc:27017"` - Environment variable for the MongoDB URI.
      - **resources**:
        - **limits**:
          - **cpu**: `"200m"` - Maximum amount of CPU the container can use.
          - **memory**: `"512Mi"` - Maximum amount of memory the container can use.
        - **requests**:
          - **cpu**: `"50m"` - Amount of CPU the container requests.
          - **memory**: `"256Mi"` - Amount of memory the container requests.

### MongoDB Kubernetes Deployment Configuration using StatefulSets

The MongoDB deployment configuration has been updated to use StatefulSets for a more stable and ordered deployment of MongoDB instances within the Kubernetes cluster.

### Key Elements of the StatefulSet Configuration

- **apiVersion**: `apps/v1` - Indicates the version of the Kubernetes API that the StatefulSet is using.
- **kind**: `StatefulSet` - Specifies that the resource type is a StatefulSet.
- **metadata**:
  - **labels**:
    - **app**: `mongo` - Labels used to identify the StatefulSet.
  - **name**: `mongo` - The name of the StatefulSet.
- **spec**:
  - **serviceName**: `mongo` - The headless service used to control the network domain for the StatefulSet.
  - **replicas**: `1` - Specifies that one instance of MongoDB should be running.
  - **selector**:
    - **matchLabels**:
      - **app**: `mongo` - Selector that determines which pods belong to the StatefulSet.
  - **template**:
    - **metadata**:
      - **labels**:
        - **app**: `mongo` - Labels applied to all pods in the StatefulSet.
    - **spec**:
      - **containers**:
        - **name**: `mongo` - Name of the container within the pod.
        - **image**: `mongo` - The Docker image to use for the container.
        - **args**: `["--dbpath","/data/db"]` - Arguments passed to the MongoDB container to specify the database path.
        - **livenessProbe** and **readinessProbe**:
          - **exec**:
            - **command**: `["mongosh", "--eval", "db.adminCommand('ping')"]` - Commands used to check the health of the MongoDB instance.
          - **initialDelaySeconds**: `30` - Delay before the probe is initiated.
          - **periodSeconds**: `10` - How often to perform the probe.
          - **timeoutSeconds**: `5` - When the probe times out.
          - **successThreshold**: `1` - Minimum consecutive successes for the probe to be considered successful after having failed.
          - **failureThreshold**: `6` - When the probe should give up, after failing consecutively.
        - **env**:
          - Environment variables for MongoDB credentials, sourced from Kubernetes secrets.
        - **volumeMounts**:
          - **name**: `mongo-data-dir`
          - **mountPath**: `/data/db` - The path where the MongoDB data directory is mounted inside the container.
      - **volumes**:
        - **name**: `mongo-data-dir`
        - **persistentVolumeClaim**:
          - **claimName**: `mongo-data` - The name of the persistent volume claim that provides storage for MongoDB data.

### Using Git Workflow to Deploy Application to GKE

This section outlines how the Git workflow defined in the `build-image.yaml` file can be utilized to deploy your application to Google Kubernetes Engine (GKE).

### Workflow Overview

The Git workflow automates the build and deployment process of your application to the GKE cluster. It consists of two main jobs: `publish-image` for building the Docker image and `deploy` for deploying the image to the GKE cluster.

### Deployment Process

1. **Build Docker Image**:

   - The `publish-image` job builds a Docker image tagged with version information and pushes it to a Docker registry (e.g., Docker Hub).
   - It uses Docker Buildx to build the image for multiple platforms (linux/amd64, linux/arm64) to ensure compatibility.
2. **Deploy to GKE**:

   - The `deploy` job deploys the Docker image to the GKE cluster.
   - It sets up GKE credentials using Google-GitHub Actions and authenticates with the GKE cluster.
   - The deployment step applies the Kubernetes manifests located in the `charts/` folder to deploy the application.
   - It then checks the status of the deployment and retrieves information about the services running in the cluster.

### Git Workflow Benefits

- **Automation**: The workflow automates the build and deployment process, reducing manual intervention.
- **Consistency**: Ensures consistent deployment of the application to the GKE cluster.
- **Scalability**: Supports deploying the application to multiple platforms using Docker Buildx.
- **Visibility**: Provides visibility into the deployment process and status of services in the GKE cluster.

### Conclusion

By leveraging the Git workflow defined in the `build-image.yaml` file, you can streamline the deployment of your application to GKE, ensuring a smooth and efficient deployment process.
