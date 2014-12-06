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

          


          path:          ":rails_root/public/spree/products/:id/:style/:basename.:extension",
          default_url:   "/:class/:attachment/:id/:style/:basename.:extension",
          default_style: "product",
          }

         


          end
    

        Paperclip.interpolates(:s3_eu_url) do |attachment, style|
        "#{attachment.s3_protocol}://#{Spree::Config[:s3_host_alias]}/#{attachment.bucket}/#{attachment.path(style).gsub(%r{^/},"")}"
        end

end
=begin
 Paperclip.interpolates(:s3_eu_url) do |att, style|
    "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
    end
=end


=begin
module AWS
    module S3
        DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"
    end
end
=end



          



Spree.user_class = "Spree::User"











  


=begin
 config.use_s3 = true
   config.s3_bucket = ''
   config.s3_access_key = ""
   config.s3_secret = ""
=end
   # if you create your Amazon S3 bucket on Western Europe server, you need these two additional options:
    