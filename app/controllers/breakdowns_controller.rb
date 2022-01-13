class BreakdownsController < ApplicationController
  before_action :set_breakdown, only: [:show, :update, :destroy]

  # GET /breakdowns
  def index
    @breakdowns = Breakdown.all

    render json: @breakdowns
  end

  # GET /breakdowns/1
  def show
    render json: @breakdown
  end

  # POST /breakdowns
  def create
    @breakdown = Breakdown.new(breakdown_params)

    if @breakdown.save
      render json: @breakdown, status: :created, location: @breakdown
    else
      render json: @breakdown.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /breakdowns/1
  def update
    if @breakdown.update(breakdown_params)
      render json: @breakdown
    else
      render json: @breakdown.errors, status: :unprocessable_entity
    end
  end

  # DELETE /breakdowns/1
  def destroy
    @breakdown.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_breakdown
      @breakdown = Breakdown.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def breakdown_params
      params.require(:breakdown).permit(:week_range)
    end
end
