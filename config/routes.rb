Hifibuys::Application.routes.draw do
  get 'items/sell' => 'items#new', :as => :sell
  get 'contact-us' => 'application#contact_us', :as => :contact

  resources :items do
    collection do
      #get 'search'
      #get 'feed'
    end
    #get :autocomplete_item_name, :on => :collection
  end

  root :to => "items#index"
end
