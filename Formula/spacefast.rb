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
      url "https://github.com/spacefast/cli/releases/download/v0.8.0/spacefast-darwin-arm64.tar.gz"
      sha256 "d5c62178c6008d9e320e42d1c550614a0eb2fe098bbc026920049d2cd44dc9c8"
    end
    on_intel do
      url "https://github.com/spacefast/cli/releases/download/v0.8.0/spacefast-darwin-x64.tar.gz"
      sha256 "f54a598aa29b4d49e092b70e787d8bf4f958eb32e894c035b24e8c2fb69cba9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/spacefast/cli/releases/download/v0.8.0/spacefast-linux-arm64.tar.gz"
      sha256 "e6ca9380596fe7ee891f74c6c42ef4bb799079b7d784af15c3dca846336b20a1"
    end
    on_intel do
      url "https://github.com/spacefast/cli/releases/download/v0.8.0/spacefast-linux-x64.tar.gz"
      sha256 "935c0c3b2c3219b0d2210c2e055efc638c6e4e77e061bbc0035f6ea1f52cdbb3"
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
