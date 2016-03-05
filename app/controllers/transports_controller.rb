class TransportsController < ApplicationController
  before_action :set_transport , only: [:show , :edit , :update , :destroy , :upvote]
  before_action :authenticate_user! , except: [:index , :show]
  before_action :transport_auth , only: [:edit , :update , :destroy]

  def index
    @transports = Transport.all.order("created_at DESC")
  end

  def show
  end

  def new
    @transport = current_user.transports.build
    @pic = @transport.build_pic
  end

  def create
    @transport = current_user.transports.build(transport_params)
    if @transport.save
      redirect_to @transport , notice: "created successfully :)"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @transport.update(transport_params)
      redirect_to @transport , notice: "updated successfully :)"
    else
      render 'edit'
    end
  end

  def destroy
    @transport.destroy
    redirect_to root_path
  end

  def upvote
    @transport.upvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private

  def set_transport
    @transport = Transport.find(params[:id])
  end

  def transport_params
    params.require(:transport).permit(:cat , :title , :desc , :from_city , :to_city , :price , :fecha , pic_attributes: [:image , :_destroy])
  end

  def transport_auth
    if @transport.user != current_user
      redirect_to root_path , notice: "no eres autorizado"
    end
  end
end
