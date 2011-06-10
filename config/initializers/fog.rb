CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJOFZFZZTBC473TPQ',       # required
    :aws_secret_access_key  => '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',       # required
  }
  config.fog_directory  = 'open-palette'                     # required
end