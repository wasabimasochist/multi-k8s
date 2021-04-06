docker build -t smcooley/multi-client:latest -t smcooley/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smcooley/multi-server:latest -t smcooley/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smcooley/multi-worker:latest -t smcooley/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push smcooley/multi-client:latest
docker push smcooley/multi-client:$SHA
docker push smcooley/multi-server:latest
docker push smcooley/multi-server:$SHA
docker push smcoley/multi-worker:latest
docker push smcoley/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smcooley/multi-server:$SHA
kubectl set image deployments/client-deployment client=smcooley/multi-client:$SHA
kubectl st image deployments/worker-deployment worker=smcooley/multi-worker:$SHA