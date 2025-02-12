const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{}); // Gère la cible (native, x86_64, etc.)
    const optimize = b.standardOptimizeOption(.{}); // Permet Debug, ReleaseSafe, etc.

    // 📌 Création d'une bibliothèque statique
    const lib = b.addStaticLibrary(.{
        .name = "mylib",
        .root_source_file = .{ .cwd_relative = "src/lib.zig" },
        .target = target,
        .optimize = optimize,
    });

    // 📌 Installation de la bibliothèque compilée
    b.installArtifact(lib);
}
