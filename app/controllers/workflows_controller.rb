class WorkflowsController < ApplicationController
  include Rapido::Controller
  include Rapido::AppController

  owner_class :account

  resource_lookup_param :token
  resource_permitted_params [:name]

  private

  def owner
    current_user.account
  end
end