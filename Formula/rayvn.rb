class Rayvn < Formula
  desc "
A shared library system for bash. Shared libraries are:

     - Developed within a GitHub repo (the 'project')
     - Deployed via 'brew install'.
     - Referenced by a qualified {project}/{library} name e.g. 'my_project/my_lib1'.
     - Used by a script or shared library via the 'require' function, e.g.: require 'rayvn/core'

"
  homepage "https://github.com/phoggy/rayvn"
  url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "8b499239d5ea8694a654703ea9826736eb27824f2ede2107e456f13eb490bc45"
  license "GPL-3.0"

  # dependencies

  depends_on "bash"
  depends_on "awk"

  # install

  def install
    prefix.install Dir["*"]
  end

  # def post_install
  #
  #   rayvn dependencies --assert
  #
  # end

  def caveats
    <<~EOS
      One or more tools installed or required by this formula may replace older versions
      already present on your system (e.g. in /usr/bin). If a tool isn't behaving as expected,
      your shell may be using a cached or lower-priority version from your PATH.

      To ensure you're using the correct version(s):

      🔁 Start a new terminal session
          OR
      🧹 Clear your shell's command cache:

        - For Bash:
            hash -r
        - For Zsh:
            rehash

      ✅ Then verify with:

          which <tool>
          <tool> --version

      💡 To inspect your PATH priority:

          echo $PATH | tr ':' '\\n' | nl

      Make sure Homebrew's bin directory appears **before** /usr/bin
      (e.g. /opt/homebrew/bin on Apple Silicon, /usr/local/bin on Intel Macs).
    EOS
  end

  # test

  test do

    # Check binary

    assert_path_exists bin/"rayvn", "rayvn binary should exist"
    assert_predicate bin/"rayvn", :executable?, "rayvn binary should be executable"

    # Check version

    release_date = "2025-05-28_13.07.38_PDT"
    expected_output = "rayvn #{version} (released #{release_date})"
    assert_equal expected_output, shell_output("export RAYVN_NO_TERMINAL=true; #{bin}/rayvn --version").strip

    # Run rayvn self test

    result = shell_output("export RAYVN_NO_TERMINAL=true; rayvn test").strip
    assert_match "PASSED", result
    ohai "Tests passed."
  end
end
