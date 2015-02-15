require 'rails_helper'
require './lib/beer_mapping_api'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeerMappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if many is returned by the API, all are shown at the page" do
    allow(BeerMappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ),Place.new( name:"Oljenkorsi2", id: 2 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Oljenkorsi2"
  end
  it "if nill is returned by the API, message is shown at the page" do
    allow(BeerMappingApi).to receive(:places_in).with("kumpula").and_return(
                                 []
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content 'No locations in kumpula'
  end
end