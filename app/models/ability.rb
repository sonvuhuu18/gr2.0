class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    alias_action :create, :update, :destroy, to: :cud
    case user.role
    when "admin"
      can :manage, :all
      can :assign_roles, User
      cannot :destroy, User, id: user.id
      cannot :create, Feedback
    when "trainer"
      can :manage, :all
      cannot :cud, User
      cannot :cud, Feedback
    else
      can :manage, User, id: user.id
      can :read, User
      can :read, Course
      can :read, Enrollment, user_id: user.id
      can :read, Subject
      can :manage, Feedback, user_id: user.id
    end
  end
end
