http = require 'http'

exports.tweets = (options) ->
  url = 'https://api.twitter.com/1.1/statuses/user_timeline.json'
  params = {screen_name: options.screen_name, count: options.count}
  tweets = http.request url: url, data: params

  return [{text: 'Error retrieving tweets.'}] unless tweets

  replaceText = (text, replacements) ->
    index = 0
    newText = ''

    for replacement in replacements
      newText += text.slice index, replacement.start
      newText += replacement.replaceWith
      index = replacement.end

    newText += text.slice index, text.length

  for tweet in tweets
    tweet.date = new Date tweet.created_at
    replacements = []

    if tweet.entities.urls[0] isnt 'undefined'
      for url in tweet.entities.urls
        replacement = "<a href='#{url.expanded_url}' target='_blank'>#{url.display_url}</a>"
        replacements.push start: url.indices[0], end: url.indices[1], replaceWith: replacement

    if tweet.entities.user_mentions[0] isnt 'undefined'
      for user in tweet.entities.user_mentions
        replacement = "<a href='https://twitter.com/#!/#{user.screen_name}' target='_blank'>@#{user.name}</a>"
        replacements.push start: user.indices[0], end: user.indices[1], replaceWith: replacement

    if tweet.entities.hashtags[0] isnt 'undefined'
      for hashtag in tweet.entities.hashtags
        replacement = "<a href='https://twitter.com/#!/search?q=%23#{hashtag.text}' target='_blank'>##{hashtag.text}</a>"
        replacements.push start: hashtag.indices[0], end: hashtag.indices[1], replaceWith: replacement

    replacements.sort (a, b) -> a.start - b.start

    tweet.text = {html: replaceText(tweet.text, replacements)}

  tweets

