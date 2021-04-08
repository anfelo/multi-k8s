docker build -t anfelo/multi-client:latest -t anfelo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anfelo/multi-server:latest -t anfelo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anfelo/multi-worker:latest -t anfelo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anfelo/multi-client:latest
docker push anfelo/multi-client:$SHA
docker push anfelo/multi-server:latest
docker push anfelo/multi-server:$SHA
docker push anfelo/multi-worker:latest
docker push anfelo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=anfelo/multi-server:$SHA
kubectl set image deployments/client-deployments client=anfelo/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=anfelo/multi-worker:$SHA