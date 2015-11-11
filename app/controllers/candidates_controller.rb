require 'pp'

class CandidatesController < ApplicationController
	
  
  before_filter do
    @page_crumbs << ["Кандидаты", candidates_path]
  end
  
  before_filter only: [:show,:edit,:update,:destroy] do
		@candidate=Candidate.find(params[:id])
    @page_crumbs << [@candidate.name, @candidate]
  end
  
	def index
		@candidates=Candidate.all.order(:id).reverse_order.page(params[:page]).per(100)
	end
	
	def show
		@abilities=@candidate.abilities
    @vacancies=Vacancy.active.includes(:abilities).joins(:vacancy_abilities).where(vacancy_abilities: {ability_id: @abilities}).group("vacancies.id").order("count(vacancies.id) desc").order("vacancies.salary desc").page(params[:page]).per(20)
			
	end
  
  def new
    @page_crumbs << ["Новый", [:edit,@candidate]]  
    @candidate=Candidate.new unless @candidate
    render :form
  end
  
  def create
    @candidate=Candidate.create safe_params
    
    if @candidate.valid?
      redirect_to [:edit,@candidate]
    else
      new
    end
  end
  
  def edit
    @page_crumbs << ["Редактирование", [:edit,@candidate]]  
    render :form
  end
  
  def update
    @candidate.update(safe_params)
    edit
  end
  
  def destroy
    @candidate.destroy
    redirect_to [:candidates]
  end

  def safe_params
    safe=params.require(:candidate).permit(:name,:contact_info,:salary,:is_active,:ability_names=>[])
  end

end
