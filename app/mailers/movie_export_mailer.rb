class MovieExportMailer < ApplicationMailer
  def send_file(user, file_path)
    attachments["movies.csv"] = File.read(file_path)
    mail(to: user.email, subject: "Your export is ready")
  end
end
