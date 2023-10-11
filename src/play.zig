const std = @import("std");
const builtin = @import("std").builtin;

const mem = @import("std").mem;
const exp = @import("std").testing.expect;
const assrt = @import("std").debug.assert;

const message = &[_]u8{ 'h', 'e', 'e', 'y', 'y', 'y' };
const clone = "heeyyy";
comptime {
    assrt(message.len == 6);
    assrt(mem.eql(u8, message, clone));
}
test "strings" {
    var add_the_first_to_make_the_clone: usize = 0;
    for (message) |i| {
        add_the_first_to_make_the_clone += i;
    }
    try exp(add_the_first_to_make_the_clone == ('h' * 1 +
        'e' * 2 +
        'y' * 3));
}

// How to use structs

const Cart = struct {
    x: i32,
    y: i32,
    z: ?i4,

    fn get(self: Cart) Cart {
        return self;
    }
    fn swap(self: *Cart) void {
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};
test "well defined overflow"{
    var a: u8 = 255;
    a +%= 1;
    try exp(a == 0);
}
test "getter" {
    var data = Cart{ .x=10, .y=20, .z=null };
    var x = data.get();
    try exp(x.x == 10);
    try exp(x.y == 20);
    std.debug.print("z = {?}, (x, y) = ({d}, {d})\n",
                    .{data.z,
                      data.x,
                      data.y
                      });
    try exp(data.z == undefined);
}
test "auto deref" {
    var thng = Cart{ .x=10, .y=20, .z=null };
    thng.swap();
    try exp(thng.x == 20);
    try exp(thng.y == 10);
    try exp(thng.z == null);
    try exp(@TypeOf(thng.z.?) == i4);
    var sand: ?i4 = undefined;
    thng.z = sand;
    try exp(thng.z == sand);
}
test "** syntax (comptime arrays)" {
    const patt = [_]u8{ 0xCC, 0xAA };
    const memory = patt**3;
    try exp(mem.eql(u8,
                    &memory,
                    &[_]u8{0xCC, 0xAA,
                           0xCC, 0xAA,
                           0xCC, 0xAA}));
}
test "while optional"{
    var i: ?u32 = 10;
    while (i) |num| : (i.? -%= 2) {
        try exp(@TypeOf(num) == u32);
        if (num <= 1) {
            i = num;
            break;
        }
    }
    std.debug.print("{?} ", .{i,});
}
