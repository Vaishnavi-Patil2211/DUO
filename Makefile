.PHONY: build dev stop k8s-start k8s-stop

build:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build

dev:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

stop:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml down -v

deploy:
	kubectl apply -f kubernetes/duo/duo.yml    
	kubectl apply -f kubernetes/mongodb/mongo.yml
	kubectl apply -f kubernetes/redis/redis.yml

k8s-stop:
	kubectl delete -f kubernetes/duo/duo.yml    
	kubectl delete -f kubernetes/mongodb/mongo.yml
	kubectl delete -f kubernetes/redis/redis.yml
