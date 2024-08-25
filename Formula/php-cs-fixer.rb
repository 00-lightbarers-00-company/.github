class PhpCsFixer < Formula
  desc "Tool to automatically fix PHP coding standards issues"
  homepage "https://cs.symfony.com/"
  # Bump to php 8.2 on the next release, if possible.
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v3.13.0/php-cs-fixer.phar"
  sha256 "ac2e57e32cdae67f21baa88f78405f93d4d6e928f41ba62dc91505565c785a44"
  license "MIT"
  revision 1

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, all: "511f1c7453f945211375f4a2c4dcc9fddf7b6cb1546a42ad9a6a6d23c9a2665e"
  end

  depends_on "php@8.1"

  def install
    libexec.install "php-cs-fixer.phar"

    (bin/"php-cs-fixer").write <<~EOS
      #!#{Formula["php@8.1"].opt_bin}/php
      <?php require '#{libexec}/php-cs-fixer.phar';
    EOS
  end

  test do
    (testpath/"test.php").write <<~EOS
      <?php $this->foo(   'homebrew rox'   );
    EOS
    (testpath/"correct_test.php").write <<~EOS
      <?php

      $this->foo('homebrew rox');
    EOS

    system "#{bin}/php-cs-fixer", "fix", "test.php"
    assert compare_file("test.php", "correct_test.php")
  end
end
