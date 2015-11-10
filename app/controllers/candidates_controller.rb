class CandidatesController < ApplicationController
	
	def index
		@candidates=Candidate.all.order(:id).reverse_order.page(params[:page]).per(100)
	end

end
