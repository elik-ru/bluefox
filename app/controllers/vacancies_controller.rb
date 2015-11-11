class VacanciesController < ApplicationController
  
  before_filter do
    @page_crumbs << ["Вакансии", vacancies_path]
  end
  
  before_filter only: [:show,:edit,:update,:destroy] do
		@vacancy=Vacancy.find(params[:id])
    @page_crumbs << [@vacancy.title, @vacancy]
  end
  
	def index
		@vacancies=Vacancy.all.order(:expires_at).reverse_order.page(params[:page]).per(100)
	end
	
	def show
		@abilities=@vacancy.abilities
    @candidates=Candidate.active.includes(:abilities).joins(:candidate_abilities).where(candidate_abilities: {ability_id: @abilities}).group("candidates.id").order("count(candidates.id) desc").order("candidates.salary").page(params[:page]).per(20)
	end
  
  def new
    @page_crumbs << ["Новая", [:edit,@vacancy]]  
    @vacancy=Vacancy.new unless @vacancy
    render :form
  end
  
  def create
    @vacancy=Vacancy.create safe_params
    
    if @vacancy.valid?
      redirect_to [:edit,@vacancy]
    else
      new
    end
  end
  
  def edit
    @page_crumbs << ["Редактирование", [:edit,@vacancy]]  
    render :form
  end
  
  def update
    @vacancy.update(safe_params)
    edit
  end
  
  def destroy
    @vacancy.destroy
    redirect_to [:candidates]
  end

  def safe_params
    safe=params.require(:vacancy).permit(:name,:contact_info,:salary,:added_at,:expires_at,:ability_names=>[])
  end
  
end
