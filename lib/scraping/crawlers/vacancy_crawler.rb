

class VacancyCrawler
  BASE_URL = 'https://jobonline.thecareersgroup.co.uk/careersgroup/student/'.freeze
  PAGINATION_LIMIT = 1

  private

  # (2) wrap the client in a getter method
  attr_reader :vacancy_links, :client, :page_count, :search_term, :listing_url

  # (1)
  def initialize(search_term: nil, client: Mechanize.new)
    @page_count = 0
    @vacancy_links = []
    @search_term = search_term
    @client = client
    @listing_url = set_listing_url
  end

  def set_listing_url
    @page_count += 1
    @listing_url = "#{BASE_URL}/Vacancies.aspx?st=#{search_term}&page=#{page_count}"
  end

  # you should override client here.
  def visit(url = listing_url)
    client.get(url)
  end

  def vacancy?(link)
    link.dom_class == 'ovalbuttondetails'
  end

  def get_vacancy_(link)
    vacancy_links << link if vacancy?(link)
  end

  def get_each_vacancy_link
    visit.links.each { |link| get_vacancy_(link) }
  end

  def get_each_vacancy_link_on_every_listing
    PAGINATION_LIMIT.times do
      get_each_vacancy_link
      set_listing_url
    end
  end

  def get_vacancy_doc_at(link)
    visit((BASE_URL + link.href).to_s).body
  end

  public

  # (4) Used map to make more efficient.
  def get_all_docs
    get_each_vacancy_link_on_every_listing
    vacancy_links.map { |link| get_vacancy_doc_at(link) }
  end
end
