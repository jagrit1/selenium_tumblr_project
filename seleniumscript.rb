require 'selenium-webdriver'
require 'yaml'
browser = Selenium::WebDriver.for :firefox
browser.get "https://www.tumblr.com/login"

file = YAML.load_file('./userlist.yml')
  file["user"].each do |yml_user|
		browser.find_element(id: 'signup_email').send_keys "#{yml_user["email"]}"
		browser.find_element(id: 'signup_password').send_keys "#{yml_user["password"]}\n"
	end

browser.find_element(class: "icon_post_text").click
browser.find_element(class: "editor-plaintext").send_keys "Hello World!\t"
browser.find_element(class: "editor-richtext").send_keys "This is my text\t #selenium"
browser.find_element(class: "create_post_button").click


verification = browser.find_elements(class: "post_body")
verification.each do |a| 
  if a.text.match /This is my text/
		puts "#{a.text},\nThe post has been successfully made and listed in dashboard!"
		break;
	else
		puts "The post could not be found"
  end
end

