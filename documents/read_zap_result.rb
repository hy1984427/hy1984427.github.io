require 'selenium-webdriver'
require 'io/console'
require 'rest-client'

system("pkill java") #To close any existing ZAP instance.
system("pkill firefox") #To close any existing Firefox instance.
IO.popen("/Applications/ZAP\\ 2.6.0.app/Contents/Java/zap.sh -daemon -config api.disablekey=true") #The path here should be the zap.sh path under ZAP package/folder on your machine; with the option -config api.disablekey=true, ZAP will not check the apikey, which is enable by default after ZAP 2.6.0
p "OWASP ZAP launch completed"
sleep 5 #To let ZAP start completely

profile = Selenium::WebDriver::Firefox::Profile.new
proxy = Selenium::WebDriver::Proxy.new(http: "localhost:8080") #Normally ZAP will listening at port 8080, if not, please change it to the actual port ZAP is listening
profile.proxy = proxy
options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
driver = Selenium::WebDriver.for :firefox, options: options

driver.get "http://www.google.com"
element = driver.find_element :name => "q"
element.send_keys "Cheese!"
element.submit
p "Page title is #{driver.title}"
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.title.downcase.start_with? "cheese!" }
p "Page title is #{driver.title}"

JSON.parse RestClient.get "http://localhost:8080/json/core/view/alerts" #To trigger ZAP to raise alerts if any
sleep 5 #Give ZAP some time to process
response = JSON.parse RestClient.get "http://localhost:8080/json/core/view/alerts", params: { zapapiformat: 'JSON', baseurl: "http://clients1.google.com", start: 1 } #Get the alerts ZAP found

driver.quit
RestClient.get "http://localhost:8080/JSON/core/action/shutdown" #Close ZAP instance
