# typed: false
# frozen_string_literal: true

class OmegonRc < Formula
  desc "Terminal-native AI agent harness — RC channel (pre-release)"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.17.0-rc.37"

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "d7e4437b85f4c9ee12be3335f02975cf032c7186b82e7bafb8c42226ad5d2d2d"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "9996bbc7f44268ae0d966d0821db624ec7e9f709ffc8bb7aad041c2b23eb7e28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "51ddbd54c1056d5d8406756e95df84222a6e93d4ee1a033b575b79bb4c95dfa0"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ee60a52648b2527751282a6de80330d597c5461862b74f06dae2e8d4970ba47b"
    end
  end

  conflicts_with "omegon", because: "both install the omegon binary"

  def install
    bin.install "omegon"
    bin.install_symlink "omegon" => "om"
  end

  def caveats
    <<~EOS
      This is the RC (pre-release) channel of omegon.
      To switch back to stable:
        brew unlink omegon-rc && brew install omegon

      To get started:
        export ANTHROPIC_API_KEY="sk-ant-..."
        omegon

      Or authenticate with Claude Pro/Max:
        omegon login

      Documentation: https://omegon.styrene.dev/docs/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omegon --version")
  end
end
