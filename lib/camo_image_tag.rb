require 'openssl'
require "action_view"

module CamoImageTag
  extend ActiveSupport::Concern

  included do
    alias_method_chain :image_tag, :camo
  end

  def image_tag_with_camo(source, options={})
    if source && source =~ /^http:/
      unless source =~ /^(?:cid|data):/ || source.blank?
        options[:alt] = options.fetch(:alt){ image_alt(source) }
      end
      source = camo_uri(source)
    end
    image_tag_without_camo(source, options)
  end

  def camo_uri(image_url)
    hexdigest = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest::Digest.new('sha1'), camo_config['key'], image_url)
    encoded_image_url = image_url.to_enum(:each_byte).map { |byte| "%02x" % byte }.join
    "#{camo_config['host']}/#{hexdigest}/#{encoded_image_url}"
  end

  def camo_config
    { 'key'  => ENV['CAMO_KEY']  || "0x24FEEDFACEDEADBEEFCAFE",
      'host' => ENV['CAMO_HOST'] || "http://localhost:8081" }
  end
end

if defined?(ActionView::Base)
  ActionView::Base.send :include, CamoImageTag
end
