class PayuCoConfirmationService
  include PayuUtils


  def initialize params
    @participant = Participant.find(params[:extra1])
    @state_pol = params[:state_pol]
    @estado = ESTADOS[@state_pol]
    @respuesta = RESPUESTAS[params[:response_code_pol]] || "Error en el pago: #{params[:response_message_pol]} #{params[:response_code_pol]}"
    @referencia_payu = params[:reference_pol]
    @sign = params[:sign]
    @reference = params[:reference_sale] #reference_code
    @value = params[:value].to_f
    params[:description]
    @transaction_date=params[:transaction_date]
  end

  def confirm
    if is_valid_signature?
      update_participant
      update_event(@participant.event)
      send_email_confirmation
    else
      raise "invalid signature"
    end
  end

  def send_email_confirmation
    EventMailer.payment_process_result(@participant,@result).deliver
  end

  def is_valid_signature?
    sign = find_signature(@reference, @value, @state_pol)
    sign === @sign
  end

  def update_participant
    if @estado === :APROBADO
      @participant.status = "C" #confirmado
      @participant.is_payed = true
    end
    @result = "#{@estado.to_s} (#{@respuesta}),"\
      " con número de transacción en PayU: #{@referencia_payu}, por valor de: #{@value},"\
             " en la fecha de: #{@transaction_date}"
    @participant.notes += "\n\n Resultado del pago: #{@result}"
    @participant.save!
  end

  def update_event(event)
    participants_confirmed = event.participants.select {|participant| participant.status === "C"}
    if(event.capacity <= participants_confirmed.size)
      event.is_sold_out = true
      event.save!
    end
  end

end