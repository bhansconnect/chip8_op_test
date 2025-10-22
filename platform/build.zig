const std = @import("std");
const builtin = @import("builtin");

fn mustUseLlvm(target: std.Build.ResolvedTarget) bool {
    return target.result.os.tag == .macos and target.result.cpu.arch == .x86_64;
}

fn configureBackend(step: *std.Build.Step.Compile, target: std.Build.ResolvedTarget) void {
    if (mustUseLlvm(target)) {
        step.use_llvm = true;
    }
}

pub fn build(b: *std.Build) void {
    const default_target_query: std.Target.Query = .{
        .abi = if (builtin.target.os.tag == .linux) .musl else null,
    };
    const target = b.standardTargetOptions(.{ .default_target = default_target_query });
    const optimize = b.standardOptimizeOption(.{});

    const roc = b.dependency("roc", .{
        .target = target,
        .optimize = optimize,
    });
    const roc_builtins = roc.module("builtins");

    // Figure out how to import roc builtins...
    // Build the native platform only.
    const host_lib = b.addLibrary(.{
        .name = "chip8_platform",
        .linkage = .static,
        .root_module = b.createModule(.{
            .root_source_file = b.path("host.zig"),
            .target = target,
            .optimize = optimize,
            .strip = true,
            .pic = true, // Enable Position Independent Code for PIE compatibility
        }),
    });
    configureBackend(host_lib, target);
    host_lib.root_module.addImport("builtins", roc_builtins);
    // Force bundle compiler-rt to resolve runtime symbols like __main
    host_lib.bundle_compiler_rt = true;

    // Copy the int test platform host library to the source directory
    const copy_host = b.addUpdateSourceFiles();
    const host_filename = if (target.result.os.tag == .windows) "host.lib" else "libhost.a";
    copy_host.addCopyFileToSource(host_lib.getEmittedBin(), b.pathJoin(&.{host_filename}));
    b.getInstallStep().dependOn(&copy_host.step);
}
