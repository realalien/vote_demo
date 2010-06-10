
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
        
        @files.each do | img |
          img.delete!(CONTEST_PHOTOS_SERVING_PATH)
          img_svr_path = img
          filename = File.basename(img)
          logger.info "#{filename} ; #{img_svr_path}"
          if not @img = Photo.find_by_server_path(img_svr_path)
              @img = Photo.new(:name => filename , :server_path => img_svr_path )
              @img.save!
          else
              # update info?
          end
          @images << @img
        end
      end
      
    end
    
        
    
    @debug = CONTEST_PHOTOS_SERVING_PATH.inspect
  end

  def showstats
  end

end
