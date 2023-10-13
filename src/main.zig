const std = @import("std");
const mem = @import("std").mem;

pub fn main() !void {
    // fillup zeroes the array
    var arr = mem.zeroes([5]u8);
    std.debug.print("{d}", .{arr,});
}
