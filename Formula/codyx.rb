# typed: false
# frozen_string_literal: true

class Codyx < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/codyx"
  license "BUSL-1.1"
  version "0.6.3"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/codyx/releases/download/v#{version}/codyx-v#{version}-linux-arm64.tar.gz"
      sha256 "da67bb84f58a4ab5dedeb106d0e547bf9b4c7888b8256ccb2b005c2498664aab"
    end

    on_intel do
      url "https://github.com/styrene-lab/codyx/releases/download/v#{version}/codyx-v#{version}-linux-amd64.tar.gz"
      sha256 "b1a7d92207170364a4c0f0a4f9332980a91bbd6e3a57bb774f399378e0a87c96"
    end
  end

  on_macos do
    odie "Codyx for macOS is available via DMG or TestFlight. See: https://github.com/styrene-lab/codyx/releases"
  end

  def install
    bin.install "codyx"
    (share/"codex").install "assets" if File.directory?("assets")
    (share/"applications").install "codyx.desktop" if File.exist?("codyx.desktop")
    if File.exist?("codyx.png")
      (share/"icons/hicolor/256x256/apps").install "codyx.png"
    end
  end

  test do
    assert_match "codyx", shell_output("#{bin}/codyx --version")
  end
end
