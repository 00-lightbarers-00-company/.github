class Biosig < Formula
  desc "Tools for biomedical signal processing and data conversion"
  homepage "https://biosig.sourceforge.io"
  url "https://downloads.sourceforge.net/project/biosig/BioSig%20for%20C_C%2B%2B/src/biosig-2.4.3.src.tar.xz"
  sha256 "7b6000e2275c00a67d7a25aaf7ffad229978d124315f5f910844b33a8a61e532"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/(?:biosig|biosig4c[^-]*?)[._-]v?(\d+(?:\.\d+)+)\.src\.t}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "cd18b285cc6363dc0e8dc3ccfa6e61757cc8cf88db8858d29a9ffbced6039276"
    sha256 cellar: :any,                 arm64_monterey: "666be7197b4b957e663ace06f80d9735db7818769d77023fbede8373b23c0e25"
    sha256 cellar: :any,                 arm64_big_sur:  "9c7cc801e2e9bcbc69bda4d87ab4b6795f243f06369f8ff116008bb14525007f"
    sha256 cellar: :any,                 ventura:        "c8a246347d0bae9ee90a400352e176bdfb774df471c77a79ebab2aac321f84b2"
    sha256 cellar: :any,                 monterey:       "b51b7647888687e69cb49e46eb3d154d14c2baa3ee4c6431a654baa39ab72c50"
    sha256 cellar: :any,                 big_sur:        "370e02d1a1509b432accedc09a1dd34dc39d011d3ad86182b0927e802165b8b1"
    sha256 cellar: :any,                 catalina:       "6c5a5b6d1a96cefb397a705a2e299f843566b249c8d1b6c7e6910f3bfaf7bbc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c99f7b04bdef479aed3ae4a538dba0e1aac405a956cfafbbc547af2664a3236"
  end

  depends_on "gawk" => :build
  depends_on "libarchive" => :build
  depends_on "dcmtk"
  depends_on "libb64"
  depends_on "numpy"
  depends_on "suite-sparse"
  depends_on "tinyxml"

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "usage: save2gdf [OPTIONS] SOURCE DEST", shell_output("#{bin}/save2gdf -h").strip
    assert_match "mV\t4274\t0x10b2\t0.001\tV", shell_output("#{bin}/physicalunits mV").strip
    assert_match "biosig_fhir provides fhir binary template for biosignal data",
                 shell_output("#{bin}/biosig_fhir 2>&1").strip
  end
end
