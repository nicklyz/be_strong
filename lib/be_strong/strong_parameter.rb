module BeStrong
  class StrongParameter
    class << self
      def apply_all(dir)
        files = []
        Dir.glob(File.join(path, '**/*.rb')).each do |file|
          applied = apply(file)
          files << file if applied
        end
        files
      end

      def apply(file)
        buf  = File.open(file, 'r'){|f| f.read}
        code = Code.new(buf).apply_strong_parameter!
        return false unless code.changed?

        File.open(file, 'w'){|f| f.puts(code)}
        true
      end
    end
  end
end