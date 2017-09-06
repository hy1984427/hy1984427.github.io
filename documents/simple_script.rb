require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox

driver.get "http://www.google.com"
element = driver.find_element :name => "q"
element.send_keys "Cheese!"
element.submit
p "Page title is #{driver.title}"
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.title.downcase.start_with? "cheese!" }
p "Page title is #{driver.title}"

driver.quit
