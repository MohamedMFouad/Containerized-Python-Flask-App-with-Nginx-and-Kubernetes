.PHONY: run up svc

version = $(shell date +%H%M%S)

run:
	python3 app.py

up: dependencies
up:
	docker build -f docker/flask/Dockerfile -t localhost:5000/flask:$(version) .
	cat kube/deployment.yaml | sed "s/__VERSION__/$(version)/g" | kubectl apply -f -

svc: dependencies
svc:
	cat kube/deployment.yaml | sed "s/__VERSION__/214714/g" | kubectl apply -f -

dependencies:
	kubectl apply -f kube/config-map.yaml
	kubectl apply -f kube/service.yaml
	kubectl apply -f kube/ingress.yaml

clean:
	docker images | grep localhost | awk '{print $$3}' | uniq | xargs docker rmi -f
