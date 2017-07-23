class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [360, 360]

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
