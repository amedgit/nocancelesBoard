class OciosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_ocio , only: [:show , :edit , :update , :destroy , :upvote]
  before_action :authenticate! , except: [:index , :show]
  before_action :ocio_auth , only: [:edit , :update , :destroy]

  def index
    if params[:cat].blank?
      ocios_scope = Ocio.all
    else
      ocios_scope = Ocio.where(cat: params[:cat])
    end
    ocios_scope = ocios_scope.like(params[:filter]) if params[:filter]
    ocios_scope = ocios_scope.cate(params[:category]) if params[:category]
    ocios_scope = ocios_scope.ciudad(params[:ciudad]) if params[:ciudad]
    # @ocios = smart_listing_create :ocios, ocios_scope, partial: "ocios/list", page_sizes: [5, 7, 13, 26]
    @ocios = smart_listing_create :ocios, ocios_scope, partial: 'ocios/list'
  end

  def show
    set_meta_tags title: @ocio.title ,
                  site: '¡No Canceles!' ,
                  reverse: true ,
                  description: @ocio.desc ,
                  keywords: @ocio.title.split(" ") << @ocio.cat << "ocio" << @ocio.city << @ocio.dir ,
                  twitter: {
                    card: "summary",
                    site: "@NoCanceles",
                    title: @ocio.title,
                    description: @ocio.desc,
                    image: @ocio.pic.image.url
                  }
  end

  def new
    @ocio = current_user.ocios.build
    @pic = @ocio.build_pic
  end

  def create
    @ocio = current_user.ocios.build(ocio_params)
    if @ocio.save
      redirect_to @ocio , notice: "Ocio creado"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @ocio.update(ocio_params)
      redirect_to @ocio , notice: "Ocio actualizado"
    else
      render 'edit'
    end
  end

  def destroy
    @ocio.destroy
    redirect_to root_path , notice: "Ocio eliminado"
  end

  def upvote
    @ocio.upvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {render 'ocios/vote.js.erb'}
    end
  end

  private

  def set_ocio
    @ocio = Ocio.find(params[:id])
  end

  def ocio_params
    params.require(:ocio).permit(:cat , :title , :dir , :desc , :price , :fecha , :city ,:unidad ,  pic_attributes: [:id , :image , :_destroy])
  end

  def ocio_auth
    if @ocio.user != current_user
      redirect_to @ocio , alert: "No autorizado"
    end
  end

end
