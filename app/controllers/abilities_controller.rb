class AbilitiesController < ApplicationController
  
  def index
    @abilities=Ability.all
    respond_to do |format|
      format.json {render json: @abilities}
    end
  end
end
