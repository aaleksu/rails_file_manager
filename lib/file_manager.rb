require 'file_manager/file_manager.rb'
require 'fileutils'
require 'RMagick'

module FileManager
  @images_extensions = ['.jpg', '.png', '.gif']
  def self.upload(file, model_name)
    FileUtils.mkdir(Rails.root.join('public', 'uploads', model_name)) unless File.exists?(Rails.root.join('public', 'uploads', model_name))

    origin_name = file.original_filename
    image_dir = Rails.root.join('public', 'uploads')
    upload_dir = model_name.to_s + '/'
    upload_image_dir = File.join(image_dir, upload_dir)

    name = self.get_unique_name(upload_image_dir, origin_name)

    file_path = File.join(upload_dir, name)

    # create the file path
    path = File.join(image_dir, file_path)

    # write the file
    File.open(path, 'wb') { |f| f.write(file.read) }
    thumbs = {}
    thumbs = self.get_thumbs(upload_image_dir, name) if @images_extensions.include?(File.extname(name))

    upload_result = {
      'origin' => '/uploads/' + file_path,
      'thumbs' => thumbs
    }

    upload_result
  end

  def self.get_thumbs(dir, source_image_name)
    thumb_dir = dir.to_s.sub(Rails.root.join('public').to_s, '')
    thumbs = {}
    source_image = Magick::Image.read(File.join(dir, source_image_name)).first

    source_image.change_geometry('100x100') { |cols, rows, img|
      thumb = img.resize(cols, rows)
      thumb_file_name = '100x100_' + source_image_name
      thumb_name = File.join(dir, thumb_file_name)
      thumb.write(thumb_name)
      thumbs['100x100'] = thumb_dir + thumb_file_name
    }

    source_image.change_geometry('250x250') { |cols, rows, img|
      thumb = img.resize(cols, rows)
      thumb_file_name = '250x250_' + source_image_name
      thumb_name = File.join(dir, thumb_file_name)
      thumb.write(thumb_name)
      thumbs['250x250'] = thumb_dir + thumb_file_name
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
