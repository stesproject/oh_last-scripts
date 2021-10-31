################

#AntiLag

################

    module AntiLag

      SPC = Win32API.new("kernel32", "SetPriorityClass", "pi", "i")

      @@high_priority = false

      def self.high_priority ; @@high_priority; end

      def self.high_priority?; @@high_priority; end

      def self.high_priority=(valor)

        return if @@high_priority == valor

        @@high_priority = valor

        if @@high_priority

          SPC.call(-1, 0x80)

          return

        end

        SPC.call(-1, 0x20)

      end

    end

    AntiLag.high_priority = true