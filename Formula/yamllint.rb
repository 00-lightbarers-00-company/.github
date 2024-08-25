class Yamllint < Formula
  include Language::Python::Virtualenv

  desc "Linter for YAML files"
  homepage "https://github.com/adrienverge/yamllint"
  url "https://files.pythonhosted.org/packages/c8/82/4cd3ec8f98d821e7cc7ef504add450623d5c86b656faf65e9b0cc46f4be6/yamllint-1.28.0.tar.gz"
  sha256 "9e3d8ddd16d0583214c5fdffe806c9344086721f107435f68bad990e5a88826b"
  license "GPL-3.0-or-later"
  head "https://github.com/adrienverge/yamllint.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7afd5ce4129a2b8dc19364a45db7eb13e6cf94ce28aa34626f754065a5eb83f4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0c0746af382e94c290e18940b6a0cf3348da5a505b0b85164e8e0c2107e3d99"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "53d2145c8b89c3bcf0ffe6c4978a67b8f686250e3633473ca0575c0bb5f99dff"
    sha256 cellar: :any_skip_relocation, ventura:        "2ee52b5752706b8eb7561b17173fe9d8a117ff9959e827494e18a1fc818ddd53"
    sha256 cellar: :any_skip_relocation, monterey:       "957f364235a62b3f309db996edaccc0c99a80ad767e238246e6c53e4fdecba18"
    sha256 cellar: :any_skip_relocation, big_sur:        "dff529d3f7f29984710a09ef2b1b72f5a390466fae3499d5091599a72ea387b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6778f7b696ef2df84b7c46c31277f22fa761a4b59701243c7da3e05fc913db12"
  end

  depends_on "python@3.11"
  depends_on "pyyaml"

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/24/9f/a9ae1e6efa11992dba2c4727d94602bd2f6ee5f0dedc29ee2d5d572c20f7/pathspec-0.10.1.tar.gz"
    sha256 "7ace6161b621d31e7902eb6b5ae148d12cfd23f4a249b9ffb6b9fee12084323d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"bad.yaml").write <<~EOS
      ---
      foo: bar: gee
    EOS
    output = shell_output("#{bin}/yamllint -f parsable -s bad.yaml", 1)
    assert_match "syntax error: mapping values are not allowed here", output

    (testpath/"good.yaml").write <<~EOS
      ---
      foo: bar
    EOS
    assert_equal "", shell_output("#{bin}/yamllint -f parsable -s good.yaml")
  end
end
