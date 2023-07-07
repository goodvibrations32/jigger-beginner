const builtin = @import("builtin");
const std = @import("std");

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
    // var buf: [std.fs.MAX_PATH_BYTES]u8 = undefined;
    // const some = try std.os.getenv(&buf);
    // std.debug.print("{}\n\n", .{some});

    // std.debug.print("where am at?!\n{s}\n\n", .{os_message});
    // var my_shit: i64 = 5;
    // var add_two: i64 = 2 + my_shit;
    // std.debug.print("print the sum of 5+2={}\n", .{add_two});

    // // let this uninitialized for now
    // var something: i32 = undefined;

    // // we do shit and then
    // // ....
    // // we put something there...
    // something = 4;
    // // now we can use it in some form...
    // const resultsss: i64 = add_two - something;
    // var func_res: i64 = adding(resultsss, something);

    // // stdout is for the actual output of your application, for example if you
    // // are implementing gzip, then only the compressed bytes should be sent to
    // // stdout, not any debugging messages.
    // const stdout_file = std.io.getStdOut().writer();
    // var bw = std.io.bufferedWriter(stdout_file);
    // const stdout = bw.writer();

    // try stdout.print("my result sould be 7 == {}\n\n", .{add_two});
    // try stdout.print(
    //     "what is happening if i do i64 - i32 shit [{d} - {d} = {d}] \nand revert with a adder function to 7 == {d}",
    //     .{add_two,
    //       something,
    //       resultsss,
    //       func_res });
    // try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}