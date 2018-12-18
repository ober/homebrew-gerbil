class GambitScheme < Formula
  desc "Gambit Scheme is an implementation of the Scheme Language"
  homepage "http://gambitscheme.org"
  url "https://github.com/gambit/gambit/archive/v4.9.1.tar.gz"
  sha256 "667ae2ee657c22621a60b3eda6e242224d41853adb841e6ff9bc779f19921c18"

  depends_on "openssl"
  depends_on "gcc"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-single-host
      --enable-multiple-versions
      --enable-default-runtime-options=f8,-8,t8
      --enable-poll
      --enable-openssl
    ]

    inreplace "lib/os_io.c" do |s|
      s.gsub! "SSL_CTX_set_default_verify_paths (c->tls_ctx);", ""
      s.gsub! "SSL_CTX_set_verify (c->tls_ctx, SSL_VERIFY_PEER, NULL);", ""
    end

    ENV["CC"] = Formula["gcc"].bin/"gcc"
    system "./configure", *args
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    assert_equal "0123456789", shell_output("#{prefix}/v4.9.1/bin/gsi -e \"(for-each write '(0 1 2 3 4 5 6 7 8 9))\"")
  end
end
