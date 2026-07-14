const std = @import("std");

pub fn parseTaggedUnion(
    comptime Union: type,
    comptime Enum: type,
    allocator: std.mem.Allocator,
    source: anytype,
    options: std.json.ParseOptions,
) !Union {
    const enum_info = @typeInfo(Enum).@"enum";
    const union_info = @typeInfo(Union).@"union";

    comptime {
        if (union_info.field_names.len != enum_info.field_names.len)
            @compileError("Union and Enum must have the same number of fields.");
    }

    const value = try std.json.innerParse(std.json.Value, allocator, source, options);

    const type_str = switch (value) {
        .object => |object| switch (object.get("type") orelse return error.MissingField) {
            .string => |s| s,
            else => return error.UnexpectedToken,
        },
        else => return error.UnexpectedToken,
    };

    const tag = std.meta.stringToEnum(Enum, type_str) orelse return error.InvalidEnumTag;

    inline for (
        union_info.field_names,
        union_info.field_types,
        enum_info.field_values,
    ) |field_name, field_type, field_value| {
        const enum_value: Enum = @enumFromInt(field_value);

        if (tag == enum_value) {
            return @unionInit(
                Union,
                field_name,
                try std.json.innerParseFromValue(
                    field_type,
                    allocator,
                    value,
                    options,
                ),
            );
        }
    }

    unreachable;
}
