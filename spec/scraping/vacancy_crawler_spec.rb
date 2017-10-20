
require 'mechanize'
require_relative '../../lib/scraping/crawlers/vacancy_crawler'
require_relative '../support/scraper_support.rb'

describe VacancyCrawler, :vcr do
  subject { described_class.new(client: Mechanize.new) }

  describe '#call' do
    before do
      VacancyCrawler::PAGINATION_LIMIT = 1
    end

    VCR.use_cassette('each_vacancy_page') do
      it 'will scrape each vacancy page on the listings' do
        uri_pos = 0
        subject.call.each do |page|
          expect(page.uri.to_s).to eq ScraperSupport::VACANCY_URIS[uri_pos]
          uri_pos += 1
        end
      end
    end
  end
end
