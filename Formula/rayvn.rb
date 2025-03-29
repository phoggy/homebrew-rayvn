# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "A simple bash shared library system, enabling use of \"require 'project/library'\" to load libraries."
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
        if verbose?
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

        ohai "about to run rayvn --version"
        result=shell_output("rayvn --version")
        # result=shell_output("export RAYVN_REQUIRE_TERMINAL=false; rayvn --version")
        ohai "got result: #{result}"
        assert_match "rayvn #{version}", result

        # Run rayvn self test

        ohai "MOVING ON, trying rayvn test"
        result=shell_output("rayvn test")
        # result=shell_output("export RAYVN_REQUIRE_TERMINAL=false; rayvn test")
        ohai "got result: #{result}"
        assert_match "updated ${HOME}.bashrc", result
    end
end
