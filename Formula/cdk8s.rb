require "language/node"

class Cdk8s < Formula
  desc "Define k8s native apps and abstractions using object-oriented programming"
  homepage "https://cdk8s.io/"
  url "https://registry.npmjs.org/cdk8s-cli/-/cdk8s-cli-2.1.78.tgz"
  sha256 "791371140b94cb38e29f6580b8d3cfd5363f8083bff940f3be93423682511679"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "8ae8275e5aad1bc12d686e6fe10838ea6831bc9577c52547feac9be10aaf130d"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Cannot initialize a project in a non-empty directory",
      shell_output("#{bin}/cdk8s init python-app 2>&1", 1)
  end
end
