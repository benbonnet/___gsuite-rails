Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    Rails.application.credentials.google_client_id,
    Rails.application.credentials.google_client_secret,
    {
      scope: 'userinfo.email,userinfo.profile,openid,https://www.googleapis.com/auth/drive.file',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50
    }
  )
end

OmniAuth.config.allowed_request_methods = %i[post]
