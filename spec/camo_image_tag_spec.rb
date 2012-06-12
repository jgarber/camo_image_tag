require File.expand_path('../spec_helper', __FILE__)

describe CamoImageTag do
  before do
    @helper = ActionView::Base.new
  end

  describe "#image_tag" do
    subject { @helper.image_tag(source) }

    context "when url is http" do
      let(:source) { "http://icanhascheezburger.files.wordpress.com/2007/03/mahcamouflage.jpg" }

      it "should rewrite the image source" do
        subject.should =~ Regexp.new("http://localhost:8081/0dbd812099233e12441fc03a3029791869fb33a2/687474703a2f2f6963616e686173636865657a6275726765722e66696c65732e776f726470726573732e636f6d2f323030372f30332f6d616863616d6f75666c6167652e6a7067")
      end

      it "should generate its alt attribute from the source image" do
        subject.should =~ /alt="Mahcamouflage"/
      end
    end

    context "when url is https" do
      let(:source) { "https://icanhascheezburger.files.wordpress.com/2010/10/1fb25f55-7032-4c34-ba17-1a340fe50c88.jpg" }

      it "should not rewrite the image source" do
        subject.should =~ Regexp.new(source)
      end
    end
  end
end
