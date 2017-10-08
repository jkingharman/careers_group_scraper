
require_relative '../../lib/scraping/generic_processor'

describe GenericProcessor do
  let(:crawler) { double(:crawler, get_all_docs: nil) }
  let(:parser) { double(:parser, parse_all_data_in: vacancy_details) }
  let(:vacancy_details) { nil }
  let(:persister) { double(:persister) }

  subject(:generic_persister) { described_class.new(crawler, parser, persister) }

  describe '#persist!' do
    before do
      allow(persister).to receive(:perform).with(vacancy_details)
      generic_persister.persist!
    end
    it 'will get vacancy pages from the crawler' do
      expect(crawler).to have_received(:get_all_docs)
    end

    it 'will get vacancy details from the parser' do
      expect(parser).to have_received(:parse_all_data_in)
    end

    it 'will tell the persister to persist the vacancy details' do
      expect(persister).to have_received(:perform).with(vacancy_details)
    end
  end
end
