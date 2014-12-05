# config/initializers/spree_images_paperclip.rb
 
Spree.config do |config|
  attachment_config = {
    s3_credentials: {
      access_key_id: ENV.fetch("S3_ACCESS_KEY"),
      secret_access_key: ENV.fetch("S3_SECRET"),
      bucket: ENV.fetch("S3_BUCKET"),
    },
 
    storage:        :s3,
    s3_headers:     { "Cache-Control" => "max-age=31557600" },
    s3_protocol:    "https",
    bucket:         ENV.fetch("S3_BUCKET"),
 
    styles: {
      mini:     "48x48>",
      small:    "100x100>",
      product:  "240x240>",
      large:    "600x600>"
    },
 
    path:          ":rails_root/public/spree/products/:id/:style/:basename.:extension",
    default_url:   "/spree/products/:id/:style/:basename.:extension",
    default_style: "product",
  }
 
  attachment_config.each do |key, value|
    Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
  end
end unless Rails.env.test?