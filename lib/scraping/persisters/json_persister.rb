
require 'json'

class JSONPersister
  def perform(data_to_persist)
    data_to_persist.map(&:to_json)
  end
end
