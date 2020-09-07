docker build -t tanmay8898/multi-client:latest -t tanmay8898/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t tanmay8898/multi-server:latest -t tanmay8898/multi-server:$SHA  -f ./server/Dockerfile.dev ./server
docker build -t tanmay8898/multi-worker:latest -t tanmay8898/multi-worker:$SHA  -f ./worker/Dockerfile.dev ./worker

docker push tanmay8898/multi-client:latest
docker push tanmay8898/multi-server:latest
docker push tanmay8898/multi-worker:latest

docker push tanmay8898/multi-client:$SHA
docker push tanmay8898/multi-server:$SHA
docker push tanmay8898/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=tanmay8898/multi-server:$SHA
kubectl set image deployment/client-deployment client=tanmay8898/multi-client:$SHA
kubectl set image deployment/worker -deployment worker=tanmay8898/multi-worker:$SHA