class GambitScheme < Formula
  desc "The Gambit Scheme system is a complete, portable, efficient and reliable implementation of the Scheme programming language."
  homepage "https://gambitscheme.org"
  url "https://github.com/gambit/gambit/archive/v4.9.1.tar.gz"
  sha256 "3b08b347f89ea0cdbd01c90108abf5fb1c6d2d649a7c3050590d398bb6845f1c"
  head "https://github.com/gambit/gambit.git"

  depends_on "gcc@6"
  depends_on "openssl"

  def install
    args = %W[
         --prefix=#{prefix}
         --enable-single-host
         --enable-multiple-versions
         --enable-default-runtime-options=f8,-8,t8
         --enable-poll
         --enable-openssl
    ]

    ENV["CC"] = Formula["gcc@6"].bin/"gcc-6"

    inreplace "lib/os_io.c" do |s|
      s.gsub "SSL_CTX_set_default_verify_paths (c->tls_ctx);", ""
      s.gsub "SSL_CTX_set_verify (c->tls_ctx, SSL_VERIFY_PEER, NULL);", ""
    end

    system "./configure", *args
    system "make"
    ENV.deparallelize
    system "make install"
  end

  test do
    assert_equal "0123456789",shell_output("#{bin}/gsi -e '(for-each write '(0 1 2 3 4 5 6 7 8 9))'")
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
