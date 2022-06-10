Cloudtasker.configure do |config|
  #
  # Adapt the server port to be the one used by your Rails web process
  #
  if Rails.env.production?
    config.processor_host = "https://#{Env.fetch('DOMAIN')}"
  else
    config.processor_host = "http://localhost:3000"
  end

  #
  # If you do not have any Rails secret_key_base defined, uncomment the following
  # This secret is used to authenticate jobs sent to the processing endpoint
  # of your application.
  #
  # config.secret = 'some-long-token'
  config.mode = :development
  #config.redis = { url: ENV.fetch("REDIS_URL") }
  #config.store_payloads_in_redis = true

  config.logger = SemanticLogger[Cloudtasker]
end
