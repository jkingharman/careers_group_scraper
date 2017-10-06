
require_relative '../lib/generic_crawler'

describe GenericCrawler do
  subject(:gen_crawler) { described_class.new }
  let(:url) { :'https://mock.co.uk/url' }
  let(:page_obj) { double(:page_obj) }
  let(:client) { double(:client) }

  describe '#visit' do
    it 'will tell the client to make a query' do
      expect(client).to receive(:get).with(url)
      gen_crawler.visit(url, client)
    end

    context 'when the url points to a resource' do
      before do
        allow(client).to receive(:get).with(url).and_return(page_obj)
      end
      it 'will return it as a parsed page' do
        expect(gen_crawler.visit(url, client)).to eq(page_obj)
      end
    end
  end
end
