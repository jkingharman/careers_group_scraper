

require_relative '../../lib/scraping/persisters/json_persister'
require 'json'

describe JSONPersister do
  let(:vacancies) do
    [{ 'Recruiter' => 'Anon', 'Salary' => '£20,000', 'Location' => 'LDN',
       'Job type' => 'Placement', 'Hours' => 'Full-time', 'Data posted' => '03/10/2017',
       'Degree Level' => 'Bachelor' }]
  end
  subject(:json_persister) { described_class.new }

  # fix the line length issues later

  describe '#perform' do
    it 'will convert the vacancy details to json' do
      expect(json_persister.perform(vacancies)).to eq(['{"Recruiter":"Anon","Salary":"£20,000","Location":"LDN","Job type":"Placement","Hours":"Full-time","Data posted":"03/10/2017","Degree Level":"Bachelor"}'])
    end
  end
end
