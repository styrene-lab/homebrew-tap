# typed: false
# frozen_string_literal: true

class Flynt < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/flynt"
  license "BUSL-1.1"
  version "0.12.4"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-arm64.tar.gz"
      sha256 "fdfae578042e6ec91dc757e674b905fcda7553869346def0fa79071a260d3df2"
    end

    on_intel do
      url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/flynt-v#{version}-linux-amd64.tar.gz"
      sha256 "238496d5892f65dd1a18bf16a3769c5865b6e16db3495ffbe6ca17b7b234f966"
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
