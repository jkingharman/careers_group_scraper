

class JSONPersister
  def perform(data_to_persist)
    p data_to_persist.map(&:to_json)
  end
end
