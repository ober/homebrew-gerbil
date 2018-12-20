class GerbilScheme < Formula
  desc "An opinionated dialect of Scheme designed for Systems Programming"
  homepage "https://cons.io"
  url "https://github.com/vyzo/gerbil/archive/v0.14.tar.gz"
  sha256 "8525877960ba7a6122d6dfd2bae34ed1437d5231f9e31de97bbe6106c4dfa03a"
  head "https://github.com/vyzo/gerbil.git"

  depends_on "gambit-scheme"
  depends_on "gcc"
  depends_on "leveldb"
  depends_on "libxml2"
  depends_on "libyaml"
  depends_on "lmdb"
  depends_on "mysql" if MacOS.version > "10.11"
  depends_on "openssl"
  depends_on "sqlite3"
  depends_on "zlib"

  def install
    cd "src" do
      ENV.append_path "PATH", "#{Formula['gambit-scheme'].opt_prefix}/current/bin"
      ENV['CC'] =  Formula['gcc'].opt_bin/Formula['gcc'].aliases.first.gsub("@","-")

      inreplace "std/build-features.ss" do |s|
        s.gsub! '(enable leveldb #f)', '(enable leveldb #t)'
        s.gsub! '(enable libxml #f)', '(enable libxml #t)'
        s.gsub! '(enable libyaml #f)', '(enable libyaml #t)'
        s.gsub! '(enable lmdb #f)', '(enable lmdb #t)'
      end

      ENV.prepend "CPPFLAGS", "-I#{Formula["libyaml"].opt_include}"
      ENV.prepend "CPPFLAGS", "-I#{Formula["leveldb"].opt_include}"
      ENV.prepend "CPPFLAGS", "-I#{Formula["lmdb"].opt_include}"
      ENV.prepend "CPPFLAGS", "-I#{Formula["openssl"].opt_include}"
      ENV.prepend "LDFLAGS", "-L#{Formula["libyaml"].opt_lib}"
      ENV.prepend "LDFLAGS", "-L#{Formula["lmdb"].opt_lib}"
      ENV.prepend "LDFLAGS", "-L#{Formula["leveldb"].opt_lib}"
      ENV.prepend "LDFLAGS", "-L#{Formula["openssl"].opt_lib}"
      system "./build.sh"
    end

    lib.install Dir["lib/*"]
    bin.install Dir["bin/*"]
  end

  test do
    assert_equal "0123456789", shell_output("#{bin}/gxi -e \"(for-each write '(0 1 2 3 4 5 6 7 8 9))\"")
  end
end
