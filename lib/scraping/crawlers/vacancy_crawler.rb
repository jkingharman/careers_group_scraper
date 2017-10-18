
require 'mechanize'

class VacancyCrawler
  BASE_URL = 'https://jobonline.thecareersgroup.co.uk/careersgroup/student/'.freeze
  PAGINATION_LIMIT = 1

  def call
    scrape_each_vacancy_link
    vacancy_links.map { |link| scrape_vacancy_page(link) }
  end

  def initialize(search_term = nil, client: Mechanize.new)
    @page_count = 0
    @vacancy_links = []
    @client = client
    @search_term = search_term
    @listing_url = set_listing_url
  end

  private

  attr_reader :vacancy_links, :client, :search_term, :listing_url, :page_count

  def set_listing_url
    @page_count += 1
    @listing_url = "#{BASE_URL}/Vacancies.aspx?st=#{search_term}&page=#{page_count}"
  end

  def visit(url = listing_url)
    client.get(url)
  end

  def vacancy?(link)
    link.dom_class == 'ovalbuttondetails'
  end

  def scrape_vacancy(link)
    (vacancy_links << link) if vacancy?(link)
  end

  def scrape_each_vacancy_link
    visit.links.each { |link| scrape_vacancy(link) }
  end

  def scrape_each_listing
    PAGINATION_LIMIT.times do
      scrape_each_vacancy_link
      set_listing_url
    end
  end

  # revert back to string interpolate
  def scrape_vacancy_page(link)
    visit((BASE_URL + link.href).to_s).body
  end
end
