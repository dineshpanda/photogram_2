Rails.application.routes.draw do
  # Routes for the Vote resource:

  # CREATE
  get("/votes/new", { :controller => "votes", :action => "new_form" })
  post("/create_vote", { :controller => "votes", :action => "create_row" })

  # READ
  get("/votes", { :controller => "votes", :action => "index" })
  get("/votes/:id_to_display", { :controller => "votes", :action => "show" })

  # UPDATE
  get("/votes/:prefill_with_id/edit", { :controller => "votes", :action => "edit_form" })
  post("/update_vote/:id_to_modify", { :controller => "votes", :action => "update_row" })

  # DELETE
  get("/delete_vote/:id_to_remove", { :controller => "votes", :action => "destroy_row" })

  #------------------------------

  # Routes for the Photo resource:

  # CREATE
  get("/photos/new", { :controller => "photos", :action => "new_form" })
  post("/create_photo", { :controller => "photos", :action => "create_row" })

  # READ
  get("/photos", { :controller => "photos", :action => "index" })
  get("/photos/:id_to_display", { :controller => "photos", :action => "show" })

  # UPDATE
  get("/photos/:prefill_with_id/edit", { :controller => "photos", :action => "edit_form" })
  post("/update_photo/:id_to_modify", { :controller => "photos", :action => "update_row" })

  # DELETE
  get("/delete_photo/:id_to_remove", { :controller => "photos", :action => "destroy_row" })

  #------------------------------

  devise_for :users
  # Routes for the User resource:

  # READ
  get("/users", { :controller => "users", :action => "index" })
  get("/users/:id_to_display", { :controller => "users", :action => "show" })

  #------------------------------

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
