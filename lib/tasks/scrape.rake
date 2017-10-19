

require_relative '../scraping/scraper_job'

namespace :scrape do
  desc 'Jsonify data on job vacancies from careers group'
  task :vacancies_to_json, [:search_term] do |_t, args|
    puts ScraperJob.new((args[:search_term])).call
  end
end
