class Slack < Formula
  desc "Slack command line helper"
  homepage "https://github.com/ober/slack"
  url "https://github.com/ober/slack.git"
  version "master"
  depends_on "gambit-scheme"
  depends_on "gerbil-scheme" => [ "with-yaml", "with-leveldb" ]

  def install
    ENV.append_path "PATH", "#{Formula['gambit-scheme'].bin}"
    ENV.append_path "PATH", "#{Formula['gerbil-scheme'].bin}"
    ENV.prepend "LDFLAGS", "-L/usr/local/lib/"
    ENV.prepend "LDFLAGS", "-L#{Formula['openssl'].lib}/openssl"
    ENV.prepend "LDFLAGS", "-L#{Formula['leveldb'].lib}/leveldb"
    ENV.prepend "CPPFLAGS", "-I/usr/local/include"
    ENV.prepend "CPPFLAGS", "-I#{Formula['openssl'].include}"
    ENV.prepend "CPPFLAGS", "-I#{Formula['leveldb'].include}"
    system "./build.ss static"
    bin.install Dir["./slack"]
  end

  test do
    output = `#{bin}/slack`
    assert_equal 0, $CHILD_STATUS.exitstatus
  end


end
