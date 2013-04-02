require 'rubygems'
require 'sinatra'
require 'mongoid'
require 'erector'
require_relative './views'
require_relative './helpers'

include Views
include Helpers



set :root, File.dirname(__FILE__)
set :environment, :development

also_reload (settings.root + '/views')

class Recipe
    include Mongoid::Document
    field :title
    field :ingredients
    field :method
    field :source
    field :categories # tags as csv! or single string search is regex
    field :created_at
    
    
end

Mongoid.load!(settings.root + "/mongoid.yml")


get '/' do
    @recipes = Recipe.asc(:title)
    Index.new(:recipes => @recipes).to_html
end

get '/:letter' do |letter|
  pass if letter.length > 1
  @recipes = Recipe.where(:title => /^#{letter}/ )
  Index.new(:recipes => @recipes).to_html
end

get '/new' do
    @recipe = Recipe.new
    New.new(:recipe => @recipe).to_html
end

post '/create' do
  
    @recipe = Recipe.new
    update_from_params(@recipe,params)
    @recipe.created_at = Time.now
    @recipe.save
    redirect '/'
end

get '/show/:id' do
  @recipe = Recipe.find(params[:id])
   Show.new(:recipe => @recipe).to_html
end

get '/edit/:id' do
  @recipe=Recipe.find(params[:id])
  Edit.new(:recipe =>@recipe).to_html
end

post '/update' do
    @recipe=Recipe.find(params[:id])
    update_from_params(@recipe,params)
    @recipe.save
    redirect '/'
  end
  
  get'/delete/:id' do
    @recipe=Recipe.get(params[:id])
    @recipe.destroy
    redirect '/'
  end
  
  #searches
  post '/tagsearch' do
  @recipes = Recipe.where(:categories => /#{params[:tag]}/)
  Index.new(:recipes => @recipes).to_html
  end
  
  post '/bywhosearch' do
     @recipes = Recipe.where(:source => /#{params[:tag]}/)
     Index.new(:recipes => @recipes).to_html
  end
  
  post '/ingredsearch' do
    @recipes = Recipe.where(:ingredients => /#{params[:tag]}/)
     Index.new(:recipes => @recipes).to_html
  end
  
  #utility
  
  get '/retitle' do
    recipes = Recipe.where(:title => /(\b[^A-Z][a-z]+\b)+/ )
    recipes.each do |r|
      r.title = titleise r.title
      r.save
    end
    redirect '/'
  end
  