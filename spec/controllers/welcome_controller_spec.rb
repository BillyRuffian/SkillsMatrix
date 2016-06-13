require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do

  login_admin

  it 'should GET the index page' do
    get :index
    expect(response).to render_template :index
    expect(response).to have_http_status( :success )
  end

end
