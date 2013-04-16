require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content=>"Home");
  end
  it "should have a Contact at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content=>"Contact");
  end
  it "should have a About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content=>"About");
  end
  it "should have a Support page at '/support'" do
    get '/support'
    response.should have_selector('title', :content=>"Support");
  end
  
end
