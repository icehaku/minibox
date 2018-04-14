class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    #raise User.find(2).sent_messages.inspect
    #raise User.find(2).received_messages.inspect
  end
end
