

require_relative '../lib/vacancy_parser'
require 'nokogiri'

describe VacancyParser do
  let(:parser) { Nokogiri }
  let(:doc) { double(:doc, css: vacancy_details) }
  let(:vacancy_details) { [details_one, details_three] }

  let(:details_one) { double(:details_one, text: nil, next: details_two) }
  let(:details_two) { double(:details_two, text: 'vacency detail  ', next: nil) }
  let(:details_three) { double(:details_three, text: 'Job sector:', next: details_four) }
  let(:details_four) { double(:details_four, text: nil, next: nil) }

  subject(:vacancy_parser) { described_class.new(doc, parser) }

  before do
    allow(parser::HTML::Document).to receive(:parse).and_return(doc)
  end

  describe '#get_parsed_details' do
    it 'will parse the injected html doc' do
      expect(parser::HTML::Document).to receive(:parse).and_return(doc)
      vacancy_parser.get_parsed_details
    end

    it 'will extract the injected doc\'s job details' do
      expect { vacancy_parser.get_parsed_details }.to change { vacancy_parser.send(:vacancy_details) }.from({}).to(nil => 'vacency detail')
    end

    it 'will not extract details relating to job sector' do
      vacancy_parser.get_parsed_details
      expect(vacancy_parser.send(:vacancy_details)).not_to include('Job sector:' => nil)
    end
  end
end