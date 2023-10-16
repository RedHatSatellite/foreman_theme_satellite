class ChangeBlogUrl < ActiveRecord::Migration[5.1]
  def up
    if Setting[:rss_url] == 'https://access.redhat.com/blogs/1169563/feed'
      Setting[:rss_url] = 'https://www.redhat.com/en/rss/blog/channel/red-hat-satellite'
    end
  end

  def down
    if Setting[:rss_url] == 'https://www.redhat.com/en/rss/blog/channel/red-hat-satellite'
      Setting[:rss_url] = 'https://access.redhat.com/blogs/1169563/feed'
    end
  end
end
