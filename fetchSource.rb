require "open-uri"

def fetchHTML(url)
    # attempt to access the requested URL
    @websitePointer = open(url)
    @websiteHTML = @websitePointer.read
    
    return @websiteHTML
end
