require 'api_constraints'
Rails.application.routes.draw do
  devise_for :user
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
 #namespace :api, :defaults => {:format => :json}, constraints:{subdomain:'api'}, path:'/' do
  # scope module: :v1,constraints: ApiConstraints.new(version: 1, default: true) do

  namespace :api do
      namespace :v1 do
      resources :users ,:only =>[:index,:show,:create,:update, :destroy]
      resources :sessions, :only =>[:create,:destroy]
      resources :sites, :only => [:create, :index]
      resources :searches, :only => [:index]
      get 'sites/:id/popularize', to: 'sites#popularize'
      get 'sites/:id/popularize_by_key', to: 'sites#popularize_by_key'
      end
  end
end
