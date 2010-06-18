

require 'RMagick'

class ZhangJiaJiePhotoContestController < ApplicationController
  
  include ZhangJiaJiePhotoContestHelper
  layout "site"
  
  ## ----------      task specific infomation     -----------
  CONTEST_PHOTOS_SERVING_ABS_PATH = File.expand_path("public/images/Photo\ Contest", RAILS_ROOT)
  #RECOGNIZABLE_CATEGORY_NAMES = []
  
  def reload
    # collect team info, those are the 1st dir under CONTEST_PHOTOS_SERVING_ABS_PATH
    @group_dirs = Dir.glob(File.join(CONTEST_PHOTOS_SERVING_ABS_PATH,"*"))
    teams = []
    @group_dirs.each do |dir|
      team_name = File.basename(dir)
      teams << team_name
      if not Team.find_by_name(team_name)
        t = Team.new(:name => team_name)
        t.save!
      end
    end
    
    #@images = []
    @thumbnails_paths = []
    
    # glob all file under that 
    if @group_dirs and @group_dirs.size >0
      @group_dirs.each do | grp_dir |
        logger.info ">>>>group dir -------------- #{grp_dir}"
        # create new category objects
        categories_dirs = Dir.glob(File.join(grp_dir, "*"))
        logger.debug "#{categories_dirs} ==================="
        categories_dirs.each do | cat_dir |
          c = PhotoCategory.find_by_name File.basename(cat_dir)
          unless c
             c = PhotoCategory.new(:name  => File.basename(cat_dir) )
             c.save!
          end
        end
          
        # cache group object for photo relationships
        team_name = File.basename(grp_dir)
        grp = Team.find_by_name(team_name)
        unless grp
          grp = Team.new(:name => team_name )
          grp.save!
        end
        
        
        grp_dir = File.expand_path(grp_dir, CONTEST_PHOTOS_SERVING_ABS_PATH )
        logger.info "processing grp_dir: #{grp_dir} "
        
        # TODO: catch those missing unknown suffix name
        @files =  Dir.glob(File.join(grp_dir, "**", "*.{JPG,jpg,bmp,BMP,TIFF,tiff,RAW,raw}"))
        logger.debug "Total image files: #{@files.size}"
        
        @files.each do | file_abs_path |
          logger.debug "file_abs_path => #{file_abs_path} ; "

          if file_abs_path =~ /_thumbnail/
            next # Do not process any file with 'thumbnail' in the name, which probably are the files generated for overview.
          else
            the_contest_path = file_abs_path.dup
            the_contest_path.gsub!(CONTEST_PHOTOS_SERVING_ABS_PATH, "")
            filename = File.basename(file_abs_path)

            logger.debug "----------file_abs_path => #{file_abs_path} ; "
            logger.debug "----------the_contest_path => #{the_contest_path}"
            logger.debug "----------filename =>  #{filename}"
            
            # create database entry if not exists, also add Team and PhotoCategory infomation
            if not @img = Photo.find_by_server_path(the_contest_path)
              @img = Photo.new(:name => filename , :server_path => the_contest_path )
              logger.debug "----------grp =>  #{grp.name}"
              @img.team_id = grp.id
              category = extract_category_from_path(the_contest_path)
              logger.debug "----------category =>  #{category}"
              cate = PhotoCategory.find_by_name category
              if cate
                @img.photo_category_id = cate.id
              else
                #TODO: reporting....
              end
              @img.save!
            else
              # TODO: update info?
            end
            
            
            # make thumbernail if not exists
            icon_abspath = thumbnail_abspath(the_contest_path)
            unless  File.exists(icon_abspath)
              @tmp = Magick::Image::read( File.expand_path(file_abs_path) ) 
              make_thumbnail(@tmp[0], icon_abspath)
            end
            
            # test 
            #@images << @img
          end
        end
      end
    end
    
    @debug = CONTEST_PHOTOS_SERVING_ABS_PATH.inspect
  end
  
  def statistics
     @top3 = Photo.find(:all, :order => "rating_average DESC" , :limit => 3)
     
     @team_scores = Photo.calculate(:sum, :rating_average, :group => :team_id)
          
  end
  
  
  def display
    @team_ids = Team.find(:all).collect(&:id)
    @photo_group_by_categories = {}
    @photos = Photo.find :all
    
    @cat_ids = PhotoCategory.find(:all).collect(&:id)
    
    # convert objects into 2 levels of dict(hashtable)
#    @photos.each do |p |
#        @photo_group_by_categories[p.photo_category.id] ||= {}
#        @photo_group_by_categories[p.photo_category.id][p.team_id] ||= []
#        @photo_group_by_categories[p.photo_category.id][p.team_id] << p
#    end
#     logger.debug "++++++++++++++++++++++++++++++"
#     logger.debug "#{@photo_group_by_categories}"
  end
  
  # the_contest_path - image path under the dir '/images/Photo Contest/'
  

  
end
