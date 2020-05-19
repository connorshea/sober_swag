require 'sober_swag/blueprint'

module SoberSwag
  class Controller
    class Route

      def initialize(method, action_name, path)
        @method = method
        @path = path
        @action_name = action_name
        @response_serializers = {}
        @response_descriptions = {}
      end

      attr_reader :response_serializers
      attr_reader :response_descriptions
      attr_reader :controller
      attr_reader :method
      attr_reader :path
      attr_reader :action_name
      ##
      # What to parse the request body in to.
      attr_reader :body_class
      ##
      # What to parse the request query in to
      attr_reader :query_class

      ##
      # What to parse the path params into
      attr_reader :path_params_class

      ##
      # Define the request body, using SoberSwag's type-definition scheme.
      # The block passed will be used to define the body of a new sublcass of `base` (defaulted to {Dry::Struct}.)
      # If you want, you can also define utility methods in here
      def body(base = Dry::Struct, &block)
        @body_class = make_struct!(base, &block)
        action_module.const_set('Body', @body_class)
      end

      ##
      # Does this route have a body defined?
      def body?
        !body_class.nil?
      end

      ##
      # Define the shape of the query parameters, using SoberSwag's type-definition scheme.
      # The block passed is the body of the newly-defined type.
      # You can also include a base type.
      def query(base = Dry::Struct, &block)
        @query_class = make_struct!(base, &block)
        action_module.const_set('Query', @query_class)
      end

      ##
      # Does this route have query params defined?
      def query?
        !query_class.nil?
      end

      ##
      # Define the shape of the *path* parameters, using SoberSwag's type-definition scheme.
      # The block passed will be the body of a new subclass of `base` (defaulted to {Dry::Struct}).
      # Names of this should match the names in the path template originally passed to {SoberSwag::Controller::Route.new}
      def path_params(base = Dry::Struct, &block)
        @path_params_class = make_struct!(base, &block)
        action_module.const_set('PathParams', @path_params_class)
      end

      ##
      # Does this route have path params defined?
      def path_params?
        !path_params_class.nil?
      end

      ##
      # Define the body of the action method in the controller.
      def action(&body)
        return @action if body.nil?

        @action ||= body
      end

      def description(desc = nil)
        return @description if desc.nil?

        @description = desc
      end

      def summary(sum = nil)
        return @summary if sum.nil?

        @summary = sum
      end

      ##
      # The container module for all the constants this will eventually define.
      # Each class generated by this Route will be defined within this module.
      def action_module
        @action_module ||= Module.new
      end

      ##
      # Define a serializer for a response with the given status code.
      # You may either give a serializer you defined elsewhere, or define one inline as if passed to
      # {SoberSwag::Blueprint.define}
      def response(status_code, description, serializer = nil, &block)
        status_key = Rack::Utils.status_code(status_code)

        raise ArgumentError, 'Response defiend!' if @response_serializers.key?(status_key)

        serializer ||= SoberSwag::Blueprint.define(&block)
        response_module.const_set(status_code.to_s.classify, serializer)
        @response_serializers[status_key] = serializer
        @response_descriptions[status_key] = description
      end

      ##
      # What you should call the module of this action in your controller
      def action_module_name
        action_name.to_s.classify
      end

      private

      def response_module
        @response_module ||= Module.new.tap { |m| action_module.const_set(:Response, m) }
      end

      def make_struct!(base, &block)
        Class.new(base, &block).tap { |e| e.transform_keys(&:to_sym) if base == Dry::Struct }
      end
    end
  end
end
