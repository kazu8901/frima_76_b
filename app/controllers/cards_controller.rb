class CardsController < ApplicationController

  require "payjp"

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if @card.exists?
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

    if params["payjp_token"].blank?
      redirect_to new_card_path, alert: "クレジットカードを登録できませんでした。"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)

      if @card.save
        redirect_to card_path(current_user.id)
      else
        redirect_to new_card_path
      end
    end

  end

  def show
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "JCB.png"
      when "MasterCard"
        @card_src = "mastercard.png"
      when "AmericanExpress"
        @card_src = "AmericanExpress.png"
      end
      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    @card = Card.find_by(user_id: current_user.id)

    if @card.blank?
      redirect_to new_card_path
    else

      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      if @card.destroy
        redirect_to user_path(current_user.id), alert: "削除されました。"
      else
        redirect_to card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end

end