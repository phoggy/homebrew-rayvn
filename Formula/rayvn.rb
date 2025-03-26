# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Rayvn < Formula
    desc "A bash package manager"
    homepage "https://github.com/phoggy/rayvn"
    version "0.1.0"
    url "https://github.com/phoggy/rayvn/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "de5d5380fc55a66781c474f2173cbca5ef5409f08a893b0775a615fdc766f7e7"
    license "GPL-3.0"

    # dependencies

    depends_on "bash"

    # Find user home directory without using the ${HOME} var, so that rayvn init can
    # update the correct .bashrc file

    def get_user_home
        if OS.mac?
            home_dir = `dscl . -read /Users/#{ENV["USER"]} NFSHomeDirectory | awk '{print $2}'`.chomp
            raise "Unable to determine home directory for user #{ENV["USER"]}" if home_dir.empty?
            return Pathname.new(home_dir)
        else
            home_dir = `getent passwd #{ENV["USER"]} | cut -d: -f6`.chomp
            raise "Unable to determine home directory for user #{ENV["USER"]}" if home_dir.empty?
            return Pathname.new(home_dir)
        end
    end

    # variables

    def user_name
        ENV["USER"]
    end

    def user_home
        get_user_home
    end

    def bash_path
        Formula["bash"].opt_bin/"bash"
    end

    # install

    def install
        if verbose?
            ohai "brew installed bash path: #{bash_path}"
            ohai "Current user name: #{user_name}"
            ohai "Current user's home directory: #{user_home}"
        end

        # install all files

        prefix.install Dir["*"]
        ohai "All files have been installed to: #{prefix}"

        # initialize rayvn

        result = system(bash_path, "-c", "export RAYVN_REQUIRE_TERMINAL=false; export HOME=#{user_home}; #{bin/"rayvn"} init;")
        if result != true
            raise "rayvn init failed: aborting installation."
        end
    end

    # test

    test do
        ohai "Running rayvn tests"
        result = system(bash_path, "-c", "export HOME=#{user_home}; #{bin/"rayvn"} test;")
        if result != true
            raise "rayvn test failed: aborting installation."
        end
    end
end
