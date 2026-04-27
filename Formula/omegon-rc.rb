# typed: false
# frozen_string_literal: true

class OmegonRc < Formula
  desc "Terminal-native AI agent harness — RC channel (pre-release)"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.17.0-rc.23"

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e2ceba3f4ee84943b0b92099493a809111099809d723cf775900f3a16cc60cf3"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "81409cc0e0365c73b839aa232aff82643f1fca94cb0cf5b37e2a237542c01b9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "674c7503135a2dce6176139dd3e472d48074602b95e90e2b80b22cc5af142658"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "971810d1ee4bc699a92b98a52ee536162e464ce6ccebc1550168f46337b6d068"
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
