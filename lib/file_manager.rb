require 'file_manager/file_manager.rb'
require 'fileutils'

module FileManager
  def self.upload(file, model_name)
    origin_name = file.original_filename
    image_dir = Rails.root.join('public', 'uploads')
    upload_dir = model_name.to_s

    name = self.get_unique_name(File.join(image_dir, upload_dir), origin_name)

    file_path = File.join(upload_dir, name)

    # create the file path
    path = File.join(image_dir, file_path)

    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }

    return '/uploads/' + file_path
  end

  def self.rm(file_path)
    FileUtils.rm(Rails.root.join('public', file_path[1..-1]))
  end

  private
    def self.get_unique_name(path, origin_name)
      name = origin_name
      i = 1
      while File.exists?(File.join(path, name)) do
        name = i.to_s + '_' + origin_name
        i += 1
      end
      name
    end
end
