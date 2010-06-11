

require 'RMagick'

class ZhangJiaJiePhotoContestController < ApplicationController
  
  
  ## ----------      task specific infomation     -----------
  ## 
  CONTEST_PHOTOS_SERVING_PATH = File.expand_path("public/images/Photo\ Contest", RAILS_ROOT)
  #RECOGNIZABLE_CATEGORY_NAMES = []
  
  # load 
  def reloadphotos
    # collect team info, 1st dir under CONTEST_PHOTOS_SERVING_PATH
    @group_dirs = Dir.glob(File.join(CONTEST_PHOTOS_SERVING_PATH,"*"))
    teams = []
    @group_dirs.each do |dir|
      team_name = File.basename(dir)
      #team_name.gsub!(",","")
      #team_name.gsub!(" ","")
      teams << team_name
      if not Team.find_by_name(team_name)
        t = Team.new(:name => team_name)
        t.save!
      end
    end
    
    @images = []
    # glob all file under that 
    if @group_dirs and @group_dirs.size >0
      
      @group_dirs.each do | group |
        cat_dir = File.expand_path(group, CONTEST_PHOTOS_SERVING_PATH )
        logger.info "#{cat_dir} processing"
        
        # TODO: catch those missing unknown suffix name
        @files =  Dir.glob(File.join(cat_dir, "**", "*.{JPG,jpg,bmp,BMP,TIFF,tiff,RAW,raw}"))
        
        logger.info "#{@files.size}"
        
        logger.info ">>>>  -#{cat_dir}"
        @files.each do | img |
          # make thumbernail if not exists
          @tmp = Magick::Image::read( File.expand_path(img) ) 
          
          
          
          # create database entry
          img.gsub!(CONTEST_PHOTOS_SERVING_PATH, "")
          img_svr_path = img
          filename = File.basename(img)
          logger.info "#{filename} ; #{img_svr_path}"
          if not @img = Photo.find_by_server_path(img_svr_path)
              @img = Photo.new(:name => filename , :server_path => img_svr_path )
              @img.save!
          else
              # update info?
          end
          
          img_path = File.join("/images/Photo Contest", File.basename(img_svr_path))
          
          filename = File.basename(img, File.extname(img) )+"_thumbnail"  + File.extname(img) 
          
          new_thumbenail_name = File.join(File.basename(img_path), filename)
          
          logger.info "----------------------#{new_thumbenail_name}"
          
          
          make_thumbnail(@tmp[0], new_thumbenail_name)
          
          @images << @img
        end
      end
      
      
      # TODO: clean the database entry which has not correponding files
      
      
    end
    
        
    
    @debug = CONTEST_PHOTOS_SERVING_PATH.inspect
  end

  def showstats
  end

  def make_thumbnail(img, new_name)
    if img.is_a? Magick::Image
      tmp = img.scale(__calc_scale_ratio(img))
      tmp.write(new_name)
    end
  end

  def __calc_scale_ratio(img)
      thumbnail_height = 200.0 # max rows
      if img.is_a? Magick::Image
          return thumbnail_height / img.rows 
      else
        return nil
      end
  end
  
  


  # display the photo in less small size to avoid multiple image loading
  def create_thumbnail
    
  end


end
