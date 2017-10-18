

require_relative '../../lib/scraping/formatters/json_formatter'
require 'json'

describe JSONFormatter do
  let(:vacancies) do
    [{ 'detail_category' => 'detail_particular' }, { 'detail_category' => 'detail_particular' }]
  end
  subject(:json_formatter) { described_class.new }

  describe '#format_' do
    it 'will convert the vacancy details to json' do
      expect(json_formatter.format_(vacancies)).to be_json
    end
  end
end
