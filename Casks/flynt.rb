# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.10.6"
  sha256 "e8c646215310d702bf62a513a42d9d8b01eb2537e4b562eeb8a6c760983a2f4a"

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
