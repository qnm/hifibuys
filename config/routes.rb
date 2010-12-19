Hifibuys::Application.routes.draw do
  match 'items/sell' => 'items#new', :as => :sell

  resources :items do
    collection do
      get 'search'
      get 'feed'
    end
  end

  root :to => "items#home"
end
