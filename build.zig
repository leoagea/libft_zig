const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{}); // Gère la cible (native, x86_64, etc.)
    const optimize = b.standardOptimizeOption(.{}); // Permet Debug, ReleaseSafe, etc.

    // 📌 Création d'une bibliothèque statique
    const lib = b.addStaticLibrary(.{
        .name = "libft_zig",
        .root_source_file = .{ .cwd_relative = "src/lib.zig" },
        .target = target,
        .optimize = optimize,
    });

    // 📌 Installation de la bibliothèque compilée
    b.installArtifact(lib);


    // 📌 Création et exécution des tests
    const test_exe = b.addTest(.{
        .root_source_file = .{ .cwd_relative = "src/test.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_tests = b.addRunArtifact(test_exe);
    b.step("test", "Run tests").dependOn(&run_tests.step);

}
