

class VacancyParser
  private

  attr_reader :html_doc, :html_parser, :vacancy_details

  def initialize(doc, parser = Nokogiri)
    @html_doc = doc
    @html_parser = parser
    @vacancy_details = {}
  end

  def parse_html
    parsed_doc ||= html_parser::HTML(html_doc)
  end

  def target_vacancy_details
    parse_html.css('#ctl00_ContentPlaceHolder1_DisplayVacancyUC1_pnlRounded div[3] b')
  end

  def get_vacancy_details
    target_vacancy_details.each { |detail| @vacancy_details[detail.text] = detail.next.text unless detail.text == 'Job sector:' }
  end

  def scrub_vacancy_details
    vacancy_details.each { |key, val| @vacancy_details[key] = val.strip }
  end

  public

  def get_parsed_details
    get_vacancy_details
    scrub_vacancy_details
    vacancy_details
  end
end
