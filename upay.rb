#! /usr/bin/env ruby
#
# Store your upay credentials in your netrc as machine 'upay.co.uk'.
# Change 'recipients' to a space-separated list of email addresses.
# Change 'match' to the regex to look for in the functions table.
# Change the file 'success.mail' to the message you want to send.
# 
# Requirements:
# - You need the 'netrc' gem and a ruby runtime (obviously);
# - I'm using msmtp to send email, but you could use postfix or whatever;
# - You also need casperjs, which requires phantomjs, which requires nodejs.

require "netrc"

recipients  = "example1@example.com example2@example.com"     # The recipients listed here will be notified
match       = "[Ff]ormal [Hh]all"                             # ...when this pattern is found amongst the available functions
uname, pass = Netrc.read["upay.co.uk"]                        # ...after having logged in with the credentials found in your netrc

while true
  system("casperjs upay.coffee #{uname} #{pass} #{match}")
  if $?.success?
    system("cat success.mail | msmtp #{recipients}")
    exit(0)
  end
  sleep 5*60
end
