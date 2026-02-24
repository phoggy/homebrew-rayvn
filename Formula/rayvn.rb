class Rayvn < Formula
  desc "Shared bash library system for managing executables and libraries"
  homepage "https://github.com/phoggy/rayvn"
  url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "52009c3d94d31023c67bf16f3696fa0474b717358ea9d072da1dceffbba8140c"
  license "GPL-3.0-only"



  def install
    bin.install "bin/rayvn"
    bin.install "bin/rayvn.up"
    (share/"rayvn"/"lib").install Dir["lib/*.sh"]
    (share/"rayvn"/"templates").install Dir["templates/*"]
    (share/"rayvn"/"etc").install Dir["etc/*"]
    (share/"rayvn").install "rayvn.pkg"
  end

  test do
    system "#{bin}/rayvn", "--version"
  end
end