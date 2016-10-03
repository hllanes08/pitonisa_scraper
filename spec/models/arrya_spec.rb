class ExampleGroup
   def self.it(desc, &block)
   	define_method(desc, &block)
	@examples ||= []
	@examples << desc
   end

   def self.examples	
   	@examples
   end
end

class ArraySpec < ExampleGroup
     def build_array(*args)
    	[*args]
    end
    
    it 'has a length' do
    	raise unless build_array("a").length == 1
    end

    it 'has a first element' do
    	raise unless build_array("a").first == "a"
    end

end

ArraySpec.examples.each do |example|
     begin
     	ArraySpec.new.send(example)
     	puts "#{example}: PASS"
     rescue => e
	puts "#{example}: FAIL (#{e.message})"
     end
end
