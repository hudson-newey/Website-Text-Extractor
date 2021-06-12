# write contents to a pre-determained file
def writeToFile(fileName, contents)
    # define that any existing files should be overwritten
    filePointer = File.new(fileName, "w")

    # write to file through file pointer object
    filePointer.write(contents)
    filePointer.close
end
