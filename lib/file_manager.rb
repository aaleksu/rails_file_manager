require 'file_manager/file_manager.rb'
require 'fileutils'
require 'RMagick'

module FileManager
  def self.upload(file, model_name)
    origin_name = file.original_filename
    image_dir = Rails.root.join('public', 'uploads')
    upload_dir = model_name.to_s
    upload_image_dir = File.join(image_dir, upload_dir)

    name = self.get_unique_name(upload_image_dir, origin_name)

    file_path = File.join(upload_dir, name)

    # create the file path
    path = File.join(image_dir, file_path)

    # write the file
    File.open(path, 'wb') { |f| f.write(file.read) }
    thumbs = self.get_thumbs(upload_image_dir, name)

    p '===================================='
    p thumbs.methods
    p thumbs
    p '===================================='

    return '/uploads/' + file_path
  end

  def self.get_thumbs(dir, source_image_name)
    thumbs = []
    source_image = Magick::Image.read(File.join(dir, source_image_name)).first

    source_image.change_geometry('100x100') { |cols, rows, img|
      new_img = img.resize(cols, rows)
      new_img_name = File.join(dir, '100x100' + source_image_name)
      new_img.write(new_img_name)
      thumbs.push(new_img_name)
    }
    source_image.change_geometry('250x250') { |cols, rows, img|
      new_img = img.resize(cols, rows)
      new_img_name = File.join(dir, '250x250' + source_image_name)
      new_img.write(new_img_name)
      thumbs.push(new_img_name)
    }

    thumbs
  end

  def self.rm(file_path)
    FileUtils.rm(Rails.root.join('public', file_path[1..-1]), :force => true)
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
