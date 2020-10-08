class HomesController < ApplicationController
  def index
    flash[:notice] = "Signed out successfully."
  end

  def about
  end
end
