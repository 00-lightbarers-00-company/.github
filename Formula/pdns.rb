class Pdns < Formula
  desc "Authoritative nameserver"
  homepage "https://www.powerdns.com"
  url "https://downloads.powerdns.com/releases/pdns-4.7.3.tar.bz2"
  sha256 "8bad351b2e09426f6d4fb0346881a5155fe555497c3d85071e531e7c7afe3e76"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://downloads.powerdns.com/releases/"
    regex(/href=.*?pdns[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_ventura:  "f9fb4470bed7a5c12f9b6fcf01c330da80c5f8847d5c94c318d8a7ddd36ca604"
    sha256 arm64_monterey: "0bc2833a1410994a4cd10342597f0fc3b686006eda11d770521e97790fe12543"
    sha256 arm64_big_sur:  "cec0ef3944878a458038437c3a5769c848b3bfb773f9631733cc5bafd456d883"
    sha256 ventura:        "b25eaf4f146426e67c547930a4ad9247e46ee62a944f623a9b68d1da690c65d8"
    sha256 monterey:       "27d45e5b8aeb8389964f397b0c1f13a4a47677cdf49160790decf03e40da05c1"
    sha256 big_sur:        "857b7b5da938ef75e0cff5534580b0fb09f424c9d8895d0d655ea2d52da6f15c"
    sha256 catalina:       "56e71f15270192931fa11e8b137ca3e8ab73629c33a052f7cb09ef4c49fa44ff"
    sha256 x86_64_linux:   "223164b460f222660027359d46e16e4c17898aeb4276e53fe5155fea7a35f9f9"
  end

  head do
    url "https://github.com/powerdns/pdns.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool"  => :build
    depends_on "ragel"
  end

  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "lua"
  depends_on "openssl@1.1"
  depends_on "sqlite"

  uses_from_macos "curl"

  fails_with gcc: "5" # for C++17

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}/powerdns
      --with-lua
      --with-libcrypto=#{Formula["openssl@1.1"].opt_prefix}
      --with-sqlite3
      --with-modules=gsqlite3
    ]

    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  service do
    run opt_sbin/"pdns_server"
    keep_alive true
  end

  test do
    output = shell_output("#{sbin}/pdns_server --version 2>&1", 99)
    assert_match "PowerDNS Authoritative Server #{version}", output
  end
end
