class IdeasController < ApplicationController
 
  def index
    @ideas = Idea.paginate(page: params[:page], :per_page => 30)
  end
  
  def new
    @idea = Idea.new
  end 

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to @idea, :success => 'Idea created.'
    else
      render 'new'
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])

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

    if @idea.liked_by current_user
      render :json => { :message => 'Upvote successfully' }
    else
      render :json => { :message => 'Cannot upvote' }
    end
  end

  def downvote
    @idea = Idea.find(params[:id])

    if @idea.downvote_by current_user
      render :json => { :message => 'Downvote successfully' }
    else
      render :json => { :message => 'Cannot downvote' }
    end
  end

  private
    def idea_params
      params.require(:idea).permit(:title, :content, :phase, :tag_list)
    end
end
