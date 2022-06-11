class User < Firestore::Model
  def self.from_omniauth(auth)
    # record = where(oauth_provider: auth.provider, oauth_uid: auth.uid).or(
    #   where(email: auth.info.email)
    # ).first_or_initialize

    # record.email          = auth.info.email
    # record.oauth_token    = auth.credentials.token
    # record.oauth_id_token = auth.extra.id_token
    # record.oauth_provider = auth.provider
    # record.oauth_picture  = auth.info.image
    # record.oauth_name     = auth.extra.raw_info.name
    # record.oauth_uid      = auth.uid
    # record.password       = Devise.friendly_token[0,20]
    # record.save!
    # record
  end
end
