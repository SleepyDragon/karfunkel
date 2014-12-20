.PHONY: test

install:
	dep install -f .gems
	dep install -f .gems.dev

console:
	env $$(cat .env) irb -r ./app

secret:
	ruby -r securerandom -e 'puts SecureRandom.hex(32)'

seed:
	env $$(cat .env) ruby seeds.rb

server:
	env $$(cat .env) shotgun -o 0.0.0.0

smtp:
	mt 2525

test:
	env $$(cat .env) cutest test/**/*_test.rb

workers-start:
	for worker in $$(ls workers); do \
		env $$(cat .env) ost start $$worker; \
	done

workers-stop:
	for worker in $$(ls workers); do \
		env $$(cat .env) ost stop $$worker; \
	done
