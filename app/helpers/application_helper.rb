# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Google tranlation service
  def translate( text, to, from='en' )
    
    base = 'http://ajax.googleapis.com/ajax/services/language/translate' 
    
    # assemble query params
    params = {
    :langpair => "#{from}|#{to}", 
    :q => text,
    :v => 1.0  
    }
    
    query = params.map{ |k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')
    
    # send get request
    response = Net::HTTP.get_response( URI.parse( "#{base}?#{query}" ) )
    json = JSON.parse( response.body )
    
    if json['responseStatus'] == 200
      json['responseData']['translatedText']
    else
      raise StandardError, response['responseDetails']
    end
  end
end
