# typed: false
# frozen_string_literal: true

class Flynt < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/flynt"
  license "BUSL-1.1"
  version "0.10.1"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-arm64.tar.gz"
      sha256 "1eb9e532231bce9c2e8aa9ff780fb34aea40945d052cf248d0976701922a56c5"
    end

    on_intel do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-amd64.tar.gz"
      sha256 "a259d69a69e152d9a142d2a584d6f12fb7d67543021b367a61ad65f44aa6ae08"
    end
  end

  on_macos do
    odie "Flynt for macOS is available as a DMG or PKG. See: https://github.com/styrene-lab/flynt/releases"
  end

  def install
    bin.install "flynt"
    (share/"flynt").install "assets" if File.directory?("assets")
    (share/"applications").install "flynt.desktop" if File.exist?("flynt.desktop")
    if File.exist?("flynt.png")
      (share/"icons/hicolor/256x256/apps").install "flynt.png"
    end
  end

  test do
    assert_match "flynt", shell_output("#{bin}/flynt --version")
  end
end
