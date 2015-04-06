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

  def player_in?(group)
    group.players.include? self
  end

  def game_master_for?(group)
    group.game_master == self
  end

  def member_of?(group)
    player_in?(group) || game_master_for?(group)
  end
end
