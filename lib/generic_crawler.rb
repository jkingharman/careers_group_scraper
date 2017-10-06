

class GenericCrawler
  def visit(url, client = Mechanize.new)
    @page ||= client.get(url)
  end
end
