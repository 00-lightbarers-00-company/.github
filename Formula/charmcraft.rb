class Charmcraft < Formula
  include Language::Python::Virtualenv

  desc "Tool to build charms and publish them on Charmhub"
  homepage "https://charmhub.io"
  url "https://files.pythonhosted.org/packages/79/2f/14865ae1d3c6061c9e089a1577e4e946e09920eba76c1a7a8f6bc31374d7/charmcraft-2.2.0.tar.gz"
  sha256 "8acf952c0f302c67afae6755e912a3211803a7352b5b5cc588ed3bf8a5bc6b59"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "2b0934f501c8e1178ddfcca7f2a283901c2be0fee135787de3c7923b9b3310ce"
    sha256 cellar: :any,                 arm64_monterey: "4b2fa932dbc2629130a973a8d959bcb4aea519840f77ef74648fc7ad5a24b01e"
    sha256 cellar: :any,                 arm64_big_sur:  "7d7ff3e326378816c63e359cc584e03438f04e5a8f6787d17442f51e59741a7f"
    sha256 cellar: :any,                 ventura:        "474c3a1a97365a8ace015a4937bc165929a2bafddee2c3bf8ef1e7acbc6b5e99"
    sha256 cellar: :any,                 monterey:       "4b2b15e6406937b8b3c18544a0ad7ae3642e4ac035f3ed8e615d4640f6faf9f3"
    sha256 cellar: :any,                 big_sur:        "73bbdf53745f413711a119878b04a413db70ea2587829cccfebb280b9ba178bf"
    sha256 cellar: :any,                 catalina:       "0213567260cddd82d31bbd93c55cb46e25f45c1b87ba168a72ccb63f7f43373f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "749265ed51ed815607c0e6aa30bbda8502c351b3e1dfccb1694b4f77e4020feb"
  end

  depends_on "rust" => :build # for cryptography
  depends_on "jsonschema"
  depends_on "libsodium"
  depends_on "python-tabulate"
  depends_on "python-typing-extensions"
  depends_on "python@3.10"
  depends_on "pyyaml"
  depends_on "six"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz"
    sha256 "d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "craft-cli" do
    url "https://files.pythonhosted.org/packages/27/79/084746d656a483b8a58aca7e9d8db536208018ce0860d04c8a53f5b2c969/craft-cli-1.2.0.tar.gz"
    sha256 "fb71127ccbc9da0a37e4d08824d44a14079935d94a8382dd158a0250ec125795"
  end

  resource "craft-parts" do
    url "https://files.pythonhosted.org/packages/29/c0/aedce7ebd8d0ae9ee89f7269ec702d2dd5504e91e282989cd352ecc63c18/craft-parts-1.17.1.tar.gz"
    sha256 "084f123955c37dd8995e4ad85f62003b2cb9590549de42d7ab2c1febb1985fb8"
  end

  resource "craft-providers" do
    url "https://files.pythonhosted.org/packages/dc/7f/8eb3eb991a4cdf6cdb3b414bbb53e4104c664d49abd4eaecdf6c734bfaa2/craft-providers-1.6.2.tar.gz"
    sha256 "caf7569c809686caa956e340cdcfdb29a96e32e0954d6f78b92b7fa014587f2d"
  end

  resource "craft-store" do
    url "https://files.pythonhosted.org/packages/10/d8/4355935257b72a9d8fc3251649c7f1e3fbc383bd7f7fb85f91f0622ab2a3/craft-store-2.3.0.tar.gz"
    sha256 "9e17620c7d543662fd4a4fa31cb1f1bb88040652198ae35f7099b13f7663dbbb"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/ea/d8/2afd2890fe451a3c109d2bdb6bc4ded55ec43059e524344d5e0004e36412/cryptography-3.4.tar.gz"
    sha256 "9f7aa11ea95723359f914be3217d8b378bc3897f65a1ec1ab4e0118c336f51fc"
  end

  resource "Deprecated" do
    url "https://files.pythonhosted.org/packages/c8/d1/e412abc2a358a6b9334250629565fe12697ca1cdee4826239eddf944ddd0/Deprecated-1.2.13.tar.gz"
    sha256 "43ac5335da90c31c24ba028af536a91d41d53f9e6901ddb021bcc572ce44e38d"
  end

  resource "humanize" do
    url "https://files.pythonhosted.org/packages/51/19/3e1adf0e7a8c8361496b085edcab2ddcd85410735a2b6fdd044247fc5b75/humanize-4.4.0.tar.gz"
    sha256 "efb2584565cc86b7ea87a977a15066de34cdedaf341b11c851cfcfd2b964779c"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "importlib-metadata" do
    url "https://files.pythonhosted.org/packages/32/5a/e0d75c8010295ae6746f379f5324bc726076dfc426548bfa6f0763fce870/importlib_metadata-5.1.0.tar.gz"
    sha256 "d5059f9f1e8e41f80e9c56c2ee58811450c31984dfa625329ffd7c0dad88a73b"
  end

  resource "jaraco.classes" do
    url "https://files.pythonhosted.org/packages/bf/02/a956c9bfd2dfe60b30c065ed8e28df7fcf72b292b861dca97e951c145ef6/jaraco.classes-3.2.3.tar.gz"
    sha256 "89559fa5c1d3c34eff6f631ad80bb21f378dbcbb35dd161fd2c6b93f5be2f98a"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  resource "keyring" do
    url "https://files.pythonhosted.org/packages/1c/35/c22960f14f5e17384296b2f09da259f8b5244fb3831eccec71cf948a49c6/keyring-23.11.0.tar.gz"
    sha256 "ad192263e2cdd5f12875dedc2da13534359a7e760e77f8d04b50968a821c2361"
  end

  resource "macaroonbakery" do
    url "https://files.pythonhosted.org/packages/52/40/2a8bb2f507ce1a6c5b896c1b98044d74d34b07a6dd771526b4fe84e3181f/macaroonbakery-1.3.1.tar.gz"
    sha256 "23f38415341a1d04a155b4dac6730d3ad5f39b86ce07b1bb134bdda52b48b053"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556/MarkupSafe-2.1.1.tar.gz"
    sha256 "7f91197cc9e48f989d12e4e6fbc46495c446636dfc81b9ccf50bb0ec74b91d4b"
  end

  resource "more-itertools" do
    url "https://files.pythonhosted.org/packages/13/b3/397aa9668da8b1f0c307bc474608653d46122ae0563d1d32f60e24fa0cbd/more-itertools-9.0.0.tar.gz"
    sha256 "5a6257e40878ef0520b1803990e3e22303a41b5714006c32a3fd8304b26ea1ab"
  end

  resource "overrides" do
    url "https://files.pythonhosted.org/packages/f6/39/e2e3c2c7eba7793a01b5f592c3c7fd6b27da53d75de81430407ef18befb7/overrides-7.3.1.tar.gz"
    sha256 "8b97c6c1e1681b78cbc9424b138d880f0803c2254c5ebaabdde57bb6c62093f2"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/6b/f7/c240d7654ddd2d2f3f328d8468d4f1f876865f6b9038b146bec0a6737c65/packaging-22.0.tar.gz"
    sha256 "2198ec20bd4c017b8f9717e00f0c8714076fc2fd93816750ab48e2c41de2cfd3"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/ec/4c/9af851448e55c57b30a13a72580306e628c3b431d97fdae9e0b8d4fa3685/platformdirs-2.6.0.tar.gz"
    sha256 "b46ffafa316e6b83b47489d240ce17173f123a9b9c83282141c3daf26ad9ac2e"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/55/5b/e3d951e34f8356e5feecacd12a8e3b258a1da6d9a03ad1770f28925f29bc/protobuf-3.20.3.tar.gz"
    sha256 "2e3427429c9cffebf259491be0af70189607f365c2f41c7c3764af6f337105f2"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/60/a3/23a8a9378ff06853bda6527a39fe317b088d760adf41cf70fc0f6110e485/pydantic-1.9.0.tar.gz"
    sha256 "742645059757a56ecd886faf4ed2441b9c0cd406079c2b4bee51bcc3fbcd510a"
  end

  resource "pydantic-yaml" do
    url "https://files.pythonhosted.org/packages/d9/61/1be9472b8e85d32924a0e9a784341a2b5e5ed9437b5150eabb26b6976fbb/pydantic_yaml-0.8.1.tar.gz"
    sha256 "73905a4e678266dabe41793ddd169ea9450f9181358322e00802fa4ee81ff816"
  end

  resource "pymacaroons" do
    url "https://files.pythonhosted.org/packages/37/b4/52ff00b59e91c4817ca60210c33caf11e85a7f68f7b361748ca2eb50923e/pymacaroons-0.13.0.tar.gz"
    sha256 "1e6bba42a5f66c245adf38a5a4006a99dcc06a0703786ea636098667d42903b8"
  end

  resource "PyNaCl" do
    url "https://files.pythonhosted.org/packages/a7/22/27582568be639dfe22ddb3902225f91f2f17ceff88ce80e4db396c8986da/PyNaCl-1.5.0.tar.gz"
    sha256 "8ac7448f09ab85811607bdd21ec2464495ac8b7c66d146bf545b0f08fb9220ba"
  end

  resource "pyRFC3339" do
    url "https://files.pythonhosted.org/packages/00/52/75ea0ae249ba885c9429e421b4f94bc154df68484847f1ac164287d978d7/pyRFC3339-1.1.tar.gz"
    sha256 "81b8cbe1519cdb79bed04910dd6fa4e181faf8c88dff1e1b987b5f7ab23a5b1a"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/76/63/1be349ff0a44e4795d9712cc0b2d806f5e063d4d34631b71b832fac715a8/pytz-2022.6.tar.gz"
    sha256 "e89512406b793ca39f5971bc999cc538ce125c0e51c27941bef4568b460095e2"
  end

  resource "pyxdg" do
    url "https://files.pythonhosted.org/packages/b0/25/7998cd2dec731acbd438fbf91bc619603fc5188de0a9a17699a781840452/pyxdg-0.28.tar.gz"
    sha256 "3267bb3074e934df202af2ee0868575484108581e6f3cb006af1da35395e88b4"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "requests-toolbelt" do
    url "https://files.pythonhosted.org/packages/0c/4c/07f01c6ac44f7784fa399137fbc8d0cdc1b5d35304e8c0f278ad82105b58/requests-toolbelt-0.10.1.tar.gz"
    sha256 "62e09f7ff5ccbda92772a29f394a49c3ad6cb181d568b1337626b2abb628a63d"
  end

  resource "requests-unixsocket" do
    url "https://files.pythonhosted.org/packages/c3/ea/0fb87f844d8a35ff0dcc8b941e1a9ffc9eb46588ac9e4267b9d9804354eb/requests-unixsocket-0.3.0.tar.gz"
    sha256 "28304283ea9357d45fff58ad5b11e47708cfbf5806817aa59b2a363228ee971e"
  end

  resource "semantic-version" do
    url "https://files.pythonhosted.org/packages/7d/31/f2289ce78b9b473d582568c234e104d2a342fd658cc288a7553d83bb8595/semantic_version-2.10.0.tar.gz"
    sha256 "bdabb6d336998cbb378d4b9db3a4b56a1e3235701dc05ea2690d9a997ed5041c"
  end

  resource "semver" do
    url "https://files.pythonhosted.org/packages/31/a9/b61190916030ee9af83de342e101f192bbb436c59be20a4cb0cdb7256ece/semver-2.13.0.tar.gz"
    sha256 "fa0fe2722ee1c3f57eac478820c3a5ae2f624af8264cbdf9000c980ff7f75e3f"
  end

  resource "setuptools-rust" do
    url "https://files.pythonhosted.org/packages/99/db/e4ecb483ffa194d632ed44bda32cb740e564789fed7e56c2be8e2a0e2aa6/setuptools-rust-1.5.2.tar.gz"
    sha256 "d8daccb14dc0eae1b6b6eb3ecef79675bd37b4065369f79c35393dd5c55652c7"
  end

  resource "snap-helpers" do
    url "https://files.pythonhosted.org/packages/16/53/5d85218d71a54892e34b9222fe8738f415a2055adc47588fad0588b9b90b/snap-helpers-0.3.1.tar.gz"
    sha256 "0b84b99850012124b9b4513e0e630405d085eb80061d1dc4218f2132a4d44232"
  end

  resource "types-Deprecated" do
    url "https://files.pythonhosted.org/packages/45/2f/c0e57815699277d3ecb3cc974c4ffee0afc37a593437328766a42a525dd2/types-Deprecated-1.2.9.tar.gz"
    sha256 "e04ce58929509865359e91dcc38720123262b4cd68fa2a8a90312d50390bb6fa"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/c2/51/32da03cf19d17d46cce5c731967bf58de9bd71db3a379932f53b094deda4/urllib3-1.26.13.tar.gz"
    sha256 "c083dd0dce68dbfbe1129d5271cb90f9447dea7d52097c6e0126120c521ddea8"
  end

  resource "wrapt" do
    url "https://files.pythonhosted.org/packages/11/eb/e06e77394d6cf09977d92bff310cb0392930c08a338f99af6066a5a98f92/wrapt-1.14.1.tar.gz"
    sha256 "380a85cf89e0e69b7cfbe2ea9f765f004ff419f34194018a6827ac0e3edfed4d"
  end

  resource "zipp" do
    url "https://files.pythonhosted.org/packages/8e/b3/8b16a007184714f71157b1a71bbe632c5d66dd43bc8152b3c799b13881e1/zipp-3.11.0.tar.gz"
    sha256 "a7a22e05929290a67401440b39690ae6563279bced5f314609d9d03798f56766"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"charmcraft", "version"
    system bin/"charmcraft", "help"
    system bin/"charmcraft", "init", "--author", "Foo Bar", "-p", testpath/"charm"
    assert_predicate testpath/"charm/charmcraft.yaml", :exist?
  end
end
