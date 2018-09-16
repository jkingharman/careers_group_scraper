# Careers Group Scraper

A rake task that scrapes job adverts from the [Careers Group job board](https://jobonline.thecareersgroup.co.uk/careersgroup/student/). I wrote
this for a technical test while job-hunting in 2017.

## Description ##

The task accepts an optional search term (e.g. 'business development'). It makes a request to a listings page related to your search, scrapes vacancies it finds, then formats its payload as JSON.

Example output (for one job):

```
{  
   "Recruiter:":"Educo Ltd",
   "Salary:":"£15 p/hr to £30 p/hr",
   "Location:":"London",
   "Job type:":"Temporary",
   "Hours:":"Part-time",
   "Date posted:":"13/10/2017",
   "Degree Level:":"N/A"
}
```

## To use ##

Do this:

```
git clone git@github.com:jkingharman/careers_group_scraper
cd careers_group_scraper
bundle install
rake careers_group:vacancies_to_json["optional search term"]
```

## Test ##

```
rspec -fd
```

## Dependencies ##

* Mechanize so I can make HTTP requests.
* Nokogiri so I can parse html easily.
* VCR so I can mock web requests.
* Rspec so I can test.

## Challenges ##

* __Scraping job details__. I couldn't find a HTML pattern that would allow scraping everything in one fell css selection. The div I hit missed two details: job description and title. I omitted these because I felt another selection would mean code bloat. But I'm not sure this was wise. However the scraped data is used, those details are important commercially.

* __Scraping links__. How to get links from all listings? Capybara perhaps. But programmatically clinking around felt clunky. I realised I could exploit pagination: I could simply increment the listing url's page number. But this raised a new issue, namely: when to stop? I looked for a pattern — something like a 'last page' attribute on a next button — but found nothing. And so my stopping condition is arbitrary (I stop incrementing on page twenty).

## Todos ##

* __Exceptions__. I don't handle exceptions; changing this is a must. I am now aware just how brittle scrapers can be. They are hostage to external influence: the servers they query, HTTP connection, HTML structure, etc. And so trying to anticipate failure points is important. One obvious amendment I can think of for example is to log exceptions when a queried page doesn’t have the CSS I'm looking for. Also obvious: account for dud HTTP requests.
