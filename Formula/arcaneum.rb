# Homebrew formula for Arcaneum
# Install: brew install cwensel/arcaneum/arcaneum
# This file is auto-updated by the update-homebrew workflow on each release.

class Arcaneum < Formula
  include Language::Python::Virtualenv

  desc "CLI tools for semantic and full-text search with Qdrant and MeiliSearch"
  homepage "https://github.com/cwensel/arcaneum"
  url "https://github.com/cwensel/arcaneum/releases/download/v0.8.3/arcaneum-0.8.3.tar.gz"
  sha256 "9aec4f10316a7e3d282206a87ba450b3a3bfa2ff8bf6f39b7d6f4236a320049c"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Create venv with pip available
    venv = virtualenv_create(libexec, "python3.12")
    # Install package with all dependencies resolved from PyPI.
    # Cannot use venv.pip_install_and_link (uses --no-deps) without
    # listing 50+ transitive dependencies as resource blocks.
    system libexec/"bin/python", "-m", "pip", "install", buildpath
    (bin/"arc").write_env_script libexec/"bin/arc", PATH: "#{libexec}/bin:${PATH}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arc --version")
  end
end
