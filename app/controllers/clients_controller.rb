class ClientsController < ApplicationController

  before_action :set_client, only: [:show, :update, :destroy]
  # skip_before_action :check_token, only: []

  def index
    @clients = Client.all
    render status: 200, json: { clients: @clients }
  end

  # def show
  #   @client = Client.find(params[:id])
  #   render status: 200, json: { client: @client }
  # end

  def show
    render status: 200, json: { client: @client }
  end

  def create
    @client = Client.new(client_params)
    
    # @client = Client.create(client_params)
    # if @client.persisted?
    #   render status: 200, json: { client: @client }
    # else
    #   render status: 400, json: { message: @client.errors.details }
    # end

    render_response
    
  end

  def update
    @client.assign_attributes(client_params)
    render_response
  end

  def destroy
    if @client.destroy
      render status: 200
    else
      render_errors_response
    end
  end

  private

    def client_params
      params.require(:client).permit(:name, :email)
    end

    def set_client
      @client = Client.find_by(id: params[:id])
      # @client.blank?
      # @client.nil?
      return if @client.present?
      render status: 404, json: { message: "No se encuentra el cliente #{params[:id]}" }
      false # Al ser un before_action se pone el false para lo devuelva y no ejecute la accion
      # Se puede hacer el if con un blank y no se pone el return por que se sobreentiende que se hace al final     
    end

    def render_response
      if @client.save
        render status: 200, json: { client: @client }
      else
        render_errors_response
      end
    end

    def render_errors_response
      render status: 400, json: { message: @client.errors.details }
    end

end
