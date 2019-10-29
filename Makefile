run:
	docker volume create mongodb_data
	docker volume create mysql_data
	docker-compose -f docker-compose.yml up keduroam-radius

dashboard:
	mkdir -p docker-grafana-graphite/data/whisper
	mkdir -p docker-grafana-graphite/data/grafana
	mkdir -p docker-grafana-graphite/log/graphite
	mkdir -p docker-grafana-graphite/log/supervisor
	docker-compose -f docker-compose.yml up keduroam-grafana-dashboard

pull:
	docker pull keduroam-radius
	docker pull keduroam-rest