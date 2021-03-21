# frozen_string_literal: true

Rails.application.routes.draw do
  get '/user/:login', to: 'user#show'
  get '/user/:login/:repo', to: 'user#repo'
end