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
fn adding(a: i64, b: i64) i64 {
    return a + b;
}

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
