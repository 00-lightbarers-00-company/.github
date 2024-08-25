class ClangFormat < Formula
  desc "Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript"
  homepage "https://clang.llvm.org/docs/ClangFormat.html"
  # The LLVM Project is under the Apache License v2.0 with LLVM Exceptions
  license "Apache-2.0"
  version_scheme 1
  head "https://github.com/llvm/llvm-project.git", branch: "main"

  stable do
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.6/llvm-15.0.6.src.tar.xz"
    sha256 "0b32199401f27e2e0353846a8c5fbadd77beca2570654fb9ef7ac9b7f26967e3"

    resource "clang" do
      url "https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.6/clang-15.0.6.src.tar.xz"
      sha256 "10119ae195f1b4f979fe42e67b781e175b0c0d4e982fd6a2f44c4aa7fc925233"
    end

    resource "cmake" do
      url "https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.6/cmake-15.0.6.src.tar.xz"
      sha256 "7613aeeaba9b8b12b35224044bc349b5fa45525919625057fa54dc882dcb4c86"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/llvmorg[._-]v?(\d+(?:\.\d+)+)}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fbf56abfb24a21c165be6354c24784fda0404eb0009acb24e7764f985cc46396"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "863c6e225f28a486e59d9581a15a138f12a79be7ec0e88bfbb7a13dce69caed2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9dff09df90416010de10c0f2d5827d7088f752747b79c4b1dc2fdbfc8ec82bf2"
    sha256 cellar: :any_skip_relocation, ventura:        "eaa6987f545e773b2af7030555198e441ce18ff1fc0be8728757cb167e271a4b"
    sha256 cellar: :any_skip_relocation, monterey:       "f2057cfecd05af214a620f359634001fe78fb25b21ec2c19885cd57e38af9e6f"
    sha256 cellar: :any_skip_relocation, big_sur:        "047d4e2321824b31d4ec0208a85e114e579255c210f62e0415f618f1fbbe3362"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a0d2f67c64a65e9411420b052c6f3cc234879ff62c8306c3090c19298abb4cc"
  end

  depends_on "cmake" => :build

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"
  uses_from_macos "python", since: :catalina
  uses_from_macos "zlib"

  on_linux do
    keg_only "it conflicts with llvm"
  end

  def install
    llvmpath = if build.head?
      ln_s buildpath/"clang", buildpath/"llvm/tools/clang"

      buildpath/"llvm"
    else
      (buildpath/"src").install buildpath.children
      (buildpath/"src/tools/clang").install resource("clang")
      (buildpath/"cmake").install resource("cmake")

      buildpath/"src"
    end

    system "cmake", "-S", llvmpath, "-B", "build",
                    "-DLLVM_EXTERNAL_PROJECTS=clang",
                    "-DLLVM_INCLUDE_BENCHMARKS=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build", "--target", "clang-format"

    bin.install "build/bin/clang-format"
    bin.install llvmpath/"tools/clang/tools/clang-format/git-clang-format"
    (share/"clang").install llvmpath.glob("tools/clang/tools/clang-format/clang-format*")
  end

  test do
    system "git", "init"
    system "git", "commit", "--allow-empty", "-m", "initial commit", "--quiet"

    # NB: below C code is messily formatted on purpose.
    (testpath/"test.c").write <<~EOS
      int         main(char *args) { \n   \t printf("hello"); }
    EOS
    system "git", "add", "test.c"

    assert_equal "int main(char *args) { printf(\"hello\"); }\n",
        shell_output("#{bin}/clang-format -style=Google test.c")

    ENV.prepend_path "PATH", bin
    assert_match "test.c", shell_output("git clang-format", 1)
  end
end
