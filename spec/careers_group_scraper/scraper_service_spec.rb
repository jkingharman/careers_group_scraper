require_relative '../spec_helper.rb'

describe CareersGroupScraper::ScraperService do
  let(:docs) { [double(:doc, body: nil)] }
  let(:scraper) { double(:scraper, call: docs) }
  let(:formatter) { double(:formatter) }

  subject do
    described_class.new(scraper: scraper, formatter: formatter)
  end

  describe '#persist!' do
    before do
      allow(formatter).to receive(:call).with(docs[0].body)
      subject.call
    end
    it 'will tell the scraper to find vacancy pages' do
      expect(scraper).to have_received(:call)
    end

    it 'will tell the formatter to hashify vacancy details' do
      expect(formatter).to have_received(:call)
    end
  end
end
