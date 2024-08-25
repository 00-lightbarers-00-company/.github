class Grantlee < Formula
  desc "Libraries for text templating with Qt"
  homepage "https://github.com/steveire/grantlee"
  url "https://github.com/steveire/grantlee/releases/download/v5.3.1/grantlee-5.3.1.tar.gz"
  sha256 "ba288ae9ed37ec0c3622ceb40ae1f7e1e6b2ea89216ad8587f0863d64be24f06"
  license "LGPL-2.1-or-later"
  head "https://github.com/steveire/grantlee.git", branch: "master"

  bottle do
    sha256 arm64_ventura:  "46253789d31595c08c50abca379da6d795dbd6ed79419e3a764759f8fe17e1b1"
    sha256 arm64_monterey: "cf5d7791583fbe05a7040ca9abcb8adcae421c1e6426d6c7b2d498f2fff5a882"
    sha256 arm64_big_sur:  "98cf93a0121f6dc1fe9ff0c90fac922101e2105dafe8b78ef6d58e47f7077a7b"
    sha256 monterey:       "208abce9f9486cb7ffa60421a026f44e3af436d74bf3a344ef00a92945eb5231"
    sha256 big_sur:        "8aebd298307cd5055ee40a88a3728866a141e26a412b35c1db95f3c894f886e4"
    sha256 catalina:       "c94ce97fcb5d60f4a31b48d2a36a4da60fa685a67d2f320716d535920abb5967"
    sha256 x86_64_linux:   "aa0d2ecec107907c391964d313d1ae2fa164d22d8f15c80e02b721d21e058316"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build

  depends_on "qt@5"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    system "cmake", "--build", "build", "--target", "docs"

    (pkgshare/"doc").install Dir["build/apidox/*"]
    pkgshare.install "examples"
  end

  test do
    # Test fails when qt (6) is installed
    args = %W[
      -D Qt5_DIR=#{Formula["qt@5"].opt_lib}/cmake/Qt5
      -D Qt5Gui_DIR=#{Formula["qt@5"].opt_lib}/cmake/Qt5Gui
      -D Qt5Sql_DIR=#{Formula["qt@5"].opt_lib}/cmake/Qt5Sql
      -D Qt5Widgets_DIR=#{Formula["qt@5"].opt_lib}/cmake/Qt5Widgets
    ]

    # Other examples require qt-webkit. We doesn't test execution because they're GUI-only apps.
    %w[books
       codegen
       textedit].each do |test_name|
      mkdir test_name.to_s do
        system "cmake", (pkgshare/"examples/#{test_name}"), *std_cmake_args, *args
        system "cmake", "--build", "."
      end
    end
  end
end
