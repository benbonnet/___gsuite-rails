class DummyWorker
  include(Cloudtasker::Worker)

  def perform(some_arg)
    User.update_all(updated_at: Time.zone.now)
    logger.info("Job run with #{some_arg}. This is working!")
  end
end