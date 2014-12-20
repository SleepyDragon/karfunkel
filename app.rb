require "cuba"
require "hache"
require "malone"
require "hmote"
require "hmote/render"
require "ohm"
require "ost"
require "rack/protection"
require "scrivener"
require "scrivener/contrib"

APP_KEY = ENV.fetch("APP_KEY")
APP_SECRET = ENV.fetch("APP_SECRET")
DATABASE_URL = ENV.fetch("DATABASE_URL")
MALONE_URL = ENV.fetch("MALONE_URL")

Ohm.redis = Redic.new(DATABASE_URL)
Ost.redis = Redic.new(DATABASE_URL)

Malone.connect(url: MALONE_URL)

Cuba.plugin(HMote::Render)

Cuba.use(Rack::MethodOverride)
Cuba.use(Rack::Session::Cookie, key: APP_KEY, secret: APP_SECRET, http_only: true)
Cuba.use(Rack::Static, urls: %w(/js /css /img), root: "./public")
Cuba.use(Rack::Protection, except: :http_origin)
Cuba.use(Rack::Protection::RemoteReferrer)

Dir["./lib/**/*.rb"].each      { |f| require(f) }
Dir["./models/**/*.rb"].each   { |f| require(f) }
Dir["./filters/**/*.rb"].each  { |f| require(f) }
Dir["./services/**/*.rb"].each { |f| require(f) }
Dir["./helpers/**/*.rb"].each  { |f| require(f) }
Dir["./routes/**/*.rb"].each   { |f| require(f) }

require './services/translator'
translator = Translator.new(:de)

t = ->(key) { translator.translate(key) }

Cuba.plugin Shield::Helpers

Cuba.define do
  on root do
    render("welcome", { t: t })
  end

  on 'login' do
    on get do
      render('login', {
        t: t,
        email: nil,
        error_on: {}
      })
    end

    on post, param('email'), param('password') do |email, password|
      error_on = {}

      error_on['login'] = t['login.errors.wrong_username_or_password'] unless login(User, email, password)

      if error_on.empty?
        res.redirect '/'
      else
        render('login', {
          t: t,
          email: email,
          error_on: error_on
        })
      end
    end
  end

  on 'register' do
    on get do
      render('register', {
        t: t,
        error_on: {},
        email: nil,
        nickname: nil
      })
    end

    on post, param('email'), param('nickname'), param('password'), param('password_repeat') do |email, nickname, password, password_repeat|
      error_on = {}
      error_on['password_repeat'] = t['register.errors.passwords_not_equal'] unless password == password_repeat
      error_on['password'] = t['register.errors.password_too_short'] unless password.length > 5

      begin
        User.create(email: email, password: password, nickname: nickname)
      rescue Ohm::UniqueIndexViolation
        error_on['email'] = t['register.errors.email_already_taken']
      end

      if error_on.empty?
        res.write "Hasse joot hemaaht"
      else
        render('register', {
          t: t,
          error_on: error_on,
          email: email,
          nickname: nickname
        })
      end
    end
  end
end
