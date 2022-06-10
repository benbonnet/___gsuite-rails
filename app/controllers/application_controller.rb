class ApplicationController < ActionController::API
  def index
    DummyWorker.perform_async('foo')
    render(json: "/layouts/placeholder_view")
  end
end
