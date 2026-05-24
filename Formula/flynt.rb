# typed: false
# frozen_string_literal: true

class Flynt < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/flynt"
  license "BUSL-1.1"
  version "0.11.0"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-arm64.tar.gz"
      sha256 "f126b79cd84f2b813020c17fa048df34853e9f9d1c8a123af8e2dcd1dfea80b3"
    end

    on_intel do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-amd64.tar.gz"
      sha256 "7fd9ad1219a9d94d46b5eec004c652e6474c03de528ce41e484bcc57cd030d41"
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
