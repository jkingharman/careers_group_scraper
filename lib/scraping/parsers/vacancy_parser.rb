

class VacancyParser
  def initialize(html_parser = Nokogiri)
    @html_parser = html_parser
  end

  def call(doc)
    vacancy = build_vacancy(doc)
    remove_whitespace_in(vacancy)
  end

  private

  attr_reader :html_parser

  def parse_html(doc)
    html_parser::HTML(doc)
  end

  def vacancy_details(doc)
    parse_html(doc).css('#ctl00_ContentPlaceHolder1_DisplayVacancyUC1_pnlRounded div[3] b')
  end

  def build_vacancy(doc)
    vacancy = {}
    vacancy_details(doc).each do |detail|
      vacancy[detail.text] = detail.next.text unless detail.text == 'Job sector:'
    end
    vacancy
  end

  def remove_whitespace_in(vacancy)
    vacancy.each { |k, v| vacancy[k] = v.strip }
  end
end
