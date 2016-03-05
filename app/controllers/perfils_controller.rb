class PerfilsController < ApplicationController
  before_action :set_perfil , only: [:edit , :update , :show , :destroy ,  :upvote]
  before_action :authenticate_user!,  except: [:index , :show ]
  before_action :perfil_auth , only: [:edit , :update , :destroy]

  def index
    @perfils = Perfil.all.order("created_at DESC")
  end

  def show
  end

  def new
    if current_user.perfil.blank?
      @perfil = current_user.build_perfil
      @pic = @perfil.build_pic
    else
      redirect_to root_path , notice: "tienes ya un perfil"
    end
  end

  def create
    @perfil = current_user.build_perfil(perfil_params)
    if @perfil.save
      redirect_to @perfil , notice: "perfil creado correctamente"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @perfil.update(perfil_params)
      redirect_to @perfil  , notice: "perfil modificado correctamente"
    else
      render 'edit'
    end
  end

  def destroy
    @perfil.destroy
    redirect_to root_path
  end

  def upvote
    @perfil.upvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private

  def set_perfil
    @perfil = Perfil.find(params[:id])
  end

  def perfil_params
    params.require(:perfil).permit(:first_name , :last_name , :birth_date , :age , :gender , :facebook_link , :twitter_link , :website_link , pic_attributes: [:id , :image ,:_destroy])
  end

  def perfil_auth
    if @perfil.user != current_user
      redirect_to root_path , notice: "no eres autorizado!"
    end
  end

end
