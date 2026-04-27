# typed: false
# frozen_string_literal: true

class OmegonRc < Formula
  desc "Terminal-native AI agent harness — RC channel (pre-release)"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.17.0-rc.19"

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3f189edd1157237865f35a716dc1d6e0076ccfcd75c9acb4502a114e25180946"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "44a09711ec16041eca9a42db8e18c99fe0b75b85fa07aa7d224b9c155b80888c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "470ff2fdb4d37d8a9c0d50452d81951a0c15d3f6f51cec7ed93b23969e967285"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b5efc7c7404d476017b2a00322f973fde2b10b84daa39ee0f892c0243a26935"
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
