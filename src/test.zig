const std = @import("std");
const lib = @import("lib.zig");

// ✅ Test cases pour isalpha
test "isalpha" {
    try std.testing.expect(lib.isalpha('A') == true);
    try std.testing.expect(lib.isalpha('z') == true);
    try std.testing.expect(lib.isalpha('5') == false);
    try std.testing.expect(lib.isalpha('!') == false);
    try std.testing.expect(lib.isalpha('m') == true);
    try std.testing.expect(lib.isalpha('G') == true);
    try std.testing.expect(lib.isalpha(' ') == false);
    try std.testing.expect(lib.isalpha('1') == false);
    try std.testing.expect(lib.isalpha('\t') == false);
}

// ✅ Test cases pour isdigit
test "isdigit" {
    try std.testing.expect(lib.isdigit('\t') == false);
    try std.testing.expect(lib.isdigit('A') == false);
    try std.testing.expect(lib.isdigit('z') == false);
    try std.testing.expect(lib.isdigit('!') == false);
    try std.testing.expect(lib.isdigit('m') == false);
    try std.testing.expect(lib.isdigit('G') == false);
    try std.testing.expect(lib.isdigit(' ') == false);
    try std.testing.expect(lib.isdigit('0') == true);
    try std.testing.expect(lib.isdigit('1') == true);
    try std.testing.expect(lib.isdigit('5') == true);
    try std.testing.expect(lib.isdigit('9') == true);
}

// ✅ Test cases pour isalnum
test "isalnum" {
    try std.testing.expect(lib.isalnum('\t') == false);
    try std.testing.expect(lib.isalnum('A') == true);
    try std.testing.expect(lib.isalnum('z') == true);
    try std.testing.expect(lib.isalnum('!') == false);
    try std.testing.expect(lib.isalnum('m') == true);
    try std.testing.expect(lib.isalnum('G') == true);
    try std.testing.expect(lib.isalnum(' ') == false);
    try std.testing.expect(lib.isalnum('0') == true);
    try std.testing.expect(lib.isalnum('1') == true);
    try std.testing.expect(lib.isalnum('5') == true);
    try std.testing.expect(lib.isalnum('9') == true);
}

// ✅ Test cases pour isascii
test "isascii" {
    try std.testing.expect(lib.isascii('\t') == true);
    try std.testing.expect(lib.isascii('A') == true);
    try std.testing.expect(lib.isascii('z') == true);
    try std.testing.expect(lib.isascii('!') == true);
    try std.testing.expect(lib.isascii('m') == true);
    try std.testing.expect(lib.isascii('G') == true);
    try std.testing.expect(lib.isascii(' ') == true);
    try std.testing.expect(lib.isascii('0') == true);
    try std.testing.expect(lib.isascii('1') == true);
    try std.testing.expect(lib.isascii('5') == true);
    try std.testing.expect(lib.isascii('9') == true);
    try std.testing.expect(lib.isascii(127) == true);
    try std.testing.expect(lib.isascii(128) == false);
    try std.testing.expect(lib.isascii(190) == false);
    try std.testing.expect(lib.isascii(255) == false);
}

// ✅ Test cases pour isprint
test "isprint" {
    try std.testing.expect(lib.isprint(0) == false);
    try std.testing.expect(lib.isprint(31) == false);
    try std.testing.expect(lib.isprint(32) == true);
    try std.testing.expect(lib.isprint(42) == true);
    try std.testing.expect(lib.isprint(126) == true);
    try std.testing.expect(lib.isprint(127) == false);
    try std.testing.expect(lib.isprint(255) == false);
}

// ✅ Test cases pour toupper
test "toupper" {
    try std.testing.expect(lib.toupper(0) == 0);
    try std.testing.expect(lib.toupper(42) == 42);
    try std.testing.expect(lib.toupper('A') == 'A');
    try std.testing.expect(lib.toupper('Z') == 'Z');
    try std.testing.expect(lib.toupper(91) == 91);
    try std.testing.expect(lib.toupper('a') == 'a');
    try std.testing.expect(lib.toupper('z') == 'z');
    try std.testing.expect(lib.toupper(255) == 255);
}

// ✅ Test cases pour tolower
test "tolower" {
    try std.testing.expect(lib.tolower(0) == 0);
    try std.testing.expect(lib.tolower(42) == 42);
    try std.testing.expect(lib.tolower('A') == 'a');
    try std.testing.expect(lib.tolower('Z') == 'z');
    try std.testing.expect(lib.tolower(91) == 91);
    try std.testing.expect(lib.tolower('a') == 'a');
    try std.testing.expect(lib.tolower('z') == 'z');
    try std.testing.expect(lib.tolower(255) == 255);
}