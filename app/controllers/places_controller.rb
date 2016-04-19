class PlacesController < ApplicationController

  def index
    @transports= Transport.all.order("created_at DESC")
    @ocios = Ocio.all.order("created_at DESC")
    @alojamientos = Alojamiento.all.order("created_at DESC")
  end

  def term
  end

  def norm
  end

end
