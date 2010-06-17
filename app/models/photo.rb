class Photo < ActiveRecord::Base
  
  validates_uniqueness_of :server_path
    
  #has_one :photo_category
  #has_one :team
  
  #attr_accessor :server_path
  
  def thumbnail_filename
    if self.server_path
      filename =  File.basename(self.server_path, File.extname(self.server_path)) 
                  + "_thumbnail"  
                  + File.extname(self.server_path)
      logger.debug "--------- thumbnail_filename: #{filename}"
    else
      return nil
    end
  end
  
  # path under the server directory '/public/images/Photo Contest/'
  # the same level of the original path.
  def thumbnail_filepath
    if self.server_path
      file_path = File.join( File.dirname(self.server_path), 
                                File.basename(self.server_path, File.extname(self.server_path)) \
                                + "_thumbnail"   \
                                + File.extname(self.server_path))
      return file_path
    else
      return nil
    end
  end
  
end
