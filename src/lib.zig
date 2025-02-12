const std = @import("std");

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