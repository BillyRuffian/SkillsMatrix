class SendNewRegistrationEmailJob < ActiveJob::Base
  include SuckerPunch::Job

  def perform new_user
    Admin::AdminMailer.new_registration_email( new_user ).deliver_now
  end
end
