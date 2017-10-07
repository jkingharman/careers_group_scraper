
require 'json'

class JSONPersister
  def perform(vacancies)
    vacancies.map(&:to_json)
  end
end
