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
  
  def foreign?
    !self.country.blank? && (self.country != country_names_to_country_codes['United States'])
  end
  
  # @TODO we want to truncate (not validate) first_name, last_name, and company lengths
      
  private ##########################################################################
  
  def check_state_values
    if country == Map.country_names_to_country_codes['United States'] && state.size > 2
      errors.add('state', "is not valid. If shipping in US, please use 2 character state code.")
    end
    if scountry == Map.country_names_to_country_codes['United States'] && sstate.size > 2
      errors.add('sstate', "is not valid. If shipping in US, please use 2 character state code.")
    end
  end
  
end
