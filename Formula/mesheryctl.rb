class Mesheryctl < Formula
  desc "Command-line utility for Meshery, the cloud native management plane"
  homepage "https://meshery.io"
  url "https://github.com/meshery/meshery.git",
      tag:      "v0.6.35",
      revision: "f845274be19547a43efa7c729ca2c1bbb12abd7e"
  license "Apache-2.0"
  head "https://github.com/meshery/meshery.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f2a6fe8ae9812e8e919fa56e1ec3e5650a3e510571263923a3f7fc94a50ed1cc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f2a6fe8ae9812e8e919fa56e1ec3e5650a3e510571263923a3f7fc94a50ed1cc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2a6fe8ae9812e8e919fa56e1ec3e5650a3e510571263923a3f7fc94a50ed1cc"
    sha256 cellar: :any_skip_relocation, ventura:        "1d3709d48978b09836466f1b1db14464e9d56124997025aa69cddf7f7bf7336b"
    sha256 cellar: :any_skip_relocation, monterey:       "1d3709d48978b09836466f1b1db14464e9d56124997025aa69cddf7f7bf7336b"
    sha256 cellar: :any_skip_relocation, big_sur:        "1d3709d48978b09836466f1b1db14464e9d56124997025aa69cddf7f7bf7336b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4a3ca5f39b12196e5d0f38ddf1e50247aef4287ebd55cc0e3d82eae99460c17f"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    ldflags = %W[
      -s -w
      -X github.com/layer5io/meshery/mesheryctl/internal/cli/root/constants.version=v#{version}
      -X github.com/layer5io/meshery/mesheryctl/internal/cli/root/constants.commitsha=#{Utils.git_short_head}
      -X github.com/layer5io/meshery/mesheryctl/internal/cli/root/constants.releasechannel=stable
    ]

    system "go", "build", *std_go_args(ldflags: ldflags), "./mesheryctl/cmd/mesheryctl"

    generate_completions_from_executable(bin/"mesheryctl", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mesheryctl version 2>&1")
    assert_match "Channel: stable", shell_output("#{bin}/mesheryctl system channel view 2>&1")

    # Test kubernetes error on trying to start meshery
    assert_match "The Kubernetes cluster is not accessible.", shell_output("#{bin}/mesheryctl system start 2>&1", 1)
  end
end
