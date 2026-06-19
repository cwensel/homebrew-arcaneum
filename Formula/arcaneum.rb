# Homebrew formula for Arcaneum
# Install: brew install cwensel/arcaneum/arcaneum
# This file is auto-updated by the update-homebrew workflow on each release.

class Arcaneum < Formula
  include Language::Python::Virtualenv

  desc "CLI tools for semantic and full-text search with Qdrant and MeiliSearch"
  homepage "https://github.com/cwensel/arcaneum"
  url "https://github.com/cwensel/arcaneum/releases/download/v0.8.2/arcaneum-0.8.2.tar.gz"
  sha256 "e19afbe91de427ee6f8d1dc46dc4d9e26b61b0aa692b643443b0c24ae224dfa3"
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
