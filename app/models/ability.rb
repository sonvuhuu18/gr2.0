class Ability
  include CanCan::Ability

   def initialize user
    user ||= User.new
    alias_action :new, :create, :edit, :update, :destroy, to: :crud
    case user.role
    when "admin"
      can :manage, :all
      can :read, ActiveAdmin::Page, name: "Dashboard"
      can :assign_roles, User
    when "trainer"
      can :manage, Course
    else
      can :manage, User, id: user.id
      can :read, User
    end
  end
end
