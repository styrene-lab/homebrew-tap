# typed: false
# frozen_string_literal: true

class OmegonRc < Formula
  desc "Terminal-native AI agent harness — RC channel (pre-release)"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.15.10-rc.103"

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "255398fd8725d4c02afdb43292e26536093f2a4dcd9b23268884263de50d928c"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "9bca577fc79db36ea31804a1b5e600b098918868971f97bfae2184ba597f5281"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9aea7a494ccf91827fccb536773ebc99321ffc3d94f335c511d5fb36fc387cdd"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36060c5a6d2edfd76b37886028c30c62ea28dcacc45159b6ae297808bbd0a25b"
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
