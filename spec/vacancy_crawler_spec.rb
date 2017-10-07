
require_relative '../lib/vacancy_crawler'

describe VacancyCrawler do
  let(:client_class) { double(:client_class, new: client) }
  let(:client) { double(:client, get: listing_page) }

  let(:listing_page) { double(:listing_page, links: [vacancy_link_one, vacancy_link_two]) }
  let(:vacancy_link_one) { double(:vacancy_link_one, dom_class: 'ovalbuttondetails', href: '') }
  let(:vacancy_link_two) { double(:vacancy_link_two, dom_class: nil, href: '') }

  let(:html) { double(:html) }
  let(:vacancy_page) { double(:vacancy_page, body: html) }

  subject(:vacancy_crawler) { described_class.new(client_class) }

  describe '#get_pages_to_scrap' do
    before do
      allow(client).to receive(:get).with((VacancyCrawler::BASE_URL + vacancy_link_one.href).to_s).and_return(vacancy_page)
    end

    # I may need to test outgoing message here. Research and return

    it 'will scrap links to specific vacencies (and only vacencies) from job listing pages' do
      expect { vacancy_crawler.get_vacancies }.to change { vacancy_crawler.send(:vacancy_links) }.from([]).to([vacancy_link_one])
    end

    it 'will scrap specific vacancy pages' do
      expect(vacancy_crawler.get_vacancies).to eq([html])
    end
  end
end