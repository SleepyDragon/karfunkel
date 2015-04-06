require 'shield'

class User < Ohm::Model
  include Shield::Model

  attribute :email
  unique :email

  attribute :nickname

  attribute :crypted_password

  def self.fetch(email)
    with(:email, email)
  end

  def in_group?(group)
    group.players.include? self
  end

  def game_master_for?(group)
    group.game_master == self
  end
end
