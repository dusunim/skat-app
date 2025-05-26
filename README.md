# skat-app

**skat-app** is a skeleton application that demonstrates how to consume `skat-core` as a reusable package and as a directly embedded source within an application.  
This project provides multiple build presets to support both scenarios and to enable fast iteration cycles during development.

## Overview

This repository serves as a reference project for developing SKAT-based applications using `skat-core`.

It shows two main integration strategies:

1. **Using `skat-core` as a *vcpkg* package**  
   Ideal for stable development environments where `skat-core` is pre-built and versioned.

2. **Directly embedding `skat-core`**  
   Useful when you need fast iteration with local edits, live debugging, or close integration.  
   This bypasses the package manager and compiles everything together in a single build context.

## Getting Started

### Clone and initialize submodules

```bash
$ git clone https://github.com/dusunim/skat-app.git
$ cd skat-app
$ git submodule update --init
```

## 🧱 Option 1: Build using skat-core as a *vcpkg* overlay-ports
This is the default build mode.

In this setup, `skat-core` is integrated as a ***vcpkg* overlay-ports**.  
Overlay-ports allow you to add or override ports in your local project without modifying the central *vcpkg* registry.  
This provides flexibility to use custom versions or configurations of libraries like `skat-core` within your project.

For more detailed information, see the official *vcpkg* documentation on [Overlay ports](https://learn.microsoft.com/en-us/vcpkg/concepts/overlay-ports).

```bash
$ cmake --preset ninja
$ cmake --build --preset ninja/release
```

On Windows with Visual Studio:

```bash
$ cmake --preset vs
$ cmake --build --preset vs/release
```

### To change the version of `skat-core`
Edit the version field in:

```text
/ports/skat-core/vcpkg.json
```
Example:

```json
{
  "name": "skat-core",
  "version": "0.1.1", # from 0.1.0
  "homepage": "https://github.com/dusunim/skat-core",
  "description": "skat-core lib from GitHub Release"
}
```

This version corresponds to a GitHub release tag on `skat-core`.

## ⚡ Option 2: Embedded build (for fast development iteration)

This mode directly compiles skat-core from source together with the application.
It is useful for scenarios where you:
* Frequently change core library code
* Need tight debugging integration
* Want to avoid package build delays

### Linux / macOS
```bash
$ cmake --preset ninja-embed
$ cmake --build --preset ninja-embed/release
```

### Windows / Visual Studio
```bash
$ cmake --preset vs-embed
$ cmake --build --preset vs-embed/release
```
