class CreateGroupValidation < Scrivener
  attr_accessor :name
  attr_accessor :system
  attr_accessor :game_master

  def validate
    assert_present(:name)
    assert_present(:system)
    assert_present(:game_master)
  end
end
