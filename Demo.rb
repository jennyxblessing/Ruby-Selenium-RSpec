require "selenium-webdriver"
require "rspec"

driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
username = 'standard_user'
password = 'secret_sauce'
addText = 'ADD TO CART'
removeText = 'REMOVE'

describe "Logging in" do 
	it "Logs in with username and password variable" do

		driver.navigate.to "https://www.saucedemo.com"
		
		sleep 1


		driver.find_element(id: 'user-name').send_keys (username)
		driver.find_element(id: 'password').send_keys (password)
		driver.find_element(id: 'login-button').click
		
	end
end 


describe "Check for banner" do
	it "Waits until banner appears and checks that the text is correct" do
 				
		wait.until {driver.find_element(id: 'header_container').displayed?}
		expect(driver.find_element(id: 'header_container').text).to include("PRODUCTS")

		sleep 1
	end
end
	
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

