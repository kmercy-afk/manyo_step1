Rails.application.routes.draw do
  # Set root to tasks index (this creates the 'root' prefix)
  root 'tasks#index'

  # This single line gives you ALL the required prefixes automatically:
  # - tasks       GET    /tasks(.:format)          tasks#index
  # - new_task    GET    /tasks/new(.:format)      tasks#new
  # - task        GET    /tasks/:id(.:format)      tasks#show
  # - edit_task   GET    /tasks/:id/edit(.:format) tasks#edit
  # - (plus POST /tasks, PATCH/PUT /tasks/:id, DELETE /tasks/:id)
  resources :tasks
  resources :labels
end