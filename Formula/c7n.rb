class C7n < Formula
  include Language::Python::Virtualenv

  desc "Rules engine for cloud security, cost optimization, and governance"
  homepage "https://github.com/cloud-custodian/cloud-custodian"
  url "https://github.com/cloud-custodian/cloud-custodian/archive/0.9.21.0.tar.gz"
  sha256 "a7dc65a2b075a38a5b159379ed82832c78c96fd282e679cabd71bd9dd552ec02"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e2588778651d9750db0d4a157dfd6f840d7428ad59d1250a713581264126013b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1dfd9dbadea53154da624e4121713029f53f0dedfc3e37ce5c01b40c0812ccee"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9627bc996a39baf040de3f0b584cbfed03d548f692a4c6ffa5f2634f115d85e1"
    sha256 cellar: :any_skip_relocation, ventura:        "8f56fa2dacc5eb3ad43991df495b93bf39af6f33e08afe1ee6bcea49423fadcc"
    sha256 cellar: :any_skip_relocation, monterey:       "c44ae48614dd9a85d920009a4fc0ed49912330e0b8087b4084cbe8c90a02a1ac"
    sha256 cellar: :any_skip_relocation, big_sur:        "2e2980e901049f44805fcf93ffea384edd4e4c1a38de219993a1aa752bd1351d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d3e389699a15f37406c722f88c836ad7f96663f96929b3ed641d6e89a486c84"
  end

  depends_on "jsonschema"
  depends_on "python-tabulate"
  depends_on "python@3.10"
  depends_on "pyyaml"
  depends_on "six"

  resource "argcomplete" do
    url "https://files.pythonhosted.org/packages/05/f8/67851ae4fe5396ba6868c5d84219b81ea6a5d53991a6853616095c30adc0/argcomplete-2.0.0.tar.gz"
    sha256 "6372ad78c89d662035101418ae253668445b391755cfe94ea52f1b9d22425b20"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/fb/62/9920814ada419367cfea333fd440f8e7951ef5b0404325e66a6ad3d56b40/boto3-1.26.30.tar.gz"
    sha256 "13ba1d98ab5e2591be2dd19c779d67aa4210f126a827c9a376532ace435d8df9"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/6d/36/b08a5873f03f1462975d891245a5966caee248d04d718d47681b24ab1e7d/botocore-1.29.30.tar.gz"
    sha256 "9364417f53842167f8bcf72b9ab3c78457c7df613051101952b2470d9de7ea31"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/4c/17/559b4d020f4b46e0287a2eddf2d8ebf76318fd3bd495f1625414b052fdc9/docutils-0.17.1.tar.gz"
    sha256 "686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125"
  end

  resource "importlib-metadata" do
    url "https://files.pythonhosted.org/packages/32/5a/e0d75c8010295ae6746f379f5324bc726076dfc426548bfa6f0763fce870/importlib_metadata-5.1.0.tar.gz"
    sha256 "d5059f9f1e8e41f80e9c56c2ee58811450c31984dfa625329ffd7c0dad88a73b"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/00/2a/e867e8531cf3e36b41201936b7fa7ba7b5702dbef42922193f05c8976cd6/jmespath-1.0.1.tar.gz"
    sha256 "90261b206d6defd58fdd5e85f478bf633a2901798906be2ad389150c5c60edbe"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/e1/eb/e57c93d5cd5edf8c1d124c831ef916601540db70acd96fa21fe60cef1365/s3transfer-0.6.0.tar.gz"
    sha256 "2ed07d3866f523cc561bf4a00fc5535827981b117dd7876f036b0c1aca42c947"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/c2/51/32da03cf19d17d46cce5c731967bf58de9bd71db3a379932f53b094deda4/urllib3-1.26.13.tar.gz"
    sha256 "c083dd0dce68dbfbe1129d5271cb90f9447dea7d52097c6e0126120c521ddea8"
  end

  resource "zipp" do
    url "https://files.pythonhosted.org/packages/8e/b3/8b16a007184714f71157b1a71bbe632c5d66dd43bc8152b3c799b13881e1/zipp-3.11.0.tar.gz"
    sha256 "a7a22e05929290a67401440b39690ae6563279bced5f314609d9d03798f56766"
  end

  def install
    virtualenv_install_with_resources

    # we depend on jsonschema, but that's a separate formula, so install a `.pth` file to link them
    site_packages = Language::Python.site_packages("python3.10")
    jsonschema = Formula["jsonschema"].opt_libexec
    (libexec/site_packages/"homebrew-jsonschema.pth").write jsonschema/site_packages
  end

  test do
    # trim last decimal point version to match semver returned from version command
    assert_match version.major_minor_patch.to_s, shell_output("#{bin}/custodian version")

    (testpath/"good-policy.yml").write <<~EOF
      policies:
      - name: ec2-auto-tag-user
        resource: ec2
        mode:
          type: cloudtrail
          role: arn:aws:iam::{account_id}:role/custodian-auto-tagger
          # note {account_id} is optional. If you put that there instead of
          # your actual account number, when the policy is provisioned it
          # will automatically inherit the account_id properly
          events:
            - RunInstances
        filters:
          - tag:CreatorName: absent
        actions:
          - type: auto-tag-user
            tag: CreatorName
            principal_id_tag: CreatorId
    EOF
    output = shell_output("custodian validate --verbose #{testpath}/good-policy.yml 2>&1")
    assert_match "valid", output
    # has invalid "action" key instead of "actions"
    (testpath/"bad-policy.yml").write <<~EOF
      policies:
      - name: ec2-auto-tag-user
        resource: ec2
        filters:
          - tag:CreatorName: absent
        action:
          - type: auto-tag-user
            tag: CreatorName
            principal_id_tag: CreatorId
    EOF
    output = shell_output("custodian validate --verbose #{testpath}/bad-policy.yml 2>&1", 1)
    assert_match "invalid", output
  end
end
