WhatsappAnalyzer::Application.routes.draw do

  root 'intro#home'
  resources :stats, :only => [:new, :create]
  get 'about' => 'intro#about', :as => :about
  get 'results' => 'stats#results', :as => :results
  get 'example' => 'stats#example', :as => :example

end
