

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
    vacancy_docs = crawler.get_all_vacancy_docs # not taking advatnage of ducktyping!!!
    vacancies = parser.parse_all_vacancies_in(vacancy_docs)
    persister.perform(vacancies)
  end
end
