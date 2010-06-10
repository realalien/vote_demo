class ZhangJiaJiePhotoContestController < ApplicationController
  
  
  ## ----------      task specific infomation     -----------
  ## 
  CONTEST_PHOTOS_SERVING_PATH = "public/images/Photo\ Contest"
  
  
  # load 
  def reloadphotos
    @dirs = Dir.glob(CONTEST_PHOTOS_SERVING_PATH)
    #@files = 
  end

  def showstats
  end

end
