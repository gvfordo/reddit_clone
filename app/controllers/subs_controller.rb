require 'debugger'
class SubsController < ApplicationController
  before_action :authenticate, only: [:new, :create, :edit, :update, :destroy]
  def new
    @sub = current_user.subs.new
    5.times { @sub.links.build }
  end

  def create
    @sub = current_user.subs.new(sub_params)
    @links = current_user.links.build(link_params)
    @sub.links = @links
    if @sub.save
      redirect_to sub_url(@sub)
    else
      debugger
      (5 - @sub.links.count).times { @sub.links.build }
      flash.now[:errors] = @sub.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
  end

  def destroy
  end

  private

  def sub_params
    params.require(:sub).permit(:name)
  end

  def link_params

    params.permit(links: [:title, :url, :link_text]).require(:links).values.reject {|data|                                                                            data.values.all?(&:blank?) }
  end

end
