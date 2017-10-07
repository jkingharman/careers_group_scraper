

require_relative '../lib/json_persister'

describe JSONPersister do

  let(:vacancy_hash) { {'Recruiter' => 'Anon', 'Salary' => '£20,000', 'Location' => 'LDN',
    'Job type' => 'Placement', 'Hours' => 'Full-time', 'Data posted' => '03/10/2017',
    'Degree Level' => 'Bachelor'} }
  subject(:json_persister) { described_class.new }

  # fix the line length issues later

  describe '#perform' do
    it 'will convert the vacancy hash to json' do
      expect(json_persister.perform(vacancy_hash)).to eq("{\"Recruiter\":\"Anon\",\"Salary\":\"£20,000\",\"Location\":\"LDN\",\"Job type\":\"Placement\",\"Hours\":\"Full-time\",\"Data posted\":\"03/10/2017\",\"Degree Level\":\"Bachelor\"}")
    end
  end

end
