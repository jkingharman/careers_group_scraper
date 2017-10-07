
require 'mechanize'
require 'nokogiri'
require 'json'

require_relative 'generic_processor'
require_relative 'vacancy_crawler'
require_relative 'vacancy_parser'
require_relative 'json_persister'
require_relative 'scraper_job'


class ScraperJob
  def perform(search_term = nil)
    GenericProcessor.new(VacancyCrawler.new(search_term), VacancyParser.new, JSONPersister.new).persist!
  end
end

ScraperJob.new.perform
