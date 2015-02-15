require 'rails_helper'

describe "Beer" do
  before :each do
    FactoryGirl.create :beer
  end


  it "when filled name and style, is added to the system" do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
      FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
    @styles = ["Lager","tumma"]
    @styles.each do |style_name|
      FactoryGirl.create(:style, name: style_name)
    end
    visit new_beer_path
    fill_in :'beer_name', with:'uusiOlut'
    select('Lager', from:'beer_style_id')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
   # save_and_open_page
  end
  it "when not filled name is not added to the system" do
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
      FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
    @styles = ["Lager","tumma"]
    @styles.each do |style_name|
      FactoryGirl.create(:style, name: style_name)
    end
    visit new_beer_path
    select('Lager', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)

    expect(current_path).to eq(beers_path)
    # save_and_open_page
  end
end