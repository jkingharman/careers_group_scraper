# Careers_Group_Scraper

A rake task that scrapes vacancy details from the [CareersGroup job board](https://jobonline.thecareersgroup.co.uk/careersgroup/student/)

## Run ##

Steps to scrape:

```
git clone git@github.com:jkingharman/careers_group_scraper
$ cd careers_group_scraper
$ bundle
$ rake scrape:vacancies_to_json[marketing]
```

## Test ##

```
$ rspec
```

## Major dependencies ##

* Mechanize so that I can make HTTP requests.
* Nokogiri so that I can parse html easily.
* Json so that I can convert scraped data to JSON.

## Approach to design ##

One thing that heavily influenced my design was ignorance. By this, I mean I had little information about the intent behind the scraper and also its ultimate scope — what the scraped data’s use might be, the full context of its use, etc. — and hence I tried to design for unknown demands. I wanted to structure something effective for the task at hand but also amenable to change.

As a first step here, I assigned the broad responsibilities in scraping to three generic type of classes. They are:

* __Crawlers__: classes that net data for structuring by describing a web page to scrape.

* __Parsers__: classes that parse the output of crawlers.

* __Persisters__: classes that serialise and persist the output of parsers.

I used these generic classes to help me reason about my own specific scraping domain. I ended up splitting the main responsibilities in my domain like so:

* __VacancyCrawler__: understands how to produce html from which vacancy details can be extracted.

* __VacancyParser__: understands how to extract vacancy details from html.

* __JSONFormatter__: understands how to persist extracted data to JSON.

* __GenericProcessor__: understands how tie together all the objects involved in scrapping the careers group website.

"GenericProcessor" is generic in this sense: it can work with any subclass of the Crawler, Parser, or Persister classes so long as they have the right interface. That means it's pretty easy to extend the scraper. Just define new webpage- or task-specific crawlers and parsers and inject them into the processor. Random example: you could decide you want to scrape the careers fair section on the CareersGroup site. In this case, you might define a CareersFairCrawler, CareersFairParser and CSVPersister.


## Challenges ##

* __Efficient and effective vacancy detail extraction__. I couldn't find a pattern in the html that would allow me to extract all the required data in one css selection. The group of elements I targeted held five pieces of relevant data but missed two major ones: job description and job title. I omitted these because I felt another, separate selection would put me on the road to code bloat. But I'm not sure this was the right choice. However the scraped data is used, those details seem important to have commercially.


* __Efficient link extraction__. To get links to specific vacancies my first idea was to spider site links using Capybara. This felt clunky. Fortunately, I realised I could exploit pagination instead. I could simply increment the url's page number. This, however, raised a new problem: when to stop incrementing? I searched for a pattern I could exploit — something, for instance, like a last page attribute in a href attribute of a relevant link — but I couldn’t find anything. Right now, my stopping condition is arbitrary.

## TODOs ##

* __Exceptions__. My scraper doesn't log or handle exceptions; changing this is a priority. I am now more aware just how brittle scrapers can be. They are hostage to external influence: the servers they query, HTTP connection, html structure, etc. And so trying to anticipate and handle failure points is important. One obvious amendment I can think of, for example, would be to write code that logs exceptions when a queried page doesn’t contain the css selector I'm using to get data.

* __Rake task test__. Though the service objects my task points to are all tested, the rake task itself is not. I will plug this gap today (9/10/2017).

* __Pagination__. I really want to address the above pagination issue. That is, I want to dynamically generate the right page number at which to stop scraping vacancy links.
