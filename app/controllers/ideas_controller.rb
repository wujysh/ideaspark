class IdeasController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :new
 
  def index
    @ideas = Idea.paginate(page: params[:page])
  end
  
  def new
    @idea = Idea.new
  end 

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      # process when idea got saved
      idea.tag_list = params[:tags]  # seperated by ','
      redirect_to @idea, :success => 'Idea created'
    else
      render 'new'
    end
  end

  def update
    if @idea.update_attributes(idea_params)
      idea.tag_list = params[:tags]
      redirect_to @idea, :success => 'Idea updated'
    else
      render 'edit'
    end
  end

  def show
    @idea = Idea.find(params[:id])
    @tags = @idea.tag_list
  end

  def tagged
    if params[:tag].present? 
      @ideas = Idea.tagged_with(params[:tag]).paginate(page: params[:page])
    else 
      @ideas = Idea.paginate(page: params[:page])
    end  
  end

  def put
    # TODO:
  end

  private
    def idea_params
      params.require(:idea).premit(:title, :content, :phrase, :tags)
    end
end
