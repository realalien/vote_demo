module SurveySheetsHelper
  
  # find the
  # Q: can I refer to the objects in the controller
  # Q: how do I debug this function? in script/console, then how?
  # ESP: it is ensured that questions and responses are constructed correctly 
  def that_user_response(question)
    if @survey_sheet.respond_to?("responses")
      @survey_sheet.responses.each do | r |
        if r.question_id == question.id
          return r
        end
      end
      return nil
    end
  end
end
