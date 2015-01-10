module TranslationsHelper
  def t(key)
    translator.translate(key)
  end

  def translator
    @translator ||= Translator.new(:de)
  end
end
