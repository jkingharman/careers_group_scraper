# require_relative '../spec_helper'
# require 'rake'
#
# describe 'careers_group:scraper_service' do
#   subject { Rake.application.tasks[1] }
#   let(:scraper_job) { double(:scraper_job, call: '[{}]') }
#
#   before do
#     Rake.application.rake_require '../Rakefile'
#     Rake::Task.define_task(:environment)
#     allow(ScraperJob).to receive(:new).and_return(scraper_job)
#   end
#
#   it 'will \'puts\' the scraped vacancy details to stdout' do
#     expect { subject.invoke }.to output("[{}]\n").to_stdout
#   end
# end
