require "spec_helper"

describe "flickr.people.getPublicPhotos" do
  use_vcr_cassette

  before(:each) do
    @response = Flickr.people.find(PERSON_ID).get_public_photos(extras: EXTRAS)
    @media = @response.find(PHOTO_ID)
  end

  it "returns a right kind of collections" do
    @response.should be_a(Flickr::Collection)

    person = Flickr.people.find(PERSON_ID)
    person.get_public_media(extras: EXTRAS).select { |object| object.is_a?(Flickr::Photo) }.should_not be_empty
    person.get_public_media(extras: EXTRAS).select { |object| object.is_a?(Flickr::Video) }.should_not be_empty
    person.get_public_photos(extras: EXTRAS).each { |object| object.should be_a(Flickr::Photo) }
    person.get_public_videos(extras: EXTRAS).each { |object| object.should be_a(Flickr::Video) }
  end

  it "assigns attributes correctly" do
    @media.id.should be_a_nonempty(String)
  end
end
