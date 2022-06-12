class User < Firestore::Model
  # User.from_omniauth(OpenStruct.new(provider: :google_oauth2, credentials: { token: SecureRandom.uuid }))
  def self.from_omniauth(auth)
    
    payload = {
      oauth_provider: auth.provider,
      email: auth.info.email,
      oauth_token: auth.credentials.token,
      oauth_id_token: auth.extra.id_token,
      oauth_picture: auth.info.image,
      oauth_name: auth.extra.raw_info.name,
      oauth_uid: auth.uid
    }

    record = find_by(oauth_provider: auth.provider, oauth_uid: auth.uid)
    
    record ? record.save(**payload) : create(**payload)
  end

  attributes(
    %i[
      email
      oauth_token
      oauth_id_token
      oauth_provider
      oauth_picture
      oauth_name
      oauth_uid
    ]
  )
end
