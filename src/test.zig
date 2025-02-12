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