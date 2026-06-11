# typed: false
# frozen_string_literal: true

class Flynt < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/flynt"
  license "BUSL-1.1"
  version "0.12.6"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-arm64.tar.gz"
      sha256 "399d826937b98ae8be5962091b1fc48cc26b5b330a4b9d89996d82e95fa4cf12"
    end

    on_intel do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-amd64.tar.gz"
      sha256 "3bfc224752b2db44167e9ec4e89b100ca0117bab2408049966a48fd1a3c1cabb"
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
