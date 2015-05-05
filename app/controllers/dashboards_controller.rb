class DashboardsController < ApplicationController

  # GET /admin/users
  def users
  end

  private

  # TODO: Move this code to a dashboards model?
  def lti_users_table
    # Use this as a base:
    # http://staging.cs10.org/admin/analyze/queries/12-questions-per-student
  end
end
