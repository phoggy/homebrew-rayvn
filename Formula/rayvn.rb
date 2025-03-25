# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "A bash package manager"
    homepage "https://github.com/phoggy/rayvn"
    version "0.1.0"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "c343b5d90c0f42ee893b113ebae8129c91b039532191919d2cc3020cee8cef4c"
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
