class Iconforge < Formula
  desc "Convert any image into a macOS .icns icon bundle from the terminal"
  homepage "https://github.com/villagealchemist/iconforge"
  url "https://github.com/villagealchemist/iconforge/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "1118dc86c1d7d58043275ff16ae947210c9083cc9710b63530ae2dc8a1c48787"
  license "MIT"
  version "1.0.0"

  depends_on :macos
  # No additional dependencies—uses built-in sips, iconutil, find.

  def install
    bin.install "bin/iconforge.sh" => "iconforge"
  end

  test do
    # Verify that the binary runs and prints its version
    output = shell_output("#{bin}/iconforge --version")
    assert_match "iconforge v1.0.0", output
  end
end
