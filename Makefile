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

run: prep pull 
	docker volume create mysql_data
	docker-compose -f docker-compose.yml up -d --force-recreate keduroam-radius
	docker-compose -f docker-compose.yml up -d keduroam-dashboard
	docker exec -it keduroam-radius service collectd start
	docker exec -it keduroam-radius service rsyslog start

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


dblog:
	docker logs keduroam-rest -f

dashboardlog:
	docker logs keduroam-dashboard

shell:
	docker exec -it keduroam-radius bash

testlocal:
	docker exec -it keduroam-radius eapol_test -c /root/univs/local.conf -s testing123

testroam:
	docker exec -it keduroam-radius eapol_test -c /root/univs/roaming.conf -s testing123

radiuslog:
	docker exec -it keduroam-radius tail -f /var/log/freeradius/radius.log