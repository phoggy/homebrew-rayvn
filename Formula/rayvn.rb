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
    version "0.1.5"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.5.tar.gz"
    sha256 "1a9935017ceaf1eb5223605a1e22872d1b9a26f106e253da0dc30766511ee72f"
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

    # test

    test do
        assert_predicate bin/"rayvn", :exist?, "rayvn binary should exist"
        assert_predicate bin/"rayvn", :executable?, "rayvn binary should be executable"

        assert_predicate bin/"rayvn-pinentry", :exist?, "rayvn-pinentry binary should exist"
        assert_predicate bin/"rayvn-pinentry", :executable?, "rayvn-pinentry binary should be executable"

        # Check version

        releaseDate "2025-04-06_14.05.34_PDT"
        result=shell_output("export RAYVN_NO_TERMINAL=true; rayvn --version", 0).strip
        assert_equal "rayvn v#{version} (released #{releaseDate})", result

        # Run rayvn self test

        result=shell_output("export RAYVN_NO_TERMINAL=true; rayvn test", 0).strip
        assert_match /PASSED/, result

        ohai "Tests passed."
    end
end
