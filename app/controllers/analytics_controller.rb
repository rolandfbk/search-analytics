class AnalyticsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @analytics = Analytic.all.group_by(&:search).map { |k, v| [k, v.count] }.to_h.sort_by { |k, v| v }.reverse
  end

  def show
    @analytics = Analytic.find(params[:id])
  end

  def new; end

  def create
    @search_text = params[:usersearch]
    # @test = "Test"
    # render json: { test: @test }

    @analytics = current_user.analytics.new(search: @search_text)

    if @analytics.save
      # redirect_to root_path, notice: 'Your search was successfully saved.'
      render json: { answer: true }
    else
      # render :new, notice: 'There was an error saving your search.'
      render json: { answer: false }
    end
  end

  def destroy
    @analytics = Analytic.find(params[:id])
    @analytics.destroy
    redirect_to analytics_path
  end

  def user_search
    @user = User.find(params[:user_id])
    @analytics = @user.analytics.group_by(&:search).map { |k, v| [k, v.count] }.to_h.sort_by { |k, v| v }.reverse
    render json: { analytics: @analytics }
  end

end