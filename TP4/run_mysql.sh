docker run -d \
	-p 3307:3306 \
	-v vol-sql-demo:/vqr/lib/mysql \
	--name tp4-sql \
	--env MYSQL_ROOT_PASSWORD=foo \
	--network net-tp4 \
	mysql:8.0
