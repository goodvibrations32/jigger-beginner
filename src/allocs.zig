const std = @import("std");
const expct = std.testing.expect;

test "alloc" {
    const alloc = std.heap.page_allocator;

    // allocation of 100 bytes as []u8
    const memory = try alloc.alloc(u8, 100);
    // zig feeing patern
    defer alloc.free(memory);

    try expct(memory.len == 100);
    try expct(@TypeOf(memory) == []u8);
}
test "arena alloc" {
    // allocate many times (var) but free ONCE!!
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // used to free all memory after execution...??
    defer arena.deinit();

    const alloc = arena.allocator();
    _ = try alloc.alloc(u8, 1);
    _ = try alloc.alloc(u8, 100);
    var @"_" = try alloc.alloc(u8, 1000);
    std.debug.print("lendth is {d} ", .{@"_".len,
                                        });
}
test "single item allocation" {
    const b = try std.heap.page_allocator.create(u8);
    defer std.heap.page_allocator.destroy(b);
    b.* = 128;
}
test "gp case" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloctr = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) (expct(false)
                                         catch @panic(
                                             "Test failed"
        ));
    }
    const bts = try alloctr.alloc(u8, 100);
    defer alloctr.free(bts);
}

fn ticker(step: u8) void {
    while (true) {
        std.time.sleep(1 * std.time.ns_per_s);
        tick += @as(isize, step);
    }
}
var tick: isize = 0;

test "Threads for my first time" {
    var thrd = try std.Thread.spawn(.{}, ticker, .{@as(u8, 1)});
    std.debug.print("threads on system: {!} \n {d}",
                    .{std.Thread.getCpuCount(),
                      std.Thread.getCurrentId()});

    _ = thrd;
    try expct(tick == 0);
    std.time.sleep(2 * std.time.ns_per_s / 2);
    std.debug.print("\n{d} ", .{tick,});

}
