require_relative './lib/careers_group_scraper'

namespace :careers_group do
  desc 'Returns valid json on jobs from Careers Group'
  task :jobs_to_json, [:search_term] do |_t, args|
    CareersGroupScraper::ScraperService.new((args[:search_term])).call
  end
end
