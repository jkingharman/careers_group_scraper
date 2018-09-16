module CareersGroupScraper
  class ScraperService
    def initialize(search_term = nil,
                   formatter: JobFormatter.new,
                   scraper: JobScraper.new(search_term))
      @formatter = formatter
      @scraper = scraper
    end

    def call
      docs = scraper.call
      docs.map! { |doc| formatter.call(doc.body) }
      docs.to_json
    end

    private

    attr_reader :scraper, :formatter
  end
end
