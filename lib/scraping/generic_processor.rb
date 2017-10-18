

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
    docs.map! { |doc| parser.parse(doc) }
    formatter.format_(docs)
  end
end
