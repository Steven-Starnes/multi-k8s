docker build -t starnes22/multi-client:latest -t starnes22/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t starnes22/multi-server:latest -t starnes22/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t starnes22/multi-worker:latest -t starnes22/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push starnes22/multi-client:latest
docker push starnes22/multi-server:latest
docker push starnes22/multi-worker:latest

docker push starnes22/multi-client:$SHA
docker push starnes22/multi-server:$SHA
docker push starnes22/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=starnes22/multi-server:$SHA
kubectl set image deployments/client-deployment client=starnes22/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=starnes22/multi-worker:$SHA
