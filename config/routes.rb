HDwall::Application.routes.draw do
  get "variables/testScreen1L2L"

  get "agents_controller/agentsModal"

  get "variables/screen1L2L"

  get "charts/screen2MB"

  get "agents/screen3L"

  get "agents/screen2R"

  get "variables/screen2L"

  get "maps/screen3R"

  get "maps/screen2MT"

  get "maps/screen1R"

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # :random_number is used to get around the Google API's 4-minute cache
  match "/maps/:colors_array/get_map_KML_blue(/:cat1_vars)(/:cat2_vars)(/:cat3_vars)(/:cat4_vars)" => "maps#get_map_KML_blue"
  match "/maps/:colors_array/get_map_KML_red(/:cat1_vars)(/:cat2_vars)(/:cat3_vars)(/:cat4_vars)" => "maps#get_map_KML_red"
  match "/maps/:colors_array/screen3R" => "maps#screen3R"
  match "/maps/:colors_array/screen3R_map(/:present_future)" => "maps#screen3R_map"
  match "/maps/:colors_array/screen1R(/:cat1_vars)(/:cat2_vars)(/:cat3_vars)(/:cat4_vars)" => "maps#screen1R"
  match "/maps/:colors_array/screen2MT/:map_num(/:cat1_vars)(/:cat2_vars)(/:cat3_vars)(/:cat4_vars)" => "maps#screen2MT"
  match "/maps/get_map_KML_selected/:clusterNum/:clusterName/:clusterZipList" => "maps#get_map_KML_selected"

  match "/variables/:colors_array/get_map_KML_DB(/:cat1_vars)(/:cat2_vars)(/:cat3_vars)(/:cat4_vars)(/:filters)(/:present_future)(/:projected_value)(/:whichvar)(/:levers3L)" => "variables#get_map_KML_DB"

  match "/charts/get_variable_values_for_zips/:chart/:axis/:varID/:map1_selected/:map2_selected" => "charts#get_variable_values_for_zips"
  match "/charts/get_timeseries_data_for_zips/:chart/:varID/:map1_selected/:map2_selected" => "charts#get_timeseries_data_for_zips"

  match "/agents/get_agents_for_zips/:clusterID/:zips" => "agents#get_agents_for_zips"
  match "/agents/get3Lvars/:clusterZips" => "agents#get3Lvars"
  match "/agents/get3LvarsSummary/:clusterZips" => "agents#get3LvarsSummary"

  match "/agents/get_agent_info_for_modal/:agentID" => "agents#get_agent_info_for_modal"
  match "/maps/get_zillow_deep_search_results/:address/:zip" => "maps#get_zillow_deep_search_results"
end