# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.12.3"
  sha256 "c92d634f90c71a0cfe217aaf87c6ed29b5b0b4f5992e37b507022f96d26d1fc1"

  url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/Flynt-#{version}-macos.dmg"
  name "Flynt"
  desc "Local-first knowledge workspace"
  homepage "https://github.com/styrene-lab/flynt"

  depends_on macos: ">= :monterey"

  app "Flynt.app"

  zap trash: [
    "~/Library/Application Support/io.styrene.codex",
    "~/Library/Caches/io.styrene.codex",
    "~/Library/Preferences/io.styrene.codex.plist",
  ]
end
