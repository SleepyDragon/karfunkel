require_relative '../helper.rb'

test "Translate pirate welcome message" do
  translator = Translator.new(:pirate, translations_folder: 'test/fixtures/translations')
  assert_equal translator.translate('general.top_box.welcome_message'), 'Aye matey'
end
