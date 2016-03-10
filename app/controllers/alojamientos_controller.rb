class AlojamientosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_alojamiento , only: [:show,:edit , :update , :destroy , :upvote ]
  before_action :alojamiento_auth , only: [ :edit , :update , :destroy ]
  before_action :authenticate_user! , except: [:index , :show]

  def index
    alojamientos_scope = Alojamiento.all
    alojamientos_scope = alojamientos_scope.like(params[:filter]) if params[:filter]
    alojamientos_scope = alojamientos_scope.cate(params[:category]) if params[:category]
    # @alojamientos = smart_listing_create :alojamientos, alojamientos_scope, partial: "alojamientos/list", page_sizes: [5, 7, 13, 26]
    @alojamientos = smart_listing_create :alojamientos, alojamientos_scope, partial: 'alojamientos/list'
  end

  def show
  end

  def new
    @alojamiento = current_user.alojamientos.build
    @pic = @alojamiento.build_pic
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
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {render 'alojamientos/vote.js.erb'}
    end
  end

  private

  def set_alojamiento
    @alojamiento = Alojamiento.find(params[:id])
  end

  def alojamiento_auth
    if @alojamiento.user != current_user
      redirect_to root_path , notice: "no eres autorizado "
    end
  end

  def alojamiento_params
    params.require(:alojamiento).permit(:cat , :title , :dir , :desc , :price , :fecha_ir , :fecha_volver , :city ,   pic_attributes: [:id , :image , :_destroy])
  end
end
