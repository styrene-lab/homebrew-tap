# typed: false
# frozen_string_literal: true

class Codyx < Formula
  desc "Local-first knowledge vault — notes, tasks, diagrams, and agent integration"
  homepage "https://github.com/styrene-lab/codyx"
  license "BUSL-1.1"
  version "0.6.4"

  on_linux do
    depends_on "webkitgtk" => "4.1"
    depends_on "gtk+3"

    on_arm do
      url "https://github.com/styrene-lab/codyx/releases/download/v#{version}/codyx-v#{version}-linux-arm64.tar.gz"
      sha256 "d62682cbe16d72ff08bf761082f568fbf667463d397f1460eab958119f234c89"
    end

    on_intel do
      url "https://github.com/styrene-lab/codyx/releases/download/v#{version}/codyx-v#{version}-linux-amd64.tar.gz"
      sha256 "b2dd8d03f072ff869ecc5dd84a5a500f5ea29d9eeab75ffd327b6acd387b5640"
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
