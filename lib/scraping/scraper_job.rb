

class ScraperJob
  def perform(processor_class, crawler_class, parser_class, formatter_class, search_term = nil)
    processor_class.new(crawler_class.new(search_term: search_term), parser_class.new, formatter_class.new).persist!
  end
end
