
require_relative '../lib/vacency_crawler'

describe VacencyCrawler do
  let(:client_class) { double(:client_class, new: client) }
  let(:client) { double(:client, get: listing_page) }

  let(:listing_page) { double(:listing_page, links: [vacency_link_one, vacency_link_two]) }
  let(:vacency_link_one) { double(:vacency_link_one, dom_class: 'ovalbuttondetails', href: '') }
  let(:vacency_link_two) { double(:vacency_link_two, dom_class: nil, href: '') }

  let(:html) { double(:html) }
  let(:vacency_page) { double(:vacency_page, body: html) }

  subject(:vacency_crawler) { described_class.new(client_class) }

  describe '#get_pages_to_scrap' do
    before do
      allow(client).to receive(:get).with((VacencyCrawler::BASE_URL + vacency_link_one.href).to_s).and_return(vacency_page)
    end

    # I may need to test outgoing message here. Research and return

    it 'will scrap links to specific vacencies (and only vacencies) from job listing pages' do
      expect { vacency_crawler.get_vacencies }.to change { vacency_crawler.send(:vacency_links) }.from([]).to([vacency_link_one])
    end

    it 'will scrap specific vacency pages' do
      expect(vacency_crawler.get_vacencies).to eq([html])
    end
  end
end
