class AnalyticsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @analytics = Analytics.all
  end

  def show
    @analytics = Analytics.find(params[:id])
  end

  def new; end

  def create
    @test = params[:usersearch]
    # @test = "Test"
    render json: { test: @test }

    # @analytics = Analytics.new(analytics_params)
    # if @analytics.save
    #   redirect_to analytics_path(@analytics)
    # else
    #   render :new
    # end
  end

  def destroy
    @analytics = Analytics.find(params[:id])
    @analytics.destroy
    redirect_to analytics_path
  end

end