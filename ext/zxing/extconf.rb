require 'mkmf'

ZXING_CPP = "#{__dir__}/zxing-cpp"
ZXING_CPP_BUILD = "#{ZXING_CPP}/build"
ZXING_CMAKE = "#{__dir__}/cmake/bin/cmake"

Dir.mkdir ZXING_CPP_BUILD unless File.exist? ZXING_CPP_BUILD
Dir.chdir ZXING_CPP_BUILD do
  `#{ZXING_CMAKE} -DBUILD_SHARED_LIBS:BOOL=OFF -DCMAKE_CXX_FLAGS="-fPIC" ..`
end

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
