class IdeasController < ApplicationController
  load_and_authorize_resource
 
  def create
  end

  def show
    @idea = Idea.find(params[:id])
  end
end
