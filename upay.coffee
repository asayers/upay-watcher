casper = require('casper').create()

casper.start "https://www.upay.co.uk/login.aspx", ->
  @evaluate ->
    document.querySelector('input[name="ctl00$ContentPlaceHolder1$Login1$UserName"]').setAttribute('value', casper.cli.args[0])
    document.querySelector('input[name="ctl00$ContentPlaceHolder1$Login1$Password"]').setAttribute('value', casper.cli.args[1])

casper.then ->
  @click("#ctl00_ContentPlaceHolder1_Login1_LoginButton")

casper.then ->
  @click("#MakeABooking")

casper.run ->
  @echo("Checking...")
  events = @getHTML("#ctl00_ContentPlaceHolder1_GridView1")
  if events.match(///#{casper.cli.args[2]}///)
    @echo("WHOOOAAAAAH!").exit(0)
  else
    @echo("Nothing.").exit(1)
