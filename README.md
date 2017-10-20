# Careers_Group_Scraper

A rake task that scrapes job adverts from the [Careers Group job board](https://jobonline.thecareersgroup.co.uk/careersgroup/student/)

## Description ##

The scraper is run via a rake task, which accepts a search term (e.g. 'infosec'). It makes a request to a listings page related to your search, scrapes vacancies it finds, then formats its load as JSON.

This JSON is then outputted to the CL for the user:


## Run ##

Steps to scrape:

```
git clone git@github.com:jkingharman/careers_group_scraper
$ cd careers_group_scraper
$ bundle
$ rake scrape:vacancies_to_json["optional search term here"]
```

## Test ##

```
$ rspec -fd
```

## Dependencies ##

* Mechanize so I can make HTTP requests.
* Nokogiri so I can parse html easily.
* VCR so I can mock web requests.
* Rspec so I can test.

## Design ##



## Challenges ##

* __Full scraping of job details__. I couldn't find a pattern in the HTML that would afford scraping everything in one fell css selection. The div I hit missed two details - job description and job title. I omitted these because I felt another, separate selection would bring code bloat. But I'm not sure this was wise now. However the scraped data is used, those details seem important to have commercially.

* __Link scraping__. How to get links to jobs from all listings? First idea: click through each using Capybara. Programmatically clinking around felt clunky, though. I realised I should exploit pagination. I could simply increment the listing url's page number. But this had its own problem: when to stop? I looked for a pattern — something like a 'last page' attribute on a next button, say - but nothing. And so I ended up having an arbitrary stopping condition (iteration ends on page twenty).

## TODOs ##

* __Exceptions__. My scraper doesn't log exceptions; changing this is a priority. I am now more aware just how brittle scrapers can be. They are hostage to external influence: the servers they query, HTTP connection, HTML structure, etc. And so trying to anticipate and handle failure points is important. One obvious amendment I can think of, for example, is to log exceptions when a queried page doesn’t have the css I'm looking for. Also obvious, I could also account for dud http requests.

* __Pagination__. I'll address the above pagination issue. I want to dynamically generate the right page number at which to stop scraping job links.

## Tests ##
