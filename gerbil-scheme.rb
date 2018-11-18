class GerbilScheme < Formula
  desc "An opinionated dialect of Scheme designed for Systems Programming"
  homepage "https://cons.io"
  url "https://github.com/vyzo/gerbil/archive/v0.13.tar.gz"
  sha256 "b464579f82682d733752a40a3e164fb387de94e05f220d04bfb43f2a70db40e3"
  head "https://github.com/vyzo/gerbil.git"

  depends_on "gambit-scheme"
  depends_on "gcc@6"
  depends_on "leveldb"
  depends_on "libxml2"
  depends_on "libyaml"
  depends_on "lmdb"
#  depends_on "mysql"
  depends_on "openssl"
  depends_on "sqlite3"
  depends_on "zlib"


  def install
    cd "src" do
      ENV["CC"] = "#{Formula['gcc@6'].bin}/gcc-6"

      ENV.append_path "PATH", "/usr/local/Cellar/gambit-scheme/4.9.1/v4.9.1/bin"

      inreplace "std/build-features.ss" do |s|
        s.gsub "(enable leveldb #f)", "(enable leveldb #t)"
        s.gsub "(enable libxml #f)", "(enable libxml #t)"
        s.gsub "(enable libyaml #f)", "(enable libyaml #t)"
        s.gsub "(enable lmdb #f)", "(enable lmdb #t)"
 #       s.gsub "(enable mysql #f)", "(enable mysql #t)"
      end

      #ENV.append_path "PATH", "#{Formula['gambit-scheme'].bin}"
      # ENV.prepend "CPPFLAGS", "-I#{Formula["openssl"].opt_include}"
      # ENV.prepend "LDFLAGS", "-L#{Formula["openssl"].opt_lib}"
      # ENV.prepend "CPPFLAGS", "-I#{Formula["leveldb"].opt_include}"
      # ENV.prepend "LDFLAGS", "-L#{Formula["leveldb"].opt_lib}"
      # ENV.prepend "CPPFLAGS", "-I#{Formula["libxml2"].opt_include}"
      # ENV.prepend "LDFLAGS", "-L#{Formula["libxml2"].opt_lib}"
      # ENV.prepend "CPPFLAGS", "-I#{Formula["libyaml"].opt_include}"
      # ENV.prepend "LDFLAGS", "-L#{Formula["libyaml"].opt_lib}"
      # ENV.prepend "CPPFLAGS", "-I#{Formula["lmdb"].opt_include}"
      # ENV.prepend "LDFLAGS", "-L#{Formula["lmdb"].opt_lib}"
      # ENV.prepend "CPPFLAGS", "-I#{Formula["mysql"].opt_include}"
      # ENV.prepend "LDFLAGS", "-L#{Formula["mysql"].opt_lib}"

      system "./build.sh"
    end

    lib.install Dir["lib/*"]
    bin.install Dir["bin/*"]
  end

  test do
    output = `#{bin}/gxi -e "(for-each write '(0 1 2 3 4 5 6 7 8 9))"`
    assert_equal "0123456789", output
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
