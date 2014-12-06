# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
#Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
   # config.admin_interface_logo = 'logo/spree_50.png.png'
 # config.logo = 'store_logo2.png'



#S3_CONFIG = YAML.load_file(Rails.root.join("config/application.yml"))[Rails.env]


Spree.config do |config|

  config.logo = 'store_logo2.png'
  config.attachment_styles = ActiveSupport::JSON.encode({
        "mini" => "100x100>",
        "small" => "200x200>",
        "medium" => "400x600>",
        "product" => "400x600>",
        "large" => "600x600>",
        "xl" => "800x800>",
        "xxl" => "1200x1200>",

    })

   #AWS S3
  config.use_s3 = true
  config.s3_bucket = S3_CONFIG['bucket']
  config.s3_access_key = S3_CONFIG['access_key_id']
  config.s3_secret = S3_CONFIG['secret_access_key']

  config.attachment_url = ":s3_eu_west_1_url"
  config.s3_host_alias = "s3-eu-west-1.amazonaws.com"

end

Paperclip.interpolates(:s3_us_west_2_url) do |attachment, style|
  "#{attachment.s3_protocol}://#{Spree::Config[:s3_host_alias]}/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
end

Spree.user_class = "Spree::User"









=begin
####################################################################


 #S3 configuration


=begin
if Rails.env.production? then
           #production. Store images on S3.
           # development will default to local storage

          attachment_config = {
          s3_credentials: {
            access_key_id: ENV["S3_KEY"],
            secret_access_key: ENV["S3_SECRET"],
            bucket: ENV["S3_BUCKET"],
            s3_endpoint: ENV["S3_ENDPOINT"],
            attachment_url: ENV[":s3_eu_url"],
            s3_host_alias: ENV["s3-eu-west-1.amazonaws.com"],
          },


          storage:        :s3,
          s3_headers:     { "Cache-Control" => "max-age=31557600" },
          s3_protocol:    "https",
          bucket:         ENV["S3_BUCKET"],
           url:            ":s3_domain_url",

           styles: {
              mini:     "48x48>",
              small:    "100x100>",
              product:  "240x240>",
              large:    "600x600>"
         },

          


          path:          ":rails_root/public/:class/:attachment/:id/:style/:basename.:extension",
          default_url:   "/:class/:attachment/:id/:style/:basename.:extension",
          default_style: "product",
          }

         


          end
    

#Makes Paperclip use the correct URL for images
Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-west-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
}



end
          



Spree.user_class = "Spree::User"
=end
