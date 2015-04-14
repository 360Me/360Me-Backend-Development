class SelectiveStack
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["PATH_INFO"].start_with?("/api/") # <--- Change URL path here
      @app.call(env)
    else
      middleware_stack.build(@app).call(env)
    end
  end

  private
  def middleware_stack
    @middleware_stack ||= begin
      ActionDispatch::MiddlewareStack.new.tap do |middleware|
        # needed for OmniAuth
        middleware.use ActionDispatch::Cookies
        middleware.use Rails.application.config.session_store, Rails.application.config.session_options
        middleware.use OmniAuth::Builder#, &OmniAuthConfig
        # needed for Doorkeeper /oauth views
        middleware.use ActionDispatch::Flash

    #    middleware.use ActionDispatch::Static
    #    middleware.use Rack::Lock
        #middleware.use #<ActiveSupport::Cache::Strategy::LocalCache::Middleware:0x007ffd148f9468>
      #  middleware.use Rack::Runtime
     #   middleware.use Rack::MethodOverride
    #    middleware.use ActionDispatch::RequestId
     #   middleware.use Rails::Rack::Logger
    #    middleware.use ActionDispatch::ShowExceptions
    #    middleware.use ActionDispatch::DebugExceptions
    #    middleware.use ActionDispatch::RemoteIp
    #    middleware.use ActionDispatch::Reloader
        middleware.use ActionDispatch::Callbacks
     #   middleware.use ActiveRecord::Migration::CheckPending
        middleware.use ActiveRecord::ConnectionAdapters::ConnectionManagement
      #  middleware.use ActiveRecord::QueryCache
        #middleware.use ActionDispatch::Cookies
    #    middleware.use ActionDispatch::Session::CookieStore
        #middleware.use ActionDispatch::Flash
        middleware.use ActionDispatch::ParamsParser
    #    middleware.use Rack::Head
     #   middleware.use Rack::ConditionalGet
     #   middleware.use Rack::ETag
        #run RackTest::Application.routes
      end
    end
  end
end