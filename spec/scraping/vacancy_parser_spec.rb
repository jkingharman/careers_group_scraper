
require 'nokogiri'
require 'mechanize'
require_relative '../../lib/scraping/parsers/vacancy_parser'

describe VacancyParser, :vcr do
  subject { described_class.new }

  let(:expected_hash) do
    { 'Recruiter:' => 'Educo Ltd',
      'Salary:' => '£15 p/hr to £30 p/hr',
      'Location:' => 'London', 'Job type:' => 'Temporary',
      'Hours:' => 'Part-time', 'Date posted:' => '13/10/2017',
      'Degree Level:' => 'N/A' }
  end

  describe '#call' do
    VCR.use_cassette('vacancy_page') do
      page = Mechanize.new.get('https://jobonline.thecareersgroup.co.uk/careersgroup/student/DisplayVacancy.aspx?id=d4552df3-9d1c-451a-87ca-53ef15cecc33')
      doc = page.body

      it 'will hashify the vacancy page details' do
        expect(subject.call(doc)).to eq('Recruiter:' => 'Educo Ltd',
                                        'Salary:' => '£15 p/hr to £30 p/hr', 'Location:' => 'London',
                                        'Job type:' => 'Temporary', 'Hours:' => 'Part-time',
                                        'Date posted:' => '13/10/2017', 'Degree Level:' => 'N/A')
      end
    end
  end
end
