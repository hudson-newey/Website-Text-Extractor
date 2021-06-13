def convertToString(text)
    return text.map {|s| "#{s}"}.join(" ")
end

def removeArtifacts(text)
    text = text.to_enum(:scan, /.+?/).map { Regexp.last_match }
    text = convertToString(text)

    text = text.gsub("<", "")
    text = text.gsub(">", "")

    return text
end

def findText(websiteHTML)
    @artifactRules = [/<script.+?>.+?</, /<script.+?>(.+?<)*/, /<style.+?>.+?<\/style>/]
    # remove all artifacts from the html source
    @artifactRules.each do |rule|
        @foundScriptTags = websiteHTML.to_enum(:scan, rule).map { Regexp.last_match }
        
        @foundScriptTags.each do |item|
            item = convertToString([item])
            websiteHTML = websiteHTML.gsub(item, "")
        end
    end

    # find all inner text (this text will contain artifacts "<" & ">")
    @matchRegex = />[^<].+?</
    @foundText = websiteHTML.to_enum(:scan, @matchRegex).map { Regexp.last_match }

    # convert the array to string and then remove artifacts
    @revisedText = convertToString(@foundText)
    @revisedText = removeArtifacts(@revisedText)

    return @revisedText
end
