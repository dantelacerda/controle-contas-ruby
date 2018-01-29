class HistoricosController < ApplicationController
  before_action :set_historico, only: [:show, :edit, :update, :destroy]
  before_action :set_options_for_select, only: [:new, :edit, :update, :create]

  # GET /historicos
  # GET /historicos.json
  def index
    @historicos = Historico.all
    #@historicos = Historico.where(status: 'TRANSFERIDO')
    
    @historicos.each do |c|
      
      if c.tipotransacao == 'TR'
        c.tipotransacao = 'Transferência'
      else
        c.tipotransacao = 'Aporte'
      end
    end
  end

  # GET /historicos/1
  # GET /historicos/1.json
  def show
  end

  # GET /historicos/new
  def new
    @historico = Historico.new
  end

  # GET /historicos/1/edit
  def edit
  end

  # POST /historicos
  # POST /historicos.json
  def create
    #@historico = Historico.new(historico_params)
    @historico = Historico.new
    
    @valido = true
    @tipotransacao = params[:historico][:tipotransacao]
    @conta_origem = Contum.find(params[:historico][:contaorigem])
    @conta_destino = Contum.find(params[:historico][:contadestino])
    @valor = params[:historico][:valor]
    @aporte = params[:historico][:aporte]
    
   if @conta_origem.saldo < @valor.to_i
      @valido = false
      @historico.errors[:base] << "O valor informado é mais alto do que o existente em conta"
    elsif @conta_destino.tipoconta == 'matriz' && @tipotransacao == 'TR'
      @valido = false
      @historico.errors[:base] << "Não pode ser realizada Transferência para uma conta Matriz"
  #Melhorar a validação da mesma árvore
    elsif @conta_origem.conta_id != @conta_destino.conta_id && @tipotransacao == 'TR'
      @valido = false
      @historico.errors[:base] << "Só podem ser realizadas transferências entre contas da mesma Matriz"
    elsif @tipotransacao == 'AP' && @conta_origem.conta_id != @conta_destino.id
      @valido = false
      @historico.errors[:base] << "Só podem ser realizados Aportes entre contas da mesma Matriz"
     elsif @tipotransacao == 'AP' 
     
      @historicoaporte = Historico.select(:id).where(aporte:  @aporte)
      
      if @historicoaporte.any?
        @valido = false
        @historico.errors[:base] << "Já existe um aporte com o código informado"
      end  
      
    end
    
    if @valido == true
      @conta_origem.saldo = @conta_origem.saldo - @valor.to_i
      @conta_destino.saldo = @conta_destino.saldo + @valor.to_i
        
      @conta_origem.save
      @conta_destino.save
    end
    
    @historico.contaorigem = @conta_origem
    @historico.contadestino =  @conta_destino
    @historico.datatransacao = Time.now
    @historico.tipotransacao = @tipotransacao
    @historico.aporte = @aporte
    @historico.valor = @valor
    @historico.status = 'TRANSFERIDO'
    
    respond_to do |format|
      if @valido == false 
        format.html { render :new }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      elsif @historico.save
        format.html { redirect_to historicos_url, notice: 'Transação realizada com sucesso!.' }
        format.json { render :index, status: :created, location: @historico }
      else
        format.html { render :new }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historicos/1
  # PATCH/PUT /historicos/1.json
  def update
    
    @historico = Historico.new
    
    @valido = true
    @estornado = false
    @valor = params[:historico][:valor]
    @aporte = params[:historico][:aporte]
    
    @historicobanco = Historico.find(params[:id])
    @conta_origem = @historicobanco.contaorigem
    @conta_destino = @historicobanco.contadestino
    
    
    @historicoestornado = Historico.select(:id).where(contaorigem:  @historicobanco.contaorigem, contadestino: @historicobanco.contadestino, valor: @valor, status: 'ESTORNADO')
    
    if @historicoestornado.any?
        @estornado = true
        @historico.errors[:base] << "O pagamento já foi estornado"
    elsif @conta_destino.saldo < @valor.to_i
      @valido = false
      @historico.errors[:base] << "O estorno não pode ser realizado, pois a conta não tem saldo suficiente"
    elsif @historicobanco.aporte != @aporte && @historicobanco.tipotransacao == 'AP'
      @valido = false
      @historico.errors[:base] << "O código de aporte informado é inválido"
    else
      @conta_origem.saldo = @conta_origem.saldo + @valor.to_i
      @conta_destino.saldo = @conta_destino.saldo - @valor.to_i
      
      @conta_origem.save
      @conta_destino.save
    end
    
    
    @historico.valor = @historicobanco.valor
    @historico.aporte = @historicobanco.aporte
    @historico.contaorigem = @historicobanco.contaorigem
    @historico.contadestino = @historicobanco.contadestino
    @historico.tipotransacao = @historicobanco.tipotransacao
    @historico.datatransacao = Time.now
    @historico.status = 'ESTORNADO'
    
    
    respond_to do |format|
      
      if @estornado == true
        format.html { redirect_to historicos_url, notice: 'O pagamento já foi estornado!' }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      elsif @valido == false 
        format.html { render :edit }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      elsif @historico.save
        format.html { redirect_to historicos_url, notice: 'Estorno realizado com sucesso!' }
        format.json { render :index, status: :created, location: @historico }
      else
        format.html { render :edit }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historicos/1
  # DELETE /historicos/1.json
  def destroy
    @historico.destroy
    respond_to do |format|
      format.html { redirect_to historicos_url, notice: 'Historico excluído com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historico
      @historico = Historico.find(params[:id])
    end
    def set_options_for_select
      @accountslist = Contum.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historico_params
      params.require(:historico).permit(:contaorigem, :contadestino, :datatransacao, :tipotransacao, :aporte, :valor)
    end
end
