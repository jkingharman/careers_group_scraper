module CareersGroupScraper
  # Parses vacancy details from each Careers Group vacancy page, formatting each
  # vacancy as a hash.
  class JobFormatter
    def initialize(parser: Nokogiri)
      @parser = parser
    end

    def call(doc)
      vacancy = vacancy_to_hash(doc)
      remove_whitespace(vacancy)
    end

    private

    attr_reader :parser

    def parse_html(doc)
      parser::HTML(doc)
    end

    def vacancy_details(doc)
      parse_html(doc).css(
        '#ctl00_ContentPlaceHolder1_DisplayVacancyUC1_pnlRounded div[3] b'
      )
    end

    def vacancy_to_hash(doc)
      vacancy = {}
      vacancy_details(doc).each do |detail|
        unless detail.text == 'Job sector:'
          vacancy[detail.text] = detail.next.text
        end
      end
      vacancy
    end

    def remove_whitespace(vacancy)
      vacancy.each { |k, v| vacancy[k] = v.strip }
    end
  end
end
