module Xeroizer
  class ApiException < StandardError
    
    attr_reader :type, :message, :xml, :request_body
    
    def initialize(type, message, xml, request_body)
      @type         = type
      @message      = message
      @xml          = xml
      @request_body = request_body
    end
    
    def message
      "#{@type}: #{@message} \n Generated by the following XML: \n #{@xml}"
    end
    
  end
  
  class UnparseableResponse < StandardError
    
    def initialize(root_element_name)
      @root_element_name = root_element_name
    end
    
    def message
      "A root element of #{@root_element_name} was returned, and we don't understand that!"
    end
      
  end
  
  class ObjectNotFound < StandardError
    
    def initialize(api_endpoint)
      @api_endpoint = api_endpoint
    end
    
    def message
      "Couldn't find object for API Endpoint #{@api_endpoint}"
    end
    
  end
  
  class InvoiceNotFoundError < StandardError; end

  class CreditNoteNotFoundError < StandardError; end
  
  class MethodNotAllowed < StandardError
    
    def initialize(klass, method)
      @klass = klass
      @method = method
    end
    
    def message
      "Method #{@method} not allowed on #{@klass}"
    end
    
  end
  
  class RecordKeyMustBeDefined < StandardError
    
    def initialize(possible_keys)
      @possible_keys = possible_keys
    end
    
    def message
      "One of the keys #{@possible_keys.join(', ')} need to be defined to update the record."
    end
    
  end

  class SettingTotalDirectlyNotSupported < StandardError
    
    def initialize(attribute_name)
      @attribute_name = attribute_name
    end
    
    def message
      "Can't set the total #{@attribute_name} directly as this is calculated automatically."
    end
    
  end

  class InvalidAttributeInWhere < StandardError
    
    def initialize(model_name, attribute_name)
      @model_name = model_name
      @attribute_name = attribute_name
    end
    
    def message
      "#{@attribute_name} is not an attribute of #{@model_name}."
    end
    
  end
  
  class AssociationTypeMismatch < StandardError
    
    def initialize(model_class, actual_class)
      @model_class = model_class
      @actual_class = actual_class
    end
  
    def message
      "#{@model_class} expected, got #{@actual_class}"
    end
    
  end
  
end