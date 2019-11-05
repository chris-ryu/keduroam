prep:
	mkdir -p \
		dashboard_state/data/whisper \
		dashboard_state/data/elasticsearch \
		dashboard_state/data/grafana \
		dashboard_state/log/graphite \
		dashboard_state/log/graphite/webapp \
		dashboard_state/log/elasticsearch

pull :
	docker-compose pull

run: prep pull dashboard
	docker volume create mongodb_data
	docker volume create mysql_data
	docker-compose -f docker-compose.yml up --force-recreate keduroam-radius

dashboard:
	docker-compose -f docker-compose.yml up -d keduroam-dashboard

pull:
	docker pull chrisryu/keduroam-radius
	docker pull chrisryu/keduroam-rest
	docker pull chrisryu/keduroam-dashboard

down :
	docker-compose down

shell :
	docker exec -ti keduroam-radius /bin/bash

tail :
	docker logs -f keduroam-radius

reset : 
	-docker rm -f keduroam-radius 
	-docker rm -f keduroam-rest
	-docker rm -f keduroam-dashboard
	docker system prune -a -f
	docker volume create mysql_data 

radiuslog:
	docker logs keduroam-radius

dblog:
	docker logs keduroam-rest

dashboardlog:
	docker logs keduroam-dashboard