module Login

	def loggingIn

		driver = Selenium::WebDriver.for :chrome
		driver.navigate.to "https://www.saucedemo.com"

		sleep 3

		userName = driver.find_element(id: 'user-name')
		userName.send_keys ('standard_user')

		sleep 3

		password = driver.find_element(id: 'password')
		password.send_keys ('secret_sauce')

		sleep 3

		button = driver.find_element(id: 'login-button')
		button.click

		sleep 3

	end

end

