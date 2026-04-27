# typed: false
# frozen_string_literal: true

class Codex < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/codex"
  license "BUSL-1.1"
  version "0.6.0"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/codex/releases/download/v#{version}/codex-v#{version}-linux-arm64.tar.gz"
      sha256 "02d3839e9090d1d6773dd3fb240c69312dfcfb9f2218080e99ebfa308de4f764"
    end

    on_intel do
      url "https://github.com/styrene-lab/codex/releases/download/v#{version}/codex-v#{version}-linux-amd64.tar.gz"
      sha256 "dad32ff7ae9afe64fbc88efa4b3dd29eed3e0c381bad3e5a7a6aa28ae2e7f029"
    end
  end

  on_macos do
    # macOS builds are distributed via DMG and TestFlight.
    # Homebrew install will be available once macOS release artifacts stabilise.
    odie "Codex for macOS is available via DMG download or TestFlight. See: https://github.com/styrene-lab/codex/releases"
  end

  def install
    bin.install "codex"
    if File.directory?("assets")
      (share/"codex").install "assets"
    end
    if File.exist?("codex.desktop")
      (share/"applications").install "codex.desktop"
    end
    if File.exist?("codex.png")
      (share/"icons/hicolor/256x256/apps").install "codex.png"
    end
  end

  test do
    assert_match "codex", shell_output("#{bin}/codex --version 2>&1", 1)
  end
end
