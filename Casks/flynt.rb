# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.12.11"
  sha256 "589cf9b6bb5d8c62e2773d78845c795c64d2b0ca443e1baf8061e5da0d3d290a"

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
