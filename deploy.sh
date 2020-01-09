docker build -t erushing/multi-client:latest -t erushing/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erushing/multi-server:latest -t erushing/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erushing/multi-worker:latest -t erushing/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erushing/multi-client:latest
docker push erushing/multi-server:latest
docker push erushing/multi-worker:latest

docker push erushing/multi-client:$SHA
docker push erushing/multi-server:$SHA
docker push erushing/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=erushing/multi-server:$SHA
kubectl set image deployment/client-deployment server=erushing/multi-client:$SHA
kubectl set image deployment/worker-deployment server=erushing/multi-worker:$SHA
