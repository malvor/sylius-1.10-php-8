env=dev
docker-os=linux
compose=docker-compose -f docker-compose.yml -f etc/$(env)/docker-compose.yml

export compose env

.PHONY: start
start: erase build start-deps up db

.PHONY: start-deps
start-deps:
		$(compose) run --rm start_dependencies

.PHONY: stop
stop:
		$(compose) stop $(s)

.PHONY: rebuild
rebuild: start

.PHONY: erase
erase: ## stop and delete containers, clean volumes.
		touch .env.blackfire
		$(compose) stop
		docker-compose rm -v -f

.PHONY: build
build:
		$(compose) build

		if [ env = "prod" ]; then \
			echo Building in $(env) mode; \
			$(compose) run --rm php sh -lc 'xoff;COMPOSER_MEMORY_LIMIT=-1 composer install --no-ansi --no-dev --no-interaction --no-plugins --no-progress --no-scripts --no-suggest --optimize-autoloader'; \
		else \
			$(compose) run --rm php sh -lc 'xoff;COMPOSER_MEMORY_LIMIT=-1 composer install'; \
		fi

.PHONY: xon
xon: ## activate xdebug simlink
		$(compose) exec -T php sh -lc 'xon | true'

.PHONY: xoff
xoff: ## deactivate xdebug
		$(compose) exec -T php sh -lc 'xoff | true'
		make up


.PHONY: composer-update
composer-update: ## Update project dependencies
		$(compose) run --rm php sh -lc 'xoff;COMPOSER_MEMORY_LIMIT=-1 composer update'

.PHONY: up
up:
		$(compose) up -d

.PHONY: db
db: ## recreate database
		$(compose) exec -T php sh -lc './bin/console d:d:d --force --if-exists'
		$(compose) exec -T php sh -lc './bin/console d:d:c --if-not-exists'
.PHONY: schema-validate
schema-validate: ## validate database schema
		$(compose) exec -T php sh -lc './bin/console d:s:v'

.PHONY: install
install:
		$(compose) exec -T php sh -lc './bin/console sylius:install -n'

.PHONY: reinstall
reinstall: db install

.PHONY: sample
sample:
		$(compose) exec -T php sh -lc './bin/console sylius:install:sample-data'

.PHONY: phpunit
phpunit: db ## execute project unit tests
		$(compose) exec -T php sh -lc "php -dpcov.enabled='1' -dpcov.directory=. -dpcov.exclude='~vendor~' ./vendor/bin/phpunit $(conf)"

.PHONY: phpstan
phpstan: ## executes php analizers
		$(compose) run --rm code sh -lc './vendor/bin/phpstan analyse -l 6 -c phpstan.neon src tests'

.PHONY: psalm
psalm: ## execute psalm analyzer
		$(compose) run --rm code sh -lc './vendor/bin/psalm --show-info=false'
