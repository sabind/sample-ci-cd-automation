class BasePage
  def initialize(test_env)
    @browsers = test_env[:browsers]
    @browser_name = test_env[:browser_name]
    @home = test_env[:url]
    @wait_timeout = test_env[:wait_timeout]
    @test_env = test_env
  end

  def home
    @home
  end

  def current_page_title(browser=0)
    @browsers[browser].title.downcase
  end

  def refresh(browser=0)
    @browsers[browser].navigate.refresh
  end

  def close_window(browser=0)
    @browsers[browser].quit
  end

  def browser(browser=0)
    @browsers[browser]
  end

  def load_home(browser=0, additional_url=nil)
    url = @home
    url += additional_url unless additional_url.nil?
    @browsers[browser].get url
  end
end
