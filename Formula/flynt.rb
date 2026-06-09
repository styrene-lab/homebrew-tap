# typed: false
# frozen_string_literal: true

class Flynt < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/flynt"
  license "BUSL-1.1"
  version "0.12.2"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-arm64.tar.gz"
      sha256 "9ca5e17e8ad9354d2ca3e7251379627674fd5d296394c1deef8c05acb3cdb465"
    end

    on_intel do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-amd64.tar.gz"
      sha256 "134c4e45e58c30aab784aa376d1725e5ce766461a640bc2fa4f35c913b74f084"
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
