class Quantumxx < Formula
  desc "Modern C++ quantum computing library"
  homepage "https://github.com/softwareQinc/qpp"
  url "https://github.com/softwareQinc/qpp/archive/v4.3.tar.gz"
  sha256 "ef2675a95817b1df953333b68e92d99ddd99fb4d996638d7438e9d1f8849971b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "4f404a5248761b3ae66153f4ccf95cd074294a49c0b05e5bba035a9c4b944b76"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "eigen"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.15)
      project(qpp_test)
      set(CMAKE_CXX_STANDARD 17)

      find_package(qpp REQUIRED)
      add_executable(qpp_test qpp_test.cpp)
      target_link_libraries(qpp_test PUBLIC ${QPP_LINK_DEPS} libqpp)
    EOS
    (testpath/"qpp_test.cpp").write <<~EOS
      #include <iostream>
      #include <qpp/qpp.h>

      int main() {
          using namespace qpp;
          std::cout << disp(transpose(0_ket)) << std::endl;
      }
    EOS
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    assert_equal "1  0", shell_output("./build/qpp_test").chomp
  end
end
