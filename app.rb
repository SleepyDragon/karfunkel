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
require "shield"

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
Cuba.use(Shield::Middleware, "/login")

Dir["./lib/**/*.rb"].each { |f| require(f) }
Dir["./models/**/*.rb"].each { |f| require(f) }
Dir["./validations/**/*.rb"].each { |f| require(f) }
Dir["./filters/**/*.rb"].each { |f| require(f) }
Dir["./services/**/*.rb"].each { |f| require(f) }
Dir["./helpers/**/*.rb"].each { |f| require(f) }
Dir["./routes/**/*.rb"].each { |f| require(f) }

Cuba.plugin Shield::Helpers
Cuba.plugin TranslationsHelper
Cuba.plugin SessionHelper
Cuba.plugin GroupHelper

Cuba.define do
  on(root) { res.redirect '/groups' }
  on('login') { run LoginRoutes }
  on('logout') { run LogoutRoutes }
  on('register') { run RegisterRoutes }

  on('groups/(\\d+)') do |group_id|
    group = Group[group_id]
    if group.nil?
      res.redirect '/groups'
    else
      with(group: group) { run GroupRoutes }
    end
  end

  on('groups') { run GroupsRoutes }
end
