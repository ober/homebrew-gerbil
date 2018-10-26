class GambitScheme < Formula
  desc "Gambit Scheme"
  homepage "https://gambitscheme.org"
  version "4.9.0"
  url "https://github.com/gambit/gambit.git",
      :tag => "v#{version}"

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

    bin.install Dir["gsc/gsc"]
    bin.install Dir["gsi/gsi"]

    %W[ gambcomp-C
        gambcomp-java
        gambcomp-js
        gambcomp-php
        gambcomp-python
        gambcomp-ruby
        gambdoc
        ].each do |l|
           bin.install Dir["bin/#{l}"]
        end

    %W[ gsi-script
        scheme-ieee-1178-1990
        scheme-r4rs
        scheme-r5rs
        scheme-srfi-0
        six
        six-script ].each do |l|
          bin.install_symlink "gsi" => "#{l}"
        end

    %W[ gambit.html gambit.pdf gambit.txt ].each do |d|
      doc.install Dir["doc/#{d}"]
    end

    %W[ gambit-not409000.h  gambit.h ].each do |i|
      include.install Dir["include/#{i}"]
    end

    %W[ gambit.info gambit.info-1 gambit.info-2 gambit.info-3 ].each do |i|
      info.install Dir["info/#{i}"]
    end

    %W[ _asm#.scm _define-syntax.scm  _gambit.c _io#.scm _num#.scm _syntax-boot.scm _syntax-common.scm _syntax-template.scm _syntax.scm _with-syntax-boot.scm  digest.scm libgambitgsc.a  r5rs#.scm
    _assert#.scm  _eval#.scm _gambitgsc.c  _kernel#.scm  _repl#.scm  _syntax-case-xform-boot.scm  _syntax-pattern.scm _syntax-xform-boot.scm  _system#.scm  _x86#.scm gambit#.scm  libgambitgsi.a  syntax-case.scm
    _codegen#.scm  _gambit#.scm _gambitgsi.c  _nonstd#.scm  _std#.scm _syntax-case-xform.scm _syntax-rules-xform.scm  _syntax-xform.scm _thread#.scm  digest#.scm libgambit.a  r4rs#.scm
    ].each do |l|
      lib.install Dir["lib/#{l}"]
    end

    bin.install_symlink "bin/gsc" => "gsc-script"
    system "ln -s #{prefix}/#{version} #{prefix}/#{version}/v#{version}"

#    prefix.install Dir["*"]
  end
end
