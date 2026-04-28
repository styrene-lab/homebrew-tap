# typed: false
# frozen_string_literal: true

class Omegon < Formula
  desc "Terminal-native AI agent harness — single binary, ten providers, zero dependencies"
  homepage "https://omegon.styrene.dev"
  license "BUSL-1.1"
  version "0.17.4"


  LINUX_MIN_GLIBC = Version.new("2.39")

  on_macos do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f86c4fcf1eda9a98f449481b0102f36ae463170152d3a2f1bb200cf20a10431e"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "b4a38f742558bc6eb58f0905b3fffc80cbe23e05d4ef69dc6438e9364d6f8bbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d86512ef248a7869ce2fed65ab9bf65e9f891eaa77bb787e999ffb04b9f65c05"
    end

    on_intel do
      url "https://github.com/styrene-lab/omegon/releases/download/v#{version}/omegon-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f18609ed38b10821aa1106d9e218eae81982874fb0f5834b39783168bae3b203"
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
