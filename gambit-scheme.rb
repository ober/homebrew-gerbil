class GambitScheme < Formula
  desc "Gambit Scheme"
  homepage "https://gambitscheme.org"
  url "https://github.com/gambit/gambit.git",
      :tag => "v4.9.0"

  depends_on "gcc@6"

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
    bins = %W[
         gambcomp-C
         gambcomp-java
         gambcomp-js
         gambcomp-php
         gambcomp-python
         gambcomp-ruby
         gambdoc
         gsc
         gsi
         ]
    gsc_links = %W[ gsc-script ]
    gsi_links = %W[
                  gsi-script
                  scheme-ieee-1178-1990
                  scheme-r4rs
                  scheme-r5rs
                  scheme-srfi-0
                  six
                  six-script ]

    docs = %W[ gambit.html gambit.pdf gambit.txt ]
    includes = %W[ gambit-not409000.h  gambit.h ]
    infos = %W[ gambit.info gambit.info-1 gambit.info-2 gambit.info-3 ]
    libs = %W[ _asm#.scm _define-syntax.scm  _gambit.c _io#.scm _num#.scm _syntax-boot.scm _syntax-common.scm _syntax-template.scm _syntax.scm _with-syntax-boot.scm  digest.scm libgambitgsc.a  r5rs#.scm
    _assert#.scm  _eval#.scm _gambitgsc.c  _kernel#.scm  _repl#.scm  _syntax-case-xform-boot.scm  _syntax-pattern.scm _syntax-xform-boot.scm  _system#.scm  _x86#.scm gambit#.scm  libgambitgsi.a  syntax-case.scm
    _codegen#.scm  _gambit#.scm _gambitgsi.c  _nonstd#.scm  _std#.scm _syntax-case-xform.scm _syntax-rules-xform.scm  _syntax-xform.scm _thread#.scm  digest#.scm libgambit.a  r4rs#.scm ]

    bins.each |b| do
      bin.install Dir["bin/#{b}"]
    end

    gsc_links.each |l| do
      bin.install_symlink libexec"bin/gsc" => "#{l}"
    end

    gsi_links.each |l| do
      bin.install_symlink libexec"bin/gsi" => "#{l}"
    end

    docs.each |d| do
      doc.install Dir["doc/#{d}"]
    end

    includes.each |i| do
      include.install Dir["include/#{i}"]
    end

    infos.each |i| do
      info.install Dir["info/#{i}"]
    end

    libs.each |l| do
      lib.install Dir["lib/#{l}"]
    end

  end
end
