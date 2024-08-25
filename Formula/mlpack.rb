class Mlpack < Formula
  desc "Scalable C++ machine learning library"
  homepage "https://www.mlpack.org"
  url "https://mlpack.org/files/mlpack-4.0.0.tar.gz"
  sha256 "041d9eee96445667d2f7b970d2a799592027f1f8818cd96a65dcce1ac0745773"
  license all_of: ["BSD-3-Clause", "MPL-2.0", "BSL-1.0", "MIT"]
  head "https://github.com/mlpack/mlpack.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "5293e16fd5e4a768188d45f985a9b259837cfdc7d306c5eae9f4511393f55a9e"
    sha256 cellar: :any,                 arm64_monterey: "9054a85591ea7e35da63fcacaaf45fb703eab442bfc517c24395badb1500b2c0"
    sha256 cellar: :any,                 arm64_big_sur:  "0a4363df84ff60bf4abdf5574e972b71f1d590ed2db3df8f8d65b8a1a0cc1f01"
    sha256 cellar: :any,                 ventura:        "2d68ff0aeddcaf5e3e433f2cb9c73d8757359f818f9f3a0c17220e4b18d77e74"
    sha256 cellar: :any,                 monterey:       "39d2ecbe49028f2e47aad8c937544a8ed6ea9a3b261cacef49ad8f6432d4e0e9"
    sha256 cellar: :any,                 big_sur:        "3ce0402749604bbdebfbbcd71a5773b54cfbb2205b10a811a55176307394a4f0"
    sha256 cellar: :any,                 catalina:       "d9f4ae02319dd3c35b8a04878d80cf351241d67ce1d731ffdcba0d945e8eaf7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01f0246ce3d77bf1ce07f6dbd325a9128d530346405a19391679a2f47e397107"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "pkg-config" => :build

  depends_on "armadillo"
  depends_on "boost"
  depends_on "cereal"
  depends_on "ensmallen"
  depends_on "graphviz"

  resource "stb_image" do
    url "https://raw.githubusercontent.com/nothings/stb/e140649c/stb_image.h"
    sha256 "8e5b0d717dfc8a834c97ef202d20e78d083d009586e1731c985817d0155d568c"
    version "2.26"
  end

  resource "stb_image_write" do
    url "https://raw.githubusercontent.com/nothings/stb/314d0a6f/stb_image_write.h"
    sha256 "51998500e9519a85be1aa3291c6ad57deb454da98a1693ab5230f91784577479"
    version "1.15"
  end

  def install
    resources.each do |r|
      r.stage do
        (include/"stb").install "#{r.name}.h"
      end
    end

    args = %W[
      -DDEBUG=OFF
      -DPROFILE=OFF
      -DBUILD_TESTS=OFF
      -DUSE_OPENMP=OFF
      -DARMADILLO_INCLUDE_DIR=#{Formula["armadillo"].opt_include}
      -DENSMALLEN_INCLUDE_DIR=#{Formula["ensmallen"].opt_include}
      -DARMADILLO_LIBRARY=#{Formula["armadillo"].opt_lib}/#{shared_library("libarmadillo")}
      -DSTB_IMAGE_INCLUDE_DIR=#{include/"stb"}
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    doc.install Dir["doc/*"]
    (pkgshare/"tests").install "src/mlpack/tests/data" # Includes test data.
  end

  test do
    system "#{bin}/mlpack_knn",
      "-r", "#{pkgshare}/tests/data/GroupLensSmall.csv",
      "-n", "neighbors.csv",
      "-d", "distances.csv",
      "-k", "5", "-v"

    (testpath/"test.cpp").write <<-EOS
      #include <mlpack/core.hpp>

      using namespace mlpack;

      int main(int argc, char** argv) {
        Log::Debug << "Compiled with debugging symbols." << std::endl;
        Log::Info << "Some test informational output." << std::endl;
        Log::Warn << "A false alarm!" << std::endl;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++14", "-I#{include}", "-L#{Formula["armadillo"].opt_lib}",
                    "-larmadillo", "-L#{lib}", "-o", "test"
    system "./test", "--verbose"
  end
end
