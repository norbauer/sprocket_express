class SprocketFulfillmentOrder < ActiveRecord::Base
  has_many :sprocket_fulfillment_order_line_items
  validates_presence_of :first_name, :last_name, :sales_id, :address_1, :city, :country, :state, :zipcode
  validates_length_of :city, :scity, :password, :maximum => 20, :allow_nil => true
  validates_length_of :company, :address_1, :address_2, :comment, :scompany, :saddress_1, :saddress_2, :title, :stitle, :maximum => 40, :allow_nil => true
  validates_length_of :sales_id, :is => 3

  validates_format_of :email, :semail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true

  validates_inclusion_of :country,  :in => Map::country_codes, :message => "is not valid. Please check country mapping for valid country codes."
  validates_inclusion_of :scountry, :in => Map::country_codes, :message => "is not valid. Please check country mapping for valid country codes.", :allow_nil => true
  validates_inclusion_of :ship_via, :in => Map::carrier_codes, :message => "is not valid. Please check carrier mapping for valid carrier codes."
  validates_inclusion_of :state, :in => Map::state_abbreviations, :if  => Proc.new { |order| order.foreign? == false }, :message => 'is not a valid two-character state abbreviation.'
  
  validate :check_state_values
  
  before_save :truncate_attributes_that_can_be
  
  def foreign?
    !self.country.blank? && (self.country != country_names_to_country_codes['United States'])
  end
      
  private ##########################################################################
  
  def truncate_attributes_that_can_be
    { :billing_first_name => 15,
      :shipping_first_name => 15,
      :billing_last_name => 20,
      :shipping_last_name => 20,
      :billing_company => 40,
      :shipping_company => 40 }.each_with_key do |attribute,limit|
        self.send("#{attribute.to_s}=",self.send(attribute).to_s.slice(0,limit)) 
      end
  end
  
  def check_state_values
    if country == Map.country_names_to_country_codes['United States'] && state.size > 2
      errors.add('state', "is not valid. If shipping in US, please use 2 character state code.")
    end
    if scountry == Map.country_names_to_country_codes['United States'] && sstate.size > 2
      errors.add('sstate', "is not valid. If shipping in US, please use 2 character state code.")
    end
  end
  
end
