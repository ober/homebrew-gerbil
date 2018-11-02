class Confluence < Formula
  desc "confluence command line helper"
  homepage "https://github.com/ober/confluence"
  url "https://github.com/ober/confluence.git"
  version "master"
  depends_on "gambit-scheme"
  depends_on "gerbil-scheme" => "with-yaml"

  def install
    ENV.append_path "PATH", "#{Formula['gambit-scheme'].bin}"
    ENV.append_path "PATH", "#{Formula['gerbil-scheme'].bin}"
    ENV.prepend "CPPFLAGS", "-I#{Formula['openssl'].include}"
    ENV.prepend "CPPFLAGS", "-I/usr/local/include"
    ENV.prepend "LDFLAGS", "-L#{Formula['openssl'].lib}/openssl"
    ENV.prepend "LDFLAGS", "-L/usr/local/lib/"
    system "./build.ss static"
    bin.install Dir["./confluence"]
  end

  test do
    output = `#{bin}/confluence`
    assert_equal 0, $CHILD_STATUS.exitstatus
  end


end