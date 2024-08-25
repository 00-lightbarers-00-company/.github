require "language/node"

class AngularCli < Formula
  desc "CLI tool for Angular"
  homepage "https://cli.angular.io/"
  url "https://registry.npmjs.org/@angular/cli/-/cli-15.0.3.tgz"
  sha256 "9dc258a4a37a71e2d83619bc4424fe959d22c452753f9b3001c4882e48b4535b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f61e7c46b0d2cffad77561bfe11f7004704bc24528b8ea2ae4f134c2602f4d17"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f61e7c46b0d2cffad77561bfe11f7004704bc24528b8ea2ae4f134c2602f4d17"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f61e7c46b0d2cffad77561bfe11f7004704bc24528b8ea2ae4f134c2602f4d17"
    sha256 cellar: :any_skip_relocation, ventura:        "27ce1f547a68fa58f772095f7226ff1963f37ad96b94ba0a3e63abf92d9e410c"
    sha256 cellar: :any_skip_relocation, monterey:       "27ce1f547a68fa58f772095f7226ff1963f37ad96b94ba0a3e63abf92d9e410c"
    sha256 cellar: :any_skip_relocation, big_sur:        "27ce1f547a68fa58f772095f7226ff1963f37ad96b94ba0a3e63abf92d9e410c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f61e7c46b0d2cffad77561bfe11f7004704bc24528b8ea2ae4f134c2602f4d17"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"ng", "new", "angular-homebrew-test", "--skip-install"
    assert_predicate testpath/"angular-homebrew-test/package.json", :exist?, "Project was not created"
  end
end
