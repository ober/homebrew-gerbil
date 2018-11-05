class GambitScheme < Formula
  desc "Gambit Scheme"
  homepage "https://gambitscheme.org"
  url "https://github.com/gambit/gambit.git", :tag => "v4.9.0"

  depends_on "gcc@6"
  depends_on "openssl" => :optional

  def install
    args = %W[--prefix=#{prefix}]

    ENV["CC"] = Formula["gcc@6"].bin/"gcc-6"

    #if build.with? "disable-ssl-verification"
    system "sed -i -e 's#SSL_CTX_set_default_verify_paths (c->tls_ctx);##g' lib/os_io.c"
    system "sed -i -e 's#SSL_CTX_set_verify (c->tls_ctx, SSL_VERIFY_PEER, NULL);##g' lib/os_io.c"
    #end

    #if build.with? "single-host"
    args << "--enable-single-host"
    #end

    #if build.with? "multiple-versions"
    args << "--enable-multiple-versions"
    #end

    #if build.with? "gerbil-options"
    args << "--enable-default-runtime-options=f8,-8,t8"
    #end

    #if build.with? "poll"
    args << "--enable-poll"
    #end

    #if build.with? "openssl"
    args << "--enable-openssl"
    #end

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
