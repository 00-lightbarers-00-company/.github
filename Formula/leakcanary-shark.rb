class LeakcanaryShark < Formula
  desc "CLI Java memory leak explorer for LeakCanary"
  homepage "https://square.github.io/leakcanary/shark/"
  url "https://github.com/square/leakcanary/releases/download/v2.11/shark-cli-2.11.zip"
  sha256 "455573925705bf851665182f5b95c385b3939d346b18a2ccf64256da38599571"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "f6566393be1d076e40f13307a82ae8d1cedffe8195faf763495195d1a9a1bdd7"
  end

  depends_on "openjdk"

  resource "sample_hprof" do
    url "https://github.com/square/leakcanary/raw/v2.6/shark-android/src/test/resources/leak_asynctask_m.hprof"
    sha256 "7575158108b701e0f7233bc208decc243e173c75357bf0be9231a1dcb5b212ab"
  end

  def install
    # Remove Windows scripts
    rm_f Dir["bin/*.bat"]

    libexec.install Dir["*"]
    (bin/"shark-cli").write_env_script libexec/"bin/shark-cli", Language::Java.overridable_java_home_env
  end

  test do
    resource("sample_hprof").stage do
      assert_match "1 APPLICATION LEAKS",
                   shell_output("#{bin}/shark-cli --hprof ./leak_asynctask_m.hprof analyze").strip
    end
  end
end
