const std = @import("std");
const lib = @import("lib.zig");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

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

// ✅ Test cases pour strlen
test "strlen" {
    try std.testing.expect(lib.strlen("") == 0);
    try std.testing.expect(lib.strlen("Hello") == 5);
}

// ✅ Test cases pour strchr
test "strchr" {
    try std.testing.expectEqual(null, lib.strchr("", 'e'));
    try std.testing.expectEqualStrings("Hello", lib.strchr("Hello", 'H').?);
    try std.testing.expectEqualStrings("ello", lib.strchr("Hello", 'e').?);
    try std.testing.expectEqualStrings("llo", lib.strchr("Hello", 'l').?);
    try std.testing.expectEqualStrings("o", lib.strchr("Hello", 'o').?);
}

// ✅ Test cases pour strrchr
test "strrchr" {
    try std.testing.expectEqual(null, lib.strrchr("", 'e'));
    try std.testing.expectEqualStrings("Hello", lib.strrchr("Hello", 'H').?);
    try std.testing.expectEqualStrings("ello", lib.strrchr("Hello", 'e').?);
    try std.testing.expectEqualStrings("lo", lib.strrchr("Hello", 'l').?);
    try std.testing.expectEqualStrings("o", lib.strrchr("Hello", 'o').?);
}

// ✅ Test cases pour strcmp
test "strcmp" {
    try std.testing.expectEqual(1, lib.strcmp("","e"));
    try std.testing.expectEqual(0, lib.strcmp("Hello","He"));
    try std.testing.expectEqual(1, lib.strcmp("He","Hello"));
    try std.testing.expectEqual(1, lib.strcmp("H","Hello"));
    try std.testing.expectEqual(2, lib.strcmp("Hello","Hello"));
    try std.testing.expectEqual(2, lib.strcmp("Hello World","Hello World"));
    try std.testing.expectEqual(1, lib.strcmp("Hello","abcd"));
}

// // ✅ Test cases pour atoi
test "atoi" {
    try std.testing.expectEqual(lib.atoi("42"), 42);
    try std.testing.expectEqual(lib.atoi("   123"), 123);
    try std.testing.expectEqual(lib.atoi("-789"), -789);
    try std.testing.expectEqual(lib.atoi("+456"), 456);
    try std.testing.expectEqual(lib.atoi("2147483647"), 2147483647); // max i32
    try std.testing.expectEqual(lib.atoi("-2147483648"), -2147483648); // min i32
    try std.testing.expectEqual(lib.atoi("9999999999"), 9999999999);
    try std.testing.expectEqual(lib.atoi("-9999999999"), -9999999999);
    try std.testing.expectEqual(lib.atoi("999999999999999999999999999999999999999999999999"), error.Overflow); // overflow
    try std.testing.expectEqual(lib.atoi("-99999999999999999999999999999999999999999999999"), error.Overflow); // underflow
    try std.testing.expectEqual(lib.atoi("42abc"), 42); // Ignore les caractères après les chiffres
    try std.testing.expectEqual(lib.atoi(""), 0); // Retourne 0 si la chaîne est vide
}

// // ✅ Test cases pour strnstr
test "strnstr" {
    try std.testing.expectEqualStrings("World", try lib.strnstr("Hello World", "World", 11));
    try std.testing.expectEqualStrings("Hello World All", try lib.strnstr("Hello World All", "", 10));
    try std.testing.expectEqualStrings("Hello World", try lib.strnstr("Hello World", "Hello", 5));
    try std.testing.expectError(error.NotFound, lib.strnstr("Hello World", "World", 5));
}

// // ✅ Test cases pour strdup
test "strdup" {
    try std.testing.expectEqualStrings("Hello World", try lib.strdup(allocator, "Hello World"));
    try std.testing.expectEqualStrings("Hello World All", try lib.strdup(allocator, "Hello World All"));
    try std.testing.expectEqualStrings("Hello", try lib.strdup(allocator, "Hello"));
}

// // ✅ Test cases pour bzero
test "bzero" {
    var buffer: [5]u8 = [_]u8{1, 2, 3, 4, 5};
    try lib.bzero(&buffer, 3); 

    try std.testing.expectEqual(0, buffer[0]); 
    try std.testing.expectEqual(0, buffer[1]); 
    try std.testing.expectEqual(0, buffer[2]); 
    try std.testing.expectEqual(4, buffer[3]); 
    try std.testing.expectEqual(5, buffer[4]); 
}

// // ✅ Test cases pour substr
test "substr" {
    try std.testing.expectEqualStrings("World", try lib.substr(allocator, "Hello World", 6, 5));
    try std.testing.expectEqualStrings("Hello World", try lib.substr(allocator, "Hello World All", 0, 11));
    try std.testing.expectEqualStrings("ell", try lib.substr(allocator, "Hello", 1, 3));
}

// // ✅ Test cases pour strjoin
test "strjoin" {
    try std.testing.expectEqualStrings("Hello World", try lib.strjoin(allocator, "Hello", " World"));
    try std.testing.expectEqualStrings("Hello World All", try lib.strjoin(allocator, "Hello World", " All"));
    try std.testing.expectEqualStrings("Hello", try lib.strjoin(allocator, "Hello", ""));
    try std.testing.expectEqualStrings("World", try lib.strjoin(allocator, "", "World"));
}

// // ✅ Test cases pour strtrim
test "strtrim" {
    try std.testing.expectEqualStrings("Hello", try lib.strtrim(allocator, "  Hello  ", " "));
    try std.testing.expectEqualStrings("Hello", try lib.strtrim(allocator, "  abHellocd  ", " abcd"));
    try std.testing.expectEqualStrings("Hello", try lib.strtrim(allocator, "\t  Hello  \n", " \t\n"));
    try std.testing.expectEqualStrings("", try lib.strtrim(allocator, "", " \t\n"));

}
