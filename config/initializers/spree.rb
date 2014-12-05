# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
   # config.admin_interface_logo = 'logo/spree_50.png.png'
   config.logo = 'store_logo2.png'





  
 #S3 configuration
      if Rails.env.production? then
           #production. Store images on S3.
           # development will default to local storage
          attachment_config = {
          s3_credentials: {
            access_key_id: ENV["S3_KEY"],
            secret_access_key: ENV["S3_SECRET"],
            bucket: ENV["S3_BUCKET"],
          },


          storage:        :s3,
          s3_headers:     { "Cache-Control" => "max-age=31557600" },
          s3_protocol:    "https",
          bucket:         ENV["S3_BUCKET"],

          path:          ":rails_root/public/:class/:attachment/:id/:style/:basename.:extension",
          default_url:   "/:class/:attachment/:id/:style/:basename.:extension",
          default_style: "product",
          }

         Paperclip.interpolates(:s3_eu_url) do |attachment, style|
        "#{attachment.s3_protocol}://#{Spree::Config[:s3_host_alias]}/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/},"")}"
          end
    end
end

Spree.user_class = "Spree::User"








  


=begin
 config.use_s3 = true
   config.s3_bucket = ''
   config.s3_access_key = ""
   config.s3_secret = ""
=end
   # if you create your Amazon S3 bucket on Western Europe server, you need these two additional options:
    