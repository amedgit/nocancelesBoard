class TransportsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_transport , only: [:show , :edit , :update , :destroy , :upvote]
  before_action :authenticate! , except: [:index , :show]
  before_action :transport_auth , only: [:edit , :update , :destroy]

  def index
    if params[:cat].blank?
      transports_scope = Transport.all
    else
      transports_scope = Transport.where(cat: params[:cat])
    end
    transports_scope = transports_scope.like(params[:filter]) if params[:filter]
    transports_scope = transports_scope.cate(params[:category]) if params[:category]
    transports_scope = transports_scope.fciudad(params[:fciudad]) if params[:fciudad]
    transports_scope = transports_scope.tciudad(params[:tciudad]) if params[:tciudad]
    # @transports = smart_listing_create :transports, transports_scope, partial: "transports/list", page_sizes: [5, 7, 13, 26]
    @transports = smart_listing_create :transports, transports_scope, partial: 'transports/list'
  end

  def show
    set_meta_tags title: @transport.title ,
                  site: '¡No Canceles!' ,
                  reverse: true ,
                  description: @transport.desc ,
                  keywords: @transport.title.split(" ") << @transport.cat << "transport" << @transport.from_city << @transport.to_city ,
                  twitter: {
                    card: "summary",
                    site: "@NoCanceles",
                    title: @transport.title,
                    description: @transport.desc,
                    image: @transport.pic.image.url
                  },
                  og: {
                    title: @transport.title,
                    description:  @transport.desc,
                    type: "website",
                    url: transport_url(@transport),
                    image: @transport.pic.image.url
                  }
  end

  def new
    @transport = current_user.transports.build
    @pic = @transport.build_pic
  end

  def create
    @transport = current_user.transports.build(transport_params)
    if @transport.save
      redirect_to @transport , notice: "Transporte creado"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @transport.update(transport_params)
      redirect_to @transport , notice: "Transporte actualizado"
    else
      render 'edit'
    end
  end

  def destroy
    @transport.destroy
    redirect_to root_path , notice: "Transporte eliminado"
  end

  def upvote
    @transport.upvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back}
      format.js   {render 'transports/vote.js.erb'}
    end
  end

  private

  def set_transport
    @transport = Transport.find(params[:id])
  end

  def transport_params
    params.require(:transport).permit(:cat , :title , :desc , :from_city , :to_city , :price , :fecha , :unidad , pic_attributes: [:id , :image , :_destroy])
  end

  def transport_auth
    if @transport.user != current_user
      redirect_to @transport , alert: "No autorizado"
    end
  end
end
