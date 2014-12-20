require 'yaml'
require 'fat'

class Translator
  def initialize(locale, translations_folder: 'translations')
    @translations = YAML.load_file("#{translations_folder}/#{locale}.yml")
  end

  def translate(key)
    Fat.at(@translations, key)
  end
end
