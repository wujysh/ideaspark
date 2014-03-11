class StaticPagesController < ApplicationController
  def home
    @static_pages = Idea.paginate(page: params[:page], :per_page => 30)
  end

  def help
  end

  def about
  end
end
