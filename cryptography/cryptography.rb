require "fiddle"
require "fiddle/import"

module RustCrypto
  extend Fiddle::Importer

  dlload "./target/libcrypto-ef49a452cb3f5dbe.dylib"

  extern "char* md5_int(int)"
  extern "char* md5_str(char*)"
end

class Crypto
  class << self
    def md5(input)
      case input
      when Fixnum
        read_and_free RustCrypto.md5_int(input.to_i)
      when String
        c_input = Fiddle::Pointer[input.to_s]

        read_and_free RustCrypto.md5_str(c_input)
      end
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


