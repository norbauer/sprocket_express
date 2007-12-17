class SprocketExpressOrder < ActiveRecord::Base
  
  include SprocketExpress
        
  has_many :sprocket_express_order_line_items, :dependent => :destroy
    
  validates_presence_of :billing_first_name, :billing_last_name, :billing_address_1, :billing_city, :billing_country, :billing_zipcode, :ship_via
  validates_presence_of :billing_state, :if => Proc.new { |order| !order.foreign? }
  validates_length_of :billing_city, :shipping_city, :maximum => 20, :allow_nil => true
  validates_length_of :billing_address_1, :billing_address_2, :shipping_address_1, :shipping_address_2, :maximum => 40, :allow_nil => true
  validates_length_of :gift_message_1, :gift_message_2, :gift_message_3, :maximum => 70, :allow_nil => true
  
  validates_presence_of :shipping_zipcode, :if => Proc.new { |order| !order.shipping_same_as_billing? }
  validates_presence_of :shipping_address_1, :if => Proc.new { |order| !order.shipping_same_as_billing? }

  validates_format_of :billing_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :shipping_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => Proc.new { |order| !order.shipping_same_as_billing? && !order.shipping_email.blank? }
  
  validates_inclusion_of :billing_country,  :in => SprocketExpress::country_codes, :message => "is not valid. Please check country mapping for valid country codes."
  validates_inclusion_of :shipping_country, :in => SprocketExpress::country_codes, :if  => Proc.new { |order| !order.shipping_same_as_billing? }, :message => "is not valid. Please check country mapping for valid country codes.", :allow_nil => true
  validates_inclusion_of :ship_via, :in => SprocketExpress::carrier_codes, :message => "is not valid. Please check carrier mapping for valid carrier codes."
  validates_inclusion_of :shipping_state, :in => SprocketExpress::state_abbreviations, :if  => Proc.new { |order| !order.foreign? && !order.shipping_same_as_billing? }, :message => 'is not a valid two-character state abbreviation.'
  validates_inclusion_of :billing_state,  :in => SprocketExpress::state_abbreviations, :if  => Proc.new { |order| !order.foreign? }, :message => 'is not a valid two-character state abbreviation.'
    
  validate :check_state_values
  
  before_validation :truncate_attributes_that_can_be
  before_validation :clear_out_shipping_values_if_shipping_same_as_billing
  before_validation :remove_state_if_foreign
    
  def foreign?
    if self.shipping_same_as_billing?
      !self.billing_country.blank? && (self.billing_country != SprocketExpress::countries('United States'))
    else
      !self.shipping_country.blank? && (self.shipping_country != SprocketExpress::countries('United States'))
    end
  end

  private ##########################################################################
  
  def truncate_attributes_that_can_be
    { :billing_first_name => 15,
      :shipping_first_name => 15,
      :billing_last_name => 20,
      :shipping_last_name => 20,
      :billing_company => 40,
      :shipping_company => 40 }.each_pair do |attribute,limit|
        self.send("#{attribute.to_s}=",self.send(attribute).to_s.slice(0,limit)) 
      end
  end
    
  def clear_out_shipping_values_if_shipping_same_as_billing
    if self.shipping_same_as_billing?
      self.attribute_names.grep(/^shipping_/).each do |attribute|
        self.send("#{attribute}=",nil) unless attribute == 'shipping_same_as_billing'
      end
    end
  end
  
  def remove_state_if_foreign
    if foreign?
      self.billing_state = nil
      self.shipping_state = nil
    end
  end
  
  def check_state_values
    return true if foreign?
    
    if self.billing_state.size != 2
      errors.add('billing_state', "is not valid. If shipping in US, please use 2 character state code.")
    end
    
    if !self.shipping_same_as_billing? && !self.shipping_state.blank?
      if self.shipping_state.size != 2 || self.shipping_state.size != 2
        errors.add('shipping_state', "is not valid. If shipping in US, please use 2 character state code.")        
      end
    end
  end
        
end
