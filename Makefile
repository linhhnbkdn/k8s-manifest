cp_rs256:
	kubectl cp backend/overlays/local/file/RS256/ $(POD):/RS256 -n $(NAMESPACE)
# Ex: kubectl cp backend/overlays/local/file/RS256 auth-microservice-5cc5df4c7c-v56zx:/RS256 -n backend


# while true; do curl --location 'http://auth-microservice-svc:8000/api/token/' --header 'Content-Type: application/json' --data '{"username": "admin","password": "admin"}'; sleep .5; done
