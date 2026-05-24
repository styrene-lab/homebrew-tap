# typed: false
# frozen_string_literal: true

class Omegon < Formula
  desc "Terminal-native AI agent harness — single binary, ten providers, zero dependencies"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.23.6"


  LINUX_MIN_GLIBC = Version.new("2.39")

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3e4c414a8c134fd2406f6dcd4f6d4c93a5495527835f3220e764cf13dd5cbec0"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "45ffe17ea868f1df949aa5848391f692626d496f9c9858972610785864f9edda"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "338e8dc118c1aefc57a83d1fb58b7fa32c12fecee17f190113cd7077411d2e31"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "339c8f7ba4f9b7f19b71a40b75a59095a402c4e4fba50bcf851dd935c79038a3"
    end
  end

  def install
    check_linux_glibc_requirement!
    bin.install "omegon"
    bin.install_symlink "omegon" => "om"
  end

  def caveats
    <<~EOS
      Two entrypoints are installed:
        omegon  # full harness
        om      # slim harness (same binary, alias-based mode)

      To get started:
        export ANTHROPIC_API_KEY="sk-ant-..."
        om

      Or authenticate with Claude Pro/Max:
        omegon login

      Documentation: https://omegon.styrene.dev/docs/
    EOS
  end

  test do
    assert_match "omegon", shell_output("#{bin}/omegon --version")
  end

  private

  def check_linux_glibc_requirement!
    return unless OS.linux?

    glibc = detect_glibc_version
    return if glibc && glibc >= LINUX_MIN_GLIBC

    detected = glibc ? glibc.to_s : "unknown"
    odie <<~EOS
      Omegon's Linux Homebrew binary currently requires glibc >= #{LINUX_MIN_GLIBC}.
      Detected glibc: #{detected}

      Homebrew on Linux does not upgrade your host glibc to satisfy Omegon's runtime ABI.
      Use a newer Linux distribution, container, or VM with a compatible glibc baseline.

      See: https://omegon.styrene.dev/docs/install/
    EOS
  end

  def detect_glibc_version
    output = Utils.safe_popen_read("ldd", "--version")
    first_line = output.lines.first.to_s
    match = first_line.match(/(\d+\.\d+)/)
    match ? Version.new(match[1]) : nil
  rescue Errno::ENOENT
    nil
  end
end
