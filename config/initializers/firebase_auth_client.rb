Rails.application.config.to_prepare do
  FirebaseAuth = Firebase::Admin::Auth::Client.new("#{Rails.application.config.root}/etc/secrets/serviceAccountKey.json")
end