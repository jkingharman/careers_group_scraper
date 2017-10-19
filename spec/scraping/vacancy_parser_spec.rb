

require_relative '../../lib/scraping/parsers/vacancy_parser'
require 'nokogiri'

describe VacancyParser do
  let(:parser) { Nokogiri }
  let(:doc) { double(:doc, css: vacancy_details) }
  let(:vacancy_details) { [detail_one] }

  let(:detail_one) { double(:detail_one, text: 'detail category', next: detail_two) }
  let(:detail_two) { double(:detail_two, text: 'detail particular') }

  subject { described_class.new(html_parser: parser) }

  describe '#call' do
      before do
        allow(parser::HTML::Document).to receive(:parse).and_return(doc)
      end

    it 'will hashify vacancy page job details' do
      expect(subject.call(doc)).to eq('detail category' => 'detail particular')
    end
  end
end
