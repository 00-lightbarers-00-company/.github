class SvtplayDl < Formula
  include Language::Python::Virtualenv

  desc "Download videos from https://www.svtplay.se/"
  homepage "https://svtplay-dl.se/"
  url "https://files.pythonhosted.org/packages/1e/fd/d0db3eaca2443474f0659738a760e52aae9eebff494a5d271a83c43919c4/svtplay-dl-4.17.tar.gz"
  sha256 "41a1c78d55c639a5e82c5725d6cc5c449bf8d11e5aedd1bca670de7c44b23bd0"
  license "MIT"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "081104c2e3031dfebdcc3f7183c0757ba382e948293699c6a9dfc1efeb698abe"
    sha256 cellar: :any,                 arm64_monterey: "16fe1c919c2295c9d372afb932c0dc87a4cae0d414ae94024669d89ddf8eeb63"
    sha256 cellar: :any,                 arm64_big_sur:  "e8cd95d8cc54e63899bfa40546d98f998aa6fd76598f8219cd6b01f633416dd1"
    sha256 cellar: :any,                 ventura:        "2ad6c5b9eb893287f3f918f2c3dc13782e0ee0be3c31a8332c5cbe29e7fa6b5d"
    sha256 cellar: :any,                 monterey:       "40162d0f198de2adf941c8cf0ae3da7830a3f0a9a94423a158316135e3406526"
    sha256 cellar: :any,                 big_sur:        "c2dc1b5918ce11dcf9fa9c8afe56e86828d5dd31ee0624b1ef94b4ae5323775f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ba78d086a5b9ce88d2cdbc6fef6718e1f07504a54a3a9ff1eecefd977f41fe1"
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"
  depends_on "python@3.11"
  depends_on "pyyaml"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/cb/a4/7de7cd59e429bd0ee6521ba58a75adaec136d32f91a761b28a11d8088d44/certifi-2022.9.24.tar.gz"
    sha256 "0d9c601124e5a6ba9712dbc60d9c53c21e34f5f641fe83002317394311bdce14"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz"
    sha256 "d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/e3/3f/41186b1f2fd86a542d399175f6b8e43f82cd4dfa51235a0b030a042b811a/cryptography-38.0.4.tar.gz"
    sha256 "175c1a818b87c9ac80bb7377f5520b7f31b3ef2a0004e2420319beadedb67290"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "PySocks" do
    url "https://files.pythonhosted.org/packages/bd/11/293dd436aea955d45fc4e8a35b6ae7270f5b8e00b53cf6c024c83b657a11/PySocks-1.7.1.tar.gz"
    sha256 "3f8804571ebe159c380ac6de37643bb4685970655d3bba243530d6558b799aa0"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/c2/51/32da03cf19d17d46cce5c731967bf58de9bd71db3a379932f53b094deda4/urllib3-1.26.13.tar.gz"
    sha256 "c083dd0dce68dbfbe1129d5271cb90f9447dea7d52097c6e0126120c521ddea8"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      To use post-processing options:
        `brew install ffmpeg` or `brew install libav`.
    EOS
  end

  test do
    url = "https://tv.aftonbladet.se/abtv/articles/244248"
    match = "https://amd-ab.akamaized.net/ab/vod/2018/02/cdaefe0533c2561f00a41c52a2d790bd/1280_720_pkg.m3u8"
    assert_match match, shell_output("#{bin}/svtplay-dl -g #{url}")
  end
end
