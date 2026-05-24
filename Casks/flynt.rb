# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.11.0"
  sha256 "ea023a0d671ab4269e9404e43d7fc65ad53c92d40384bcedbd68e0c5c3279d9b"

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
