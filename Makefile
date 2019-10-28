run:
	docker volume create mongodb_data
	docker volume create mysql_data
	docker-compose -f docker-compose.yml up keduroam-radius
