# frozen_string_literal: true

# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                              /assets                                                                                  #<Sprockets::Environment:0x3ff1d9eae9fc root="/Users/andreheijstek/RubymineProjects/biblestudy_platform", paths=["/Users/andreheijstek/RubymineProjects/biblestudy_platform/app/assets/config", "/Users/andreheijstek/RubymineProjects/biblestudy_platform/app/assets/images", "/Users/andreheijstek/RubymineProjects/biblestudy_platform/app/assets/javascripts", "/Users/andreheijstek/RubymineProjects/biblestudy_platform/app/assets/stylesheets", "/Users/andreheijstek/RubymineProjects/biblestudy_platform/vendor/assets/javascripts", "/Users/andreheijstek/RubymineProjects/biblestudy_platform/vendor/assets/stylesheets", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/trix-rails-2.2.0/vendor/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/trix-rails-2.2.0/vendor/assets/stylesheets", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/i18n-js-3.7.1/app/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/font-awesome-rails-4.7.0.5/app/assets/fonts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/font-awesome-rails-4.7.0.5/app/assets/stylesheets", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/cocoon-1.2.14/app/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/client_side_validations-simple_form-11.0.0/vendor/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/client_side_validations-17.0.0/vendor/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/jquery-rails-4.4.0/vendor/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/coffee-rails-5.0.0/lib/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/actioncable-6.0.3.2/app/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/activestorage-6.0.3.2/app/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/actionview-6.0.3.2/lib/assets/compiled", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootstrap-sass-3.4.1/assets/stylesheets", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootstrap-sass-3.4.1/assets/javascripts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootstrap-sass-3.4.1/assets/fonts", "/Users/andreheijstek/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/bootstrap-sass-3.4.1/assets/images"]>
#                           users_index GET    /users/index(.:format)                                                                   users#index
#                                  root GET    /                                                                                        pericopes#index
#                            admin_root GET    /admin(.:format)                                                                         admin/application#index
#              admin_biblebook_chapters POST   /admin/biblebooks/:biblebook_id/chapters(.:format)                                       admin/chapters#create
#           new_admin_biblebook_chapter GET    /admin/biblebooks/:biblebook_id/chapters/new(.:format)                                   admin/chapters#new
#          edit_admin_biblebook_chapter GET    /admin/biblebooks/:biblebook_id/chapters/:id/edit(.:format)                              admin/chapters#edit
#               admin_biblebook_chapter GET    /admin/biblebooks/:biblebook_id/chapters/:id(.:format)                                   admin/chapters#show
#                                       PATCH  /admin/biblebooks/:biblebook_id/chapters/:id(.:format)                                   admin/chapters#update
#                                       PUT    /admin/biblebooks/:biblebook_id/chapters/:id(.:format)                                   admin/chapters#update
#                                       DELETE /admin/biblebooks/:biblebook_id/chapters/:id(.:format)                                   admin/chapters#destroy
#                      admin_biblebooks GET    /admin/biblebooks(.:format)                                                              admin/biblebooks#index
#                                       POST   /admin/biblebooks(.:format)                                                              admin/biblebooks#create
#                   new_admin_biblebook GET    /admin/biblebooks/new(.:format)                                                          admin/biblebooks#new
#                  edit_admin_biblebook GET    /admin/biblebooks/:id/edit(.:format)                                                     admin/biblebooks#edit
#                       admin_biblebook GET    /admin/biblebooks/:id(.:format)                                                          admin/biblebooks#show
#                                       PATCH  /admin/biblebooks/:id(.:format)                                                          admin/biblebooks#update
#                                       PUT    /admin/biblebooks/:id(.:format)                                                          admin/biblebooks#update
#                                       DELETE /admin/biblebooks/:id(.:format)                                                          admin/biblebooks#destroy
#                           admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                                       POST   /admin/users(.:format)                                                                   admin/users#create
#                        new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
#                       edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                            admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
#                                       PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                                       PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                      new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                       PUT    /users/password(.:format)                                                                devise/passwords#update
#                                       POST   /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                       PUT    /users(.:format)                                                                         devise/registrations#update
#                                       DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                       POST   /users(.:format)                                                                         devise/registrations#create
#                            studynotes GET    /studynotes(.:format)                                                                    studynotes#index
#                                       POST   /studynotes(.:format)                                                                    studynotes#create
#                         new_studynote GET    /studynotes/new(.:format)                                                                studynotes#new
#                        edit_studynote GET    /studynotes/:id/edit(.:format)                                                           studynotes#edit
#                             studynote GET    /studynotes/:id(.:format)                                                                studynotes#show
#                                       PATCH  /studynotes/:id(.:format)                                                                studynotes#update
#                                       PUT    /studynotes/:id(.:format)                                                                studynotes#update
#                                       DELETE /studynotes/:id(.:format)                                                                studynotes#destroy
#                             pericopes GET    /pericopes(.:format)                                                                     pericopes#index
#                          new_pericope GET    /pericopes/new(.:format)                                                                 pericopes#new
#                         edit_pericope GET    /pericopes/:id/edit(.:format)                                                            pericopes#edit
#                              pericope GET    /pericopes/:id(.:format)                                                                 pericopes#show
#                                       DELETE /pericopes/:id(.:format)                                                                 pericopes#destroy
#                               profile GET    /profile(.:format)                                                                       users#show
#                                  page GET    /pages/*id                                                                               high_voltage/pages#show
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'users/index'

  root 'pericopes#index'

  namespace :admin do
    root 'application#index'
    resources :biblebooks do
      resources :chapters, except: [:index]
    end
    resources :users, except: [:destroy]
  end

  devise_for :users

  resources :studynotes
  resources :pericopes, except: [:create, :update]

  get 'profile', to: 'users#show'
end
