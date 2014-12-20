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

Cuba.define do
  on root do
    render("welcome", { t: ->(key) { translator.translate(key) } })
  end

  on 'login' do
    render('login', { t: ->(key) { translator.translate(key) } })
  end

  on 'register' do
    render('register', { t: ->(key) { translator.translate(key) } })
  end
end
