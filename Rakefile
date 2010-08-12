# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'
require 'RMagick'
require 'parseexcel'
require "spreadsheet/excel" 


desc "Add the default roles(admin, leader, employee)"
task :user_role_init => :environment do
  Role.create( :name => 'admin' )
  Role.create( :name => 'leader' )
  Role.create( :name => 'employee' )
#  
  User.create( :name => "Admin" , 
               :login => "admin" , 
               :email => "ZhuJiaCheng@spicyhorse.com", 
               :password => "123456",
               :password_confirmation => "123456")
#  
#  User.create( :name => "Guest" , 
#               :login => "guest" , 
#               :email => "guest@spicyhorse.com", 
#               :password => "123456",
#               :password_confirmation => "123456")
               
  r = Role.find_by_name("admin")
  u = User.find_by_login("realalien")
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

def line_data(worksheet, row, array_of_data)
    col = 0
    array_of_data ||= []
    array_of_data.each_with_index do | data, idx |
      worksheet.write(row, idx, data)
    end
end

desc ""
task :dump_existing_surveys => :environment do
  
  # create backup directory if not exists
   bak_dir = File.join(RAILS_ROOT,"db/backup")
   if not File.exists? bak_dir
        Dir.mkdir bak_dir
   end
   
   # default import files
   default_file = "export.xls"
   export_surveys_xls = File.join(RAILS_ROOT,"db/backup", default_file)
   
   
  workbook = Spreadsheet::Excel.new(export_surveys_xls)

  @survey_defs = Survey.find :all
  
  @survey_defs.each_with_index do | s , idx|
      worksheet = workbook.add_worksheet(s.title || "Unspecified"+idx)
      row = 0
      line_data(worksheet, row, ["Title:",        s.title])       ; row += 1
      line_data(worksheet, row, ["Description:",  s.description]) ; row += 1
      line_data(worksheet, row, ["Category:",     s.category]) ;    row += 1
      line_data(worksheet, row, ["Target Audience:",     s.target_audience]) ;    row += 1
      line_data(worksheet, row, ["Created At:",     s.created_at.to_s]) ;    row += 1
      line_data(worksheet, row, ["Updated At:",     s.updated_at.to_s]) ;    row += 1
      line_data(worksheet, row, ["Guideline: ",     s.guideline ]) ;    row += 1
      
      tmp = ["Questions:"]
      line_data(worksheet, row, tmp ) ;    row += 1
       # print title
      question_titles = ["title","description","hint","is_commentable","is_rateable","is_voteable","created_at","updated_at","section_id"]
      line_data(worksheet, row, question_titles ) ;    row += 1
      s.questions.each do | q| 
          q_data = []
          q_data << q.title
          q_data << q.description
          q_data << q.hint
          q_data << q.is_commentable.to_s
          q_data << q.is_rateable.to_s
          q_data << q.is_voteable.to_s
          q_data << q.created_at.to_s
          q_data << q.updated_at.to_s
          q_data << q.section_id
          line_data(worksheet, row,  q_data ) ;    row += 1
      end
  end
 
   workbook.close
end


desc "Import surveys data from excel to databasa"
task :import_all_surveys => [:environment, :dump_existing_surveys] do | args|
   
   # create backup directory if not exists
   bak_dir = File.join(RAILS_ROOT,"db/backup")
   if not File.exists? bak_dir
        Dir.mkdir bak_dir
   end
   
   # default import files
   default_file = "import.xls"
   import_surveys_xls = File.join(RAILS_ROOT,"db/backup", default_file)
   
   if args.nil?
     puts "No import Excel file given, using the default one..."
     puts ">>> #{import_surveys_xls}\n"
   end
      
   workbook = Spreadsheet::ParseExcel.parse(import_surveys_xls)
   
#     puts " -----------  book methods: "
#   workbook.methods.sort.each  { | m| puts "#{m} "}
  
   num_sheets = workbook.sheet_count
     
  

  puts " -----------  sheet methods: "
  worksheet =  workbook.worksheet(0)
  worksheet.methods.sort.each  { | m| puts "#{m} "}  

   (1..num_sheets).each do | num |
       worksheet = workbook.worksheet(num - 1)     
       
       survey_data_column_idx = 1
       
#       s = Survey.new
#       s.title =            worksheet.row(0).at(survey_data_column_idx).to_s   ; puts s.title
#       s.description =      worksheet.row(1).at(survey_data_column_idx).to_s   ; puts s.description
#       s.category =         worksheet.row(2).at(survey_data_column_idx).to_s   ; puts  s.category
#       s.target_audience =  worksheet.row(3).at(survey_data_column_idx).to_s   ; puts s.target_audience
#       s.created_at =       worksheet.row(4).at(survey_data_column_idx).to_s   ; puts s.created_at 
#       s.updated_at =       worksheet.row(5).at(survey_data_column_idx).to_s   ; puts s.updated_at 
#       s.guideline =        worksheet.row(6).at(survey_data_column_idx).to_s   ; puts s.guideline 
#       
#       puts "New survey"
#       puts s
       
   
       ## get survey and its questions.
#       worksheet.each o 




   worksheet.each { |row|
      puts row.to_a
   }
#      j=0
#      i=0
#      if row != nil
#      row.each { |cell|
#        if cell != nil
#          contents = cell.to_s('latin1')
#          puts "Row: #{j} Cell: #{i} #{contents}"
#          end
#          i = i+1
#        }
#        j = j +1
#        end
#      }  
    end
   
         
   
   puts "***************************************************"
   puts " Remember to copy the /db/backup/* to a safe place! "
   puts "***************************************************"
   
   
end


desc "backup vote_demo_db, dump the db vote_demo_development to a .sql file for data backup"
task :backup_db do
  
end




