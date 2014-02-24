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
    else
      render 'new'
    end
  end

  def update
    if @idea.update_attributes(idea_params)
      redirect_to @idea, :success => 'Idea updated'
    else
      render 'edit'
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end
  
  def upvote
    @idea = Idea.find(params[:id])
    @idea.liked_by current_user
      render :json => { :message => 'Upvote successfully' }
    else
      render :json => { :message => 'Cannot upvote' }
    end

  def downvote
    @idea = Idea.find(params[:id])
    @idea.downvote_by current_user
      render :json => { :message => 'Downvote successfully' }
    else
      render :json => { :message => 'Cannot downvote' }
    end
  end

  private
    def idea_params
      params.require(:idea).premit(:title, :content, :phrase)
    end
end
