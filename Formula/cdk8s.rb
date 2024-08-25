require "language/node"

class Cdk8s < Formula
  desc "Define k8s native apps and abstractions using object-oriented programming"
  homepage "https://cdk8s.io/"
  url "https://registry.npmjs.org/cdk8s-cli/-/cdk8s-cli-2.1.74.tgz"
  sha256 "730dbe49a14f7c9f90c740d8bedc31366132a5ec7c090e6f2d196cd881f5b300"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "6425cc07c0630a7c8480ca4b46c778753b923c18384502e7695b6852eebb22c8"
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
