CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = ENV['S3_BUCKET']
  else
    Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
  end
end
