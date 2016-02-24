class AlojamientosController < ApplicationController
  before_action :set_alojamiento , only: [:show , :edit , :update , :destroy , :upvote]
  before_action :authenticate_user! , except: [:index , :show]

  def index
    @alojamientos = Alojamiento.all.order("created_at DESC")
  end

  def show
  end

  def new
    @alojamiento = current_user.alojamientos.build
    @pic = @alojamiento.pics.build
  end

  def create
    @alojamiento = current_user.alojamientos.build(alojamiento_params)
    if @alojamiento.save
      redirect_to @alojamiento , notice: "created successfully :)"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @alojamiento.update(alojamiento_params)
      redirect_to @alojamiento , notice: "updated successfully :)"
    else
      render 'edit'
    end
  end

  def destroy
    @alojamiento.destroy
    redirect_to root_path , notice: "eliminated successfully :)"
  end

  def upvote
    @alojamiento.upvote_by current_user
    redirect_to :back
  end

  private

  def set_alojamiento
    @alojamiento = Alojamiento.find(params[:id])
  end

  def alojamiento_params
    params.require(:alojamiento).permit(:cat , :title , :dir , :desc , :price , :fecha_ir , :fecha_volver ,  pics_attributes: [:id , :image , :_destroy])
  end
end
