# Filename: Makefile

RUNTIME = podman
NAME = $(shell basename $(CURDIR))

# Create MariaDB container
.PHONY: db-start
db-start:
	$(RUNTIME) run --detach \
	--name $(NAME)-db \
	-e MYSQL_ROOT_PASSWORD=123456 \
	-p 3306:3306 \
	docker.io/mariadb:10.3

# Load database schema
.PHONY: db-load
db-load: little-lemon.sql
	@echo "Loading database schema..."
	mariadb \
	--skip-ssl \
	--table \
	--host=127.0.0.1 \
	--port=3306 \
	--user=root \
	--password=123456 \
	< $<

# Jupyter Notebook
.PHONY: notebook-create-image
notebook-create-image: Dockerfile
	$(RUNTIME) build -t $(NAME)-notebook .

.PHONY: notebook-start
notebook-start: notebook-create-image
	@echo "Starting Jupyter Notebook..."
	@echo "Open http://localhost:8888/ in your browser"
	$(RUNTIME) run --detach \
	--name $(NAME)-notebook \
	--network host \
	-p 8888:8888 \
	-v $(CURDIR):/app \
	$(NAME)-notebook

.PHONY: clean
clean:
	$(RUNTIME) rm -f $(NAME)-db
	$(RUNTIME) rm -f $(NAME)-notebook
