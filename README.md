# Rename It!

If you want to rename all the files, folders and content in a directory this is the script for you!

## Usage


```ruby
RenameIt.new('ProjectA', 'ProjectB').run
```


Or,  if the top level folders don't match your replacement values you can try this:


```ruby
RenameIt.new('ProjectA', 'ProjectB', 'find_this', 'replace_it_with_this').run
```

Simples.


## Specs

```
$ bundle

$ rspec -f d
```

Output:

```
RenameIt
  should copy the source directory to the destination
  should rename subdirectories that match the src name
  should rename subdirectories that match the src name with a suffix
  should rename subdirectories that match the src name with a prefix
  should rename subdirectories that match the src name with a suffix and prefix
  should rename subdirectories recursively
  should rename files that match the src name
  should rename files that match the src name with a suffix
  should rename files that match the src name with a prefix
  should rename files that match the src name with a suffix and prefix
  should find and replace the src name with the replacement in all the file content
  should find and replace the src name with the replacement in all the file content recursively
```


