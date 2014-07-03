# Script to delete tags from a repository, locally and/or remotely.
# Usage: $ ruby delete_tags.rb

# Customize to add logic to decide whether the tag should be deleted from the local repo 
def should_delete_tag(tag)
  return tag[0] != '0'
end

# Edit to add logic to decide whether the tag should be deleted from the remote repo
def should_delete_remote_tag(tag)
  return should_delete_tag(tag)
end

tags_string = `git tag`
tags = tags_string.lines
tags.each do |tag|
  should_delete_tag(tag)
  `git tag -d #{tag}` if should_delete_tag(tag)
  `git push --delete origin #{tag}` if should_delete_remote_tag(tag)
end 

