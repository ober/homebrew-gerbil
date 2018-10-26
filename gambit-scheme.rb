class GambitScheme < Formula
  desc "Gambit Scheme"
  homepage "https://gambitscheme.org"
  url "https://github.com/gambit/gambit.git",
      :tag => "v4.9.0"

  depends_on "gcc@6"
  depends_on "openssl"

  def install
    args = %W[
            --prefix=#{prefix}
            --enable-single-host
            --enable-multiple-versions
            --enable-openssl
            --enable-default-runtime-options=f8,-8,t8
            --enable-poll
    ]

    ENV["CC"] = "#{Formula['gcc@6'].bin}/gcc-6"
    #ENV["PATH"] = "#{ENV['PATH']}:/usr/local/bin" # pdf2ps not found otherwise
    system "./configure", *args
    system "make", "bootstrap"
    system "make", "bootclean"
    system "make"
    ENV.deparallelize
    #system "make", "install"
    prefix.install Dir["*"]
  end
end
