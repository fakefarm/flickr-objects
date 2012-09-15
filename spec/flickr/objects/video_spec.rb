require "spec_helper"
require "uri"

VIDEO_ATTRIBUTES = {
  ready?:   proc { be_a_boolean },
  failed?:  proc { be_a_boolean },
  pending?: proc { be_a_boolean },

  duration: proc { be_a(Integer) },
  width:    proc { be_a(Integer) },
  height:   proc { be_a(Integer) }
}

describe Flickr::Video do
  describe "attributes" do
    context "flickr.photos.getInfo" do
      before(:all) do
        VCR.use_cassette "flickr.photos.getInfo" do
          @video = Flickr::Video.find(VIDEO_ID).get_info!
        end
      end
      subject { @video }

      VIDEO_ATTRIBUTES.each do |attribute, test|
        its(attribute) { should instance_eval(&test) }
      end
    end
  end

  describe "methods" do
    context "flickr.photos.search" do
      before(:all) { @video = make_request("flickr.photos.search").find(VIDEO_ID) }
      subject { @video }

      it "has #thumbnail" do
        @video.thumbnail("Square 75").should match(URI.regexp)
        @video.thumbnail("Square 75").should_not eq(@video.thumbnail("Thumbnail"))
      end
    end
  end
end
