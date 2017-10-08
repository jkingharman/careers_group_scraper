

class GenericProcessor
  private

  attr_reader :crawler, :parser, :persister

  def initialize(crawler, parser, persister)
    @crawler = crawler
    @parser = parser
    @persister = persister
  end

  public

  def persist!
    docs = crawler.get_all_docs
    parsed_data = parser.parse_all_data_in(docs)
    persister.perform(parsed_data)
  end
end
