require "selenium-webdriver"
require "rspec"

driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
validUsername = 'standard_user'
validPassword = 'secret_sauce'
invalidUser = 'invalid_username'
invalidPass = 'invalid_password'
addText = 'ADD TO CART'
removeText = 'REMOVE'
firstName = 'Jenny'
lastName = 'Blessing'
zip = '00000'


describe "1-00 Navigating to site" do
	it "User is able to reach Login page of demo site successfully" do
	
	driver.navigate.to "https://www.saucedemo.com"
	expect(driver.find_element(id: 'login_button_container'))

	sleep 1

	end
end

describe "1-01 Invalid username and password" do 
	it "User w/invalid username and invalid password receives error" do

		driver.navigate.to "https://www.saucedemo.com"
		sleep 1

		driver.find_element(id: 'user-name').send_keys (invalidUser)
		driver.find_element(id: 'password').send_keys (invalidPass)
		driver.find_element(id: 'login-button').click
		wait.until {driver.find_element(:xpath, '/html/body/div/div/div[2]/div[1]/div[1]/div/form/div[3]/h3').displayed?}
		expect(driver.find_element(id: 'login_button_container').text).to include("Epic sadface: Username and password do not match any user in this service")

		sleep 1

	end
end 


describe "1-02 Valid username/invalid password" do 
	it "User w/valid username and invalid password receives error" do

		driver.navigate.to "https://www.saucedemo.com"
		sleep 1

		driver.find_element(id: 'user-name').send_keys (validUsername)
		driver.find_element(id: 'password').send_keys (invalidPass)
		driver.find_element(id: 'login-button').click
		wait.until {driver.find_element(:xpath, '/html/body/div/div/div[2]/div[1]/div[1]/div/form/div[3]/h3').displayed?}
		expect(driver.find_element(id: 'login_button_container').text).to include("Epic sadface: Username and password do not match any user in this service")
		
		sleep 1
	end
end 


describe "1-03 Invalid username and valid password" do 
	it "User w/invalid username and valid password receives error" do

		driver.navigate.to "https://www.saucedemo.com"
		sleep 1

		driver.find_element(id: 'user-name').send_keys (invalidUser)
		driver.find_element(id: 'password').send_keys (validPassword)
		driver.find_element(id: 'login-button').click
		wait.until {driver.find_element(:xpath, '/html/body/div/div/div[2]/div[1]/div[1]/div/form/div[3]/h3').displayed?}
		expect(driver.find_element(id: 'login_button_container').text).to include("Epic sadface: Username and password do not match any user in this service")
		
		sleep 1
	end
end


describe "1-04 Valid username and password" do 
	it "User w/valid username and valid password is able to log in successfully" do
		
		driver.navigate.to "https://www.saucedemo.com"
		sleep 1

		driver.find_element(id: 'user-name').send_keys (validUsername)
		driver.find_element(id: 'password').send_keys (validPassword)
		driver.find_element(id: 'login-button').click
		
		sleep 1
	end
end 


describe "2-00 Navigating to Products page" do
	it "User is able to reach Products page of demo site successfully" do
 				
		wait.until {driver.find_element(id: 'header_container').displayed?}
		expect(driver.find_element(id: 'header_container').text).to include("PRODUCTS")

		sleep 1
	end
end

#todo refactor based on test plan IDs for bidirectional tracability 
describe "Goes shopping" do 
	it "Checking for button text and adding items to cart" do

		expect(driver.find_element(id: 'add-to-cart-sauce-labs-backpack').text).to eql(addText)
		driver.find_element(id: 'add-to-cart-sauce-labs-backpack').click
		
		expect(driver.find_element(id: 'remove-sauce-labs-backpack').text).to eql(removeText)

		#expect (driver.find_element(:xpath, './/*[@id="shopping_cart_container"]/a/span').text).to include ("1")

		expect(driver.find_element(id: 'add-to-cart-sauce-labs-bike-light').text).to eql(addText)
		driver.find_element(id: 'add-to-cart-sauce-labs-bike-light').click
		
		expect(driver.find_element(id: 'remove-sauce-labs-bike-light').text).to eql(removeText)

		#expect (driver.find_element(id: "shopping_cart_container")).to include("2")

		expect(driver.find_element(id: 'add-to-cart-sauce-labs-bolt-t-shirt').text).to eql(addText)
		driver.find_element(id: 'add-to-cart-sauce-labs-bolt-t-shirt').click
		
		expect(driver.find_element(id: 'remove-sauce-labs-bolt-t-shirt').text).to eql(removeText)

		#expect (driver.find_element(id: "shopping_cart_container")).to include("3")

		sleep 1

	end
end

#todo add to test plan
describe "view cart" do
	it "navigates into the shopping cart and back to list page" do
 				
		driver.find_element(id: 'shopping_cart_container').click
		wait.until {driver.find_element(id: 'cart_contents_container').displayed?}
		
		expect(driver.find_element(id: 'header_container').text).to include("YOUR CART")
		expect(driver.find_element(id: 'continue-shopping').text).to eql("CONTINUE SHOPPING")

		sleep 1

		driver.find_element(id: 'checkout').click

		sleep 1

	end
end

#todo add to test plan
describe "Enter info/cancel" do
	it "Fills out First/Last/Zip code fields and cancels" do
 				
		wait.until {driver.find_element(id: 'checkout_info_container').displayed?}
		expect(driver.find_element(id: 'cancel').text).to eql("CANCEL")
		driver.find_element(id: 'first-name').send_keys(firstName)
		driver.find_element(id: 'last-name').send_keys(lastName)
		driver.find_element(id: 'postal-code').send_keys(zip)
		driver.find_element(id: 'cancel').click

		sleep 1
	end
end

#todo add to test plan
describe "Leave info blank error check: first name" do
	it "Attempts to CONTINUE w/o adding info, checks for errors" do
 		
 		driver.find_element(id: 'checkout').click		
		wait.until {driver.find_element(id: 'checkout_info_container').displayed?}
		driver.find_element(id: 'continue').click
		wait.until {driver.find_element(:xpath, '/html/body/div/div/div/div[2]/div/form/div[1]/div[4]').displayed?}
		expect(driver.find_element(:xpath, '/html/body/div/div/div/div[2]/div/form/div[1]/div[4]').text).to eql("Error: First Name is required")
		driver.find_element(id: 'first-name').send_keys(firstName)
		driver.find_element(id: 'continue').click

		sleep 1
	end
end

#todo add to test plan
describe "Leave info blank error check: last name" do
	it "Attempts to CONTINUE w/o adding info, checks for errors" do
 				
		wait.until {driver.find_element(:xpath, '/html/body/div/div/div/div[2]/div/form/div[1]/div[4]').displayed?}
		expect(driver.find_element(:xpath, '/html/body/div/div/div/div[2]/div/form/div[1]/div[4]').text).to eql("Error: Last Name is required")
		driver.find_element(id: 'last-name').send_keys(lastName)
		driver.find_element(id: 'continue').click

		sleep 1
	end
end

#todo add to test plan
describe "Leave info blank error check: postal code" do
	it "Attempts to CONTINUE w/o adding info, checks for errors" do
 				
		wait.until {driver.find_element(:xpath, '/html/body/div/div/div/div[2]/div/form/div[1]/div[4]').displayed?}
		expect(driver.find_element(:xpath, '/html/body/div/div/div/div[2]/div/form/div[1]/div[4]').text).to eql("Error: Postal Code is required")
		driver.find_element(id: 'postal-code').send_keys(zip)
		driver.find_element(id: 'continue').click

		sleep 1
	end
end


