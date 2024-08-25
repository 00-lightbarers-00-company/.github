class Phpbrew < Formula
  desc "Brew & manage PHP versions in pure PHP at HOME"
  homepage "https://phpbrew.github.io/phpbrew"
  url "https://github.com/phpbrew/phpbrew/releases/download/2.0.0/phpbrew"
  sha256 "b85d2c7a2bf6cf7ec9173e0db7eb6cf9e6de56589b2d845fdbecc492dd24111a"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "66f95d3a9bd30c75bf80d11a09c5c680f698164c9a3c9a3de63d3ed0e72d8fa0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "334ce2bf2192727172bbb2bc449b028e27419b4ed6d076d759ef459f30c76225"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c7284fc0683ff84b048b9ceb72a3e810aa250086a766dd0a44f3dc57a53c073b"
    sha256 cellar: :any_skip_relocation, ventura:        "410d66e7008950df639ae90ffc9d54d8b452a20ec2aa1077e78afc0c30fc5ac7"
    sha256 cellar: :any_skip_relocation, monterey:       "d9b4ec02efb50c18f7ddc1c4b341fd7ef954c7af9b779a4a705b67b299978135"
    sha256 cellar: :any_skip_relocation, big_sur:        "da1a09ea403685c424d6808c9486a76182ca29e689243ae703f4f9e0820b756a"
    sha256 cellar: :any_skip_relocation, catalina:       "da1a09ea403685c424d6808c9486a76182ca29e689243ae703f4f9e0820b756a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c9a253bc9b4c2f88baf9754ca9fae76bd61f573999faeb2a0af3d90d9dde644"
  end

  depends_on "php"

  # Keg-relocation breaks the formula when it replaces `/usr/local` with a non-default prefix
  on_macos do
    on_intel do
      pour_bottle? only_if: :default_prefix
    end
  end

  def install
    bin.install "phpbrew"
  end

  test do
    system bin/"phpbrew", "init"
    assert_match "8.0", shell_output("#{bin}/phpbrew known")
  end
end
