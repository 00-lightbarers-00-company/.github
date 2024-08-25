require "language/node"

class Octant < Formula
  desc "Kubernetes introspection tool for developers"
  homepage "https://octant.dev"
  url "https://github.com/vmware-tanzu/octant.git",
      tag:      "v0.25.1",
      revision: "f16cbb951905f1f8549469dfc116ca16cf679d46"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/octant.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "02429106747153e095a5c0778c702bb6e4d20bf8b7b784d6cab8f7ace15600a9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3979f72547fd4ab0f49aebc0d3b7e31cddf579a225450f21ce882a6ccd4c4d83"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b03fd4872ba4ec08a4c5992e38f33d55717bf5aae69cf58bb5e7d19da8bc1844"
    sha256 cellar: :any_skip_relocation, ventura:        "521bf38043e81e6d08d7dadb0de1750d0a5812911dbfec283e25075e9755615b"
    sha256 cellar: :any_skip_relocation, monterey:       "6e3ef528790c99983c18ee34e7cddd3d3fc5a8293822d18ae5cdac6f0be41ca0"
    sha256 cellar: :any_skip_relocation, big_sur:        "b9fcb7b4c1b04b0a14157668298580e968b7bf8108c38112e7882fd3d2574fe1"
    sha256 cellar: :any_skip_relocation, catalina:       "733232f99202af616246a23733949ba64beb39fe0f710f48271132bfa207b3b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f920929c581cb864011705ed3cd5c972fe59ed8587efaf3e1fe2c19f9ee84054"
  end

  depends_on "go" => :build
  depends_on "node@14" => :build

  uses_from_macos "python" => :build

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    ENV["GOFLAGS"] = "-mod=vendor"

    Language::Node.setup_npm_environment

    # Work around build error: "npm ERR! Invalid Version: ^3.0.8"
    # Issue is due to `npm-force-resolutions` not working with
    # npm>=8.6, which is used in node>=16 formulae.
    #
    # PR ref: https://github.com/vmware-tanzu/octant/pull/3311
    # Issue ref: https://github.com/vmware-tanzu/octant/issues/3329
    # Issue ref: https://github.com/rogeriochaves/npm-force-resolutions/issues/56
    ENV.prepend_path "PATH", Formula["node@14"].opt_bin
    cd "web" do
      system "npm", "install", *Language::Node.local_npm_install_args
    end

    system "go", "run", "build.go", "go-install"
    system "go", "run", "build.go", "web-build"

    ldflags = ["-X main.version=#{version}",
               "-X main.gitCommit=#{Utils.git_head}",
               "-X main.buildTime=#{time.iso8601}"].join(" ")

    tags = "embedded exclude_graphdriver_devicemapper exclude_graphdriver_btrfs containers_image_openpgp"

    system "go", "build", *std_go_args(ldflags: ldflags),
           "-tags", tags, "-v", "./cmd/octant"
  end

  test do
    fork do
      exec bin/"octant", "--kubeconfig", testpath/"config", "--disable-open-browser"
    end
    sleep 5

    output = shell_output("curl -s http://localhost:7777")
    assert_match "<title>Octant</title>", output, "Octant did not start"
    assert_match version.to_s, shell_output("#{bin}/octant version")
  end
end
