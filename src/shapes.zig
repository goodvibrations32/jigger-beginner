const std = @import("std");

const tag = enum {mm, cm, m, km};
const MeasUnit = union(tag) {
    mm: bool,
    cm: bool,
    m: bool,
    km: bool,
};
const Shape = struct {
    width: f64,
    height: f64,
    depth: f64 = undefined,

    fn calcArea (self: *Shape, d3: bool) f64 {
        var area = switch (d3) {
            true => self.width * self.height * self.depth,
            false => self.width * self.height,
        };return area;
    }
    fn getSideDim (self: *Shape, unit: MeasUnit) *Shape {
        var  dimentions_from_meters = switch (unit) {
            .mm => self.multi(Shape{.width=1e3, .height=1e3, .depth=1e3}),
            .cm => self.multi(Shape{.width=1e2, .height=1e2, .depth=1e2}),
            .m => self.multi(Shape{.width=1e0, .height=1e0, .depth=1e0}),
            .km => self.multi(Shape{.width=1e-3, .height=1e-3, .depth=1e-3}),
        };
        return dimentions_from_meters;
    }
    fn multi (self: *Shape, other: Shape) *Shape {
        self.width = self.width * other.width;
        self.height = self.height * other.height;
        self.depth = self.depth * other.depth;
        return self;
    }
};

pub fn main () !void {
    const unary = Shape { .width=1, .height=1 };
    var rectangle = Shape { .width=1, .height=1 };
    const dim = MeasUnit{.cm=true};
    std.debug.print("multiply 2 shapes (unary)\n{}", .{rectangle.multi(unary)});
    std.debug.print("\nfrom meters to centimeters\n{}\nunit:{}",
                    .{rectangle.getSideDim(dim), dim});

    var rect = Shape { .width=1, .height=1 };
    std.debug.print("\n2D area = {} {}^2 ", .{rect.calcArea(false),
                                              dim});

}
