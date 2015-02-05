require "fiddle"
require "fiddle/import"

module RustMessages
  extend Fiddle::Importer

  dlload "./libmessages.dylib"

  extern "char* last_message()"
  extern "char* greeting(char)"
  extern "char* format_address(char*, int, char*)"
end

class Messages
  class << self
    def last_message
      read_and_free RustMessages.last_message
    end

    def greeting(gender)
      read_and_free RustMessages.greeting(gender.codepoints[0])
    end

    def format_address(street, number, city)
      c_street = Fiddle::Pointer[street.to_s]
      c_city = Fiddle::Pointer[city.to_s]

      read_and_free RustMessages.format_address(c_street, number.to_i, c_city)
    end

    private

    # Not sure if this is necessary or if Ruby's GC takes care of them
    def read_and_free(pointer)
      result = pointer.to_s
      pointer.free
      result
    end
  end
end
