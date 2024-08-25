class Nifi < Formula
  desc "Easy to use, powerful, and reliable system to process and distribute data"
  homepage "https://nifi.apache.org"
  url "https://www.apache.org/dyn/closer.lua?path=/nifi/1.19.0/nifi-1.19.0-bin.zip"
  mirror " https://archive.apache.org/dist/nifi/1.19.0/nifi-1.19.0-bin.zip"
  sha256 "54be4c13fa81a3fe4860a728288b79fadc1e122904b19f1279a12017412ebd1a"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "7b14a9ffe0c5f20b92ee7f5012c77b87138b68096510e65a53d30ec720950640"
  end

  depends_on "openjdk@11"

  def install
    libexec.install Dir["*"]

    (bin/"nifi").write_env_script libexec/"bin/nifi.sh",
                                  Language::Java.overridable_java_home_env("11").merge(NIFI_HOME: libexec)
  end

  test do
    system bin/"nifi", "status"
  end
end
