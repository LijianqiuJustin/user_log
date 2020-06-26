class <%= log_model %>sWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3, backtrace: true

  def perform(attributes)
    <%= log_model %>.create(attributes)
  end
end