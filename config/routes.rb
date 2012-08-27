AdvantageApps::Application.routes.draw do
  devise_for :customers

  root :to => 'sms/messages#index'

  namespace :admin do
    resources :customers
    resources :create_email_tables, :only => [:new, :create]
  end

  #
  # WARNING:
  #
  # Changing the routes of the these controllers requires updates to all client code
  # 
  namespace :sms do
    resources :messages, :only => [] do
      collection do
        get 'deliver'
        post 'deliver'
        post 'receive'
      end
    end
  end

  namespace :docs do
    resources :google_docs, :only => [] do
      collection do
        get 'copy'
        match 'copy', :action => 'options', :constraints => {:method => 'OPTIONS'}
      end
    end
  end

  namespace :ace do
    resources :uploads, :only => [:new, :create]
  end

  namespace :quickbooks do
    get "/reports/:table_id/:report_id" => 'reports#show'
  end
end
