module BBS
  class Counter
    @count = 0
    class << self
      def count
        @count
      end

      def increment
        @count += 1
      end
    end
  end
end
