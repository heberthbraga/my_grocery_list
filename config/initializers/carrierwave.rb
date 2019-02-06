CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.enable_processing = false

    ImageUploader

    # use different dirs when testing
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        storage :file

        def cache_dir
          "#{Rails.root}/spec/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  else
    config.aws_bucket = ENV.fetch('AWS_BUCKET_NAME')
    config.storage    = :aws

    # The maximum period for authenticated_urls is only 7 days
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    config.aws_attributes = {
        expires: 1.week.from_now.httpdate,
        cache_control: 'max-age=315576000'
    }
    
    config.aws_credentials = {
        access_key_id:     ENV.fetch('S3_AWS_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('S3_AWS_SECRET_KEY'),
        region:            ENV.fetch('S3_AWS_REGION')
    }
  end
end