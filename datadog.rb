class Datadog < Formula
  desc "Datadog command line helper"
  homepage "https://github.com/ober/datadog"
  url "https://github.com/ober/datadog.git"
  version "master"
  depends_on "gambit-scheme"
  depends_on "gerbil-scheme"

  def install
    ENV.append_path "PATH", "#{Formula['gambit-scheme'].bin}"
    ENV.append_path "PATH", "#{Formula['gerbil-scheme'].bin}"
    ENV.prepend "LDFLAGS", "-L/usr/local/lib/"
    ENV.prepend "LDFLAGS", "-L#{Formula['openssl'].lib}/openssl"
    ENV.prepend "CPPFLAGS", "-I/usr/local/include"
    ENV.prepend "CPPFLAGS", "-I#{Formula['openssl'].include}"
    system "./build.ss static"
    bin.install Dir["./datadog"]
  end

  test do
    output = `#{bin}/datadog`
    assert_equal 0, $CHILD_STATUS.exitstatus
  end


end
