class Scdoc < Formula
  desc "Small man page generator"
  homepage "https://sr.ht/~sircmpwn/scdoc/"
  url "https://git.sr.ht/~sircmpwn/scdoc/archive/1.11.2.tar.gz"
  sha256 "e9ff9981b5854301789a6778ee64ef1f6d1e5f4829a9dd3e58a9a63eacc2e6f0"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "29f674e2123140564de370b0ce97a9e4db540b686d35498fd428906b9efc851f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3756d77d254eb7ebc1a93df5b9cb944f5452592e13345c44c68cb4eda020a6dc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "84778bad52e889adfa4fbc311f93fc44e543d06c7ae42037575c36066c8d8bce"
    sha256 cellar: :any_skip_relocation, ventura:        "b7c2a3aa48298d66fe368ec51214547459764e9c8d2378dc6b278a62670bbf31"
    sha256 cellar: :any_skip_relocation, monterey:       "ecc015fe6a7ae48aa28be734351e3c8c19a5877fd58ef5a78bb85c9a37885f16"
    sha256 cellar: :any_skip_relocation, big_sur:        "e071a34d0ff21793c6f4a788733a91b789ac1a4dc4cefbccd8a44ae221ddd4a0"
    sha256 cellar: :any_skip_relocation, catalina:       "5f794bf6647ce97a62bff11d62583e2ceb85fe393af33bd5bfb4b54309c98b17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ebfa3950c4e1e1ead4bc489e135bda185ee35a5841d4c7aae71db642513b7c58"
  end

  def install
    # scdoc sets by default LDFLAGS=-static which doesn't work on macos(x)
    system "make", "LDFLAGS=", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    preamble = <<~EOF
      .\\" Generated by scdoc #{version}
      .\\" Complete documentation for this program is not available as a GNU info page
      .ie \\n(.g .ds Aq \\(aq
      .el       .ds Aq '
      .nh
      .ad l
      .\\" Begin generated content:
    EOF
    assert_equal preamble, shell_output("#{bin}/scdoc </dev/null")
  end
end
