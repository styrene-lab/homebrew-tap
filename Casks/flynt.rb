# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.12.0"
  sha256 "c144289f8d73c9872ab45bb87ce039bf8ab4cf9d5705bcfc327ac947ea7e99d7"

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
