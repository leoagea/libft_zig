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

//Return 2 if s1 is strictly equal to s2
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
    const cpy: [] u8 = try allocator.alloc(u8, str.len);
    @memcpy(cpy, str);
    return cpy;
}

pub fn bzero(s: [*]u8, n: usize) !void {
    var i: usize = 0;

    while (i < n) : (i += 1)
        s[i] = 0;
}

/////////Additional String functions
/////////not in libc

pub fn substr(allocator: mem, str: []const u8, start: usize, len: usize) ![] u8 {
    if (start >= str.len) return error.OutOfBounds;

    const sub_len = if (start + len > str.len) str.len - start else len;
    const sub: []u8 = try allocator.alloc(u8, sub_len);

    @memcpy(sub, str[start .. start + sub_len]);

    return sub;
}

pub fn strjoin(allocator: mem, s1: []const u8, s2: []const u8) ![] u8 {
    const join_len = s1.len + s2.len;

    var join: [] u8 = try allocator.alloc(u8, join_len);
    @memcpy(join[0..s1.len], s1);
    @memcpy(join[s1.len..], s2); 

    return join;
}

pub fn strtrim(allocator: mem, str: []const u8, charset: [] const u8) ![] u8 {
    var i: usize = 0;
    var j: usize = 0;
    var isset: bool = false;

    if (str.len == 0) return try allocator.alloc(u8, 0);

    while (i < str.len) : (i += 1){
        j = 0;
        isset = false;
        while (j < charset.len) : (j += 1) {
            if (str[i] == charset[j]){
                isset = true;
                break;
            }
        }
        if (isset == false)
            break;
    }
    const start: usize = i;

    if (start == str.len) return try allocator.alloc(u8, 0);
    
    i = str.len - 1;
    while (i > 0) : (i -= 1){
        j = 0;
        isset = false;
        while (j < charset.len) : (j += 1) {
            if (str[i] == charset[j]){
                isset = true;
                break;
            }
        }
        if (isset == false)
            break;
    }
    const end: usize = i + 1;

    const trim_len = end - start;
    if (trim_len == 0) return error.AllocByZeroLength;
    const trim: [] u8 = try allocator.alloc(u8, end - start);
    @memcpy(trim, str[start..end]);

    return trim;
}

pub fn split(allocator: std.mem.Allocator, str: []const u8, c: u8) ![][]u8 {
    var word_count: usize = 0;
    var i: usize = 0;

    while (i < str.len) : (i += 1) {
        if (str[i] == c) {
            while (i < str.len and str[i] == c) : (i += 1) {}
            if (i < str.len) word_count += 1;
        }
    }
    if (str.len > 0 and str[0] != c) word_count += 1;

    if (word_count == 0) return try allocator.alloc([]u8, 0);

    const res = try allocator.alloc([]u8, word_count);

    i = 0;
    var j: usize = 0;
    while (i < str.len) : (i += 1) {
        while (i < str.len and str[i] == c) : (i += 1) {}
        if (i >= str.len) break; // ✅ Éviter un dépassement
        const start: usize = i;
        while (i < str.len and str[i] != c) : (i += 1) {}
        const end: usize = i;

        res[j] = try allocator.alloc(u8, end - start);
        @memcpy(res[j], str[start..end]);
        j += 1;
    }

    return res;
}

/////////Additional Files functions

pub fn putchar_fd(file: std.fs.File, c: u8) !void {
    try file.writer().writeByte(c);
}

pub fn putstr_fd(file: std.fs.File, str: []const u8) !void {
    try file.writer().writeAll(str);
}

pub fn putendl_fd(file: std.fs.File, str: []const u8) !void {
    try putstr_fd(file, str ++ "\n");
}

pub fn putnbr_fd(file: std.fs.File, n: i64) !void {
    try file.writer().writeInt(i64, n, std.builtin.Endian.big);
}