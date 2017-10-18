
require 'nokogiri'

require_relative '../scraping/crawlers/vacancy_crawler'
require_relative '../scraping/parsers/vacancy_parser'
require_relative '../scraping/formatters/json_formatter'

class ScraperJob
  def initialize(search_term = nil,
      parser: VacancyParser.new,
      formatter: JSONFormatter.new,
      crawler: VacancyCrawler.new(search_term))
    @parser = parser
    @crawler = crawler
    @formatter = formatter
  end

  def persist!
    docs = crawler.call
    docs.map! { |doc| parser.call(doc) }
    formatter.call(docs)
  end

  private

  attr_reader :crawler, :parser, :formatter
end
