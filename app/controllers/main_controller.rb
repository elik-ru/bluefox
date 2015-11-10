class MainController < ApplicationController
  def index
		@vacancies_count=Vacancy.all.count
		@vacancies_active_count=Vacancy.active.count
		@candidates_count=Candidate.all.count
		@candidates_active_count=Candidate.active.count
  end
end
