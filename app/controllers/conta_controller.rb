class ContaController < ApplicationController
  before_action :set_contum, only: [:show, :edit, :update, :destroy]
  before_action :set_options_for_select, only: [:new, :edit, :update, :create]

  # GET /conta
  # GET /conta.json
  def index
    @conta = Contum.order(:nome)
    
    @conta.each do |c|
      if c.tipoconta == 'matriz'
        c.tipoconta = 'Matriz'
      else
        c.tipoconta = 'Filial'
      end
    end
    
  end

  # GET /conta/1
  # GET /conta/1.json
  def show
  end

  # GET /conta/new
  def new
    @contum = Contum.new
  end

  # GET /conta/1/edit
  def edit
  end

  # POST /conta
  # POST /conta.json
  def create
    @contum = Contum.new(contum_params)
   
    if @contum.tipoconta == 'matriz'
        @contum.conta_id = ''
    end
    
    respond_to do |format|
      if @contum.save
        format.html { redirect_to conta_url, notice: 'Conta criada com sucesso!' }
        format.json { render :show, status: :created, location: @contum }
      else
        format.html { render :new }
        format.json { render json: @contum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conta/1
  # PATCH/PUT /conta/1.json
  def update
    respond_to do |format|
      if @contum.update(contum_params)
        format.html { redirect_to conta_url, notice: 'Conta atualizada com sucesso!' }
        format.json { render :show, status: :ok, location: @contum }
      else
        format.html { render :edit }
        format.json { render json: @contum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conta/1
  # DELETE /conta/1.json
  def destroy
    @contum.destroy
    respond_to do |format|
      format.html { redirect_to conta_url, notice: 'Conta excluída com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contum
      @contum = Contum.find(params[:id])
    end
    
     def set_options_for_select
      @accountslist = Contum.all
      @clienteslist = Cliente.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contum_params
      params.require(:contum).permit(:nome, :numero, :saldo, :tipoconta, :datacriacao, :situacao, :conta_id, :cliente_id)
    end
end
