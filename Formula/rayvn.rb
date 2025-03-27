# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "A simple bash package manager and library system, where scripts can use the 'require' function to load libraries."
    homepage "https://github.com/phoggy/rayvn"
    version "9.9.9"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "9993f8a35176c334f8031dcd326689378f82700afa1b533580a2ad786ddb5999"
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

        rayvn_version = shell_output("rayvn --version").strip
        assert_match "rayvn 0.1.0", rayvn_version

        # Run rayvn test

        system bash, "-c", "rayvn test;"
        if $?.exitstatus != 0
            odie "test failed with exit code #{$?}"
            raise "rayvn test failed: aborting installation."
        end
    end
end
