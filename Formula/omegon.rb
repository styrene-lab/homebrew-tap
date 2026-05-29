# typed: false
# frozen_string_literal: true

class Omegon < Formula
  desc "Terminal-native AI agent harness — single binary, ten providers, zero dependencies"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.25.1"


  LINUX_MIN_GLIBC = Version.new("2.39")

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "bb949899056dd2514dabda6570ec04add13198c0c4c49a603b68db60f5dc6f22"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7e2fb721efbcaf11cd9c8839c8150e72384b551792c1123770ba2b7a86f3d6a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "caaa1dabacfb74df2abdb043b3f03985c264ac2a27151251cbb13f2245ee38d0"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ada7c9633a62bfbce8050e728ed50d5bd4acc9604b6afc65692c4987635e298"
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
