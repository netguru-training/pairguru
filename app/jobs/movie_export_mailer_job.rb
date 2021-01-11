MovieExportMailerJob = Struct.new(:user_id, :file_path) do
  def perform
    user = User.find(user_id)
    MovieExportMailer.send_file(user, file_path).deliver_now
  end

  def queue_name
    "export_csv"
  end
end
