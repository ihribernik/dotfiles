Dotfiles
========

Cross-platform dotfiles for Ubuntu and Windows with a native installer flow.

Principles
----------

- `scripts/*/install-packages` installs software, not configs.
- `install` installs configs, not software.
- Existing files are backed up before replacement.
- Reapplying the installer is safe.
- Optional app-specific configs stay out of the default install path.

Repository layout
-----------------

- `install.sh`
- `install.ps1`
- `scripts/common/`
- `scripts/ubuntu/install-packages.sh`
- `scripts/windows/install-packages.ps1`
- `dotfiles/`
- `local/examples/`

Install
-------

Recommended:

Use the `setup` script for your platform to run the full flow.

Ubuntu:

```bash
git clone <repo>
cd dotfiles
./setup.sh
```

Ubuntu with extras and optional configs:

```bash
./setup.sh --with-extras --include-optional
```

Windows:

```powershell
git clone <repo>
cd dotfiles
.\setup.ps1
```

The Windows package script installs the terminal apps used by this repo, including Windows Terminal and WezTerm.

Advanced:

- Ubuntu packages only: `./scripts/ubuntu/install-packages.sh --with-extras`
- Ubuntu install only: `./install.sh --include-optional`
- Windows packages only: `.\scripts\windows\install-packages.ps1`
- Windows install only: `.\install.ps1 -IncludeOptional`

Optional configs
----------------

Optional configs are excluded by default.

- Ubuntu setup: `./setup.sh --include-optional`
- Windows setup: `.\setup.ps1 -IncludeOptional`

Today the optional set contains Sublime Text user settings from `dotfiles/User`.

Backups
-------

When a managed target already exists and is not the expected link, it is moved to:

```text
~/.dotfiles-backups/<timestamp>/
```

PowerShell uses the matching location under the user profile home directory.

License
-------

See `LICENSE.md`.
