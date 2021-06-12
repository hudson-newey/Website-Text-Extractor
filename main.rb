require "./fetchSource.rb"
require "./parseHTML.rb"
require "./files.rb"

@website = ARGV[0]
@websiteFormalised = @website[8..]
@websiteFormalised = @websiteFormalised.gsub("/", "!")

# fetch and parse the website's text
@websiteHTML = fetchHTML(@website)
@websiteText = findText(@websiteHTML)

# write the contents of the webpage to a file
writeToFile(@websiteFormalised + ".txt", @websiteText)
puts "Program Completed Successfully!"

# end program
exit
