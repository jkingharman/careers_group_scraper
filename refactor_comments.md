



__Application Code__



__Positional arguments to keyword arguments__

I changed many of my positional arguments to keyword ones. I can see this approach is better. It removes a dependency (argument order) and improves readability.

__Misc formatting changes__

I noted the points where my code strays from good ruby style — for example, placing two expressions on the same line, placing private methods at the file’s top — and made changes according to the ruby style guide.

__Class-level separation of responsibilities__

I removed ‘puts’ from what was ‘JSONPersister’. As it stood, the class was dual-purpose: it formatted the scraped data to JSON but also acted as a presenter. I changed the class to ‘JSONFormatter’ after extracting.

__Service object best practice__

I worked to restrict my service objects to one public method that reflects their responsibility. Given this, I felt it was appropriate to follow your suggestion and name this method ‘call’. I like the consistency this creates but also how it makes the objects look like
functions themselves.

__Simplified the design by removing GenericProcessor__

More thought about what I needed from GenericProcessor and ScraperJob led me remove the former’s contents. At this level in the system, all I wanted was a class that implements a simple interface in terms of the interface of the subclasses that do the scraping work (my crawler, parser, and formatter, that is). I realised GenericProcessor alone gave me this. So I kept GenericProcessor’s contents, but renamed it to ScraperJob to better reveal purpose.

__Reduced dependencies in the rake task__

My rake task knew a lot about the rest of my code. I did some decoupling here by injecting the classes into ScraperJob as defaults. Now rake just deals with input and output as you suggested.



__Test Code__


__Simplified tests__

Tried to simplify tests while taking onboard your remarks about them when we spoke. In practice, this meant taking a less mockist approach to unit-testing.

I feel the basic problem with my specs before was that they weren’t testing the right thing because of mocking. Mainly, I was simply reflecting the flow of logic through my methods by stubbing calls on my dependencies and canning values. I see two major costs to this. One is that it means my tests where closely tied to my implementation (whenever I changed internal methods the tests would fail). The other is that I couldn’t have confidence my parser, crawler, or formatter’s behaviour was correct where it matters.

For me, with all these units, it seems the important thing to ask is: given certain input, do you return  certain state? Consider VacancyParser. Here I want to know that if a vacancy html doc with a certain structure goes in, a hash with certain key-value pairs comes out. Previously, my spec didn’t test this. But now it does I believe. What I can’t figure out is whether there’s a way of having confidence that
my unit’s here return the state I need, without passing them the real dependencies they wrap (nokogiri and mechanise).

__Outgoing command messages__

The specs for ScraperJob all test outgoing messages. My understanding is that I need such tests because they have side effects, and it’s the responsibility of ScraperJob to ensure that they get
sent properly.

__VCR__

I ended up trying to use the vcr gem because I needed a way of not mocking Mechanise while also not hitting the careersgroup site every time I run spec. The tech is still largely a block-box to me, though I tend to read more of the docs tonight.
