# Careers_Group_Scraper

A rake task that scrapes job adverts from the [Careers Group job board](https://jobonline.thecareersgroup.co.uk/careersgroup/student/)

## Description ##

The scraper accepts a search term (e.g. 'infosec'). It makes a request to a listings page related to your search, scrapes vacancies it finds, then formats its payload as JSON.

This JSON is then outputted:


## Run ##

Do this:

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

* __Scraping job details__. I couldn't find a HTML pattern that would allow scraping everything in one fell css selection. The div I hit missed two details: job description and title. I omitted these because I felt another selection would mean code bloat. But I'm not sure this was wise. However the scraped data is used, those details are important commercially.

* __Scraping links__. How to get links from all listings? First idea: Capybara. Programmatically clinking around felt clunky, though. I realised I could instead exploit pagination. I could simply increment the listing url's page number. But this raised a new issue: when to stop? I looked for a pattern — something like a 'last page' attribute on a next button - but nothing. And so my stopping condition is arbitrary (iteration ends page twenty).

## TODOs ##

* __Exceptions__. I don't log exceptions; changing this is a must. I am now aware just how brittle scrapers can be. They are hostage to external influence: servers they query, HTTP connection, HTML structure, etc. And so trying to anticipate failure points is important. One obvious amendment I can think of, for example, is to log exceptions when a queried page doesn’t have the css I'm looking for. Also obvious: I could  account for dud http requests.

* __Pagination__. I'll address the above pagination issue. I want to dynamically generate the right page number at which to stop scraping job links.

## Tests ##
