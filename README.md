# Kaiburr Task 2: Kubernetes Deployment

This repository contains the implementation of Task 2 for the Kaiburr assessment, which involves deploying a Java backend REST API (from Task 1) to Kubernetes using Docker Desktop Kubernetes, setting up MongoDB, and modifying the "execute" endpoint to run shell commands in Kubernetes pods using `busybox`.

## How to Run

Follow these steps to set up and run the application locally using Docker Desktop Kubernetes:

### 1. Enable Kubernetes in Docker Desktop
- Open Docker Desktop on Windows.
- Go to `Settings > Kubernetes`, check "Enable Kubernetes," and click `Apply & Restart`. Wait for Kubernetes to start.

### 2. Install Prerequisites
- Ensure you have Java 17, Maven, Docker Desktop, and `kubectl` installed.
- Verify Kubernetes is running:
  ```bash
  kubectl get nodes
  ```
  This should show `docker-desktop` as `Ready`.

### 3. Build the Docker Image
- Navigate to the project root (`kaiburr-task2` folder).
- Run:
  ```bash
  mvn clean package
  docker build -t task1-backend:latest .
  ```

### 4. Deploy MongoDB
Apply the MongoDB deployment:
```bash
kubectl apply -f mongo-deployment.yaml
```

### 5. Deploy the Application
Apply the application deployment:
```bash
kubectl apply -f app-deployment.yaml
```

### 6. Test the Application
Check pods and services:
```bash
kubectl get pods
kubectl get services
```
Access the API at `http://localhost:30080/tasks`. Use `curl`, PowerShell, or a browser to test endpoints.

## Endpoints
The REST API provides the following endpoints:

### `GET /tasks`
- No parameters: Returns all tasks.
- With `id` parameter (e.g., `/tasks?id=123`): Returns a single task or `404` if not found.

### `PUT /tasks`
- **Body:** JSON object (e.g., `{"id":"123","name":"Print Hello","owner":"Vxnu","command":"echo Hello World"}`).
- Creates or updates a task in MongoDB, validating the command for safety.

### `DELETE /tasks`
- **Parameter:** `id` (e.g., `/tasks?id=123`).
- Deletes the task with the specified ID.

### `GET /tasks/search`
- **Parameter:** `name` (e.g., `/tasks/search?name=Hello`).
- Returns tasks whose name contains the string, or `404` if none found.

### `PUT /tasks/execute`
- **Parameter:** `id` (e.g., `/tasks/execute?id=123`).
- Executes the task’s shell command in a Kubernetes pod using `busybox`, storing the execution details in `taskExecutions`.

## Screenshots
The following screenshots demonstrate the application’s deployment and functionality:
- **Pods List:** Shows `kubectl get pods` output with `mongodb-`, `task1-app-`, and `task-exec-` pods.
- **API Test:** Shows a successful `PUT /tasks/execute?id=123` response with my name (`Vxnu`) and the current date/time visible.

## Notes
- The application uses Spring Boot 3.4.3, Java 17, MongoDB, and Kubernetes client 19.0.0.
- MongoDB data persists using a PersistentVolumeClaim.
- The `busybox` image is used for running shell commands in Kubernetes pods.
- Ensure Docker Desktop Kubernetes is enabled and running for local testing.



