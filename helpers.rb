module Helpers
    
  def update_from_params(obj, params)
    obj.title = params[:title]
    obj.ingredients = params[:ingredients]
    obj.method = params[:method]
    obj.source = params[:source]
    obj.categories = params[:categories]
    
  end
  
  def simple_format(text)
    text=text.to_s
    txtarray = text.split("\n")
    txtarray.reject!(&:nil?)
    txtarray.join("<br/><br/>")
    
  end
  
  def titleise(field)
    field.split(/\s+/).each do |s|
      s.capitalize!
    end.join(" ")
  end
    
  
end
  
