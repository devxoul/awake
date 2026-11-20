class Awake < Formula
  desc "Keep a MacBook running with the lid closed while the screen goes dark"
  homepage "https://github.com/devxoul/awake"
  url "https://github.com/devxoul/awake/archive/refs/tags/0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/devxoul/awake.git", branch: "main"

  depends_on :macos

  def install
    bin.install "awake"
  end

  def caveats
    <<~EOS
      `awake on` and `awake off` run `sudo pmset -a disablesleep`.
      Sleep stays disabled until you run `awake off`, even after a restart.
    EOS
  end

  test do
    assert_match "usage: awake", shell_output("#{bin}/awake help 2>&1", 1)
  end
end
