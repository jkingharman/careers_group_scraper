

class GenericProcessor
  private

  attr_reader :crawler, :parser, :formatter

  def initialize(crawler, parser, formatter)
    @crawler = crawler
    @parser = parser
    @formatter = formatter
  end

  public

  def persist!
    docs = crawler.get_all_docs
    parsed_data = parser.parse_all_data_in(docs)
    formatter.format_(parsed_data)
  end
end
