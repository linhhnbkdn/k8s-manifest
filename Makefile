cp_rs256:
	kubectl cp backend/overlays/local/file/RS256/ $(POD):/RS256 -n $(NAMESPACE)
clean:
	kubectl delete -k .
	kubectl delete namespace backend || true
	kubectl delete namespace frontend || true
	kubectl delete namespace istio-system || true
	kubectl delete namespace istio-operator || true
	kubectl delete namespace istio-operator || true
	minikube minikube stop -p li-cluster || true

create-istio-namespace:
	kubectl delete namespace istio-system || true
	kubectl create namespace istio-system || true

start-istio-base: create-istio-namespace
	helm install istio-base istio/base -n istio-system --set defaultRevision=default

start-istio: start-istio-base
	helm install istiod istio/istiod -n istio-system --wait

up: start-istio
	kubectl apply -k .

dashboard-kiali:
	istioctl dashboard kiali

dashboard-jaeger:
	istioctl dashboard jaeger

dashboard-prometheus:
	istioctl dashboard prometheus

dashboard-grafana:
	istioctl dashboard grafana

# Ex: kubectl cp backend/overlays/local/file/RS256 auth-microservice-c8f56d56c-fgbbb:/ -n backend


# while true; do curl --location 'http://auth-microservice-svc:8000/api/token/' --header 'Content-Type: application/json' --data '{"username": "admin","password": "admin"}'; sleep .5; done
