//! =================== Main entrance for now... ================================
//! This script aims to gather information from the system is running on.
//! Zig allows for cross-platform executions and may handling some situations
//! better than other system languages for embedding to micro-processors.
const std = @import("std");
const builtin = @import("builtin");

const os_message = switch (builtin.target.os.tag) {
    .linux => "GNU/linux",
    .windows => "Windows OS, install linux please",
    else => @panic(std.PackedIntArray),
};

const kernel_info = switch (std.mem.eql(u8, os_message, "GNU/linux")){
    true => builtin
        .target
        .os
        .version_range
        .linux
        .range
        .max,
    false => builtin
        .target
        .os
        .version_range
        .windows
        .range
        .max
};

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("\n\nAll your {s} are belong to us.\n~~~~\n", .{"codebase"});

    std.debug.print("OS info: {s}\nKernel version: {}\n~~~~\n", .{
        os_message,
        kernel_info
    });

    // cwd from std lib
    var buffer: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    const cwd = try std.os.getcwd(&buffer);
    std.debug.print("Current working dir: \n{s}\n~~~~\n", .{cwd});
}
