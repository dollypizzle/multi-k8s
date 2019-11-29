
docker build -t dollypizzle/multi-client:latest -t dollypizzle/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dollypizzle/multi-server:latest -t dollypizzle/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dollypizzle/multi-worker:latest -t dollypizzle/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dollypizzle/multi-client:latest
docker push dollypizzle/multi-server:latest
docker push dollypizzle/multi-worker:latest

docker push dollypizzle/multi-client:$SHA
docker push dollypizzle/multi-server:$SHA
docker push dollypizzle/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dollypizzle/multi-server:$SHA
kubectl set image deployments/client-deployment client=dollypizzle/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dollypizzle/multi-worker:$SHA
