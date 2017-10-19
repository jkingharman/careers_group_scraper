
# break this test to increase your confidence here.

require_relative '../../lib/scraping/formatters/json_formatter'

describe JSONFormatter do
  let(:vacancies) do
    [{ 'detail_category' => 'detail_particular' }, { 'detail_category' => 'detail_particular' }]
  end

  describe '#format_' do
    it 'will format the vacancy details in json' do
      expect(subject.call(vacancies)).to be_json
    end
  end
end
