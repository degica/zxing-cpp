require 'mkmf'

ZXING_CPP = "#{File.dirname(__FILE__)}/zxing-cpp"
ZXING_CPP_BUILD = "#{ZXING_CPP}/build"

Dir.chdir ZXING_CPP_BUILD do
  `make`
end

cpp_include = File.join File.expand_path("#{ZXING_CPP}/core/src")
lib = File.expand_path "#{ZXING_CPP_BUILD}/libzxing.a"

$CPPFLAGS = %(-I#{cpp_include})
$DLDFLAGS = %(-lstdc++ #{lib})

if Dir["/usr/lib/libiconv.*"].size > 0
  $DLDFLAGS << %( -liconv)
end

create_makefile 'zxing/zxing'
