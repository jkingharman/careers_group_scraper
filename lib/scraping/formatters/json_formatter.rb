
require 'json'

class JSONFormatter
  def call(data)
    data.to_json
  end
end
