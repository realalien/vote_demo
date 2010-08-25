class StatController < ApplicationController
  def report
    if params[:survey_id]
      @survey_sheet = self.current_user.survey_sheets.find(params[:survey_id])
      logger.debug "-------------------------------------"
      logger.debug @survey_sheet.responses.size
      logger.debug "-------------------------------------"
    else
      render :text => "Please assign a survey to investigate."
    end
        
    @graph = open_flash_chart_object(600,300,"/stat/graph_code")
  end
  
  # all previously 
  def history_data(question_id)
    
  end
  
  
  def graph_code
    # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/data-lines-2.php
    # and parts from this example - http://teethgrinder.co.uk/open-flash-chart-2/x-axis-labels-3.php
    title = Title.new("Multiple Lines")

    data1 = []
    data2 = []
    data3 = []

    10.times do |x|
    data1 << rand(5) + 1
    data2 << rand(5) + 3
    data3 << rand(5) + 5
    end

    line_dot = LineDot.new
    line_dot.width = 4
    line_dot.colour = '#DFC329'
    line_dot.dot_size = 5
    line_dot.values = data1

    line_hollow = LineHollow.new
    line_hollow.width = 1
    line_hollow.colour = '#6363AC'
    line_hollow.dot_size = 5
    line_hollow.values = data2

    line = Line.new
    line.width = 1
    line.colour = '#5E4725'
    line.dot_size = 5
    line.values = data3

    # Added these lines since the previous tutorial
    tmp = []
    x_labels = XAxisLabels.new
    x_labels.set_vertical()

    ["Jan.", "Feb.", "March","Apr.","May","June","July","Aug.","Sept.","Oct.","Nov.", "Dec."].each do |text|
      tmp << XAxisLabel.new(text, '#0000ff', 10, 'diagonal')
    end

    x_labels.labels = tmp

    x = XAxis.new
    x.set_labels(x_labels)

    y = YAxis.new
    y.set_range(0,10,1)

    x_legend = XLegend.new("2010 Monthly")
    x_legend.set_style('{font-size: 20px; color: #778877}')

    y_legend = YLegend.new("Rating")
    y_legend.set_style('{font-size: 20px; color: #770077}')

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.x_axis = x # Added this line since the previous tutorial
    chart.y_axis = y

    chart.add_element(line_dot)
    chart.add_element(line_hollow)
    chart.add_element(line)

    render :text => chart.to_s
  end

end
