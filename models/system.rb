require 'ostruct'

class System
  def self.all
    [
      OpenStruct.new(slug: 'sr5', name: 'Shadowrun 5'),
      OpenStruct.new(slug: 'dsa4', name: 'DSA 4'),
      OpenStruct.new(slug: 'dsa5', name: 'DSA 5'),
      OpenStruct.new(slug: 'coc', name: 'Call of Cthulhu')
    ]
  end

  def self.find(slug:)
    self.all.find { |system| system.slug == name }
  end
end
