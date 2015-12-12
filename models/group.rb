class Group < Ohm::Model
  attribute :name
  attribute :system
  reference :game_master, :User
  set :players, :User
  set :events, :Event
  index :name

  def title
    "#{name} (#{game_master.nickname})"
  end
end
