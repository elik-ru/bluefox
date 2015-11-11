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
		@candidate=Candidate.find(params[:id])
		
		@abilities=@candidate.abilities.uniq

		
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
    params.require(:candidate).permit(:name,:contact_info,:salary,:is_active)
  end

end
