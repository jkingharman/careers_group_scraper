

class VacancyCrawler
  BASE_URL = 'https://jobonline.thecareersgroup.co.uk/careersgroup/student/'.freeze
  PAGINATION_LIMIT = 3 # return to manually investigate listing

  private

  attr_reader :vacancy_links, :client_class, :page_count, :search_term, :listing_url
  attr_accessor :client

  def initialize(search_term = nil, client_class = Mechanize)
    @page_count = 0
    @vacancy_links = []
    @search_term = search_term
    @client_class = client_class
    @listing_url = set_listing_url
  end

  def set_listing_url
    @page_count += 1
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
    PAGINATION_LIMIT.times { get_each_vacancy_link; set_listing_url }
  end

  def get_vacancy_doc_at(link)
    visit((BASE_URL + link.href).to_s).body
  end

  public

  def get_all_docs
    vacancy_docs = []
    get_each_vacancy_link_on_every_listing
    vacancy_links.each { |link| vacancy_docs << get_vacancy_doc_at(link) }
    vacancy_docs
  end
end
