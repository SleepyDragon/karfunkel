# Karfunkel

An online system to help pen and paper role play gamers.

## Getting Started

* Clone the repository
* Set up the environment variables to some sensible defaults with `cp .env.example .env`
* Install [bundler](http://bundler.io) as we use it to keep our environment consistent `gem install bundler`
* Install everything with `make install`
* You can now run the app via `make server` and see if everything works by visiting [http://localhost:9393](http://localhost:9393)

## Development Process

* `make install`: Installs dependencies.
* `make console`: Opens a IRB console.
* `make secret`: Prints a secure random secret.
* `make seed`: Runs the seeds file.
* `make server`: Starts the web server.
* `make smtp`: Fakes a SMTP server and prints emails to stdout.
* `make test`: Runs the test suite.
* `make workers`: Runs ost workers from workers/ directory.

## Thanks

* Thanks to @maynkj and @frodsan for the app template

## License

This software is released under GNU GPL v3.0
