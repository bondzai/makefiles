.PHONY: create-prettier-config format up down start stop restart build_broker build_front up_build

FRONT_END_BINARY=frontApp
BROKER_BINARY=brokerApp

up:
	@echo "Starting Docker images..."
	docker-compose up -d
	@echo "Docker images started!"

up_build: build_broker
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

down:
	@echo "Stopping docker compose..."
	docker-compose down
	@echo "Done!"

build_broker:
	@echo "Building broker binary..."
	cd ../broker-service && env GOOS=linux CGO_ENABLED=0 go build -o ${BROKER_BINARY} ./cmd/api
	@echo "Done!"

build_front:
	@echo "Building front end binary..."
	cd ../frontend && env CGO_ENABLED=0 go build -o ${FRONT_END_BINARY} ./cmd/web
	@echo "Done!"

start: build_front
	@echo "Starting front end"
	cd ../frontend && ./${FRONT_END_BINARY} &

stop:
	@echo "Stopping front end..."
	@-pkill -SIGTERM -f "./${FRONT_END_BINARY}"
	@echo "Stopped front end!"

restart: stop start

create-prettier-config:
	@echo 'Creating .prettierrc.json...'
	@if [ ! -e .prettierrc.json ]; then \
		echo 'Creating default .prettierrc.json configuration file...'; \
		echo '{' > .prettierrc.json; \
		echo '    "semi": false,' >> .prettierrc.json; \
		echo '    "singleQuote": true,' >> .prettierrc.json; \
		echo '    "tabWidth": 4,' >> .prettierrc.json; \
		echo '    "printWidth": 80,' >> .prettierrc.json; \
		echo '    "trailingComma": "all"' >> .prettierrc.json; \
		echo '}' >> .prettierrc.json; \
		echo 'Done! .prettierrc.json file created with default settings.'; \
	fi

format:
	@echo 'Formatting code...'
	@prettier --write "**/*.{tsx,ts}"
	@echo 'Done!'
