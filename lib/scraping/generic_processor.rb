

class GenericProcessor

  def initialize(crawler, parser, formatter)
    @crawler = crawler
    @parser = parser
    @formatter = formatter
  end

  def persist!
    docs = crawler.call
    docs.map! { |doc| parser.call(doc) }
    formatter.call(docs)
  end

  private

  attr_reader :crawler, :parser, :formatter

end
