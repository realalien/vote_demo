# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'
require 'RMagick'

desc "Add the default roles(admin, leader, employee)"
task :user_role_init => :environment do
#  Role.create( :name => 'admin' )
#  Role.create( :name => 'leader' )
#  Role.create( :name => 'employee' )
#  
#  User.create( :name => "Admin" , 
#               :login => "admin" , 
#               :email => "ZhuJiaCheng@spicyhorse.com", 
#               :password => "123456",
#               :password_confirmation => "123456")
#  
#  User.create( :name => "Guest" , 
#               :login => "guest" , 
#               :email => "guest@spicyhorse.com", 
#               :password => "123456",
#               :password_confirmation => "123456")
               
  r = Role.find_by_name("admin")
  u = User.find_by_login("zhujiacheng2")
  if r and u
    u.roles << r
    u.save!
  end
end


desc "Regenerate thumbnails"
task :gen_thumb => :environment do
    include ZhangJiaJiePhotoContestHelper
    CONTEST_PHOTOS_SERVING_ABS_PATH = File.expand_path("public/images/Photo\ Contest", RAILS_ROOT)
    
    # collect team info, those are the 1st dir under CONTEST_PHOTOS_SERVING_ABS_PATH
    puts "Processing teams info ..."
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
    puts "Processing photo category info ..."
    if @group_dirs and @group_dirs.size >0
      @group_dirs.each do | grp_dir |
        # create new category objects
        categories_dirs = Dir.glob(File.join(grp_dir, "*"))
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
        #puts  "processing grp_dir: #{grp_dir} ..."
        
        # TODO: catch those missing unknown suffix name
        @files =  Dir.glob(File.join(grp_dir, "**", "*.{JPG,jpg,bmp,BMP,TIFF,tiff,RAW,raw}"))
        puts "  -----------   Total image files: #{@files.size}  ---------"
        
        @files.each do | file_abs_path |
          if file_abs_path =~ /_thumbnail/
            next # Do not process any file with 'thumbnail' in the name, which probably are the files generated for overview.
          else
            puts "Handling file : file_abs_path => #{file_abs_path} ; "
            the_contest_path = file_abs_path.dup
            the_contest_path.gsub!(CONTEST_PHOTOS_SERVING_ABS_PATH, "")
            filename = File.basename(file_abs_path)

#            puts "----------file_abs_path => #{file_abs_path} ; "
#            puts "----------the_contest_path => #{the_contest_path}"
#            puts "----------filename =>  #{filename}"
            
            # create database entry if not exists, also add Team and PhotoCategory infomation
            if not @img = Photo.find_by_server_path(the_contest_path)
              @img = Photo.new(:name => filename , :server_path => the_contest_path )
              #puts "----------grp =>  #{grp.name}"
              @img.team_id = grp.id
              category = extract_category_from_path(the_contest_path)
              #puts "----------category =>  #{category}"
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
            unless  File.exists?(icon_abspath)
              puts " ......generating thumbnail => #{icon_abspath} ; "
              @tmp = Magick::Image::read( File.expand_path(file_abs_path) ) 
              make_thumbnail(@tmp[0], icon_abspath)
            end
            
            # test 
            #@images << @img
          end
        end
      end
      
      
      # TODO: clean the database entry which has not correponding files
      
      
    end
    
    
    
    @debug = CONTEST_PHOTOS_SERVING_ABS_PATH.inspect
end

