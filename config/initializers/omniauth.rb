OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '899585634274-8ljd00p0hle7rlh0mgah8f7r8i3aph7g.apps.googleusercontent.com', 'nLMLQR25wTC72FC4s07QeNRU', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end