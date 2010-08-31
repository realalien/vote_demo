class StatController < ApplicationController
  def report
    if params[:survey_id]
        @qid_to_graph = {} # to store multiple graphs by question ids
        @survey_sheet = self.current_user.survey_sheets.find_by_survey_id(params[:survey_id])
        
        @survey_sheet.responses.each do | resp |
           
            logger.debug " ````````  generating graph for question # #{resp.question.id} ...... ///////"
            graph = open_flash_chart_object(600,300,"/stat/graph_code_gen?survey_id=#{params[:survey_id]}&question_id=#{resp.question.id}" )
            @qid_to_graph.update ( { resp.question.id => graph })
        end
        
    end
  end
  
  # all previously 
  def history_datafor_question(question_id)
      
  end

  def graph_code_gen()
     if params[:survey_id]
        @survey_sheet = self.current_user.survey_sheets.find_by_survey_id(params[:survey_id], params[:question_id])
        
        # Note: 
        # * the supposing way to retrieve verions of reponses is
        #   a sheet -> some responses(of the user by default) ; a response -> some versions
        #   it looks through questions may cause errors because of the model relations
        logger.debug "---------///////  @survey_sheet.id: #{@survey_sheet.id}"
        logger.debug "//////// -----  @survey_sheet.responses.size : |||||    #{@survey_sheet.responses.size}"
        
        rating_history = {}
        @survey_sheet.responses.each do | resp |
          logger.debug " @@@@@@@@@ Try to locating response,  checking response with question id #{resp.question.id}, creteria: #{params[:question_id]}"
          
          # due to class of different number
          if resp.question.id.to_s == params[:question_id]   #TODO: refactor
            logger.debug "//////// find target response of question #{params[:question_id]}  |||||  #{resp.response_versions.size}"
            
            # Note: due to ajax-rating, each star rating operation will create a version record 
            #       for a response (imply: any time user click the stars, the average value will be affected!)
            #       For the moment, instead of preventing users from inputing, here I will evaluate the revisions
            #       based on new value and input timestamp ( which can be used to distinguish unintentional input; 
            #       eliminate new revisions caused by clicking Save comment button;)
            
            rating_history = apply_data_filtering_just_for_presentation(rating_history)  # try to reuse in data processing. # ATTENTION: rule must be explicit!!!!
            
            # To solve the problem,  following ideas can be tried out.
            # * limit the user to do the rating less regularly, maybe weekly, monthly or quarterly.
            # * MORE: any steps ( collecting, counting, calculating, presenting) for this auditing/statistic function.
            
            previous_rating = 0 
            resp.response_versions.each do | ver |
              logger.debug "~~~~~~~~~~~~~~~  for version #{ver.version} ==== rating : #{ver.rating} , timestamp #{ver.updated_at} "
              rating_history.update( { ver.updated_at.to_s => ver.rating } ) 
            end
          end
        end
        chart = gen_response_version_graph rating_history, "of question # #{params[:question_id]}"
        render :text => chart.to_s # even without data diagram can be displaced to be a placeholder
      end
  end

  # TODO: presents in a monthly/quarterly manner
  
  # all_time_rating_values, 
  def apply_data_filtering_just_for_presentation(all_time_rating_values)
      
      filtered = {}
      
      previous_timestamp = nil
      previous_rating = -1
      all_time_rating_values.sort.each_with_index do | map , idx |
          
          # scenarion and rule: if within one day and rating not change, 
          logger.debug "map   key: #{map.key}  =>  value #{map.value} ....  idx :  #{idx}"
          
          # copy to timestamp for comparing and judging
          previous_timestamp = map.key
          previous_rating = map.value
          
      end
      
      filtered = all_time_rating_values
      return filtered
  end


  # rating_history: a timestamp-rating map, sorted by key
  def gen_response_version_graph(rating_history, question_used_as_title)
      
     # TODO: sanity check
     
      # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
      # and parts from this example - http://teethgrinder.co.uk/open-flash-chart-2/x-axis-labels-3.php
      title = Title.new("#{question_used_as_title}")
      
      data1 = []
      
      rating_history.keys.sort.each do | item | 
        data1 << rating_history["#{item}"]
      end
    
      logger.debug " ///////////////   #{data1.join(",")}   ///////...."
  
      line_dot = LineDot.new
      line_dot.width = 4
      line_dot.colour = '#DFC329'
      line_dot.dot_size = 5
      line_dot.values = data1

      # Added these lines since the previous tutorial
      tmp = []
      x_labels = XAxisLabels.new
      x_labels.set_vertical()
      rating_history.keys.sort.each do |text|
        tmp << XAxisLabel.new(text, '#0000ff', 10, 'diagonal')
      end
      x_labels.labels = tmp

      x = XAxis.new
      x.set_labels(x_labels)
      y = YAxis.new
      y.set_range(0,10,1)
  
      x_legend = XLegend.new("2010 Monthly")
      x_legend.set_style('{font-size: 20px; color: #778877}')
      y_legend = YLegend.new("Monthly Average Rating")
      y_legend.set_style('{font-size: 20px; color: #770077}')

      chart =OpenFlashChart.new
      chart.set_title(title)
      chart.set_x_legend(x_legend)
      chart.set_y_legend(y_legend)
      chart.x_axis = x # Added this line since the previous tutorial
      chart.y_axis = y

      chart.add_element(line_dot)
      
      return chart
  end
end
