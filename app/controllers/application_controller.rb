# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def resource_errors(resource)
    resource.errors.full_messages.join(' ')
  end
end
