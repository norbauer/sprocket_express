module Map
  # Path of the order csv file to be stored. 
  CSV_STORAGE_PATH = File.dirname(__FILE__) +'/../../../../public/sprocket_fulfillment_csv_files' 
 
  CARRIER_CODES = { 'AP' => "USPS International Air parcel or Air Letter",
                    'EM' => "USPS Express Mail",
                    'FC' => "USPS First Class",
                    'GXM' => "USPS International Express Mail",
                    'GPM'	=> "USPS International Priority Mail",
                    'MM' =>	 "USPS Book Rate",
                    'PM' =>	"USPS Priority Mail",
                    'PP'	=> "USPS Parcel Post",
                    'UP2' => "UPS Commercial 2nd Day",
                    'UP3' =>	"UPS Commercial 3rd day",
                    'UPC' =>	"UPS Commercial Ground",
                    'UPN' =>	"UPS Commercial Next Day",
                    'UPS' =>	"UPS Residential Ground",
                    'UPV' =>	"UPS Residential Next Day Air Saver ",
                    'UR2' =>	"UPS Residential 2nd Day",
                    'UR3' =>	"UPS Residential 3rd day",
                    'URN' =>	"UPS Residential Next Day" }
                             
  COUNTRY_CODES = { '001' => "United States",
                    '002' => "Afghanistan",
                    '003' => "Albania",
                    '004' => "Algeria",
                    '005' => "Andorra",
                    '006' => "Angola",
                    '007' => "Anguilla",
                    '008' => "Antigua and Barbuda",
                    '009' => "Argentina",
                    '010' => "Aruba",
                    '011' => "Ascension",
                    '012' => "Australia",
                    '013' => "Austria",
                    '014' => "Azores",
                    '015' => "Bahamas",
                    '016' => "Bahrain",
                    '017' => "Bangladesh",
                    '018' => "Barbados",
                    '019' => "Belgium",
                    '020' => "Belize",
                    '021' => "Benin",
                    '022' => "Bermuda",
                    '023' => "Bhutan",
                    '024' => "Bolivia",
                    '025' => "Botswana",
                    '026' => "Brazil",
                    '027' => "Virgin Islands, British",
                    '028' => "Brunei Darussalam",
                    '029' => "Bulgaria",
                    '030' => "Burkina Faso",
                    '031' => "Burma",
                    '032' => "Burundi",
                    '033' => "Cameroon",
                    '034' => "Canada",
                    '035' => "Cape Verde",
                    '036' => "Cayman Islands",
                    '037' => "Central African Republic",
                    '038' => "Chad",
                    '039' => "Chile",
                    '040' => "China",
                    '041' => "Colombia",
                    '042' => "Comoros",
                    '043' => "Congo",
                    '044' => "Corsica",
                    '045' => "Costa Rica",
                    '046' => "Cote D'Ivoire",
                    '047' => "Cuba",
                    '048' => "Cyprus",
                    '049' => "Czechoslovakia",
                    '050' => "Denmark",
                    '051' => "Djibouti",
                    '052' => "Dominica",
                    '053' => "Dominican Rep.",
                    '054' => "East Timor",
                    '055' => "Ecuador",
                    '056' => "Egypt",
                    '057' => "El Salvador",
                    '058' => "Equatorial Guinea",
                    '059' => "Estonia",
                    '060' => "Ethiopia",
                    '061' => "Falkland Islands (Malvinas)",
                    '062' => "Faroe Islands",
                    '063' => "Fiji",
                    '064' => "Finland",
                    '065' => "France",
                    '066' => "French Guiana",
                    '067' => "French Polynesia",
                    '068' => "Gabon",
                    '069' => "Gambia",
                    '070' => "Germany",
                    '071' => "Ghana",
                    '072' => "Gibraltar",
                    '073' => "United kingdom",
                    '074' => "Greece",
                    '075' => "Greenland",
                    '076' => "Grenada",
                    '077' => "Guadeloupe",
                    '078' => "Guatemala",
                    '079' => "Guinea",
                    '080' => "Guinea-Bissau",
                    '081' => "Guyana",
                    '082' => "Haiti",
                    '083' => "Honduras",
                    '084' => "Hong Kong",
                    '085' => "Hungary",
                    '086' => "Iceland",
                    '087' => "India",
                    '088' => "Indonesia",
                    '089' => "Iran",
                    '090' => "Iraq",
                    '091' => "Ireland, the Republic of",
                    '092' => "Israel",
                    '093' => "Italy",
                    '094' => "Jamaica",
                    '095' => "Japan",
                    '096' => "Jordan",
                    '097' => "Kampuchea",
                    '098' => "Kenya",
                    '099' => "Kiribati",
                    '100' => "Korea, Democ. Peoples Rep.",
                    '101' => "Kuwait, Republic of Kuwait",
                    '102' => "Lao",
                    '103' => "Latvia",
                    '104' => "Lebanon",
                    '105' => "Lesotho",
                    '106' => "Liberia",
                    '107' => "Libya",
                    '108' => "Liechtenstein",
                    '109' => "Lithuania",
                    '110' => "Luxembourg",
                    '111' => "Macau",
                    '112' => "Madagascar",
                    '113' => "Madeira Islands",
                    '114' => "Malawi",
                    '115' => "Malaysia",
                    '116' => "Maldives",
                    '117' => "Mali",
                    '118' => "Malta",
                    '119' => "Martinique",
                    '120' => "Mauritania",
                    '121' => "Mauritius",
                    '122' => "Mexico",
                    '123' => "Monaco",
                    '124' => "Mongolia",
                    '125' => "Montserrat",
                    '126' => "Morocco",
                    '127' => "Mozambique",
                    '128' => "Nauru",
                    '129' => "Nepal",                                 
                    '130' => "Netherlands",
                    '131' => "Netherlands Antilies",
                    '132' => "New Caledonia",
                    '133' => "New Zealand",
                    '134' => "Nicaragua",
                    '135' => "Niger",
                    '136' => "Nigeria",
                    '137' => "Norway",
                    '138' => "Oman",                                
                    '139' => "Pakistan",
                    '140' => "Panama",
                    '141' => "Papua New Guinea",
                    '142' => "Paraguay",
                    '143' => "Peru",
                    '144' => "Philippines",
                    '145' => "Pitcairn",
                    '146' => "Poland",
                    '147' => "Portugal",
                    '148' => "Qatar",
                    '149' => "Reunion",
                    '150' => "Romania",
                    '151' => "Russian Federation",
                    '152' => "Rwanda",
                    '153' => "Saint Kitts and Nevis",
                    '154' => "Saint Helena",
                    '155' => "Saint Lucia",
                    '156' => "Saint Pierre & Miquelon",
                    '157' => "St. Vincent&The Grenadines",
                    '158' => "San Marino",
                    '159' => "Sao Tome and Principe",
                    '160' => "Saudi Arabia",
                    '161' => "Senegal",
                    '162' => "Seychelles",
                    '163' => "Sierra Leone",
                    '164' => "Singapore",
                    '165' => "Solomon Islands",
                    '166' => "Somalia",
                    '167' => "South Africa",
                    '168' => 'Spain',
                    '169' => "Sri Lanka",
                    '170' => "Sudan",
                    '171' => "Suriname",
                    '172' => "Swaziland",
                    '173' => "Sweden",
                    '174' => "Switzerland",
                    '175' => "Syrian Arab Republic",
                    '176' => "Taiwan",
                    '177' => "Tanzania, United Republic of",
                    '178' => "Thailand",
                    '179' => "Togo",
                    '180' => "Tonga",
                    '181' => "Trinidad and Tobago",
                    '182' => "Tristan da Cunha",
                    '183' => "Tunisia",
                    '184' => "Turkey",
                    '185' => "Turks and Caicos Islands",
                    '186' => "Tuvalu",
                    '187' => "Wallis and Futuna Islands",
                    '188' => "Western Samoa",
                    '189' => "U.S.S.R. (No Longer Used)",
                    '190' => "Uganda",
                    '191' => "United Arab Emirates",
                    '192' => "Uruguay",
                    '193' => "Vanuatu",
                    '194' => "Holy See (Vatican City State)",
                    '195' => "Venezuela",
                    '196' => "Vietnam",
                    '197' => "Yemen",
                    '198' => "Yugoslavia",
                    '199' => "Zaire",
                    '200' => "Zambia",
                    '201' => "Zimbabwe",
                    '202' => "Korea, Republic of",
                    '225' => "Armenia",
                    '226' => "Azerbaijan",
                    '227' => "Belarus",
                    '229' => "Republic of Georgia",
                    '230' => "Kazakhstan",
                    '231' => "Kyrgyzstan",
                    '232' => "La Luia",
                    '233' => "Lithvania",
                    '234' => "MocDavia",
                    '235' => "Tadzhikistan",
                    '236' => "Turkmenistan",
                    '237' => "Ukraine",
                    '238' => "Uzbekistan",
                    '239' => "Bosnia and Herzegovina",
                    '240' => "Croatia",
                    '241' => "Serbia (Montenegro)",
                    '242' => "Macedonia",
                    '243' => "Slovenia",
                    '244' => "Slovakia",
                    '245' => "Czech Republic",
                    '246' => "Scotland",
                    '247' => "Canary Islands",
                    '280' => "British Forces Post Office",
                    '248' => "American Samoa",
                    '249' => "Antarctica",
                    '250' => "Bouvet Island",
                    '251' => "British Indian Ocean Territory",
                    '252' => "Cambodia",
                    '253' => "Christmas Island",
                    '254' => "Cocos (Keeling) Islands",
                    '256' => "Cook Islands",
                    '257' => "Eritrea",
                    '258' => "France, Metropolitan",
                    '259' => "French Southern Territorie",
                    '260' => "Guam",
                    '261' => "Heard And Mc Donald Island",
                    '301' => "Korea, Democratic People's",
                    '262' => "Marshall Islands",
                    '263' => "Mayotte",
                    '304' => "Micronesia, Federated States of",
                    '265' => "Moldova, Republic Of",
                    '266' => "Myanmar",
                    '267' => "Namibia",
                    '268' => "Niue",
                    '305' => "Norfolk Island",
                    '306' => "Northern Mariana Islands",
                    '271' => "Palau",
                    '272' => "Puerto Rico",
                    '310' => "South Georgia And The Sout",
                    '311' => "Svalbard And Jan Mayen Isl",
                    '275' => "Tajikistan",
                    '276' => "Tokelau",
                    '313' => "United States Minor Outlyi",
                    '278' => "Virgin Islands, U.S.",
                    '279' => "Western Sahara",
                    '300' => "Congo, The Democratic Repuplic",
                    '302' => "Lao People's Democratic Republic",
                    '303' => "Macedonia, The Former Yugoslav Republic of",
                    '307' => "Palestinian Territory, Occ",
                    '308' => "Saint Vincent and The Grenadines",
                    '309' => "Slovakia (slovak Republic)",
                    '312' => "Taiwan, Province Of China" }
                    
  # Mapping of the methods of models to the columns in CSV. Also added the specification for the columns provided in the example file.
  MAPPING = [  ['alt_num' ,'AltNum', 'Not used. Please leave blank'],
               ['cust_num', 'Cust_Num', 'Not used. Please default to zero'],
               ['last_name','LastName' ],
               ['first_name','FirstName' ],
               ['company','Company'],
               ['address_1','Address1'],
               ['address_2','Address2'],
               ['city','City' ],
               ['state', 'State'],
               ['zipcode','ZipCode'],
               ['foreign', 'Foreign','Indicate "Y" if shipment is out of the US'],
               ['phone','Phone'],
               ['comment','Comment'],
               ['ctype_1','Ctype1'],
               ['ctype_2','Ctype2'],
               ['ctype_3','Ctype3'],
               ['tax_exempt', 'TaxExempt'],
               ['prospect','Prospect'],
               ['card_type', 'CardType'],
               ['card_num', 'CardNum'],
               ['expires', 'Expires'],
               ['source_key','Source_Key', 'this is a constant 3 Char code identifying you as a unique customer. Your code may not yet be assigned.'],
               ['catalog' ,'Catalog'],
               ['sales_id','Sales_ID' ,'this is a constant 3 Char code identifying you as a unique customer. Your code may not yet be assigned.'],
               ['oper_id','Oper_ID' ],
               ['reference','Reference'],
               ['ship_via','Ship_Via', 'From Carrier Codes'],
               ['fulfilled','Fulfilled'],
               ['paid', 'Paid' ],
               ['continued',  'Continued',"If more than 5 SKU's being ordered, continue the order on next line and place an 'X' here."],
               ['order_date','Order_Date',"Order date from your shopping cart. Not required"],
               ['ord_num','Ord-Num', 'Order number from your shopping cart. Useful but not required'],
               ['product_01','Product01', "SKU's need to have the same 3 character identifier preceeding the SKU unless separate company is used."],
               ['quantity_01', 'Quantity01'],
               ['product_02','Product02', "SKU's need to have the same 3 character identifier preceeding the SKU unless separate company is used."],
               ['quantity_02', 'Quantity02'],
               ['product_03','Product03', "SKU's need to have the same 3 character identifier preceeding the SKU unless separate company is used."],
               ['quantity_03', 'Quantity03'],
               ['product_04','Product04', "SKU's need to have the same 3 character identifier preceeding the SKU unless separate company is used."],
               ['quantity_04', 'Quantity04'],
               ['product_05','Product05', "SKU's need to have the same 3 character identifier preceeding the SKU unless separate company is used."],
               ['quantity_05','Quantity05'],
               ['slast_name','SLastName' ,"Ship to address. Last name. Note[' if ship to address is blank, then order will be shipped to the bill-to address."],
               ['sfirst_name','SFirstName' ],
               ['scompany','SCompany'],
               ['saddress_1','SAddress1'],
               ['saddress_2','SAddress2'],
               ['scity','SCity' ],
               ['sstate', 'SState'],
               ['szip_code','SZipCode'],
               ['hold_date','HoldDate', "Keep this constant unless we are doing your invoicing"],
               ['greeting_1','Greeting1'],
               ['greeting_2','Greeting2'],
               ['promo_cred','PromoCred'],
               ['use_prices','UsePrices', "leave blank and omit pricing if you don�t want to show pricing"],
               ['price_01','Price01'],
               ['discount_01','Discount01', "discount expressed as a percent off the price"],
               ['price_02','Price02'],
               ['discount_02','Discount02',  "discount expressed as a percent off the price"],
               ['price_03','Price03'],
               ['discount_03','Discount03',  "discount expressed as a percent off the price"],
               ['price_04','Price04'],
               ['discount_04','Discount04',  "discount expressed as a percent off the price"],
               ['price_05','Price05'],
               ['discount_05','Discount05',  "discount expressed as a percent off the price"],
               ['use_ship_amt', 'UseShipAmt', "leave blank and omit pricing if you don�t want to showthe amount charged for Shipping & Handling"],
               ['shipping','Shipping'],
               ['email','Email', "Not required, but without it, we cannot send a confirming email to the customer."],
               ['country', 'Country', "See country tab. Country must be text. '001 is not 1."],
               ['scountry', 'Scountry', "See country tab. Country must be text. '001 is not 1."],
               ['phone_2', 'Phone2'],
               ['sphone', 'Sphone'],
               ['sphone_2', 'Sphone2'],
               ['semail','Semail'],
               ['order_type',  'OrderType'"constant"],
               ['inpart', 'Inpart'],
               ['title', 'Title'],
               ['salu', 'Salu'],
               ['hono', 'Hono'],
               ['ext', 'Ext'],
               ['ext_2', 'Ext2'],
               ['stitle', 'STitle'],
               ['ssalu' ,'Ssalu'],
               ['shono', 'Shono'],
               ['sext', 'sext'],
               ['sext_2', 'sext2'],
               ['ship_when', 'Ship_When'],
               ['greeting_3', 'Greeting3'],
               ['greeting_4', 'Greeting4'],
               ['greeting_5', 'Greeting5'],
               ['greeting_6', 'Greeting6'],
               ['password', 'Password'],
               ['custom01', 'Custom01'],
               ['custom02', 'Custom02'],
               ['custom03', 'Custom03'],
               ['custom04', 'Custom04'],
               ['custom05', 'Custom05'],
               ['rcode', 'Rcode'],
               ['approval', 'Approval'],
               ['avs', 'Avs'],
               ['antrans_id','AnTrans_ID',],
               ['auth_amt','Auth_Amt'],
               ['auth_time', 'Auth_Time'],
               ['internet_id', 'InternetID'],
               ['order_note1', 'Ordnote1'],
               ['order_note2', 'Ordnote2'],
               ['order_note3', 'Ordnote3'],
               ['order_note4', 'Ordnote4'],
               ['order_note5', 'Ordnote5'],
               ['fulfill1', 'Fulfill1'],
               ['fulfill2', 'Fulfill2'],
               ['fulfill3', 'Fulfill3'],
               ['fulfill4', 'Fulfill4'],
               ['fulfill5', 'Fulfill5'],
               ['internet', 'Internet', "constant"],
               ['priority', 'Priority'],
               ['no_mail', 'NoMail', "constant"],
               ['no_rent', 'NoRent', "constant"],
               ['no_Email', 'NoEmail', "constant"],
               ['po_number', 'PONumber'],
               ['address_3', 'Address3'],
               ['saddress_3', 'SAddress3'],
               ['cc_other', 'CC_Other'],
               ['order_promo', 'OrderPromo'],
               ['best_order_promo', 'BestOrderPromo'],
               ['order_memo1', 'OrderMomo1', "Information entered here will appear on the packing slip. If nothing is here, a standard thank-you note will appear."],
               ['order_memo2', 'OrderMomo2', "Information entered here will appear on the packing slip. If nothing is here, a standard thank-you note will appear."],
               ['order_memo3', 'OrderMomo3', "Information entered here will appear on the packing slip. If nothing is here, a standard thank-you note will appear."],
               ['ship_ahead', 'ShipAhead', "Normally the code is 'F'. If a 'T' is placed here, the system will ship all available inventory and hold backordered items."],
               ['return_product_code1','ReturnProductCode1'],
               ['return_product_code2','ReturnProductCode2'],
               ['return_product_code3','ReturnProductCode3'],
               ['return_product_code4','ReturnProductCode4'],
               ['return_product_code5','ReturnProductCode5'] ]

  # Extracts the title of the columns to be added in CSV.
  def self.extract_titles
    MAPPING.collect{|a| a[1]}    
  end
  
  # Search for a particular attribute in MAPPING
  def self.search_attribute(attr)
    MAPPING.each{|x| return x if x[0] == attr.to_s}
  end
  
  def self.get_country_code(country)
    COUNTRY_CODES.invert[country]
  end
    
  def self.get_carrier_code(carrier)
    CARRIER_CODES.invert[carrier]
  end
  
end

