require 'rails_helper'

#oluen luonti onnistuu ja olut tallettuu kantaan jos oluella on nimi ja tyyli asetettuna
#oluen luonti ei onnistu (eli creatella ei synny validia oliota), jos sille ei anneta nimeä
#oluen luonti ei onnistu, jos sille ei määritellä tyyliä

RSpec.describe Beer, type: :model do

    it "has the name set correctly" do
      beer = Beer.create name:"Pekka", style_id:1

      beer.name.should == "Pekka"
      expect(Beer.count).to eq(1)
    end

 #   it "is not saved without a style" do
 #     beer = Beer.create name:"Pekka"

  #    expect(beer).not_to be_valid
  #    expect(Beer.count).to eq(0)
  #  end
  end