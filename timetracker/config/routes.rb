Rails.application.routes.draw do
  root 'timetracker#late'
  devise_for :users

  get 'timetracker/late'
  get 'timetracker/review', to: 'timetracker#review'

end
