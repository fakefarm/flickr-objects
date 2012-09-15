require "flickr/objects/attribute_values/photo"
require "flickr/api/photo"

class Flickr
  class Photo < Media
    attr_reader :size

    attribute :rotation,   type: Integer
    attribute :source_url, type: String
    attribute :height,     type: String
    attribute :width,      type: String

    SIZES.keys.each do |size|
      size_name, size_number = size.split(" ").map(&:downcase)

      define_method("#{size_name}#{size_number}!") { @size = size; self }
      define_method("#{size_name}#{size_number}")  { dup.send("#{size_name}#{size_number}!") }

      if size_number
        define_method("#{size_name}!") {|size_number| send("#{size_name}#{size_number}!") }
        define_method("#{size_name}")  {|size_number| send("#{size_name}#{size_number}") }
      end
    end

    def largest!; @size = largest_size; self end
    def largest;  dup.largest!               end

    def initialize(*args)
      super
      largest!
    end
  end
end
