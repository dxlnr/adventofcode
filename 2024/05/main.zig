const std = @import("std");

pub fn readf(filen: []const u8) ![]u8 {
    const f = try std.fs.cwd().openFile(filen, .{});
    defer f.close();

    return try f.readToEndAlloc(std.heap.page_allocator, std.math.maxInt(usize));
}

pub fn ruleset(s: []const u8) ![]u8 {
    var buf: [1024]u8 = [_]u8{0} ** 1024;
    var num: u8 = 0;

    var rules = std.mem.splitSequence(u8, s, "\n");
    var c: usize = 0;
    while (rules.next()) |r| {
        var ns = std.mem.splitSequence(u8, r[0..], "|");
        while (ns.next()) |n| {
            if (c >= buf.len) {
                return error.OutOfBounds;
            }
            num = try std.fmt.parseInt(u8, n, 10);
            buf[c] = num;
            c += 1;
        }
    }
    return buf[0..c];
}

pub fn main() !void {
    const filen: []const u8 = "example";

    const content = try readf(filen);
    defer std.heap.page_allocator.free(content);

    const delimiter: []const u8 = "\n\n";
    var seq = std.mem.splitSequence(u8, content[0..], delimiter);

    const rules = try ruleset(seq.first());

    // while (rules.next()) |part| {
    //     // std.debug.print("{d}: {s}\n", .{ counter, part }); // Correct usage of {s}
    // }
    const pages: []const u8 = seq.rest();

    std.debug.print("rules:\n{s}\n", .{rules});
    std.debug.print("page:\n{s}\n", .{pages});

    // while (pages.next()) |p| {

    //     var seq = std.mem.splitSequence(u8, content[0..], delimiter);
    //     while (std.mem.splitSequence(u8, p[0..], ",").next()) |n| {
    //     }
    //     // std.debug.print("{s}\n", .{p});
    //     // counter = counter + 1;
    // }

    // const gpa = general_purpose_allocator.allocator();

    // const f = try std.fs.cwd().openFile(filen, .{});
    // defer f.close();

    // var reader = std.io.bufferedReader(f.reader());
    // var stream = reader.reader();

    // var buf: [1024]u8 = undefined;
    // for (content) |c| {
    //     std.debug.print("{c}  (0x{x})\n", .{ c, c });
    // }
    // std.debug.print("File content:\n{s}\n", .{content});
}
