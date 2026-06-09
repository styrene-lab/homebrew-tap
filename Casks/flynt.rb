# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.12.2"
  sha256 "95a305cc645b7dea3a7add4fb70eeb253252b5d2e7ea0c3a8a0b7ca4a9f928e0"

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
