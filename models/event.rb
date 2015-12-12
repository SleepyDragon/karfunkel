class Event < Ohm::Model
  include Ohm::DataTypes

  attribute :start_time, Type::Time
  attribute :end_time, Type::Time
  attribute :location
end
