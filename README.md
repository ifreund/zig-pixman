# zig-pixman

[zig](https://ziglang.org/) 0.14 bindings for
[pixman](https://gitlab.freedesktop.org/pixman/pixman) that are a little
nicer to use than the output of `zig translate-c`.

The main repository is on [codeberg](https://codeberg.org/ifreund/zig-pixman),
which is where the issue tracker may be found and where contributions are accepted.

Read-only mirrors exist on [sourcehut](https://git.sr.ht/~ifreund/zig-pixman)
and [github](https://github.com/ifreund/zig-pixman).

## Versioning

For now, zig-pixman versions are of the form `0.major.patch`. A major version
bump indicates a zig-pixman release that breaks API or requires a newer Zig
version to build. A patch version bump indicates a zig-pixman release that is
fully backwards compatible.

For unreleased versions, the `-dev` suffix is used (e.g. `0.1.0-dev`).

The version of zig-pixman currently has no direct relation to the upstream
pixman version supported.

Breaking changes in zig-pixman's API will be necessary until a stable Zig 1.0
version is released, at which point I plan to switch to a new versioning scheme
and start the version numbers with `1` instead of `0`.

