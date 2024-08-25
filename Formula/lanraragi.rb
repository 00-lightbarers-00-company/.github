require "language/node"

class Lanraragi < Formula
  desc "Web application for archival and reading of manga/doujinshi"
  homepage "https://github.com/Difegue/LANraragi"
  url "https://github.com/Difegue/LANraragi/archive/v.0.8.7.tar.gz"
  sha256 "4b0338a1fc0bd6cc64cee38da823e395caa7e61362f60d9ae7c2d07e3cb51da5"
  license "MIT"
  head "https://github.com/Difegue/LANraragi.git", branch: "dev"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "2445c07c8f92473c73b9654da0e81afe41514ea365acd4267b91b0d6e2a10c79"
    sha256 cellar: :any,                 arm64_monterey: "3731c4b8c241e190430528ea1c6db6ac729e38d995494db81051680608c4a044"
    sha256 cellar: :any,                 arm64_big_sur:  "2c72d50acb5f48b67db009d31e9616656a96c6cd991c5e9646ef45118832fd28"
    sha256 cellar: :any,                 ventura:        "bda2d3aafb92a76d9180b4390f23e114a6e495053bbe0eedfd4ec848fe279acd"
    sha256 cellar: :any,                 monterey:       "513328a5b21273b678723d351ae46541564bcdc42ffee32cf174ddd0f8d2d3ad"
    sha256 cellar: :any,                 big_sur:        "88b712c81f26c0b59bda5c619129a64dadd5c54cd055dd0562ff4e0c39a9a5fc"
    sha256 cellar: :any,                 catalina:       "36900d82301c02c6c3217fb472faebbf4df8aaf3496e6324e79d19b360351f54"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6762bb72de8d407cfc53d289f7d599910c542094d995d6911379afa7c8607320"
  end

  depends_on "nettle" => :build
  depends_on "pkg-config" => :build
  depends_on "cpanminus"
  depends_on "ghostscript"
  depends_on "giflib"
  depends_on "imagemagick"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "node"
  depends_on "openssl@1.1"
  depends_on "perl"
  depends_on "redis"
  depends_on "zstd"

  uses_from_macos "libarchive"

  resource "libarchive-headers" do
    on_macos do
      url "https://github.com/apple-oss-distributions/libarchive/archive/refs/tags/libarchive-83.100.2.tar.gz"
      sha256 "a0228f75792f881bc927196f8b794d0263a019aab741765e54550f75271258aa"
    end
  end

  resource "Image::Magick" do
    url "https://cpan.metacpan.org/authors/id/J/JC/JCRISTY/Image-Magick-7.0.11-3.tar.gz"
    sha256 "232f2312c09a9d9ebc9de6c9c6380b893511ef7c6fc358d457a4afcec26916aa"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", "#{libexec}/lib/perl5"
    ENV.prepend_path "PERL5LIB", "#{libexec}/lib"

    # On Linux, use the headers provided by the libarchive formula rather than the ones provided by Apple.
    ENV["CFLAGS"] = if OS.mac?
      "-I#{libexec}/include"
    else
      "-I#{Formula["libarchive"].opt_include}"
    end

    ENV["OPENSSL_PREFIX"] = Formula["openssl@1.1"].opt_prefix

    imagemagick = Formula["imagemagick"]
    resource("Image::Magick").stage do
      inreplace "Makefile.PL" do |s|
        s.gsub! "/usr/local/include/ImageMagick-#{imagemagick.version.major}",
                "#{imagemagick.opt_include}/ImageMagick-#{imagemagick.version.major}"
      end

      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    if OS.mac?
      resource("libarchive-headers").stage do
        cd "libarchive/libarchive" do
          (libexec/"include").install "archive.h", "archive_entry.h"
        end
      end
    end

    system "cpanm", "Config::AutoConf", "--notest", "-l", libexec
    system "npm", "install", *Language::Node.local_npm_install_args
    system "perl", "./tools/install.pl", "install-full"

    prefix.install "README.md"
    (libexec/"lib").install Dir["lib/*"]
    libexec.install "script", "package.json", "public", "templates", "tests", "lrr.conf"
    cd "tools/build/homebrew" do
      bin.install "lanraragi"
      libexec.install "redis.conf"
    end
  end

  def caveats
    <<~EOS
      Automatic thumbnail generation will not work properly on macOS < 10.15 due to the bundled Libarchive being too old.
      Opening archives for reading will generate thumbnails normally.
    EOS
  end

  test do
    # Make sure lanraragi writes files to a path allowed by the sandbox
    ENV["LRR_LOG_DIRECTORY"] = ENV["LRR_TEMP_DIRECTORY"] = testpath
    %w[server.pid shinobu.pid minion.pid].each { |file| touch file }

    # Set PERL5LIB as we're not calling the launcher script
    ENV["PERL5LIB"] = libexec/"lib/perl5"

    # This can't have its _user-facing_ functionality tested in the `brew test`
    # environment because it needs Redis. It fails spectacularly tho with some
    # table flip emoji. So let's use those to confirm _some_ functionality.
    output = <<~EOS
      ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━!!!!!
      (╯・_>・）╯︵ ┻━┻
      It appears your Redis database is currently not running.
      The program will cease functioning now.
    EOS
    # Execute through npm to avoid starting a redis-server
    return_value = OS.mac? ? 61 : 111
    assert_match output, shell_output("npm start --prefix #{libexec}", return_value)
  end
end
