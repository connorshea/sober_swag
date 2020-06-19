module SoberSwag
  module Serializer
    class Meta < Base

      def initialize(base, meta)
        @base = base
        @meta = meta
      end

      attr_reader :base, :meta

      def lazy_type
        @base.lazy_type.meta(**meta)
      end

      def type
        @base.type.meta(**meta)
      end

      def finalize_lazy_type!
        @base.finalize_lazy_type!
      end

      def lazy_type?
        @base.lazy_type?
      end

    end
  end
end
