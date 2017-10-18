
require 'mechanize'
require 'nokogiri'
require 'json'

require_relative '../scraping/crawlers/vacancy_crawler'
require_relative '../scraping/parsers/vacancy_parser'
require_relative '../scraping/formatters/json_formatter'

require_relative '../scraping/generic_processor'
require_relative '../scraping/scraper_job'

namespace :scrape do
  desc 'Jsonify data on job vacancies from careers group'
  task :vacancies_to_json, [:search_term] do |_t, args|
    ScraperJob.new.perform(GenericProcessor, VacancyCrawler,
                           VacancyParser, JSONFormatter, args[:search_term])
  end
end
