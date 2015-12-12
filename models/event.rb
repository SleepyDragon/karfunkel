class Event < Ohm::Model
  include Ohm::DataTypes

  attribute :date, Type::Date
  attribute :time
  attribute :location
end
