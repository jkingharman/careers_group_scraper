
require_relative '../../lib/scraping/scraper_job'

describe ScraperJob do
  let(:docs) { [double(:doc)] }
  let(:crawler) { double(:crawler, call: docs) }
  let(:parser) { double(:parser) }
  let(:formatter) { double(:formatter) }

  subject { described_class.new(crawler: crawler,
    parser: parser,
    formatter: formatter) }

  describe '#persist!' do
    before do
      allow(parser).to receive(:call).with(docs[0])
      allow(formatter).to receive(:call).with(docs)
      subject.call
    end
    it 'will tell the crawler to find vacancy pages' do
      expect(crawler).to have_received(:call)
    end

    it 'will tell the parser to hashify vacancy details' do
      expect(parser).to have_received(:call)
    end

    it 'will tell the formatter to jsonify the hashed details' do
      expect(formatter).to have_received(:call)
    end
  end
end
