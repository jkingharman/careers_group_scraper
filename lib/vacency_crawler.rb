

class VacencyCrawler
  BASE_URL = 'https://jobonline.thecareersgroup.co.uk/careersgroup/student/'.freeze

  private

  attr_reader :listing_url, :vacency_links, :client_class, :page_count
  attr_accessor :client

  def initialize(client_class = Mechanize, search_term = nil)
    @page_count = 1
    @vacency_links = []
    @client_class = client_class
    @listing_url = "#{BASE_URL}/Vacancies.aspx?st=#{search_term}&page=#{page_count}"
  end

  def visit(url = listing_url)
    client ||= client_class.new
    client.get(url)
  end

  def vacency?(link)
    link.dom_class == 'ovalbuttondetails'
  end

  def get_each_vacency_link
    visit.links.each { |link| vacency_links.push(link) if vacency?(link) }
  end

  def get_each_vacency_link_on_every_listing
    1.times { get_each_vacency_link; @page_count += 1 }
  end

  def get_vacency_at(link)
    visit((BASE_URL + link.href).to_s).body
  end

  public

  def get_vacencies
    vacencies = []
    get_each_vacency_link_on_every_listing
    vacency_links.each { |link| vacencies << get_vacency_at(link) }
    vacencies
  end
end
