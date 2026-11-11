class Spacefast < Formula
  desc "Command-line interface for publishing and managing Spacefast spaces"
  homepage "https://spacefast.com"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/spacefast/cli/releases/download/v0.9.0/spacefast-darwin-arm64.tar.gz"
      sha256 "695f43a33eb9e0c37f088530a1ef3314db9c1d21ae050af6448fc55c91eebff0"
    end
    on_intel do
      url "https://github.com/spacefast/cli/releases/download/v0.9.0/spacefast-darwin-x64.tar.gz"
      sha256 "4e5a574b19ba94beb30b1cbcd8618f9076b472f01757abdaeb83c86db8b089e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/spacefast/cli/releases/download/v0.9.0/spacefast-linux-arm64.tar.gz"
      sha256 "1a64532c7aae3fc3ab67eded3eeae147ed345072c612b391f20568e0770beead"
    end
    on_intel do
      url "https://github.com/spacefast/cli/releases/download/v0.9.0/spacefast-linux-x64.tar.gz"
      sha256 "72ca864ee4471141abd479407af18305319d3f8b8a94e634e2daa7cde90b36a4"
    end
  end

  def install
    # The executable loads its payload from the sibling lib/ directory, so keep
    # them together in libexec and expose only the entrypoints on PATH.
    libexec.install "spacefast", "lib"
    bin.install_symlink libexec/"spacefast"
    bin.install_symlink libexec/"spacefast" => "sf"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spacefast --version")
    assert_match version.to_s, shell_output("#{bin}/sf --version")
  end
end
