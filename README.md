# Zed editor (Unofficial Windows builds)

[![Build](https://github.com/pirafrank/zed_unofficial_win_builds/actions/workflows/build.yml/badge.svg)](https://github.com/pirafrank/zed_unofficial_win_builds/actions/workflows/build.yml)

This repository contains unofficial builds of the Zed editor for Windows x64.

Not affiliated with Zed Industries.

## What is Zed?

<https://zed.dev>

## Why?

The official Zed editor is only available for macOS and Linux. This repository fills the gap until official builds for Windows will be available.

## How it works?

This repository automatically builds for Windows x64 from [Zed sources](https://github.com/zed-industries/zed) using a GitHub Workflow. The workflow is externally triggered as soon as an official Zed release is made. An additional scheduled check exists.

Releases published here matches [those by Zed](https://github.com/zed-industries/zed/releases) in version and type (if is pre-release or not) for clarity.

## Install

Choose one of the following options.

### Scoop

```powershell
scoop bucket add zed-unofficial https://github.com/pirafrank/zed_unofficial_win_builds.git
scoop install zed
```

> [!INFO]
> Use command above to install versions `0.159.6` and newer. For earlier versions use `scoop install zed-[VERSION]`.
> A list of old versions is available in the [bucket/versions](https://github.com/pirafrank/zed_unofficial_win_builds/tree/main/bucket/versions) dir.

### Installation script

```powershell
Invoke-WebRequest -Uri https://github.com/pirafrank/zed_unofficial_win_builds/raw/refs/heads/main/install_or_update.ps1 -OutFile .\install_or_update.ps1
.\install_or_update.ps1
```

### Manually

Download the [latest release](https://github.com/pirafrank/zed_unofficial_win_builds/releases/latest) and put it in a directory of your choice. A good place could be:

```txt
%USERPROFILE%\AppData\Local\Programs\Zed
```

> [!TIP]
> Create a shortcut to `zed.exe` and to place it here to add Zed to the Start Menu.
>
> ```txt
> %APPDATA%\Microsoft\Windows\Start Menu\Programs\Zed
> ```

I have also made a [PR](https://github.com/ScoopInstaller/Versions/pull/1949) to add this to `scoop` for easier install.

## Configuration

Zed writes config here:

```txt
%APPDATA%\Zed
```

## Discord

Official Discord by Zed Industries [here](https://discord.gg/8GubhShZ3a), as per [this discussion](https://www.reddit.com/r/ZedEditor/comments/1e3soql/zed_in_wsl/) on the official repository.

## License

This is just packing of Zed from source. No changes to Zed code or license whatsoever.

The workflow file of the repo is do-whatever-you-like license.
