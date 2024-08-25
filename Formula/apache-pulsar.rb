class ApachePulsar < Formula
  desc "Cloud-native distributed messaging and streaming platform"
  homepage "https://pulsar.apache.org/"
  url "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=pulsar/pulsar-2.10.2/apache-pulsar-2.10.2-src.tar.gz"
  mirror "https://archive.apache.org/dist/pulsar/pulsar-2.10.2/apache-pulsar-2.10.2-src.tar.gz"
  sha256 "20e367b120db9d7daacfe5f26b4b5a1d84958933a2448dfa01f731998ddd369a"
  license "Apache-2.0"
  head "https://github.com/apache/pulsar.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, ventura:      "affabf6e195e874f11c0ae7e87a49ae164ba95964b32b02596b4b9afd73cbeb8"
    sha256 cellar: :any_skip_relocation, monterey:     "265bcbfb605f91cd333a8558a8d2889f8249b409b3110235796a10a33a43794c"
    sha256 cellar: :any_skip_relocation, big_sur:      "8be561a9f0e660f85d7923269cdf9739f3c162040cc52507f4a50d6dc21ccac9"
    sha256 cellar: :any_skip_relocation, catalina:     "e84214120c05b9b6ede37c8a9ee4349638c3df2bff7a4ae73fa81c71edc315c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "77f96251b1f71005ce48d7d182b6f752f3eba22be5f81c125b901a739eb4ddec"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cppunit" => :build
  depends_on "libtool" => :build
  depends_on "maven" => :build
  depends_on "pkg-config" => :build
  depends_on "protobuf" => :build
  depends_on arch: :x86_64
  depends_on "openjdk@17"

  def install
    with_env("TMPDIR" => buildpath, **Language::Java.java_home_env("17")) do
      system "mvn", "-X", "clean", "package", "-DskipTests", "-Pcore-modules"
    end

    built_version = if build.head?
      # This script does not need any particular version of py3 nor any libs, so both
      # brew-installed python and system python will work.
      Utils.safe_popen_read("python3", "src/get-project-version.py").strip
    else
      version
    end

    binpfx = "apache-pulsar-#{built_version}"
    system "tar", "-xf", "distribution/server/target/#{binpfx}-bin.tar.gz"
    libexec.install "#{binpfx}/bin", "#{binpfx}/lib", "#{binpfx}/instances", "#{binpfx}/conf"
    (libexec/"lib/presto/bin/procname/Linux-ppc64le").rmtree
    pkgshare.install "#{binpfx}/examples", "#{binpfx}/licenses"
    (etc/"pulsar").install_symlink libexec/"conf"

    libexec.glob("bin/*") do |path|
      if !path.fnmatch?("*common.sh") && !path.directory?
        bin_name = path.basename
        (bin/bin_name).write_env_script libexec/"bin"/bin_name, Language::Java.java_home_env("17")
      end
    end
  end

  def post_install
    (var/"log/pulsar").mkpath
  end

  service do
    run [bin/"pulsar", "standalone"]
    log_path var/"log/pulsar/output.log"
    error_log_path var/"log/pulsar/error.log"
  end

  test do
    ENV["PULSAR_GC_LOG"] = "-Xlog:gc*:#{testpath}/pulsar_gc_%p.log:time,uptime:filecount=10,filesize=20M"
    ENV["PULSAR_LOG_DIR"] = testpath
    fork do
      exec bin/"pulsar", "standalone", "--zookeeper-dir", "#{testpath}/zk", " --bookkeeper-dir", "#{testpath}/bk"
    end
    # The daemon takes some time to start; pulsar-client will retry until it gets a connection, but emit confusing
    # errors until that happens, so sleep to reduce log spam.
    sleep 15

    output = shell_output("#{bin}/pulsar-client produce my-topic --messages 'hello-pulsar'")
    assert_match "1 messages successfully produced", output
    output = shell_output("#{bin}/pulsar initialize-cluster-metadata -c a -cs localhost -uw localhost -zk localhost")
    assert_match "Cluster metadata for 'a' setup correctly", output
  end
end
