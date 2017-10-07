
require 'json'

class JSONPersister
  def perform(vacancy_details)
    vacancy_details.to_json
  end
end
