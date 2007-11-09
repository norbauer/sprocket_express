module RequiresParameters
  def requires!(hash, *params)
    keys = hash.keys
    params.each do |param| 
      if param.is_a?(Array)
        raise ArgumentError.new("Missing required parameter: #{param}") unless keys.include?(param.first) 

        valid_options = param[1..-1]
        raise ArgumentError.new("Parameter :#{param.first} must be one of #{valid_options.inspect}") unless valid_options.include?(hash[param.first])
      else
        raise ArgumentError.new("Missing required parameter: #{param}") unless keys.include?(param) 
      end
    end
  end    
end
