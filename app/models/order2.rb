class Order2 < ApplicationRecord
    belongs_to :cart
    validate :validate_card
    # has_many :order_transactions
    has_many :transactions, :class_name => "OrderTransaction"

    require "active_merchant/billing/rails"

    attr_accessor :card_number, :card_verification


    def purchase
        response = process_purchase
        transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
        # cart.update_attribute(:purchased_at, Time.now) if response.success?
        response.success?
      end
      
      def price_in_cents
        (cart.total_price*100).round
      end
    

      def express_token=(token)
        write_attribute(:express_token, token)
        if new_record? && !token.blank?
          details = EXPRESS_GATEWAY.details_for(token)
          self.express_payer_id = details.payer_id
          self.first_name = details.params["first_name"]
          self.last_name = details.params["last_name"]
        end
      end


    private
      def process_purchase
        if express_token.blank?
            GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
        else
          EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
        end
      end


      def standard_purchase_options
        {
          :ip => ip_address,
          :billing_address => {
            :name     => "Ryan Bates",
            :address1 => "123 Main St.",
            :city     => "New York",
            :state    => "NY",
            :country  => "US",
            :zip      => "10001"
          }
        }
      end
      
      def express_purchase_options
        {
          :ip => ip_address,
          :token => express_token,
          :payer_id => express_payer_id
        }
      end




    def validate_card
        #  debugger
        if express_token.blank? && !credit_card.valid?
            credit_card.errors.full_messages.each do |message|
            # errors.add_to_base message
            errors.add :base, message
          end
        end
      end
      
    def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        :brand               => card_type,
        :number             => card_number,
        :verification_value => card_verification,
        :month              => card_expires_on.month,
        :year               => card_expires_on.year,
        :first_name         => first_name,
        :last_name          => last_name
    )
    end
end
