Rails.application.config.to_prepare do
  FirebaseAuth = Firebase::Admin::Auth::Client.new("/etc/secrets/serviceAccountKey.json")
end