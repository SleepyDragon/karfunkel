.PHONY: test style

install:
	bundle install

console:
	env $$(cat .env) bundle exec irb -r ./app

secret:
	ruby -r securerandom -e 'puts SecureRandom.hex(32)'

seed:
	env $$(cat .env) bundle exec ruby seeds.rb

server:
	env $$(cat .env) bundle exec shotgun -o 0.0.0.0

redis:
	redis-server redis.conf

smtp:
	mt 2525

style:
	bundle exec sass --watch style/app.scss:public/css/app.css

test:
	env $$(cat .env) bundle exec cutest test/**/*_test.rb

workers-start:
	for worker in $$(ls workers); do \
		env $$(cat .env) bundle exec ost start $$worker; \
	done

workers-stop:
	for worker in $$(ls workers); do \
		env $$(cat .env) bundle exec ost stop $$worker; \
	done
