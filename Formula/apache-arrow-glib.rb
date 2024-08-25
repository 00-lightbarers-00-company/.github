class ApacheArrowGlib < Formula
  desc "GLib bindings for Apache Arrow"
  homepage "https://arrow.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=arrow/arrow-10.0.1/apache-arrow-10.0.1.tar.gz"
  mirror "https://archive.apache.org/dist/arrow/arrow-10.0.1/apache-arrow-10.0.1.tar.gz"
  sha256 "c814e0670112a22c1a6ec03ab420a52ae236a9a42e9e438c3cbd37f37e658fb3"
  license "Apache-2.0"
  revision 1
  head "https://github.com/apache/arrow.git", branch: "master"

  livecheck do
    formula "apache-arrow"
  end

  bottle do
    sha256 cellar: :any, arm64_ventura:  "8bffa7405e13176228e9609e30c22bd26b500039d331bf998ca0830071e184ff"
    sha256 cellar: :any, arm64_monterey: "3b9d56da7fef81bc65a24a7d35640621832712478ec3ac2318bd1f4a9ed86ba6"
    sha256 cellar: :any, arm64_big_sur:  "b05ca184cbcbdd10e374d4d7bbaba606f1bf250dc9031deb61f4bb0d1092315d"
    sha256 cellar: :any, ventura:        "5a11dda2c03bf6e316649e1a283a404987e7f6bd045123b14963d4db080f946a"
    sha256 cellar: :any, monterey:       "24389bd3f724fef4a0239f403c05d429cf6bc32eab75f7e08b77c8147eaa78c2"
    sha256 cellar: :any, big_sur:        "9d82c3201f3d3a949ba1784f8f917fede7aa35a7e68c4c58403992b7d9a7b561"
    sha256 cellar: :any, catalina:       "35b87a0729b403188e8a8990c76851914e2416bcb312db3cce9bc1ce58fb5f45"
    sha256               x86_64_linux:   "ca08feea5655e745137c3d253b3d89fba80e60b11256cd505120a649f28dc62a"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "apache-arrow"
  depends_on "glib"

  fails_with gcc: "5"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "../c_glib"
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    (testpath/"test.c").write <<~SOURCE
      #include <arrow-glib/arrow-glib.h>
      int main(void) {
        GArrowNullArray *array = garrow_null_array_new(10);
        g_object_unref(array);
        return 0;
      }
    SOURCE
    apache_arrow = Formula["apache-arrow"]
    glib = Formula["glib"]
    flags = %W[
      -I#{include}
      -I#{apache_arrow.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -L#{lib}
      -L#{apache_arrow.opt_lib}
      -L#{glib.opt_lib}
      -DNDEBUG
      -larrow-glib
      -larrow
      -lglib-2.0
      -lgobject-2.0
      -lgio-2.0
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
