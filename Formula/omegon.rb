# typed: false
# frozen_string_literal: true

class Omegon < Formula
  desc "Terminal-native AI agent harness — single binary, ten providers, zero dependencies"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.18.5"


  LINUX_MIN_GLIBC = Version.new("2.39")

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "92bdb62d684007f59ea3d0ef81318d54eb610c648ff52559fe7848fd579930e8"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "ba11ebe1b220ecf582e3205037d2f39046cced4606c00fff0384f958d1f7ff52"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd57f878dc1becaa84d56fb71c7116a8bd47c554b0de771c509c889eaac8e0ae"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2aa6556a3202878cc21625db837d0f4cd9d3e089ef53b87fbdb622e312335223"
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
