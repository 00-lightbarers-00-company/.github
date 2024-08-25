class Typedb < Formula
  desc "Distributed hyper-relational database for knowledge engineering"
  homepage "https://vaticle.com/"
  url "https://github.com/vaticle/typedb/releases/download/2.14.3/typedb-all-mac-2.14.3.zip"
  sha256 "41a574d4d0fafcdfd678599b488dfb3aa7e2c4664e111dbd479bdf0a4dbd12a7"
  license "AGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "9d2db455c9a587a9eb74879be312ccb44aa30d4a9334c3ba1cc5d647b7557d69"
  end

  depends_on "openjdk@11"

  def install
    libexec.install Dir["*"]
    bin.install libexec/"typedb"
    bin.env_script_all_files(libexec, Language::Java.java_home_env("11"))
  end

  test do
    assert_match "A STRONGLY-TYPED DATABASE", shell_output("#{bin}/typedb server --help")
  end
end
