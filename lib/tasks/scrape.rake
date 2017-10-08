
require 'mechanize'
require 'nokogiri'
require 'json'

require_relative '../scraping/producers/vacancy_crawler'
require_relative '../scraping/consumers/vacancy_parser'
require_relative '../scraping/persisters/json_persister'

require_relative '../scraping/generic_processor'
require_relative '../scraping/scraper_job'

namespace :scrap do
  desc 'Jsonify data on job vacancies from careers group'
  task :vacancies_to_json, [:search_term] do |_t, args|
    ScraperJob.new.perform(args[:search_term])
  end
end
