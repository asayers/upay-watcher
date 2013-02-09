#! /usr/bin/env ruby

require "netrc"

uname, pass = Netrc.read["upay.co.uk"]
recipients = ""

while true
  system("casperjs upay.coffee #{uname} #{pass}")
  if $?.success?
    system("cat success.mail | msmtp #{recipients}")
  end
  sleep 5*60
end
