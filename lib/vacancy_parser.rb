

class VacancyParser
  private

  attr_reader :html_doc, :html_parser, :vacancies

  def initialize(html_parser = Nokogiri)
    @html_parser = html_parser
    @vacancies = []
  end

  def parse_html(doc)
    parsed_doc ||= html_parser::HTML(doc)
  end

  def target_vacancy_details(doc)
    parse_html(doc).css('#ctl00_ContentPlaceHolder1_DisplayVacancyUC1_pnlRounded div[3] b')
  end

  def get_vacancy_details(doc)
    target_vacancy_details(doc).each { |vacancy| vacancies << Hash[vacancy.text, vacancy.next.text] unless vacancy.text == 'Job sector:' }
  end

  def scrub_vacancy_details
    vacancies.each { |vacancy| vacancy.each { |key, val| vacancy[key] = val.strip } }
  end

  def parse_one_vacancy_in(doc)
    get_vacancy_details(doc)
    scrub_vacancy_details
  end

  public

  def parse_all_vacancies_in(vacancy_docs)
    vacancy_docs.each { |doc| parse_one_vacancy_in(doc) }
    vacancies
  end
end
