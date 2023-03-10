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
docker rm oracle-free
docker run -d --name oracle-free -p 1521:1521 -e ORACLE_PWD=YourStrongPassword123 container-registry.oracle.com/database/free:latest
```

### Issue 2: Database Not Accessible
If you can't connect to the database:

1. Check if container is healthy:
```powershell
docker inspect oracle-free | findstr "Status"
```

2. Check if port is accessible:
```powershell
Test-NetConnection -ComputerName localhost -Port 1521
```

3. Verify database status from inside container:
```powershell
docker exec oracle-free sqlplus / as sysdba <<EOF
SELECT status FROM v$instance;
EXIT;
EOF
```

### Issue 3: Data Persistence
To prevent data loss between container restarts:

1. Create a volume:
```powershell
docker volume create oracle_data
```

2. Run container with volume:
```powershell
docker run -d --name oracle-free `
    -p 1521:1521 `
    -e ORACLE_PWD=YourStrongPassword123 `
