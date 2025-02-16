class Tio < Formula
  desc "Simple TTY terminal I/O application"
  homepage "https://tio.github.io"
  url "https://github.com/tio/tio/releases/download/v1.32/tio-1.32.tar.xz"
  sha256 "a8f5ed6994cacb96780baa416b19e5a6d7d67e8c162a8ea4fd9eccd64984ae44"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-bash-completion-dir=#{bash_completion}"
    system "make", "install"
  end

  test do
    # Test that tio emits the correct error output when run with an argument that is not a tty.
    # Use `script` to run tio with its stdio attached to a PTY, otherwise it will complain about that instead.
    assert_match /Error: Not a tty device/, shell_output("script -q /dev/null #{bin}/tio /dev/null", 1).strip
  end
end
