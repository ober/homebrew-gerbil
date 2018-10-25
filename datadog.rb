class Datadog < Formula
  desc "Datadog command line tools"
  homepage "https://github.com/ober/datadog"
  #url "https://github.com/ober/datadog.git"

  #depends_on "gambit-scheme"
  #depends_on "gerbil-scheme"

  def install

    ENV.append_path "PATH", "/usr/local/opt/gambit-scheme/current/bin"
    system "gxpkg install github.com/ober/datadog"

  end


end
