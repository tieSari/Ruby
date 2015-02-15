require 'rails_helper'

describe "BeerMappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeerMappingApi.places_in("espoo")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Gallows Bird")
    expect(place.street).to eq("Merituulentie 30")
  end
  it "When HTTP GET returns nill entry, empty array is returned" do

    canned_answer = <<-END_OF_STRING
<?xml version="1.0" encoding="UTF-8"?>    <bmp-locations><location><id nil="true"/><name nil="true"/><status nil="true"/><reviewlink nil="true"/><proxylink nil="true"/><blogmap nil="true"/><street nil="true"/><city nil="true"/><state nil="true"/><zip nil="true"/><country nil="true"/><phone nil="true"/><overall nil="true"/><imagecount nil="true"/></location></bmp-locations>
    END_OF_STRING

    stub_request(:get, /.*kokkola/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeerMappingApi.places_in("kokkola")

    expect(places.size).to eq(0)
  end
  it "When HTTP GET returns many entries, all are returned" do

    canned_answer = <<-END_OF_STRING
<?xml version="1.0" encoding="UTF-8"?>
<bmp-locations>
  <location type="array">    <location>
      <id>13307</id>
      <name>O'Connell's Irish Bar</name>
      <status>Beer Bar</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap>
      <street>Rautatienkatu 24</street>
      <city>Tampere</city>
      <state nil="true"/>
      <zip>33100</zip>
      <country>Finland</country>
      <phone>35832227032</phone>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>18845</id>
      <name>Pyynikin käsityöläispanimo</name>
      <status>Brewery</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18845</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=18845&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=18845&amp;d=1&amp;type=norm</blogmap>
      <street>Tesoman valtatie 24</street>
      <city>Tampere</city>
      <state nil="true"/>
      <zip>33300</zip>
      <country>Finland</country>
      <phone nil="true"/>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
    <location>
      <id>18857</id>
      <name>Panimoravintola Plevna</name>
      <status>Brewpub</status>
      <reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18857</reviewlink>
      <proxylink>http://beermapping.com/maps/proxymaps.php?locid=18857&amp;d=5</proxylink>
      <blogmap>http://beermapping.com/maps/blogproxy.php?locid=18857&amp;d=1&amp;type=norm</blogmap>
      <street>Itäinenkatu 8</street>
      <city>Tampere</city>
      <state nil="true"/>
      <zip>33210</zip>
      <country>Finland</country>
      <phone nil="true"/>
      <overall>0</overall>
      <imagecount>0</imagecount>
    </location>
  </location>
</bmp-locations>
    END_OF_STRING

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeerMappingApi.places_in("tampere")

    expect(places.size).to eq(3)
  end
end