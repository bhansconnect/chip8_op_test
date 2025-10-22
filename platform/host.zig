//! Simple platform host that calls into a simplified Roc entrypoint with two integers and prints the result.

const std = @import("std");
const builtins = @import("builtins");

/// Host environment - contains our arena allocator
const HostEnv = struct {
    arena: std.heap.ArenaAllocator,
};

/// Roc allocation function
fn rocAllocFn(roc_alloc: *builtins.host_abi.RocAlloc, env: *anyopaque) callconv(.c) void {
    const host: *HostEnv = @ptrCast(@alignCast(env));
    const allocator = host.arena.allocator();

    const log2_align = std.math.log2_int(u32, @intCast(roc_alloc.alignment));
    const align_enum: std.mem.Alignment = @enumFromInt(log2_align);

    const result = allocator.rawAlloc(roc_alloc.length, align_enum, @returnAddress());

    roc_alloc.answer = result orelse {
        @panic("Host allocation failed");
    };
}

/// Roc deallocation function
fn rocDeallocFn(roc_dealloc: *builtins.host_abi.RocDealloc, env: *anyopaque) callconv(.c) void {
    _ = roc_dealloc;
    _ = env;
    // NoOp as our arena frees all memory at once
}

/// Roc reallocation function
fn rocReallocFn(roc_realloc: *builtins.host_abi.RocRealloc, env: *anyopaque) callconv(.c) void {
    _ = roc_realloc;
    _ = env;
    @panic("Realloc not implemented in this example");
}

/// Roc debug function
fn rocDbgFn(roc_dbg: *const builtins.host_abi.RocDbg, env: *anyopaque) callconv(.c) void {
    _ = env;
    const message = roc_dbg.utf8_bytes[0..roc_dbg.len];
    std.debug.print("ROC DBG: {s}\n", .{message});
}

/// Roc expect failed function
fn rocExpectFailedFn(roc_expect: *const builtins.host_abi.RocExpectFailed, env: *anyopaque) callconv(.c) void {
    _ = env;
    const message = roc_expect.utf8_bytes[0..roc_expect.len];
    std.debug.print("ROC EXPECT FAILED: {s}\n", .{message});
}

/// Roc crashed function
fn rocCrashedFn(roc_crashed: *const builtins.host_abi.RocCrashed, env: *anyopaque) callconv(.c) noreturn {
    _ = env;
    const message = roc_crashed.utf8_bytes[0..roc_crashed.len];
    @panic(message);
}

// External symbols provided by the Roc runtime object file
// Follows RocCall ABI: ops, ret_ptr, then argument pointers
const Ret = extern struct {};
extern fn roc__runIters(ops: *builtins.host_abi.RocOps, ret_ptr: *Ret, arg_ptr: *const u64) callconv(.c) void;

// OS-specific entry point handling
comptime {
    // Export main for all platforms
    @export(&main, .{ .name = "main" });

    // Windows MinGW/MSVCRT compatibility: export __main stub
    if (@import("builtin").os.tag == .windows) {
        @export(&__main, .{ .name = "__main" });
    }
}

// Windows MinGW/MSVCRT compatibility stub
// The C runtime on Windows calls __main from main for constructor initialization
fn __main() callconv(.c) void {}

// C compatible main for runtime
fn main(argc: c_int, argv: [*][*:0]u8) callconv(.c) c_int {
    _ = argc;
    _ = argv;
    platform_main() catch |err| {
        std.fs.File.stderr().deprecatedWriter().print("HOST ERROR: {s}", .{@errorName(err)}) catch unreachable;
        return 1;
    };
    return 0;
}

/// Platform host entrypoint -- this is where the roc application starts and does platform things
/// before the platform calls into Roc to do application-specific things.
fn platform_main() !void {
    var host_env = HostEnv{
        .arena = std.heap.ArenaAllocator.init(std.heap.page_allocator),
    };
    defer host_env.arena.deinit(); // Clean up all allocations on exit

    const stdout = std.fs.File.stdout().deprecatedWriter();

    try stdout.print("Starting Host\n", .{});

    // Create the RocOps struct
    var roc_ops = builtins.host_abi.RocOps{
        .env = @as(*anyopaque, @ptrCast(&host_env)),
        .roc_alloc = rocAllocFn,
        .roc_dealloc = rocDeallocFn,
        .roc_realloc = rocReallocFn,
        .roc_dbg = rocDbgFn,
        .roc_expect_failed = rocExpectFailedFn,
        .roc_crashed = rocCrashedFn,
        .host_fns = undefined, // No host functions for this simple example
    };

    // TODO: read from args.
    const iters: u64 = 10;
    var result: Ret = .{};

    try stdout.print("Launching Roc\n", .{});
    roc__runIters(&roc_ops, &result, &iters);
    try stdout.print("Done with result: {}\n", .{result});
}
