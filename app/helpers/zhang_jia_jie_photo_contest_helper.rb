module ZhangJiaJiePhotoContestHelper
  
  ZJJ_CONTEST_WEB_PATH = "/images/Photo Contest"
  
  def __calc_scale_ratio(img)
    thumbnail_height = 200.0 # max rows
    if img.is_a? Magick::Image
      return thumbnail_height / img.rows 
    else
      return nil
    end
  end
  
  def thumbnail_path(photo)
    if photo.is_a? Photo
      return File.join(ZJJ_CONTEST_WEB_PATH, photo.thumbnail_filepath)
    else
      return nil
    end
  end
  
    def thumbnail_abspath(the_contest_path)
    #img_path = File.join("/images/Photo Contest", the_contest_path)
    #logger.debug "img_path----------------------#{img_path}"
    
    new_name4icon = File.basename(the_contest_path, File.extname(the_contest_path)) + "_thumbnail" + File.extname(the_contest_path)
    thumbenail_relpath = File.join(File.dirname(the_contest_path), new_name4icon)
    
    #logger.debug "thumbnail new name----------------------#{new_name4icon}"
    #logger.debug "thumbenail_relpath ----------------------#{thumbenail_relpath}"
    
    # create thumbnails to absolute path of file system.
    thumb_nail_abs_filepath = File.join(CONTEST_PHOTOS_SERVING_ABS_PATH, thumbenail_relpath)
    return thumb_nail_abs_filepath
  end
  
  
  # display the photo in less small size to avoid multiple image loading
  def make_thumbnail(img, new_file_path)
    if img.is_a? Magick::Image
      tmp = img.scale(__calc_scale_ratio(img))
      tmp.write(new_file_path)
    end
  end
  
  def extract_category_from_path(relpath)
     File.basename(File.dirname(relpath))
  end
 
end
