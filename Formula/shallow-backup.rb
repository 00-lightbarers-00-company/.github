class ShallowBackup < Formula
  include Language::Python::Virtualenv

  desc "Git-integrated backup tool for macOS and Linux devs"
  homepage "https://github.com/alichtman/shallow-backup"
  url "https://files.pythonhosted.org/packages/96/d7/c59ad086eabfc1b2984e32cc2615368f9ab0b375b8fc5a7a63e5ca81c017/shallow-backup-5.3.tar.gz"
  sha256 "0af200e5c2d1887e9209bfd970a6835d1d304cc22183569613f378f00848cfe1"
  license "MIT"
  head "https://github.com/alichtman/shallow-backup.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ab1676f4c6dda57e1db62f527f9232e6d0d86953399c71a80cfd27c5df02409d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4797807c1182b74ab833f2f914f1893d9c3b0dc9c770e88f0083c9a9a6128c2c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6342d17678040b2056130981873b5711be6e3cdc8707859b3948aa48b1dcc72b"
    sha256 cellar: :any_skip_relocation, ventura:        "77ad1980d4f924b7ae39dd231cb3865bc84c419f7f69923440995e58e33b2010"
    sha256 cellar: :any_skip_relocation, monterey:       "8406e0540482aebe4fea1a2959a2fe2fa25494ce0276de462f0941cc84f67fbd"
    sha256 cellar: :any_skip_relocation, big_sur:        "c0d7e1a5832f7b5b4a81eba31e8e4c6ec83fd74a6f7fda701c9da705315cdd67"
    sha256 cellar: :any_skip_relocation, catalina:       "f3a608282966e4a22b337cdf778675e43a9c2ab00de1033a4a58c5010edb6c30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72394db8253b59075aa00a57de4edcaaef24a111bc798c18b9fb2be94aa9d30e"
  end

  depends_on "python@3.11"
  depends_on "six"

  resource "blessed" do
    url "https://files.pythonhosted.org/packages/e5/ad/97453480e7bdfce94f05a983cf7ad7f1d90239efee53d5af28e622f0367f/blessed-1.19.1.tar.gz"
    sha256 "9a0d099695bf621d4680dd6c73f6ad547f6a3442fbdbe80c4b1daa1edbc492fc"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/4b/47/dc98f3d5d48aa815770e31490893b92c5f1cd6c6cf28dd3a8ae0efffac14/gitdb-4.0.10.tar.gz"
    sha256 "6eb990b69df4e15bad899ea868dc46572c3f75339735663b81de79b06f17eb9a"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/22/ab/3dd8b8a24399cee9c903d5f7600d20e8703d48904020f46f7fa5ac5474e9/GitPython-3.1.29.tar.gz"
    sha256 "cc36bfc4a3f913e66805a28e84703e419d9c264c1077e537b54f0e1af85dbefd"
  end

  resource "inquirer" do
    url "https://files.pythonhosted.org/packages/38/26/9ad1d6c8007af64989bf45500f00e21014f04a2a6b3413c6166c07cf4e98/inquirer-3.0.0.tar.gz"
    sha256 "528725bfd7e18b063727529d2983cfa61e0e512042365a7697d89930588cb686"
  end

  resource "python-editor" do
    url "https://files.pythonhosted.org/packages/0a/85/78f4a216d28343a67b7397c99825cff336330893f00601443f7c7b2f2234/python-editor-1.0.4.tar.gz"
    sha256 "51fda6bcc5ddbbb7063b2af7509e43bd84bfc32a4ff71349ec7847713882327b"
  end

  resource "readchar" do
    url "https://files.pythonhosted.org/packages/75/d1/eddb559d5911fd889f2ec0de052a88edd0fa8fc4746f29da0d384d29e10e/readchar-4.0.3.tar.gz"
    sha256 "1d920d0e9ab76ec5d42192a68d15af2562663b5dfbf4a67cf9eba520e1ca57e6"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/21/2d/39c6c57032f786f1965022563eec60623bb3e1409ade6ad834ff703724f3/smmap-5.0.0.tar.gz"
    sha256 "c840e62059cd3be204b0c9c9f74be2c09d5648eddd4580d9314c3ecde0b30936"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/89/38/459b727c381504f361832b9e5ace19966de1a235d73cdbdea91c771a1155/wcwidth-0.2.5.tar.gz"
    sha256 "c4d647b99872929fdb7bdcaa4fbe7f01413ed3d98077df798530e5b04f116c83"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Creates a config file and adds a test file to it
    # There is colour in stdout, hence there are ANSI escape codes
    assert_equal "\e[34m\e[1mCreating config file at: \e[22m#{pwd}/.config/shallow-backup.conf\e[0m\n" \
                 "\e[34m\e[1mAdded: \e[22m#{test_fixtures("test.svg")}\e[0m",
    shell_output("#{bin}/shallow-backup --add-dot #{test_fixtures("test.svg")}").strip

    # Checks if config file was created
    assert_predicate testpath/".config/shallow-backup.conf", :exist?

    # Checks if the test file is in the config
    system "shallow-backup -show | grep test.svg"
  end
end
