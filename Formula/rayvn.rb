# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "A bash package manager"
    homepage "https://github.com/phoggy/rayvn"
    version "0.1.0"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "701084d7124e0363115f29b7bb56d24963a26fc2daf33d7bc52f850350997938"
    license "GPL-3.0"

    # dependencies

    depends_on "bash"

    def install
        system "chmod", "+x", "bin/rayvn"
        system "chmod", "+x", "bin/rayvn-pinentry"
        system "{#bin}/bash --version"
        system "{#bin}/bash bin/rayvn init"
    end

    test do
        system "bin/rayvn test"
    end
end
