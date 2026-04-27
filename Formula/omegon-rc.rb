# typed: false
# frozen_string_literal: true

class OmegonRc < Formula
  desc "Terminal-native AI agent harness — RC channel (pre-release)"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.17.0-rc.14"

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "ad55e39252d2506a8ed9984101453db556491ecf3db35de27ca37269aaf53f3d"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "6c7f613723b66a553db6240ebfd978eec127156b4080b3b6ea3ae23eca405f5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38b1c09556dca3307548a2891e06c6cdd6439a54c868825c4f4cb21397df1ff8"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a949e338832b5c7bb8a624e508d2e30dc1ca3cf1b9c675af673788fe26c91d83"
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
