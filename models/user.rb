class User < Ohm::Model
  attribute :email
  unique :email

  attribute :nickname
end
