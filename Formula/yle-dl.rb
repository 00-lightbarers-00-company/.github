class YleDl < Formula
  include Language::Python::Virtualenv

  desc "Download Yle videos from the command-line"
  homepage "https://aajanki.github.io/yle-dl/index-en.html"
  url "https://files.pythonhosted.org/packages/12/84/645771c885267d0a0452df9514ec024a6690960f208a2c979844a6bb52ef/yle-dl-20221111.tar.gz"
  sha256 "6ba32fd8ee11d24dbbf71281e888b4621198bbe3835536cc783b221e807edee3"
  license "GPL-3.0-or-later"
  head "https://github.com/aajanki/yle-dl.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "540ef201c496c129711387956e790196a57c10c3f742148c173323c05c91a06a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "710c49400610594c867c01920f117e2f869f7afd97e9a2410207f3202c2aadd1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "309e7f86ea7e7199d617388b99b1de6c8296887e4eb082b2c34d57ca7878bdcc"
    sha256 cellar: :any_skip_relocation, ventura:        "84293a9386e7a026bd4bb13b40dde97bd55b8f535e6c69e4d9df59ab73b07910"
    sha256 cellar: :any_skip_relocation, monterey:       "42647331f5ca4293c2d98b135301968e0cedc8f2850b59cebab71443ba07bb38"
    sha256 cellar: :any_skip_relocation, big_sur:        "2344c2eb8e2529a121d44ac9fcd7548bb2adc7a4805ba1f2793d1e679d0354ba"
    sha256 cellar: :any_skip_relocation, catalina:       "ef362fc461271db02e24cb123ee66a3016c17bde9bb4be092789318b5b776206"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f530c69a648c7d82cc2f1246c0a713e8fa8b2be14017d1629bc80c34d79f005f"
  end

  depends_on "ffmpeg"
  depends_on "python@3.11"
  depends_on "rtmpdump"

  uses_from_macos "libxslt"

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/1a/cb/c4ffeb41e7137b23755a45e1bfec9cbb76ecf51874c6f1d113984ecaa32c/attrs-22.1.0.tar.gz"
    sha256 "29adc2665447e5191d0e7c568fde78b21f9672d344281d0c6e1ab085429b22b6"
  end

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

  resource "ConfigArgParse" do
    url "https://files.pythonhosted.org/packages/16/05/385451bc8d20a3aa1d8934b32bd65847c100849ebba397dbf6c74566b237/ConfigArgParse-1.5.3.tar.gz"
    sha256 "1b0b3cbf664ab59dada57123c81eff3d9737e0d11d8cf79e3d6eb10823f1739f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/70/bb/7a2c7b4f8f434aa1ee801704bf08f1e53d7b5feba3d5313ab17003477808/lxml-4.9.1.tar.gz"
    sha256 "fe749b052bb7233fe5d072fcb549221a8cb1a16725c47c37e42b0b9cb3ff2c3f"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94/urllib3-1.26.12.tar.gz"
    sha256 "3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e"
  end

  resource "xattr" do
    url "https://files.pythonhosted.org/packages/f8/84/8e2a2578c804545d55f684f86b6144c3924a849b5ec8e1f39336233be752/xattr-0.10.0.tar.gz"
    sha256 "722652d2a5324e17891c416d4c76d91ccf98830a8f516a0de8533ce867f3acaf"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    output = shell_output("#{bin}/yle-dl --showtitle https://areena.yle.fi/1-1570236")
    assert_match "Traileri:", output
    assert_match "2012-05-30T10:51", output
  end
end
