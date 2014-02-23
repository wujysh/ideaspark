class StaticPagesController < ApplicationController
  def home
    @idea = Idea.all
  end

  def help
  end

  def about
  end
end
