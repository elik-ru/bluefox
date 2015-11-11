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
		@abilities=@vacancy.abilities.uniq

		
		@vacancies=Vacancy.active.includes(:abilities)
		@vac=@vacancies[1]
		
		pp @abilities
		pp @vac
		
		pp @vac.abilities
		pp @abilities & @vac.abilities

		@good_vacancies=@vacancies.select{|vacancy| vacancy.abilities & @abilities == vacancy.abilities}
		
#		@good_vacancies=Vacancy.all.joins(:abilities).where("abilities.id in(?)",@abilities.map{|a| a.id}).order(:salary).reverse_order.limit(10)


	  @not_so_good_vacancies=@vacancies.select{|vacancy| (vacancy.abilities & @abilities).size>0}.sort_by{|vacancy| [(vacancy.abilities & @abilities).size, vacancy.salary]}.reverse


#		@not_so_good_vacancies=Vacancy.all.joins(:abilities).where("abilities.id in(?)",@abilities.map{|a| a.id}).group("vacancies.id").order("count(abilities.id)").reverse_order.order(:salary).reverse_order.limit(10)
		
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
