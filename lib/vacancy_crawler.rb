

class VacancyCrawler
  BASE_URL = 'https://jobonline.thecareersgroup.co.uk/careersgroup/student/'.freeze

  private

  attr_reader :listing_url, :vacancy_links, :client_class, :page_count
  attr_accessor :client

  def initialize(client_class = Mechanize, search_term = nil)
    @page_count = 1
    @vacancy_links = []
    @client_class = client_class
    @listing_url = "#{BASE_URL}/Vacancies.aspx?st=#{search_term}&page=#{page_count}"
  end

  def visit(url = listing_url)
    client ||= client_class.new
    client.get(url)
  end

  def vacancy?(link)
    link.dom_class == 'ovalbuttondetails'
  end

  def get_each_vacancy_link
    visit.links.each { |link| vacancy_links.push(link) if vacancy?(link) }
  end

  def get_each_vacancy_link_on_every_listing
    1.times { get_each_vacancy_link; @page_count += 1 }
  end

  def get_vacancy_at(link)
    visit((BASE_URL + link.href).to_s).body
  end

  public

  def get_vacancies
    vacancies = []
    get_each_vacancy_link_on_every_listing
    vacancy_links.each { |link| vacancies << get_vacancy_at(link) }
    vacancies
  end
end
