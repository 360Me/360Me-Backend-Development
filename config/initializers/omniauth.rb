Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['78qlyjyxxiinn1'], ENV['sMd7rV8Mmvx7xOQw']
end