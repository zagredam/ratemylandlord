class LandlordsController < ApplicationController
  def index
    if params[:search] == nil
      @landlords = Landlord.all
    else
      @landlords = Landlord.search(params[:search])
    end
  end

  def show
    landlord_id = params[:id]
    pagenum = (params[:page] || '1').to_i
    @mylandlord = Landlord.find(landlord_id)
    @reviews = @mylandlord.ratings(pagenum)
    @avg_reviews=@mylandlord.average_ratings
    @color_func = lambda do |rating|
      case rating
      when (3.5..5)
        'greenback'
      when (2..3.4)
        'yellowback'
      else
        'redback'
      end
    end
    @user_id = current_user.id unless current_user.nil?
  end

  def destroy
    landlord = Landlord.find(params[:id])
    if landlord
      Rating.where(landlord_id: landlord.id).destroy_all
      landlord.destroy
    end
    redirect_to landlords_path
  end
end
