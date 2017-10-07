
require 'json'

class JSONPersister
  def perform(vacancy_hash)
    vacancy_hash.to_json
  end
end
