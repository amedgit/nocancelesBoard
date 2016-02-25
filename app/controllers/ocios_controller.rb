class OciosController < ApplicationController
  before_action :set_ocio , only: [:show , :edit , :update , :destroy , :upvote]
  before_action :authenticate_user! , except: [:index , :show]

  def index
    @ocios = Ocio.all.order("created_at DESC")
  end

  def show
  end

  def new
    @ocio = current_user.ocios.build
    @pic = @ocio.pics.build
  end

  def create
    @ocio = current_user.ocios.build(ocio_params)
    if @ocio.save
      redirect_to @ocio , notice: "created successfully :)"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @ocio.update(ocio_params)
      redirect_to @ocio , notice: "updated successfully :)"
    else
      render 'edit'
    end
  end

  def destroy
    @ocio.destroy
    redirect_to root_path , notice: "eliminated successfully :)"
  end

  def upvote
    @ocio.upvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private

  def set_ocio
    @ocio = Ocio.find(params[:id])
  end

  def ocio_params
    params.require(:ocio).permit(:cat , :title , :dir , :desc , :price , :fecha ,  pics_attributes: [:id , :image , :_destroy])
  end

end
