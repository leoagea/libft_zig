const std = @import("std");
const mem = std.mem.Allocator;
/////////Char functions

const alpha_table = blk: {
    var table: [256]bool = [_]bool{false} ** 256;
    var i: usize = 'A';
    while (i <= 'Z') : (i += 1) table[i] = true;
    i = 'a';
    while (i <= 'z') : (i += 1) table[i] = true;
    break :blk table;
};

const digit_table = blk: {
    var table: [256]bool = [_]bool{false} ** 256;
    var i: usize = '0';
    while (i <= '9') : (i += 1) table[i] = true;
    break :blk table;
};

const alnum_table = blk: {
    var table: [256]bool = [_]bool{false} ** 256;
    var i: usize = 'A';
    while (i <= 'Z') : (i += 1) table[i] = true;
    i = 'a';
    while (i <= 'z') : (i += 1) table[i] = true;
    i = '0';
    while (i <= '9') : (i += 1) table[i] = true;
    break :blk table;
};

const print_table = blk: {
    var table: [256]bool = [_]bool{false} ** 256;
    var i: usize = 32;
    while (i <= 126) : (i += 1) table[i] = true;
    break :blk table;
};

pub fn isalpha(c: u8) bool {
    return alpha_table[c];
}

pub fn isdigit(c: u8) bool{
    return digit_table[c];
}

pub fn isalnum(c: u8) bool{
    return alnum_table[c];
}

pub fn isascii(c: u8) bool{
    return (c & @as(u8, ~@as(u8, 0x7f))) == 0;
}

pub fn isprint(c: u8) bool {
    return print_table[c];
}

pub fn toupper(c: u8) u8 {
    return c | @as(u8, 0x20) * @intFromBool(c >= 'a' and c <= 'z');
}

pub fn tolower(c: u8) u8 {
    return c | @as(u8, 0x20) * @intFromBool(c >= 'A' and c <= 'Z');
}

/////////String functions

pub fn strlen(str: []const u8) usize {
    return str.len;
}

pub fn strchr(str: []const u8, c: u8) ?[]const u8 {
    for (str, 0..) |ch, i|
        if (ch == c) 
            return str[i..];

    return null;
}

pub fn strrchr(str: []const u8, c: u8) ?[]const u8 {
    if (str.len == 0) return null;
    var i = str.len - 1;

    while (i >= 0) : (i -= 1){
        if (str[i] == c)
            return str[i..];
    }

    return null;
}

pub fn strcmp(s1: []const u8, s2: []const u8) i8 {
    return @intFromEnum(std.mem.order(u8, s1, s2));
}

//Return integer from string, return error.Overflow if overflow happend
pub fn atoi(s: []const u8) !i64 {
    var i: usize = 0;
    var result: i128 = 0;
    var sign: i32 = 1;
    var overflow: i128 = 0;

    while (i < s.len and s[i] == ' ') : (i += 1) {}

    if (i < s.len and (s[i] == '-' or s[i] == '+')) {
        if (s[i] == '-')
            sign = -1;
        i += 1;
    }

    while (i < s.len and s[i] >= '0' and s[i] <= '9') : (i += 1) {
        const digit: i32 = @intCast(s[i] - '0');

        if (overflow > std.math.maxInt(i64)) {
                return error.Overflow;
        }
        result = result * 10 + digit;
        overflow = result;
    }

    return @intCast(result * sign);
}

pub fn strnstr(str: []const u8, to_find: []const u8, n: usize) ![]const u8 {
    if (to_find.len == 0) return str;

    var i: usize = 0;
    while (i < n and i + to_find.len <= str.len) : (i += 1) {
        if (str[i] == to_find[0]) {
            var j: usize = 0;
            while (j < to_find.len and i + j < n and str[i + j] == to_find[j]) : (j += 1) {}

            if (j == to_find.len) return str[i..];
        }
    }
    return error.NotFound;
}

pub fn strdup(allocator: std.mem.Allocator, str: []const u8) ![] u8 {
    const cpy = try mem.alloc(allocator, u8, str.len);
    @memcpy(cpy, str);
    return cpy;
}

pub fn bzero(s: [*]u8, n: usize) !void {
    var i: usize = 0;

    while (i < n) : (i += 1)
        s[i] = 0;
}