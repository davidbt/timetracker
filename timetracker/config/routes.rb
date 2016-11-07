Rails.application.routes.draw do
  get 'timetracker/late'
  root 'timetracker#late'
  devise_for :users
end
