def convertToString(text)
    return text.map {|s| "#{s}"}.join(" ")
end

def removeArtifacts(text)
    text = text.gsub("<", "")
    text = text.gsub(">", "")

    return text
end

def findText(websiteHTML)
    # remove all the script tags from the html
    @matchRegex = /<script.+?>.+?</
    @foundScriptTags = websiteHTML.to_enum(:scan, @matchRegex).map { Regexp.last_match }

    @foundScriptTags.each do |item|
        item = convertToString([item])
        websiteHTML = websiteHTML.gsub(item, "")
    end

    # remove all the style tags
    @matchRegex = /<style.+?>.+?</
    @foundStyleTags = websiteHTML.to_enum(:scan, @matchRegex).map { Regexp.last_match }

    @foundStyleTags.each do |item|
        item = convertToString([item])
        websiteHTML = websiteHTML.gsub(item, "")
    end

    # find all inner text (this text will contain artifacts "<" & ">")
    @matchRegex = />[^<].+?</
    @foundText = websiteHTML.to_enum(:scan, @matchRegex).map { Regexp.last_match }

    # convert the array to string and then remove artifacts
    @revisedText = convertToString(@foundText)
    @revisedText = removeArtifacts(@revisedText)

    return @revisedText
end
