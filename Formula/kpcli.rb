require "language/perl"

class Kpcli < Formula
  include Language::Perl::Shebang

  desc "Command-line interface to KeePass database files"
  homepage "https://kpcli.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/kpcli/kpcli-3.8.1.pl"
  sha256 "6c84f8639245799bf9b2d5ce297c41b5d4ec0789f7f5fa9e8767556816ea472c"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/kpcli[._-]v?(\d+(?:\.\d+)+)\.pl}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "2a440001de998b54ca9d2a97a73f73b43b6d024d2ad9c86e631bc2631c3d0ae9"
    sha256 cellar: :any,                 arm64_monterey: "e6822ae86583cea07648a7a30af3200840f116d3906bc156b6d65d07cd77978e"
    sha256 cellar: :any,                 arm64_big_sur:  "3a64a9484bb333bb7d5f5899a198068aa31eebea62085169395fb5d33b9f8b5f"
    sha256 cellar: :any,                 ventura:        "b99f197d433d429c17c294cb610123a84af85ba5db52a014dff8e1014b4fe5a2"
    sha256 cellar: :any,                 monterey:       "2f478468bf140161be5c1d1be0460eee3ecb36939cb75b73a96c85697ac3301f"
    sha256 cellar: :any,                 big_sur:        "d5dad780a72e80534283aeff00ffcac79378540d202f9b80bcae476c1fbd2281"
    sha256 cellar: :any,                 catalina:       "c3758fabfccc8b2497d18549516a494aaa70be5781fb1a97567d76305683cfaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "abf409107c643eb43913bd956a7e99342424ca44caecbcb3a5940ba7d1695a18"
  end

  depends_on "readline"

  uses_from_macos "perl"

  resource "Mac::Pasteboard" do
    on_macos do
      url "https://cpan.metacpan.org/authors/id/W/WY/WYANT/Mac-Pasteboard-0.103.tar.gz"
      sha256 "2f5e8dd2db0d6445558484ca6d42d839c5a97ee8aa1b250e694d67d5b7f6634c"
    end
  end

  resource "Clone" do
    on_linux do
      url "https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/Clone-0.45.tar.gz"
      sha256 "cbb6ee348afa95432e4878893b46752549e70dc68fe6d9e430d1d2e99079a9e6"
    end
  end

  resource "TermReadKey" do
    on_linux do
      url "https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz"
      sha256 "5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290"
    end
  end

  resource "Module::Build" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz"
    sha256 "7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717"
  end

  resource "File::KeePass" do
    url "https://cpan.metacpan.org/authors/id/R/RH/RHANDOM/File-KeePass-2.03.tar.gz"
    sha256 "c30c688027a52ff4f58cd69d6d8ef35472a7cf106d4ce94eb73a796ba7c7ffa7"
  end

  resource "Crypt::Rijndael" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Crypt-Rijndael-1.16.tar.gz"
    sha256 "6540085e3804b82a6f0752c1122cf78cadd221990136dd6fd4c097d056c84d40"
  end

  resource "Sort::Naturally" do
    url "https://cpan.metacpan.org/authors/id/B/BI/BINGOS/Sort-Naturally-1.03.tar.gz"
    sha256 "eaab1c5c87575a7826089304ab1f8ffa7f18e6cd8b3937623e998e865ec1e746"
  end

  resource "Term::ShellUI" do
    url "https://cpan.metacpan.org/authors/id/B/BR/BRONSON/Term-ShellUI-0.92.tar.gz"
    sha256 "3279c01c76227335eeff09032a40f4b02b285151b3576c04cacd15be05942bdb"
  end

  resource "Term::ReadLine::Gnu" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAYASHI/Term-ReadLine-Gnu-1.42.tar.gz"
    sha256 "3c5f1281da2666777af0f34de0289564e6faa823aea54f3945c74c98e95a5e73"
  end

  resource "Data::Password" do
    url "https://cpan.metacpan.org/authors/id/R/RA/RAZINF/Data-Password-1.12.tar.gz"
    sha256 "830cde81741ff384385412e16faba55745a54a7cc019dd23d7ed4f05d551a961"
  end

  resource "Clipboard" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/Clipboard-0.28.tar.gz"
    sha256 "9e8d79015194263357c25a0f5d094800fff43bdbf9f8601ec3b0ed5eb0966d26"
  end

  resource "Capture::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz"
    sha256 "6c23113e87bad393308c90a207013e505f659274736638d8c79bac9c67cc3e19"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    res = resources.to_set(&:name) - ["Clipboard", "Term::Readline::Gnu"]
    res.each do |r|
      resource(r).stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make", "install"
      end
    end

    resource("Clipboard").stage do
      system "perl", "Build.PL", "--install_base", libexec
      system "./Build"
      system "./Build", "install"
    end

    resource("Term::ReadLine::Gnu").stage do
      # Prevent the Makefile to try and build universal binaries
      ENV.refurbish_args

      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}",
                     "--includedir=#{Formula["readline"].opt_include}",
                     "--libdir=#{Formula["readline"].opt_lib}"
      system "make", "install"
    end

    rewrite_shebang detected_perl_shebang, "kpcli-#{version}.pl"

    libexec.install "kpcli-#{version}.pl" => "kpcli"
    chmod 0755, libexec/"kpcli"
    (bin/"kpcli").write_env_script(libexec/"kpcli", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"kpcli", "--help"
  end
end
