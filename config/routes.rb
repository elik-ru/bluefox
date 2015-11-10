Rails.application.routes.draw do
  root 'main#index'

	resources :candidates
	resources :vacancies
	
 end
