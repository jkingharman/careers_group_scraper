
require_relative '../../lib/scraping/scraper_job'

describe ScraperJob do
  let(:processor_class) { double(:processor_class, new: processor) }
  let(:processor) { double(:processor, persist!: nil) }
  let(:crawler_class) { double(:crawler_class, new: nil) }
  let(:parser_class) { double(:parser_class, new: nil) }
  let(:persister_class) { double(:persister_class, new: nil) }

  subject(:scraper_job) { described_class.new }

  before do
    scraper_job.perform(processor_class, crawler_class, parser_class, persister_class)
  end

  describe '#perform' do
    it 'will instaniate a processor' do
      expect(processor_class).to have_received(:new)
    end

    it 'will instaniate a crawler' do
      expect(crawler_class).to have_received(:new)
    end

    it 'will instaniate a parser' do
      expect(parser_class).to have_received(:new)
    end

    it 'will instaniate a persister' do
      expect(persister_class).to have_received(:new)
    end

    it 'will persist the scrapped data' do
      expect(processor).to have_received(:persist!)
    end
  end
end
