Webpop Extensions
=============================

These are [Webpop extensions](http://www.webpop.com/documentation/extensions) I created for that I'm sharing with the world since I couldn't find many resources while I was learning to use Webpop's extension engine.To use these extensions, simply add the .js files to your Webpop /extensions directory using either their online file manager or FTP.


Gravatar
--------

The Gravatar extension parses the blog poster's email address (as long as there is a field named "email" on the post) and creates a Gravatar URL for it. Each time the extension is run, it checks the app's storage for a saved URL first, so it only creates the Gravatar URL if it doesn't exist. If it has to create it, the extension stores the URL for the next time.

### Usage:

Add this tag wherever you want the Gravatar to be displayed:

    <img src="<pop:avatar:gravatar />" />


-------

Twitter
-------

The Twitter extension fetches and parses a Twtter feed, adding it to the page where the tag is used. It uses the official Twitter public API and allows much more styling flexibility compared to their pre-made JavaScript widgets. It parses @users, `#`hashtags, and links, creating `<a>` tags for each. The extension allows you to pass in your Twitter screen name and a count of how many tweets you would like to display.

### Usage:

    <pop:twitter:tweets screen_name="ExampleUser" count="6" wrap="ul" break="li">
        <a href="http://twitter.com/#!/ExampleUser/status/<pop:id_str />"><pop:date format="time_ago_in_words" /> ago</a>
        <p><pop:text /></p>
    </pop:twitter:tweets>

