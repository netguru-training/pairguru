require "csv"

class MovieExporter
  def call(user, file_path)
    CSV.open(file_path, "wb", csv_options) do |csv|
      Movie.all.each do |movie|
        csv << [movie.title, movie.description]
      end
    end
    sleep(5) # this emulates long export, do not remove
    MovieExportMailer.send_file(user, file_path).deliver_now
  end

  private

  def csv_options
    {
      write_headers: true,
      headers: %w(title description),
      col_sep: ";",
    }
  end
end
