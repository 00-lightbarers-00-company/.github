class Kubecfg < Formula
  desc "Manage complex enterprise Kubernetes environments as code"
  homepage "https://github.com/kubecfg/kubecfg"
  url "https://github.com/kubecfg/kubecfg/archive/v0.28.1.tar.gz"
  sha256 "40fc6d02550a137973909ae93929a219ed49d5317c4196fa333a3c6e619d9b05"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b807b1fe337f1812be1ae1bd9d3ff3e64b17f34cf7287c2482c4c052676fbf27"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b9b7b9405affa0dd3f62903fffded24c75ad83ca1c9196b75d9b39395e8ef67"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5e06edc2205566250ca003bc3393141597cb74ccbcfe532905243110305e3b2d"
    sha256 cellar: :any_skip_relocation, ventura:        "bfd956252e55e99dade7d2cd2ec6f7248fd62f57fe0e8f4876c35d46c2e52e79"
    sha256 cellar: :any_skip_relocation, monterey:       "5f7d08a4c49dbad861265b6ba2512b96226a8857ed36ca351d7ed152fb431f3d"
    sha256 cellar: :any_skip_relocation, big_sur:        "107f927c2d1745804c6eca1044fd23e79f6930acd53d0047c087598dbd971c13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f2caefee5d77bc26a85d9c3e717ecbf21100d3041dabd607a94e1a1d93fb5dab"
  end

  depends_on "go" => :build

  def install
    (buildpath/"src/github.com/kubecfg/kubecfg").install buildpath.children

    cd "src/github.com/kubecfg/kubecfg" do
      system "make", "VERSION=v#{version}"
      bin.install "kubecfg"
      pkgshare.install Pathname("examples").children
      pkgshare.install Pathname("testdata").children
      prefix.install_metafiles
    end

    generate_completions_from_executable(bin/"kubecfg", "completion", "--shell", shells: [:bash, :zsh])
  end

  test do
    system bin/"kubecfg", "show", "--alpha", pkgshare/"kubecfg_test.jsonnet"
  end
end
