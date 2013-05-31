require 'mechanize'
require 'logger'

domainname=ARGV.first

agent = Mechanize.new
agent.log = Logger.new "mech.log"
agent.user_agent_alias = 'Mac Safari'
agent.verify_mode=OpenSSL::SSL::VERIFY_NONE

page = agent.get "https://partners.networksolutions.com/en_US/ppcontroller.go"

loginform = page.form_with :name => "loginForm"
loginform.field_with(:name=> 'partnerId').value="XXXXXx"
loginform.field_with(:name=> 'pswd').value="XXXXXX"

loginresults = agent.submit loginform

domainsearchlink=loginresults.link_with :text=>'View/Update Domains'
domainsearch=domainsearchlink.click
domainsearchform=domainsearch.form_with :name=>'singleSearchForm'
domainsearchform.field_with(:name=>'domainName').value=domainname
searchresults=agent.submit domainsearchform
detailsform=searchresults.form_with :name=>'detailsForm'
res=searchresults.search "//table[@class='domaindetails']"
puts res.text
puts detailsform.values
