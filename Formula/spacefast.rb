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
      url "https://github.com/spacefast/cli/releases/download/v0.5.0/spacefast-darwin-arm64.tar.gz"
      sha256 "2648c95ae1812c9574acff8281f68341e8a4d8952b5bc108a2bb36c790a51928"
    end
    on_intel do
      url "https://github.com/spacefast/cli/releases/download/v0.5.0/spacefast-darwin-x64.tar.gz"
      sha256 "40bb1b89ab88a990fbbefd619932fc88a175f1032375689484e659f6a5ff6d11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/spacefast/cli/releases/download/v0.5.0/spacefast-linux-arm64.tar.gz"
      sha256 "ed825e4aafa1e4fd40e4785533f2f0b654987faeba1ba49d37d11e327a425741"
    end
    on_intel do
      url "https://github.com/spacefast/cli/releases/download/v0.5.0/spacefast-linux-x64.tar.gz"
      sha256 "c29db06a872cf3db5fb939f3da49b8580815c05113fe25864a7bfe9f8726557a"
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
    assert_match "spacefast/#{version}", shell_output("#{bin}/spacefast --version")
    assert_match "spacefast/#{version}", shell_output("#{bin}/sf --version")
  end
end
