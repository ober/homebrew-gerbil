class Jira < Formula
  desc "jira command line helper"
  homepage "https://github.com/ober/jira"
  url "https://github.com/ober/jira.git"
  version "master"

  depends_on "gerbil-scheme" => [ "with-yaml", "with-openssl" ]
  depends_on "openssl"

  def install
    ENV.append_path "PATH", "#{Formula['gambit-scheme'].bin}"
    ENV.append_path "PATH", "#{Formula['gerbil-scheme'].bin}"
    ENV.prepend "CPPFLAGS", "-I#{Formula['openssl'].include}"
    ENV.prepend "CPPFLAGS", "-I/usr/local/include"
    ENV.prepend "LDFLAGS", "-L#{Formula['openssl'].lib}/openssl"
    ENV.prepend "LDFLAGS", "-L/usr/local/lib/"
    system "./build.ss static"
    bin.install Dir["./jira"]
  end

  test do
    output = `#{bin}/jira`
    assert_equal 0, $CHILD_STATUS.exitstatus
  end


end
