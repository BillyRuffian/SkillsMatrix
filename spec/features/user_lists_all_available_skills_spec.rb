require 'rails_helper'

RSpec.feature "User lists all available skills", type: :feature do

  before :each do
    login_as FactoryGirl.create :administrator
  end

  it 'can see all available skills' do
    skill = FactoryGirl.create :skill
    visit skills_path
    expect( page ).to have_content skill.name
  end

  it 'can search for a specific skill' do
    skills = Array.new(20){ |x| x = FactoryGirl.create( :skill ) }
    skill = skills.sample
    visit skills_path
    fill_in 'search', with: skill.name
    click_button 'search-button'
    expect( page ).to have_content skill.name
  end
end
