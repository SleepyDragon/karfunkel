require 'yaml'
require 'fat'

class TranslationNotFound < RuntimeError
end

class Translator
  def initialize(locale, translations_folder: 'translations')
    @translations = YAML.load_file("#{translations_folder}/#{locale}.yml")
  end

  def translate(key)
    result = Fat.at(@translations, key)
    raise TranslationNotFound.new, "No translation found for `#{key}`" if result.nil?
    result
  end
end
