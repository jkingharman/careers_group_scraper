
require_relative '../../lib/scraping/crawlers/vacancy_crawler'

describe VacancyCrawler do

  let(:client) { double(:client, get: listing_page) }
  let(:listing_page) { double(:listing_page, links: [link_one, link_two]) }
  let(:link_one) { double(:link_one, dom_class: 'ovalbuttondetails', href: '') }
  let(:link_two) { double(:link_two, dom_class: nil, href: '') }

  let(:vacancy_page) { double(:vacancy_page, body: vacancy_html) }
  let(:vacancy_html) { double(:vacancy_html) }

  subject { described_class.new(client: client) }

  describe '#call' do
    before do
      VacancyCrawler::PAGINATION_LIMIT = 1
      allow(client).to receive(:get).with((VacancyCrawler::BASE_URL + link_one.href).to_s) { vacancy_page }
    end

    it 'will return an array of html describing specific vacancies' do
      expect(subject.call).to eq([vacancy_html])
    end
  end
end
