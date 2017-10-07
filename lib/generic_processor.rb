

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
    vacancy_details = parser.get_parsed_details(crawler.get_vacancies)
    persister.perform(vacancy_details)
  end
end
