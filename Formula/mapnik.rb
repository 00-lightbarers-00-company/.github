class Mapnik < Formula
  desc "Toolkit for developing mapping applications"
  homepage "https://mapnik.org/"
  license "LGPL-2.1-or-later"
  revision 15
  head "https://github.com/mapnik/mapnik.git", branch: "master"

  stable do
    url "https://github.com/mapnik/mapnik/releases/download/v3.1.0/mapnik-v3.1.0.tar.bz2"
    sha256 "43d76182d2a975212b4ad11524c74e577576c11039fdab5286b828397d8e6261"

    # Allow Makefile to use PYTHON set in the environment. Remove in the next release.
    patch do
      url "https://github.com/mapnik/mapnik/commit/a53c90172c664d29cd877302de9790a6ee9b5330.patch?full_index=1"
      sha256 "9e0e06fd64d16b9fbe59d72402e805c94335397385ab57c49a6b468b9cc5a39c"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "1ee8e37cfd927c0bddb456cd0435cb26de4dc6d9ae25728cff8f9e66daf61846"
    sha256 cellar: :any,                 arm64_monterey: "c19d5bc65c66038e87e3048e96552fcd275a9b7e3230a77035604489a7195cba"
    sha256 cellar: :any,                 arm64_big_sur:  "8bcb940e5911dcbd7a2c0c38d457a93e390c3c789d7097bb10841e81780cb3ef"
    sha256 cellar: :any,                 ventura:        "a600af8282f392bfdd596cb5075bd4f1661aa1bddc6bef1ed67e1de2b186e835"
    sha256 cellar: :any,                 monterey:       "86e4858ca029222867ef5a75d4e2b3a435acf1e2e77b4ff25f9216d7dbbeb0ef"
    sha256 cellar: :any,                 big_sur:        "32870d981e76517265efd49cbbbd93c9a6ecb6551d255a8d6578094086c6cd80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4e5a360f7bbb15196d1038e9914e99f8ae07a03b4e95261b2ec6699bb6b0c5c2"
  end

  depends_on "pkg-config" => :build
  depends_on "python@3.9" => :build
  depends_on "boost"
  depends_on "cairo"
  depends_on "freetype"
  depends_on "gdal"
  depends_on "harfbuzz"
  depends_on "icu4c"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libpq"
  depends_on "libtiff"
  depends_on "proj"
  depends_on "webp"

  def install
    ENV.cxx11
    ENV["PYTHON"] = "python3.9"

    # Work around "error: no member named 'signbit' in the global namespace"
    # encountered when trying to detect boost regex in configure
    ENV.delete("SDKROOT") if DevelopmentTools.clang_build_version >= 900

    boost = Formula["boost"].opt_prefix
    freetype = Formula["freetype"].opt_prefix
    harfbuzz = Formula["harfbuzz"].opt_prefix
    icu = Formula["icu4c"].opt_prefix
    jpeg = Formula["jpeg-turbo"].opt_prefix
    libpng = Formula["libpng"].opt_prefix
    libtiff = Formula["libtiff"].opt_prefix
    proj = Formula["proj"].opt_prefix
    webp = Formula["webp"].opt_prefix

    args = %W[
      CC=#{ENV.cc}
      CXX=#{ENV.cxx}
      PREFIX=#{prefix}
      BOOST_INCLUDES=#{boost}/include
      BOOST_LIBS=#{boost}/lib
      CAIRO=True
      CPP_TESTS=False
      FREETYPE_CONFIG=#{freetype}/bin/freetype-config
      GDAL_CONFIG=#{Formula["gdal"].opt_bin}/gdal-config
      HB_INCLUDES=#{harfbuzz}/include
      HB_LIBS=#{harfbuzz}/lib
      ICU_INCLUDES=#{icu}/include
      ICU_LIBS=#{icu}/lib
      INPUT_PLUGINS=all
      JPEG_INCLUDES=#{jpeg}/include
      JPEG_LIBS=#{jpeg}/lib
      NIK2IMG=False
      PG_CONFIG=#{Formula["libpq"].opt_bin}/pg_config
      PNG_INCLUDES=#{libpng}/include
      PNG_LIBS=#{libpng}/lib
      PROJ_INCLUDES=#{proj}/include
      PROJ_LIBS=#{proj}/lib
      TIFF_INCLUDES=#{libtiff}/include
      TIFF_LIBS=#{libtiff}/lib
      WEBP_INCLUDES=#{webp}/include
      WEBP_LIBS=#{webp}/lib
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mapnik-config --prefix").chomp
    assert_equal prefix.to_s, output
  end
end
