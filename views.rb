module Views
  
  class Layout < Erector::Widget
  def content
    html do
      head do
        css '/styles.css'
        title "Davis Recipes"
        link :rel => "SHORTCUT ICON",:href => "/recipes.ico"
      end#html
      body do
        img :src =>'/sweetpea1-cutout.png', :class => 'leftpic'   
        div :class => 'main' do
          h1 do
            a("*", :href =>'/')
            text "Davis Family Recipes (" 
         a("add recipe", :href =>'/new')
         text " )"
      end
           main_area
        end#main
      end#body
    end#html
  end#content
  
  def main_area
    text "placeholder"
  end#main_area
  
  end#Layout
  
  
  class Index < Layout
   
    def main_area
      div.form do
        form :action => '/tagsearch', :method => :post do
          label "search by tag"
          input :name => 'tag', :id => 'tag', :type => 'text'
          input :type => 'submit', :value => 'search'
        end
      end
      div.form do
        form :action => '/bywhosearch',:method => :post do
         label "search by source"
         input :name => 'tag', :id => 'tag', :type => 'text'
         input :type => 'submit', :value => 'search'
      end
      end
      div.form do
        form :action => '/ingredsearch',:method => :post do
         label "search by ingredient"
         input :name => 'tag', :id => 'tag', :type => 'text'
         input :type => 'submit', :value => 'search'
      end
      end
      
      div.alphabet do
        ("A".."Z").each do |alpha|
          a alpha, :href => "\/#{alpha}"
        end
          
      end
      div.list do
        ul do
           @recipes.each do |recipe|
            li { a( recipe.title, :href => "\/show\/#{recipe.id}") }
        end
      end
      end
    end
  end#Index
  
  class Show < Layout
    
    def main_area
      
      a "Back", :href => '/' 
      text ' | '
      a "Edit",  :href => "\/edit\/#{@recipe.id}"
      text ' | '
      a "Compact", :href => "\/compact\/#{@recipe.id}"
      h1 @recipe.title.to_s
      div :class=>"half-left" do
        h3 "Ingredients"
        rawtext  simple_format @recipe.ingredients
        h3 "Tags"
        p @recipe.categories.to_s
      end
      div :class=>"half-right" do
       h3 "Method" 
       rawtext  simple_format @recipe.method
		   br
       p do
        b @recipe.source.to_s
        rawtext "&nbsp;&nbsp;"
        text "Recipe added: #{@recipe.created_at.strftime('%d-%m-%Y %H:%M:%S')}"
       end
      end
      div :style =>"clear:both;"
    end
 end#Show
  
  
  class Edit < Layout
    def main_area
      a "Back", :href => '/'
      br
      h1 "Edit Recipe"
      form :action => '/update', :method => :post do
        input :name => 'id', :value => @recipe.id, :type => 'hidden'
	      label "Title"
	      input :id => 'title',:name => 'title', :type => 'text', :value => @recipe.title
	      br
	      label "Ingredients"
        textarea :id => 'ingredients', :name => 'ingredients', :rows => 10, :cols => 70 do 
          text @recipe.ingredients
        end
	      br
	      label "Method"
        textarea :id => 'method', :name => 'method', :rows => 10, :cols => 70 do 
          text @recipe.method
        end
        br
        label "Tags"
        input.long :name => 'categories', :id => 'categories', :type => 'text', :value => @recipe.categories
        br
	      label "Source"
	      input.long :id =>'source',:name => 'source', :type => 'text', :value => @recipe.source
	      br
        div :class =>'btn' do
	        input :type => 'submit', :value => "Update" 
        end
     end#form
    end#main_area
  end#Edit
 
  class New < Layout
    def main_area
      a "Back", :href => '/'
	    h1 "New Recipe"
	    form :action => '/create', :method => :post do
        input :name => 'id', :value => @recipe.id, :type => 'hidden'
        label "Title"
	      input :id => 'title',:name => 'title', :type => 'text'
	      br
	      label "Ingredients"
	      textarea :id => 'ingredients',:name => 'ingredients', :rows => 10, :cols => 70 
	      br
	      label "Method"
	      textarea :id => 'method',:name => 'method',  :rows => 10, :cols => 70
	      br
        label "Tags"
        input :name => 'categories', :id => 'categories', :type => 'text'
        br
	      label "Source"
	      input :id =>'source', :name => 'source', :type => 'text'
	      br
        div :class =>'btn' do
	        input :type => 'submit', :value => "Create Recipe"
        end
	    end
    end
end  
  
end
