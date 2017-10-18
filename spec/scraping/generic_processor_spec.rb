
require_relative '../../lib/scraping/generic_processor'

describe GenericProcessor do
  let(:doc) { double(:doc) }
  let(:docs) { [doc] }
  let(:crawler) { double(:crawler, call: docs) }
  let(:parser) { double(:parser) }
  let(:formatter) { double(:formatter) }

  subject(:generic_processor) { described_class.new(crawler, parser, formatter) }

  describe '#persist!' do
    before do
      allow(parser).to receive(:call).with(doc)
      allow(formatter).to receive(:call).with(docs)
      generic_processor.persist!
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
