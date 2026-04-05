Dotfiles
========

Cross-platform dotfiles for Ubuntu and Windows with a native installer flow.

Principles
----------

- `bootstrap` installs software, not configs.
- `install` installs configs, not software.
- Existing files are backed up before replacement.
- Reapplying the installer is safe.
- Optional app-specific configs stay out of the default install path.

Repository layout
-----------------

- `bootstrap/ubuntu.sh`
- `bootstrap/windows.ps1`
- `install.sh`
- `install.ps1`
- `scripts/common/`
- `scripts/ubuntu/verify.sh`
- `scripts/windows/verify.ps1`
- `dotfiles/`
- `local/examples/`

Install
-------

Ubuntu:

```bash
git clone <repo>
cd dotfiles
./bootstrap/ubuntu.sh
./install.sh
./scripts/ubuntu/verify.sh
```

Windows:

```powershell
git clone <repo>
cd dotfiles
.\bootstrap\windows.ps1
.\install.ps1
.\scripts\windows\verify.ps1
```

Optional configs
----------------

Optional configs are excluded by default.

- Bash: `./install.sh --include-optional`
- PowerShell: `.\install.ps1 -IncludeOptional`

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
