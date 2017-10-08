

class ScraperJob
  def perform(processor_class, crawler_class, parser_class, persister_class, search_term = nil)
    processor_class.new(crawler_class.new(search_term), parser_class.new, persister_class.new).persist!
  end
end
