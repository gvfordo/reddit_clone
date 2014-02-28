class LinksController < ApplicationController
  def new
    @link = Link.new
    @subs = Sub.all
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
  end

  def destroy
  end

  private

  def link_params
    params.require(:link).permit({ :sub_ids => [] }, :url, :title, :link_text)
  end
end
