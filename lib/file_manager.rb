require 'file_manager/file_manager.rb'

module FileManager
  def self.upload_file(file, model_name)
    origin_name = file.original_filename
    name = origin_name
    #image_dir = Rails.root.join('app', 'assets', 'images')
    image_dir = Rails.root.join('public', 'uploads')
    upload_dir = model_name.to_s

    i = 1
    while File.exists?(File.join(image_dir, upload_dir, name)) do
      name = i.to_s + '_' + origin_name
      i += 1
    end

    file_path = File.join(upload_dir, name)

    # create the file path
    path = File.join(image_dir, file_path)

    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }

    return '/uploads/' + file_path
  end
end
