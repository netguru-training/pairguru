class ExportMoviesWorker < BaseWorker
  def perform(user_id, file_path)
    user = User.find(user_id)
    MovieExporter.call(user, file_path)
  end
end
