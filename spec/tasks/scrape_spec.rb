

require 'spec_helper'
require 'rake'

  describe 'scrape:vacencies_to_json' do

    # setting up context for tests
    let(:rake)  { Rake::Application.new }
    subject { Rake.application.tasks[1] }

    before do
      Rake.application.rake_require "tasks/scrape"
      Rake::Task.define_task(:environment)
    end

    let(:scraper_job) { double(:scraper_job, perform: nil) }

    before do
      allow(ScraperJob).to receive(:new).and_return(scraper_job)
      allow(scraper_job).to receive(:perform)
    end

    it 'performs the scraper job' do
      expect(scraper_job).to receive(:perform)
      subject.invoke
    end

end
