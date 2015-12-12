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

  # Events that are either today or in the future
  def upcoming_events
    events.select { |event| event.date >= Date.today }
  end
end
