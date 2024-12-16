const std = @import("std");

pub fn readf(filen: []const u8) ![]u8 {
    const f = try std.fs.cwd().openFile(filen, .{});
    defer f.close();

    return try f.readToEndAlloc(std.heap.page_allocator, std.math.maxInt(usize));
}

pub fn main() !void {
    const filen: []const u8 = "example";

    const content = try readf(filen);
    defer std.heap.page_allocator.free(content);

    // const f = try std.fs.cwd().openFile(filen, .{});
    // defer f.close();

    // var reader = std.io.bufferedReader(f.reader());
    // var stream = reader.reader();

    // var buf: [1024]u8 = undefined;
    // for (content) |c| {
    //     std.debug.print("{c}  ({})\n", .{ c, c });
    // }
    std.debug.print("File content:\n{s}\n", .{content});
}
