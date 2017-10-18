
require_relative '../../lib/scraping/scraper_job'

describe ScraperJob do
  let(:doc) { double(:doc) }
  let(:search_term) { nil }
  let(:docs) { [doc] }
  let(:crawler) { double(:crawler, call: docs) }
  let(:parser) { double(:parser) }
  let(:formatter) { double(:formatter) }

  subject(:scraper_job) { described_class.new(search_term,
    crawler: crawler,
    parser: parser,
    formatter: formatter) }

  describe '#persist!' do
    before do
      allow(parser).to receive(:call).with(doc)
      allow(formatter).to receive(:call).with(docs)
      scraper_job.persist!
    end
    it 'will get vacancy pages from the crawler' do
      expect(crawler).to have_received(:call)
    end

    it 'will get vacancy details from the parser' do
      expect(parser).to have_received(:call)
    end

    it 'will tell the persister to persist the vacancy details' do
      expect(formatter).to have_received(:call)
    end
  end
end
