class Group < Ohm::Model
  attribute :name
  attribute :system
  reference :game_master, :User
end
