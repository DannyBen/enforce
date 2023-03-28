# Check that file exists
file 'no_such_file'

# Check that file exists and contains something
file 'somefile.txt' do
  text 'hello world'
  no_text 'other content'
end

# Check that folder exists
folder 'subfolder'

# Check that folder exists, CD to it, and do more tests
folder 'subfolder' do
  file 'anotherfile.txt'
end
