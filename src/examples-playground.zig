//! =================== .... playground for .... ================================
//! stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff
//! stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff
//! stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff
const std = @import("std");

fn adding(a: i64, b: i64) i64 {
    return a + b;
}

pub fn main() !void {

    var my_shit: i64 = 5;
    var add_two: i64 = 2 + my_shit;
    std.debug.print("\nprint the sum of 5+2={}\n", .{add_two});

    // let this uninitialized for now
    var something: i32 = undefined;

    // we do shit and then
    // ....
    // we put something there...
    something = 4;
    // now we can use it in some form...
    const resultsss: i64 = add_two - something;
    var func_res: i64 = adding(resultsss, something);

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("my result sould be 7 == {}\n\n", .{add_two});
    try stdout.print(
        "what is happening if i do i64 - i32 shit [{d} - {d} = {d}] \nand revert with a adder function to 7 == {d}",
        .{add_two,
          something,
          resultsss,
          func_res });
    try bw.flush(); // don't forget to flush!
}
test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
