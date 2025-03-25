# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "A bash package manager"
    homepage "https://github.com/phoggy/rayvn"
    version "0.1.0"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "45a45ee92a992b62149b4f978f22061fbb539a11e968583c12c8fbc94f41917e"
    license "GPL-3.0"

    # dependencies

    # depends_on "jpeg"

    def install
        system "chmod", "+x", "bin/rayvn"
        system "chmod", "+x", "bin/rayvn-pinentry"
        system "bin/rayvn init"
    end

    test do
        system "bin/rayvn test"
    end
end
