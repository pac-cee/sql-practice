# Oracle Container Management Guide

## 1. Normal Container Operations

### Stop Container
```powershell
docker stop oracle-free
```

### Start Container
```powershell
docker start oracle-free
```

### Check Container Status
```powershell
docker ps -a  # Shows all containers, including stopped ones
docker logs oracle-free  # View container logs
```

## 2. Common Issues and Solutions

### Issue 1: Container Won't Start
If the container fails to start, try these steps in order:

1. Check container status:
```powershell
docker ps -a
```

2. View logs for errors:
```powershell
docker logs oracle-free
```

3. Remove and recreate container if needed:
```powershell
docker stop oracle-free
