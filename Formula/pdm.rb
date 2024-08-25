class Pdm < Formula
  include Language::Python::Virtualenv

  desc "Modern Python package and dependency manager supporting the latest PEP standards"
  homepage "https://pdm.fming.dev"
  url "https://files.pythonhosted.org/packages/eb/3c/09bf761352cf10c927a91f84b84e978155e21ad97ee8564299d1718f6405/pdm-2.3.3.tar.gz"
  sha256 "2897996453bbc834841ab0160f9d90d47744f8c585ee814fa2ee91d3c7840921"
  license "MIT"
  head "https://github.com/pdm-project/pdm.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2599e908410bd2b61729be83537d5a1968b89ef2b69eeb021d9354a147748ead"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5e5e0f0a7df856f664bed13ab69d42c6ec6dcc383bcc2cd4ff18cc8732409b4e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d2781494dc1cd971588addce6deec785adba6c92e7f83c61fdeef408798c8e3c"
    sha256 cellar: :any_skip_relocation, ventura:        "f54d22a93fb56705184c18696e2b8bd7fa62422abacdf2b4430f2ccf9b9fb854"
    sha256 cellar: :any_skip_relocation, monterey:       "5981419adb62491debe7480ee27dce06b347d4ad7a50a4f7c65550756eb024e6"
    sha256 cellar: :any_skip_relocation, big_sur:        "622f05da0e6e77703cfd99183f5988b96602e7b212df6148f4031f48d1d3a6ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eae31236dc5125a24714ae516213814787971874b0ee34bd3b66dfaa244bdb88"
  end

  depends_on "pygments"
  depends_on "python@3.11"

  resource "blinker" do
    url "https://files.pythonhosted.org/packages/2b/12/82786486cefb68685bb1c151730f510b0f4e5d621d77f245bc0daf9a6c64/blinker-1.5.tar.gz"
    sha256 "923e5e2f69c155f2cc42dafbbd70e16e3fde24d2d4aa2ab72fbe386238892462"
  end

  resource "CacheControl" do
    url "https://files.pythonhosted.org/packages/06/80/1f8ba1ced5f29514d8621003b2b0fb404ed88996e963dbca7f519ecc82ca/CacheControl-0.12.12.tar.gz"
    sha256 "9c2e5208ea76ebd9921176569743ddf6d7f3bb4188dbf61806f0f8fc48ecad38"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "commonmark" do
    url "https://files.pythonhosted.org/packages/60/48/a60f593447e8f0894ebb7f6e6c1f25dafc5e89c5879fdc9360ae93ff83f0/commonmark-0.9.1.tar.gz"
    sha256 "452f9dc859be7f06631ddcb328b6919c67984aca654e5fefb3914d54691aed60"
  end

  resource "distlib" do
    url "https://files.pythonhosted.org/packages/58/07/815476ae605bcc5f95c87a62b95e74a1bce0878bc7a3119bc2bf4178f175/distlib-0.3.6.tar.gz"
    sha256 "14bad2d9b04d3a36127ac97f30b12a19268f211063d8f8ee4f47108896e11b46"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/d8/73/292d9ea2370840a163e6dd2d2816a571244e9335e2f6ad957bf0527c492f/filelock-3.8.2.tar.gz"
    sha256 "7565f628ea56bfcd8e54e42bdc55da899c85c1abfe1b5bcfd147e9188cebb3b2"
  end

  resource "findpython" do
    url "https://files.pythonhosted.org/packages/28/96/ec16612c4384cfca9381239d06e9285ca41d749d4a5003df73e3a96255e7/findpython-0.2.2.tar.gz"
    sha256 "80557961c04cf1c8c4ba4ca3ac7cf76ec27fa92788a6af42cb701e3450c49430"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "installer" do
    url "https://files.pythonhosted.org/packages/c9/ab/a9141dc175ec7b620fffe7e0295251a7b6a0ffb4325d64aeb128dff8c698/installer-0.6.0.tar.gz"
    sha256 "f3bd36cd261b440a88a1190b1becca0578fee90b4b62decc796932fdd5ae8839"
  end

  resource "msgpack" do
    url "https://files.pythonhosted.org/packages/22/44/0829b19ac243211d1d2bd759999aa92196c546518b0be91de9cacc98122a/msgpack-1.0.4.tar.gz"
    sha256 "f5d869c18f030202eb412f08b28d2afeea553d6613aee89e200d7aca7ef01f5f"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/ec/4c/9af851448e55c57b30a13a72580306e628c3b431d97fdae9e0b8d4fa3685/platformdirs-2.6.0.tar.gz"
    sha256 "b46ffafa316e6b83b47489d240ce17173f123a9b9c83282141c3daf26ad9ac2e"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/71/22/207523d16464c40a0310d2d4d8926daffa00ac1f5b1576170a32db749636/pyparsing-3.0.9.tar.gz"
    sha256 "2b020ecf7d21b687f219b71ecad3631f644a47f01403fa1d1036b0c6416d70fb"
  end

  resource "pyproject_hooks" do
    url "https://files.pythonhosted.org/packages/25/c1/374304b8407d3818f7025457b7366c8e07768377ce12edfe2aa58aa0f64c/pyproject_hooks-1.0.0.tar.gz"
    sha256 "f271b298b97f5955d53fb12b72c1fb1948c22c1a6b70b315c54cedaca0264ef5"
  end

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/87/8d/ab7352188f605e3f663f34692b2ed7457da5985857e9e4c2335cd12fb3c9/python-dotenv-0.21.0.tar.gz"
    sha256 "b77d08274639e3d34145dfa6c7008e66df0f04b7be7a75fd0d5292c191d79045"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "requests-toolbelt" do
    url "https://files.pythonhosted.org/packages/0c/4c/07f01c6ac44f7784fa399137fbc8d0cdc1b5d35304e8c0f278ad82105b58/requests-toolbelt-0.10.1.tar.gz"
    sha256 "62e09f7ff5ccbda92772a29f394a49c3ad6cb181d568b1337626b2abb628a63d"
  end

  resource "resolvelib" do
    url "https://files.pythonhosted.org/packages/73/51/36f96ad70dd8c71274ac77739cda0794fee3ba45640373e7f8c5da7c9455/resolvelib-0.9.0.tar.gz"
    sha256 "40ab05117c3281b1b160105e10075094c5ab118315003c922b77673a365290e1"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/11/23/814edf09ec6470d52022b9e95c23c1bef77f0bc451761e1504ebd09606d3/rich-12.6.0.tar.gz"
    sha256 "ba3a3775974105c221d31141f2c116f4fd65c5ceb0698657a11e9f295ec93fd0"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/bd/e6/fdf53ebbf08016dba98f2b047d4db95790157f0e2eed3b14bb5754271475/shellingham-1.5.0.tar.gz"
    sha256 "72fb7f5c63103ca2cb91b23dee0c71fe8ad6fbfd46418ef17dbe40db51592dad"
  end

  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/ff/04/58b4c11430ed4b7b8f1723a5e4f20929d59361e9b17f0872d69681fd8ffd/tomlkit-0.11.6.tar.gz"
    sha256 "71b952e5721688937fb02cf9d354dbcf0785066149d2855e44531ebdd2b65d73"
  end

  resource "unearth" do
    url "https://files.pythonhosted.org/packages/f9/8d/e072c0b76ecc9fb38dde79d0037fbc806deebb5207af24515f44f209bf79/unearth-0.7.0.tar.gz"
    sha256 "cf54411b37b7a941f3cdfdf29aeee2bf18164a8afca35c467b97feab626e671e"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/c2/51/32da03cf19d17d46cce5c731967bf58de9bd71db3a379932f53b094deda4/urllib3-1.26.13.tar.gz"
    sha256 "c083dd0dce68dbfbe1129d5271cb90f9447dea7d52097c6e0126120c521ddea8"
  end

  resource "virtualenv" do
    url "https://files.pythonhosted.org/packages/7b/19/65f13cff26c8cc11fdfcb0499cd8f13388dd7b35a79a376755f152b42d86/virtualenv-20.17.1.tar.gz"
    sha256 "f8b927684efc6f1cc206c9db297a570ab9ad0e51c16fa9e45487d36d1905c058"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/a2/b8/6a06ff0f13a00fc3c3e7d222a995526cbca26c1ad107691b6b1badbbabf1/wheel-0.38.4.tar.gz"
    sha256 "965f5259b566725405b05e7cf774052044b1ed30119b5d586b2703aafe8719ac"
  end

  def install
    virtualenv_install_with_resources
    generate_completions_from_executable(bin/"pdm", "completion")
  end

  test do
    (testpath/"pyproject.toml").write <<~EOS
      [project]
      name = "testproj"
      requires-python = ">=3.9"
      version = "1.0"
      license = {text = "MIT"}

      [build-system]
      requires = ["pdm-pep517>=0.12.0"]
      build-backend = "pdm.pep517.api"

    EOS
    system bin/"pdm", "add", "requests==2.24.0"
    assert_match "dependencies = [\n    \"requests==2.24.0\",\n]", (testpath/"pyproject.toml").read
    assert_predicate testpath/"pdm.lock", :exist?
    assert_match "name = \"urllib3\"", (testpath/"pdm.lock").read
    output = shell_output("#{bin}/pdm run python -c 'import requests;print(requests.__version__)'")
    assert_equal "2.24.0", output.strip
  end
end
