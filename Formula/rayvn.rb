# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "
A shared library system for bash. Shared libraries are:

     - Developed within a GitHub repo (the 'project')
     - Deployed via 'brew install'.
     - Referenced by a qualified {project}/{library} name e.g. 'my_project/my_lib1'.
     - Used by a script or shared library via the 'require' function, e.g.: require 'rayvn/core'

"
    homepage "https://github.com/phoggy/rayvn"
    version "0.1.2"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.2.tar.gz"
    sha256 "693c3208c427fb776ac0490e2565db4ceb527a3923f7091a400ed2eefb1094d8"
    license "GPL-3.0"

    # dependencies

    depends_on "bash"

    # install

    def install

        # install all files

        prefix.install Dir["*"]
        if debug?
            ohai "All files have been installed to: #{prefix}"
        end
    end

    # def post_install
    #
    #     # assert dependencies: rayvn dependencies
    #
    # end

    # test

    test do
        assert_predicate bin/"rayvn", :exist?, "rayvn binary should exist"
        assert_predicate bin/"rayvn", :executable?, "rayvn binary should be executable"

        # Check version

        release_date="2025-04-10_12.52.07_PDT"
        result=shell_output("export RAYVN_NO_TERMINAL=true; rayvn --version", 0).strip
        assert_equal "rayvn v#{version} (released #{release_date})", result

        # Run rayvn self test

        result=shell_output("export RAYVN_NO_TERMINAL=true; rayvn test", 0).strip
        assert_match /PASSED/, result

        ohai "Tests passed."
    end

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


end
