require 'rubygems'
require 'appium_lib'
require 'rspec'
include RSpec::Matchers

caps = {}
caps["platformName"] = "iOS"
caps["platformVersion"] = "10.2"
caps["deviceName"] = "iPhone 7"
caps["app"] = "/Users/yhuang/Documents/appium/UIKitCatalog.app"
opts = {
    sauce_username: nil,
    server_url: "http://localhost:4723/wd/hub"
}
driver = Appium::Driver.new({caps: caps, appium_lib: opts}).start_driver

driver.navigate.back
el1 = driver.find_element(:xpath, "//XCUIElementTypeCell[14]")
el1.click
el2 = driver.find_element(:xpath, "//XCUIElementTypeCell[1]/XCUIElementTypeTextField")
el2.send_keys "123"
el2.value.should == "123"
el3 = driver.find_element(:xpath, "//XCUIElementTypeCell[2]/XCUIElementTypeTextField")
el3.send_keys "456"
el3.value.should == "456"

driver.quit
