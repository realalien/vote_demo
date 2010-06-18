class Photo < ActiveRecord::Base
  
  validates_uniqueness_of :server_path
    
  #has_one :photo_category
  #has_one :team
  
  #attr_accessor :server_path
  
  ajaxful_rateable :stars => 5 
  
  acts_as_commentable
  
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
  
    def origin_filepath
    if self.server_path
      file_path = File.join( File.dirname(self.server_path), 
                                File.basename(self.server_path, File.extname(self.server_path)) \
                                + File.extname(self.server_path))
      return file_path
    else
      return nil
    end
  end
  
  def add_comment
    commentable_type = params[:commentable][:commentable]
    commentable_id = params[:commentable][:commentable_id]
    # Get the object that you want to comment
    commentable = Comment.find_commentable(commentable_type, commentable_id)
  
    # Create a comment with the user submitted content
    comment = Comment.new(params[:comment])
    # Assign this comment to the logged in user
    comment.user_id = session[:user].id
  
    # Add the comment
    commentable.comments << comment
  
    redirect_to :action => commentable_type.downcase,
      :id => commentable_id
end
  
end
