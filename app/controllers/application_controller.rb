class ApplicationController < ActionController::API
  def index
    render(json: {ok: :cool})
  end

  def create_session
    DummyWorker.perform_async("HELLO WORLD!!")
    user = User.from_omniauth(request.env['omniauth.auth'])
    render(json: user)
  end
end
