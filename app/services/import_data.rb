class ImportData
  def initialize(importer = Movies::Import, organizer = Movies::Organize)
    @importer = importer
    @organizer = organizer
  end

  def self.call(data, params)
    new.call(data, params)
  end

  def call(data, params)
    imported_data = @importer.call(params)
    @organizer.call(data, imported_data)
  end
end
