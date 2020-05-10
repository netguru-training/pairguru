class CsvMoviesExportJob < ApplicationJob
  queue_as :default

  def perform(user, file_path)
    # Do something later
    MovieExporter.new.call(user, file_path)
  end
end
