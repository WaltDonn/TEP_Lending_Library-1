class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :select_dates, :choose_dates, :create, to: :rent_kit
    alias_action :volunter_portal, :returns, :pickup, :picked_up, :returned, to: :volunteer_actions

    if(user.nil?)
      user = User.new
    end
    
    if user.has_role? :admin
        can :manage, :all
    elsif user.has_role? :manager
        can :crud,                 Component
        can :dashboard,            :Dashboard
        can :upload_users,         :Home
        can :create_users,         :Home
        can :upload_schools,       :Home
        can :create_schools,       :Home
        can :reports,              :Home
        can :gen_reports,          :Home
        can :crud,                 Item
        can :crud,                 Kit
        can :crud,                 Reservation
        can :rental_calendar,      :Reservation
        can :submit_user_details,  :Reservation
        can :edit_user_details,    :Reservation
        can :confirm_user_details, :Reservation
        can :rent_kit,             :Reservation
        can :volunteer_actions,    :Reservation
        can :crud,                 School
        can :crud,                 User
        can :rental_history,       User
        
    elsif user.has_role? :volunteer
        can :volunteer_actions,    :Reservation
        can :show,                 Kit
    
    elsif user.has_role? :teacher
        can :show,                 User do |u|  
          u.id == user.id
        end
        can :update,               User do |u|  
          u.id == user.id
        end
        can :rent_kit,             :Reservation
        
        can :submit_user_details,  user do |u|
          u.id == user.id
        end
        can :edit_user_details,    user do |u|
          u.id == user.id
        end
        can :confirm_user_details, user do |u|
          u.id == user.id
        end
    end
    
  end
end
