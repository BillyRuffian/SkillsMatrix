class SendTeamChangedEmailJob < ApplicationJob
  include SuckerPunch::Job

  def perform user, administrator
    Admin::AdminMailer.teams_changed_email( user, administrator ).deliver_now
  end
end
