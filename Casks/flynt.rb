# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.11.1"
  sha256 "508fc2307d451f0e54cb80dea0cdbb24f2bac92ad4fcd3e42a07c81dbffe1663"

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
