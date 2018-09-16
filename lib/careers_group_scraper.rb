# Dependencies / lib code namespace.
module CareersGroupScraper; end

require 'mechanize'
require 'nokogiri'
require 'json'

require_relative 'careers_group_scraper/scraper_service'
require_relative 'careers_group_scraper/job_formatter'
require_relative 'careers_group_scraper/job_scraper'
