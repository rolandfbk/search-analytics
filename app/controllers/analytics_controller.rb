class AnalyticsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @analytics = Analytic.all.group_by(&:search).map { |k, v| [k, v.count] }.to_h.sort_by { |_k, v| v }.reverse
  end

  def new; end

  def create
    @search_text = params[:usersearch]

    @analytics = current_user.analytics.new(search: @search_text)

    if @analytics.save
      render json: { answer: true }
    else
      render json: { answer: false }
    end
  end

  def user_search
    @user = User.find(params[:user_id])
    @analytics = @user.analytics.group_by(&:search).map { |k, v| [k, v.count] }.to_h.sort_by { |_k, v| v }.reverse
    render json: { analytics: @analytics }
  end
end
