require 'rubygems'
require 'appium_lib'

caps = {}
caps["platformName"] = "Android"
caps["platformVersion"] = "7.1.1"
caps["deviceName"] = "Nexus5X"
caps["app"] = "/Users/yhuang/Documents/AndroidCalculator.apk"
caps["appActivity"] = ".Main"
opts = {
    sauce_username: nil,
    server_url: "http://localhost:4723/wd/hub"
}
driver = Appium::Driver.new({caps: caps, appium_lib: opts}).start_driver

el1 = driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.EditText[1]")
el1.send_keys "2"
el2 = driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.EditText[2]")
el2.send_keys "3"
el3 = driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout[2]/android.widget.LinearLayout/android.widget.Button")
el3.click

driver.quit
