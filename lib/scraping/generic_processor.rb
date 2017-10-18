

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
    docs = crawler.call
    docs.map! { |doc| parser.call(doc) }
    formatter.call(docs)
  end
end
