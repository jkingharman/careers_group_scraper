

class JSONPersister
  def perform(data_to_persist)
    puts data_to_persist.map(&:to_json)
  end
end
