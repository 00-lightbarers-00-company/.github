class Broot < Formula
  desc "New way to see and navigate directory trees"
  homepage "https://dystroy.org/broot/"
  url "https://github.com/Canop/broot/archive/v1.17.1.tar.gz"
  sha256 "acde4ddfff0875506c4f91346895c5b554d44a91f46a6918de6086d3884857d7"
  license "MIT"
  head "https://github.com/Canop/broot.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d386cd791e2b008ae2fba91065c91700c2fd1f43ddd795c7e2e8ad6886804dc8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b3639ae57563a88ed8d2fe1cefa419890ec4183de38d9260f7410308448432cf"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "101ae8a87488f9da5aacb2c7556d6ba788643905df8cce620434fccb63d3d6d1"
    sha256 cellar: :any_skip_relocation, ventura:        "d5bac98189c4749e0be33b7655861a69490d1296ccf32de8316ce9d06c6f07c5"
    sha256 cellar: :any_skip_relocation, monterey:       "64fc2daafce9ba69eeb2c653302296e793d038ed20ff2949d8a6bad2b58fa016"
    sha256 cellar: :any_skip_relocation, big_sur:        "11e19062d99d610886d728bcd18b9b158f7f0334f42f49dcab9e6a780dbf1f91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91ff7d52e6d6d56819d05fcd121e28d663dd893eff4f23903bd7822d63fa0a83"
  end

  depends_on "rust" => :build
  depends_on "libxcb"

  uses_from_macos "curl" => :build
  uses_from_macos "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    # Replace man page "#version" and "#date" based on logic in release.sh
    inreplace "man/page" do |s|
      s.gsub! "#version", version
      s.gsub! "#date", time.strftime("%Y/%m/%d")
    end
    man1.install "man/page" => "broot.1"

    # Completion scripts are generated in the crate's build directory,
    # which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/broot-*/out"].first
    bash_completion.install "#{out_dir}/broot.bash"
    bash_completion.install "#{out_dir}/br.bash"
    fish_completion.install "#{out_dir}/broot.fish"
    fish_completion.install "#{out_dir}/br.fish"
    zsh_completion.install "#{out_dir}/_broot"
    zsh_completion.install "#{out_dir}/_br"
  end

  test do
    return if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]

    assert_match "A tree explorer and a customizable launcher", shell_output("#{bin}/broot --help 2>&1")

    require "pty"
    require "io/console"
    PTY.spawn(bin/"broot", "-c", ":print_tree", "--color", "no", "--outcmd", testpath/"output.txt",
                err: :out) do |r, w, pid|
      r.winsize = [20, 80] # broot dependency terminal requires width > 2
      w.write "n\r"
      assert_match "New Configuration files written in", r.read
      Process.wait(pid)
    end
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
