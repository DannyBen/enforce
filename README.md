Enforce - A DSL for verifying file/folder content
==================================================

[![Gem](https://img.shields.io/gem/v/enforce.svg?style=flat-square)](https://rubygems.org/gems/enforce)
[![Build](https://img.shields.io/travis/DannyBen/enforce/master.svg?style=flat-square)](https://travis-ci.com/DannyBen/enforce)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/DannyBen/enforce.svg?style=flat-square)](https://codeclimate.com/github/DannyBen/enforce)

---

Create globally available DSL scripts to verify the existence of files in
a folder, and the contents of these files.

---

Install
--------------------------------------------------

```
$ gem install enforce
```

Or with bundler:

```ruby
gem 'enforce'
```

Example
--------------------------------------------------

[![asciicast](https://asciinema.org/a/bGvwdnrAzrUeHeGvY4UYfIdFZ.png)](https://asciinema.org/a/bGvwdnrAzrUeHeGvY4UYfIdFZ)

Also see the [example folder](/example).


Usage
--------------------------------------------------

1. Create a rules file containing any of the DSL commands below.
2. Run `$ enforce <fules file name>` in the directory you want to test 
   (without the `.rb` extension)

Rules files are ruby scripts that are located either in the current directory
or in your home directory, under `enforce` subdirectory (~/enforce/*.rb).

If you wish to place your rules files elsewhere, set the `ENFORCE_HOME` 
environment variable.

DSL
--------------------------------------------------

### File Commands

Verify that a file exists:

```ruby
file 'filename'
```

Verify that a file exists, and has (or doesn't have) some content:

```ruby
file 'filename' do
  text 'any content'
  no_text 'other content or regex'

  regex /any.regex/
  no_regex /any.regex/

  line 'line to match, leading and trailing spaces are ignored'
  no_line 'line to make sure is not in the file'
end
```

Verify that a file does not exist:

```ruby
no_file 'filename'
```


### Folder Commands

Verify that a folder exists:

```ruby
folder 'dirname'
```

Verify that a folder does not exist:

```ruby
no_folder 'dirname'
```

Verify that a folder exists, and run additional validations inside it:

```ruby
folder 'dirname' do
  file 'file-inside-dirname'
  file 'another-file' do
    text 'some content'
  end
end
```
