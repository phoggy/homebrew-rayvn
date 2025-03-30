# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "
A shared library system for bash. Shared libraries are:

     - Developed within a GitHub repo (the 'project')
     - Deployed via 'brew install'.
     - Referenced by a qualified {project}/{library} name e.g. 'rayvn/core'.
     - Used by a script or shared library via the 'require' function, e.g.: require 'rayvn/test'

"
    homepage "https://github.com/phoggy/rayvn"
    version "0.1.2"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.2.tar.gz"
    sha256 "9ec40ae2d5b2c804ccbcc26b58f72c36f3c7fc44e994b74fab107ae95e615732"
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

        # TODO convert to function
        if debug?
            ohai "running: rayvn --version"
        end
        result=shell_output("export RAYVN_NO_TERMINAL=true; rayvn --version")
        if debug?
            ohai "result: #{result}"
        end
        assert_match "rayvn #{version}", result

        # Run rayvn self test

        if debug?
            ohai "running: rayvn test"
        end
        result=shell_output("export RAYVN_NO_TERMINAL=true; rayvn test")
        if debug?
            ohai "result: #{result}"
        end
        assert_match "PASSED", result
    end
end
