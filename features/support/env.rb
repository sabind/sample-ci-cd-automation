require 'selenium-webdriver'
require 'json'
require 'rspec/expectations'
require 'securerandom'

UI_ENVS = {
    'local' => '192.241.217.191:3000/'
}

environment = ENV['UI_ENV'] || 'local'
domain = UI_ENVS[environment]

UI_ENVS[ENV['UI_ENV']] != 'local' ? (url = domain) : (url = UI_ENVS['UI_ENV'])

random_string = SecureRandom.hex(10)

test_env = {
    :url => url,
    :environment => environment,
    :domain => domain,
    :wait_timeout => 10,
    :random_string => random_string,
}

puts 'URL          ' + url
puts 'UI:          ' + environment
puts 'Domain:      ' + domain

Dir.mkdir('images') unless File.directory?('images')

#### TEST SUITE SETUP
Before do
  browser1 = Selenium::WebDriver.for :firefox
  browser2 = Selenium::WebDriver.for :firefox
  browser3 = Selenium::WebDriver.for :firefox
  browser4 = Selenium::WebDriver.for :firefox

  browsers = [
      browser1,browser2,browser3,browser4
  ]

  browser_name = 'Chrome'

  test_env[:browsers] = browsers
  test_env[:browser_name] = browser_name

  @browsers = browsers

  test_env[:test_data] = {}
  test_env[:unique_string] = SecureRandom.hex(4)
  test_env[:cookies] = {}
  @test_env = test_env
  @test_created_entities = {}
end

After do |scenario|
  @browsers.each_with_index do |each_browser, i|
    take_screenshot(each_browser, scenario, i)
    each_browser.quit
  end
end

def take_screenshot(browser, scenario, index)
  screenshot_path = "images/#{scenario.__id__}-#{index}.png"
  browser.save_screenshot(screenshot_path)
  embed(screenshot_path, 'image/png', 'SCREENSHOT')
end
