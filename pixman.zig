pub const Bool = c_int;

pub const Fixed_32_32 = extern enum(i64) { _ };
pub const Fixed_48_16 = extern enum(i64) { _ };
pub const Fixed_1_31 = extern enum(u32) { _ };
pub const Fixed_1_16 = extern enum(u32) { _ };
pub const Fixed_16_16 = extern enum(i32) { _ };
pub const Fixed = Fixed_16_16;

pub const PointFixed = extern struct {
    x: Fixed,
    y: Fixed,
};

pub const LineFixed = extern struct {
    p1: PointFixed,
    p2: PointFixed,
};

pub const Vector = extern struct {
    vector: [3]Fixed,
};

pub const Transform = extern struct {
    matrix: [3][3]Fixed,

    extern fn pixman_transform_init_identity(matrix: *Transform) void;
    pub const initIdentity = pixman_transform_init_identity;

    extern fn pixman_transform_point_3d(transform: *const Transform, vector: *Vector) Bool;
    pub const point3d = pixman_transform_point_3d;

    extern fn pixman_transform_point(transform: *const Transform, vector: *Vector) Bool;
    pub const point = pixman_transform_point;

    extern fn pixman_transform_multiply(dst: *Transform, l: *const Transform, r: *const Transform) Bool;
    pub const multiply = pixman_transform_multiply;

    extern fn pixman_transform_init_scale(t: *Transform, sx: Fixed, sy: Fixed) void;
    pub const initScale = pixman_transform_init_scale;

    extern fn pixman_transform_scale(forward: *Transform, reverse: *Transform, sx: Fixed, sy: Fixed) Bool;
    pub const scale = pixman_transform_scale;

    extern fn pixman_transform_init_rotate(t: *Transform, cos: Fixed, sin: Fixed) void;
    pub const initRotate = pixman_transform_init_rotate;

    extern fn pixman_transform_rotate(forward: *Transform, reverse: *Transform, c: Fixed, s: Fixed) Bool;
    pub const rotate = pixman_transform_rotate;

    extern fn pixman_transform_init_translate(t: *Transform, tx: Fixed, ty: Fixed) void;
    pub const initTranslate = pixman_transform_init_translate;

    extern fn pixman_transform_translate(forward: *Transform, reverse: *Transform, tx: Fixed, ty: Fixed) Bool;
    pub const translate = pixman_transform_translate;

    extern fn pixman_transform_bounds(matrix: *const Transform, b: *Box16) Bool;
    pub const bounds = pixman_transform_bounds;

    extern fn pixman_transform_invert(dst: *Transform, src: *const Transform) Bool;
    pub const invert = pixman_transform_invert;

    extern fn pixman_transform_is_identity(t: *const Transform) Bool;
    pub const isIdentity = pixman_transform_is_identity;

    extern fn pixman_transform_is_scale(t: *const Transform) Bool;
    pub const isScale = pixman_transform_is_scale;

    extern fn pixman_transform_is_int_translate(t: *const Transform) Bool;
    pub const isIntTranslate = pixman_transform_is_int_translate;

    extern fn pixman_transform_is_inverse(a: *const Transform, b: *const Transform) Bool;
    pub const isInverse = pixman_transform_is_inverse;

    extern fn pixman_transform_from_pixman_f_transform(t: *Transform, ft: *const FTransform) Bool;
    pub const fromFTransform = pixman_transform_from_pixman_f_transform;
};

pub const FVector = extern struct {
    vector: [3]f64,
};

pub const FTransform = extern struct {
    matrix: [3][3]f64,

    extern fn pixman_f_transform_from_pixman_transform(ft: *FTransform, t: *const Transform) void;
    pub const fromPixmanTransform = pixman_f_transform_from_pixman_transform;

    extern fn pixman_f_transform_invert(dst: *FTransform, src: *const FTransform) Bool;
    pub const invert = pixman_f_transform_invert;

    extern fn pixman_f_transform_point(t: *const FTransform, v: FVector) Bool;
    pub const point = pixman_f_transform_point;

    extern fn pixman_f_transform_point_3d(t: *const FTransform, v: FVector) void;
    pub const point3d = pixman_f_transform_point_3d;

    extern fn pixman_f_transform_multiply(dst: *FTransform, l: *const FTransform, r: *const FTransform) void;
    pub const multiply = pixman_f_transform_multiply;

    extern fn pixman_f_transform_init_scale(t: *FTransform, sx: f64, sy: f64) void;
    pub const initScale = pixman_f_transform_init_scale;

    extern fn pixman_f_transform_scale(forward: *FTransform, reverse: *FTransform, sx: f64, sy: f64) Bool;
    pub const scale = pixman_f_transform_scale;

    extern fn pixman_f_transform_init_rotate(t: *FTransform, cos: f64, sin: f64) void;
    pub const initRotate = pixman_f_transform_init_rotate;

    extern fn pixman_f_transform_rotate(forward: *FTransform, reverse: *FTransform, c: f64, s: f64) Bool;
    pub const rotate = pixman_f_transform_rotate;

    extern fn pixman_f_transform_init_translate(t: *FTransform, tx: f64, ty: f64) void;
    pub const initTranslate = pixman_f_transform_init_translate;

    extern fn pixman_f_transform_translate(forward: *FTransform, reverse: *FTransform, tx: f64, ty: f64) Bool;
    pub const translate = pixman_f_transform_translate;

    extern fn pixman_f_transform_bounds(t: *const FTransform, b: *Box16) Bool;
    pub const bounds = pixman_f_transform_bounds;

    extern fn pixman_f_transform_init_identity(t: *FTransform) void;
    pub const initIdentity = pixman_f_transform_init_identity;
};

pub const RegionOverlap = extern enum {
    out,
    in,
    part,
};

pub const Region16Data = extern struct {
    size: c_long,
    num_rects: c_long,
    // In memory but not explicity declared
    //rects: [size]Box16,
};

pub const Rectangle16 = extern struct {
    x: i16,
    y: i16,
    width: u16,
    height: u16,
};

pub const Box16 = extern struct {
    x1: i16,
    y1: i16,
    x2: i16,
    y2: i16,
};

pub const Region16 = extern struct {
    extents: Box16,
    data: ?*Region16Data,

    extern fn pixman_region_init(region: *Region16) void;
    pub const init = pixman_region_init;

    extern fn pixman_region_init_rect(region: *Region16, x: c_int, y: c_int, width: c_uint, height: c_uint) void;
    pub const initRect = pixman_region_init_rect;

    extern fn pixman_region_init_rects(region: *Region16, boxes: *const Box16, count: c_int) Bool;
    pub const initRects = pixman_region_init_rects;

    extern fn pixman_region_init_with_extents(region: *Region16, extents: *Box16) void;
    pub const initWithExtents = pixman_region_init_with_extents;

    // TODO
    extern fn pixman_region_init_from_image(region: *Region16, image: ?*Image) void;
    pub const initFromImage = pixman_region_init_from_image;

    extern fn pixman_region_fini(region: *Region16) void;
    pub const fini = pixman_region_fini;

    extern fn pixman_region_translate(region: *Region16, x: c_int, y: c_int) void;
    pub const translate = pixman_region_translate;

    extern fn pixman_region_copy(dest: *Region16, source: *Region16) Bool;
    pub const copy = pixman_region_copy;

    extern fn pixman_region_intersect(new_reg: *Region16, reg1: *Region16, reg2: *Region16) Bool;
    pub const intersect = pixman_region_intersect;

    extern fn pixman_region_union(new_reg: *Region16, reg1: *Region16, reg2: *Region16) Bool;
    pub const @"union" = pixman_region_union;

    extern fn pixman_region_union_rect(dest: *Region16, source: *Region16, x: c_int, y: c_int, width: c_uint, height: c_uint) Bool;
    pub const unionRect = pixman_region_union_rect;

    extern fn pixman_region_intersect_rect(dest: *Region16, source: *Region16, x: c_int, y: c_int, width: c_uint, height: c_uint) Bool;
    pub const intersectRect = pixman_region_intersect_rect;

    extern fn pixman_region_subtract(reg_d: *Region16, reg_m: *Region16, reg_s: *Region16) Bool;
    pub const subtract = pixman_region_subtract;

    extern fn pixman_region_inverse(new_reg: *Region16, reg1: *Region16, inv_rect: *Box16) Bool;
    pub const inverse = pixman_region_inverse;

    extern fn pixman_region_contains_point(region: *Region16, x: c_int, y: c_int, box: *Box16) Bool;
    pub const containsPoint = pixman_region_contains_point;

    extern fn pixman_region_contains_rectangle(region: *Region16, prect: *Box16) RegionOverlap;
    pub const containsRectangle = pixman_region_contains_rectangle;

    extern fn pixman_region_not_empty(region: *Region16) Bool;
    pub const notEmpty = pixman_region_not_empty;

    extern fn pixman_region_extents(region: *Region16) *Box16;
    pub const extents = pixman_region_extents;

    extern fn pixman_region_n_rects(region: *Region16) c_int;
    pub const nRects = pixman_region_n_rects;

    extern fn pixman_region_rectangles(region: *Region16, n_rects: *c_int) *Box16;
    pub const rectangles = pixman_region_rectangles;

    extern fn pixman_region_equal(region1: *Region16, region2: *Region16) Bool;
    pub const equal = pixman_region_equal;

    extern fn pixman_region_selfcheck(region: *Region16) Bool;
    pub const selfcheck = pixman_region_selfcheck;

    extern fn pixman_region_reset(region: *Region16, box: *Box16) void;
    pub const reset = pixman_region_reset;

    extern fn pixman_region_clear(region: *Region16) void;
    pub const clear = pixman_region_clear;
};

pub const Region32Data = extern struct {
    size: c_long,
    num_rects: c_long,
    // In memory but not explicity declared
    //rects: [size]Box32,
};

pub const Rectangle32 = extern struct {
    x: i32,
    y: i32,
    width: u32,
    height: u32,
};

pub const Box32 = extern struct {
    x1: i32,
    y1: i32,
    x2: i32,
    y2: i32,
};

pub const Region32 = extern struct {
    extents: Box32,
    data: ?*Region32Data,

    extern fn pixman_region32_init(region: *Region32) void;
    pub const init = pixman_region32_init;

    extern fn pixman_region32_init_rect(region: *Region32, x: c_int, y: c_int, width: c_uint, height: c_uint) void;
    pub const initRect = pixman_region32_init_rect;

    extern fn pixman_region32_init_rects(region: *Region32, boxes: *const Box32, count: c_int) Bool;
    pub const initRects = pixman_region32_init_rects;

    extern fn pixman_region32_init_with_extents(region: *Region32, extents: *Box32) void;
    pub const initWithExtents = pixman_region32_init_with_extents;

    extern fn pixman_region32_init_from_image(region: *Region32, image: ?*Image) void;
    pub const initFromImage = pixman_region32_init_from_image;

    extern fn pixman_region32_fini(region: *Region32) void;
    pub const fini = pixman_region32_fini;

    extern fn pixman_region32_translate(region: *Region32, x: c_int, y: c_int) void;
    pub const translate = pixman_region32_translate;

    extern fn pixman_region32_copy(dest: *Region32, source: *Region32) Bool;
    pub const copy = pixman_region32_copy;

    extern fn pixman_region32_intersect(new_reg: *Region32, reg1: *Region32, reg2: *Region32) Bool;
    pub const intersect = pixman_region32_intersect;

    extern fn pixman_region32_union(new_reg: *Region32, reg1: *Region32, reg2: *Region32) Bool;
    pub const @"union" = pixman_region32_union;

    extern fn pixman_region32_intersect_rect(dest: *Region32, source: *Region32, x: c_int, y: c_int, width: c_uint, height: c_uint) Bool;
    pub const intersectRect = pixman_region32_intersect_rect;

    extern fn pixman_region32_union_rect(dest: *Region32, source: *Region32, x: c_int, y: c_int, width: c_uint, height: c_uint) Bool;
    pub const unionRect = pixman_region32_union_rect;

    extern fn pixman_region32_subtract(reg_d: *Region32, reg_m: *Region32, reg_s: *Region32) Bool;
    pub const subtract = pixman_region32_subtract;

    extern fn pixman_region32_inverse(new_reg: *Region32, reg1: *Region32, inv_rect: *Box32) Bool;
    pub const inverse = pixman_region32_inverse;

    extern fn pixman_region32_contains_point(region: *Region32, x: c_int, y: c_int, box: *Box32) Bool;
    pub const containsPoint = pixman_region32_contains_point;

    extern fn pixman_region32_contains_rectangle(region: *Region32, prect: *Box32) RegionOverlap;
    pub const containsRectangle = pixman_region32_contains_rectangle;

    extern fn pixman_region32_not_empty(region: *Region32) Bool;
    pub const notEmpty = pixman_region32_not_empty;

    extern fn pixman_region32_extents(region: *Region32) *Box32;
    pub const extents = pixman_region32_extents;

    extern fn pixman_region32_n_rects(region: *Region32) c_int;
    pub const nRects = pixman_region32_n_rects;

    extern fn pixman_region32_rectangles(region: *Region32, n_rects: *c_int) *Box32;
    pub const rectangles = pixman_region32_rectangles;

    extern fn pixman_region32_equal(region1: *Region32, region2: *Region32) Bool;
    pub const equal = pixman_region32_equal;

    extern fn pixman_region32_selfcheck(region: *Region32) Bool;
    pub const selfcheck = pixman_region32_selfcheck;

    extern fn pixman_region32_reset(region: *Region32, box: *Box32) void;
    pub const reset = pixman_region32_reset;

    extern fn pixman_region32_clear(region: *Region32) void;
    pub const clear = pixman_region32_clear;
};

extern fn pixman_blt(
    src_bits: [*]u32,
    dst_bits: [*]u32,
    src_stride: c_int,
    dst_stride: c_int,
    src_bpp: c_int,
    dst_bpp: c_int,
    src_x: c_int,
    src_y: c_int,
    dest_x: c_int,
    dest_y: c_int,
    width: c_int,
    height: c_int,
) Bool;
pub const blt = pixman_blt;

extern fn pixman_fill(
    bits: [*]u32,
    stride: c_int,
    bpp: c_int,
    x: c_int,
    y: c_int,
    width: c_int,
    height: c_int,
    _xor: u32,
) Bool;
pub const fill = pixman_fill;

extern fn pixman_version() c_int;
pub const version = pixman_version;

extern fn pixman_version_string() [*:0]const u8;
pub const versionString = pixman_version_string;

pub const Color = extern struct {
    red: u16,
    green: u16,
    blue: u16,
    alpha: u16,
};

pub const GradientStop = extern struct {
    x: Fixed,
    color: Color,
};

pub const Indexed = extern struct {
    color: Bool,
    rgba: [256]u32,
    ent: [32768]u8,
};

fn format(
    comptime bpp: comptime_int,
    comptime kind: comptime_int,
    comptime a: comptime_int,
    comptime r: comptime_int,
    comptime g: comptime_int,
    comptime b: comptime_int,
) comptime_int {
    return (bpp << 24) | (kind << 16) | (a << 12) | (r << 8) | (g << 4) | b;
}

fn formatByte(
    comptime bpp: comptime_int,
    comptime kind: comptime_int,
    comptime a: comptime_int,
    comptime r: comptime_int,
    comptime g: comptime_int,
    comptime b: comptime_int,
) comptime_int {
    return ((bpp >> 3) << 24) |
        (3 << 22) | (kind << 16) |
        ((a >> 3) << 12) |
        ((r >> 3) << 8) |
        ((g >> 3) << 4) |
        (b >> 3);
}

/// These are the PIXMAN_TYPE_FOO defines
const kind = struct {
    const other = 0;
    const a = 1;
    const argb = 2;
    const abgr = 3;
    const color = 4;
    const gray = 5;
    const yuy2 = 6;
    const yv12 = 7;
    const bgra = 8;
    const rgba = 9;
    const argb_srgb = 10;
    const rgba_float = 11;
};

pub const FormatCode = extern enum {
    // 128bpp formats
    rgba_float = formatByte(128, kind.rgba_float, 32, 32, 32, 32),
    // 96bpp formats
    rgb_float = formatByte(96, kind.rgba_float, 0, 32, 32, 32),

    // 32bpp formats
    a8r8g8b8 = format(32, kind.argb, 8, 8, 8, 8),
    x8r8g8b8 = format(32, kind.argb, 0, 8, 8, 8),
    a8b8g8r8 = format(32, kind.abgr, 8, 8, 8, 8),
    x8b8g8r8 = format(32, kind.abgr, 0, 8, 8, 8),
    b8g8r8a8 = format(32, kind.bgra, 8, 8, 8, 8),
    b8g8r8x8 = format(32, kind.bgra, 0, 8, 8, 8),
    r8g8b8a8 = format(32, kind.rgba, 8, 8, 8, 8),
    r8g8b8x8 = format(32, kind.rgba, 0, 8, 8, 8),
    x14r6g6b6 = format(32, kind.argb, 0, 6, 6, 6),
    x2r10g10b10 = format(32, kind.argb, 0, 10, 10, 10),
    a2r10g10b10 = format(32, kind.argb, 2, 10, 10, 10),
    x2b10g10r10 = format(32, kind.abgr, 0, 10, 10, 10),
    a2b10g10r10 = format(32, kind.abgr, 2, 10, 10, 10),

    // sRGB formats
    a8r8g8b8_sRGB = format(32, kind.argb_srgb, 8, 8, 8, 8),

    // 24bpp formats
    r8g8b8 = format(24, kind.argb, 0, 8, 8, 8),
    b8g8r8 = format(24, kind.abgr, 0, 8, 8, 8),

    // 16bpp formats
    r5g6b5 = format(16, kind.argb, 0, 5, 6, 5),
    b5g6r5 = format(16, kind.abgr, 0, 5, 6, 5),

    a1r5g5b5 = format(16, kind.argb, 1, 5, 5, 5),
    x1r5g5b5 = format(16, kind.argb, 0, 5, 5, 5),
    a1b5g5r5 = format(16, kind.abgr, 1, 5, 5, 5),
    x1b5g5r5 = format(16, kind.abgr, 0, 5, 5, 5),
    a4r4g4b4 = format(16, kind.argb, 4, 4, 4, 4),
    x4r4g4b4 = format(16, kind.argb, 0, 4, 4, 4),
    a4b4g4r4 = format(16, kind.abgr, 4, 4, 4, 4),
    x4b4g4r4 = format(16, kind.abgr, 0, 4, 4, 4),

    // 8bpp formats
    a8 = format(8, kind.a, 8, 0, 0, 0),
    r3g3b2 = format(8, kind.argb, 0, 3, 3, 2),
    b2g3r3 = format(8, kind.abgr, 0, 3, 3, 2),
    a2r2g2b2 = format(8, kind.argb, 2, 2, 2, 2),
    a2b2g2r2 = format(8, kind.abgr, 2, 2, 2, 2),

    c8 = format(8, kind.color, 0, 0, 0, 0),
    g8 = format(8, kind.gray, 0, 0, 0, 0),

    x4a4 = format(8, kind.a, 4, 0, 0, 0),

    x4c4 = format(8, kind.color, 0, 0, 0, 0),
    x4g4 = format(8, kind.gray, 0, 0, 0, 0),

    // 4bpp formats
    a4 = format(4, kind.a, 4, 0, 0, 0),
    r1g2b1 = format(4, kind.argb, 0, 1, 2, 1),
    b1g2r1 = format(4, kind.abgr, 0, 1, 2, 1),
    a1r1g1b1 = format(4, kind.argb, 1, 1, 1, 1),
    a1b1g1r1 = format(4, kind.abgr, 1, 1, 1, 1),

    c4 = format(4, kind.color, 0, 0, 0, 0),
    g4 = format(4, kind.gray, 0, 0, 0, 0),

    // 1bpp formats
    a1 = format(1, kind.a, 1, 0, 0, 0),

    g1 = format(1, kind.gray, 0, 0, 0, 0),

    // YUV formats
    yuy2 = format(16, kind.yuy2, 0, 0, 0, 0),
    yv12 = format(12, kind.yv12, 0, 0, 0, 0),

    extern fn pixman_format_supported_destination(format: FormatCode) Bool;
    pub const supportedDestination = pixman_format_supported_destination;

    extern fn pixman_format_supported_source(format: FormatCode) Bool;
    pub const supportedSource = pixman_format_supported_source;
};

pub const Repeat = extern enum {
    none,
    normal,
    pad,
    reflect,
};

pub const Dither = extern enum {
    none,
    fast,
    good,
    best,
    ordered_bayer_8,
    ordered_blue_noise_64,
};

pub const Filter = extern enum {
    fast,
    good,
    best,
    nearest,
    bilinear,
    convolution,
    separable_convolution,

    extern fn pixman_filter_create_separable_convolution(
        n_values: *c_int,
        scale_x: Fixed,
        scale_y: Fixed,
        reconstruct_x: Kernel,
        reconstruct_y: Kernel,
        sample_x: Kernel,
        sample_y: Kernel,
        subsample_bits_x: c_int,
        subsample_bits_y: c_int,
    ) [*]Fixed;
    pub const createSeparableConvolution = pixman_filter_create_separable_convolution;
};

pub const Kernel = extern enum {
    impulse,
    box,
    linear,
    cubic,
    gaussian,
    lanczos2,
    lanczos3,
    lanczos3_stretched,
};

pub const Op = extern enum {
    clear = 0x00,
    src = 0x01,
    dst = 0x02,
    over = 0x03,
    over_reverse = 0x04,
    in = 0x05,
    in_reverse = 0x06,
    out = 0x07,
    out_reverse = 0x08,
    atop = 0x09,
    atop_reverse = 0x0a,
    xor = 0x0b,
    add = 0x0c,
    saturate = 0x0d,

    disjoint_clear = 0x10,
    disjoint_src = 0x11,
    disjoint_dst = 0x12,
    disjoint_over = 0x13,
    disjoint_over_reverse = 0x14,
    disjoint_in = 0x15,
    disjoint_in_reverse = 0x16,
    disjoint_out = 0x17,
    disjoint_out_reverse = 0x18,
    disjoint_atop = 0x19,
    disjoint_atop_reverse = 0x1a,
    disjoint_xor = 0x1b,

    conjoint_clear = 0x20,
    conjoint_src = 0x21,
    conjoint_dst = 0x22,
    conjoint_over = 0x23,
    conjoint_over_reverse = 0x24,
    conjoint_in = 0x25,
    conjoint_in_reverse = 0x26,
    conjoint_out = 0x27,
    conjoint_out_reverse = 0x28,
    conjoint_atop = 0x29,
    conjoint_atop_reverse = 0x2a,
    conjoint_xor = 0x2b,

    multiply = 0x30,
    screen = 0x31,
    overlay = 0x32,
    darken = 0x33,
    lighten = 0x34,
    color_dodge = 0x35,
    color_burn = 0x36,
    hard_light = 0x37,
    soft_light = 0x38,
    difference = 0x39,
    exclusion = 0x3a,
    hsl_hue = 0x3b,
    hsl_saturation = 0x3c,
    hsl_color = 0x3d,
    hsl_luminosity = 0x3e,
};

pub const Image = opaque {
    extern fn pixman_image_create_solid_fill(color: *const Color) ?*Image;
    pub const createSolidFill = pixman_image_create_solid_fill;

    extern fn pixman_image_create_linear_gradient(p1: *const PointFixed, p2: *const PointFixed, stops: *const GradientStop, n_stops: c_int) ?*Image;
    pub const createLinearGradient = pixman_image_create_linear_gradient;

    extern fn pixman_image_create_radial_gradient(inner: *const PointFixed, outer: *const PointFixed, inner_radius: Fixed, outer_radius: Fixed, stops: *const GradientStop, n_stops: c_int) ?*Image;
    pub const createRadialGradient = pixman_image_create_radial_gradient;

    extern fn pixman_image_create_conical_gradient(center: *const PointFixed, angle: Fixed, stops: *const GradientStop, n_stops: c_int) ?*Image;
    pub const createConicalGradient = pixman_image_create_conical_gradient;

    extern fn pixman_image_create_bits(format: FormatCode, width: c_int, height: c_int, bits: ?[*]u32, rowstride_bytes: c_int) ?*Image;
    pub const createBits = pixman_image_create_bits;

    extern fn pixman_image_create_bits_no_clear(format: FormatCode, width: c_int, height: c_int, bits: [*c]u32, rowstride_bytes: c_int) ?*Image;
    pub const createBitsNoClear = pixman_image_create_bits_no_clear;

    extern fn pixman_image_ref(image: *Image) *Image;
    pub const ref = pixman_image_ref;

    extern fn pixman_image_unref(image: *Image) Bool;
    pub const unref = pixman_image_unref;

    extern fn pixman_image_set_destroy_function(image: *Image, function: fn (*Image, ?*c_void) void, data: ?*c_void) void;
    pub const setDestroyFunction = pixman_image_set_destroy_function;

    extern fn pixman_image_get_destroy_data(image: *Image) ?*c_void;
    pub const getDestroyData = pixman_image_get_destroy_data;

    extern fn pixman_image_set_clip_region(image: *Image, region: *Region16) Bool;
    pub const setClipRegion = pixman_image_set_clip_region;

    extern fn pixman_image_set_clip_region32(image: *Image, region: *Region32) Bool;
    pub const setClipRegion32 = pixman_image_set_clip_region32;

    extern fn pixman_image_set_has_client_clip(image: *Image, client_clip: Bool) void;
    pub const setHasClientClip = pixman_image_set_has_client_clip;

    extern fn pixman_image_set_transform(image: *Image, transform: *const Transform) Bool;
    pub const setTransform = pixman_image_set_transform;

    extern fn pixman_image_set_repeat(image: *Image, repeat: Repeat) void;
    pub const setRepeat = pixman_image_set_repeat;

    extern fn pixman_image_set_dither(image: *Image, dither: Dither) void;
    pub const setDither = pixman_image_set_dither;

    extern fn pixman_image_set_dither_offset(image: *Image, offset_x: c_int, offset_y: c_int) void;
    pub const setDitherOffset = pixman_image_set_dither_offset;

    extern fn pixman_image_set_filter(image: *Image, filter: Filter, filter_params: [*]const Fixed, n_filter_params: c_int) Bool;
    pub const setFilter = pixman_image_set_filter;

    extern fn pixman_image_set_source_clipping(image: *Image, source_clipping: Bool) void;
    pub const setSourceClipping = pixman_image_set_source_clipping;

    extern fn pixman_image_set_alpha_map(image: *Image, alpha_map: ?*Image, x: i16, y: i16) void;
    pub const setAlphaMap = pixman_image_set_alpha_map;

    extern fn pixman_image_set_component_alpha(image: *Image, component_alpha: Bool) void;
    pub const setComponentAlpha = pixman_image_set_component_alpha;

    extern fn pixman_image_get_component_alpha(image: *Image) Bool;
    pub const getComponentAlpha = pixman_image_get_component_alpha;

    extern fn pixman_image_set_accessors(image: *Image, read_func: fn (src: *const c_void, size: c_int) u32, write_func: fn (dst: *c_void, value: u32, size: c_int) void) void;
    pub const setAccessors = pixman_image_set_accessors;

    extern fn pixman_image_set_indexed(image: *Image, indexed: *const Indexed) void;
    pub const setIndexed = pixman_image_set_indexed;

    extern fn pixman_image_get_data(image: *Image) ?[*]u32;
    pub const getData = pixman_image_get_data;

    extern fn pixman_image_get_width(image: *Image) c_int;
    pub const getWidth = pixman_image_get_width;

    extern fn pixman_image_get_height(image: *Image) c_int;
    pub const getHeight = pixman_image_get_height;

    extern fn pixman_image_get_stride(image: *Image) c_int;
    pub const getStride = pixman_image_get_stride;

    extern fn pixman_image_get_depth(image: *Image) c_int;
    pub const getDepth = pixman_image_get_depth;

    extern fn pixman_image_get_format(image: *Image) FormatCode;
    pub const getFormat = pixman_image_get_format;

    extern fn pixman_image_fill_rectangles(op: Op, image: *Image, color: *const Color, n_rects: c_int, rects: [*]const Rectangle16) Bool;
    pub const fillRectangles = pixman_image_fill_rectangles;

    extern fn pixman_image_fill_boxes(op: Op, dest: *Image, color: *const Color, n_boxes: c_int, boxes: [*]const Box32) Bool;
    pub const fillBoxes = pixman_image_fill_boxes;

    extern fn pixman_image_composite(op: Op, src: *Image, mask: ?*Image, dest: *Image, src_x: i16, src_y: i16, mask_x: i16, mask_y: i16, dest_x: i16, dest_y: i16, width: u16, height: u16) void;
    pub const composite = pixman_image_composite;

    extern fn pixman_image_composite32(op: Op, src: *Image, mask: ?*Image, dest: *Image, src_x: i32, src_y: i32, mask_x: i32, mask_y: i32, dest_x: i32, dest_y: i32, width: i32, height: i32) void;
    pub const composite32 = pixman_image_composite32;

    extern fn pixman_rasterize_edges(image: *Image, l: *Edge, r: *Edge, t: Fixed, b: Fixed) void;
    pub const rasterizeEdges = pixman_rasterize_edges;

    extern fn pixman_add_traps(image: *Image, x_off: i16, y_off: i16, ntrap: c_int, traps: [*]const Trap) void;
    pub const addTraps = pixman_add_traps;

    extern fn pixman_add_trapezoids(image: *Image, x_off: i16, y_off: c_int, ntraps: c_int, traps: [*]const Trapezoid) void;
    pub const addTrapezoids = pixman_add_trapezoids;

    extern fn pixman_rasterize_trapezoid(image: *Image, trap: [*]const Trapezoid, x_off: c_int, y_off: c_int) void;
    pub const rasterizeTrapezoid = pixman_rasterize_trapezoid;

    extern fn pixman_add_triangles(image: *Image, x_off: i32, y_off: i32, n_tris: c_int, tris: [*]const Triangle) void;
    pub const addTriangles = pixman_add_triangles;
};

pub const Glyph = extern struct {
    x: c_int,
    y: c_int,
    glyph: ?*const c_void,

    extern fn pixman_glyph_get_extents(cache: ?*GlyphCache, n_glyphs: c_int, glyphs: [*]pixman_glyph_t, extents: [*]pixman_box32_t) void;
    pub const getExtents = pixman_glyph_get_extents;

    extern fn pixman_glyph_get_mask_format(cache: ?*GlyphCache, n_glyphs: c_int, glyphs: [*]const pixman_glyph_t) FormatCode;
    pub const getMaskFormat = pixman_glyph_get_mask_format;
};

pub const GlyphCache = opaque {
    extern fn pixman_glyph_cache_create() ?*GlyphCache;
    pub const create = pixman_glyph_cache_create;

    extern fn pixman_glyph_cache_destroy(cache: *GlyphCache) void;
    pub const destroy = pixman_glyph_cache_destroy;

    extern fn pixman_glyph_cache_freeze(cache: *GlyphCache) void;
    pub const freeze = pixman_glyph_cache_freeze;

    extern fn pixman_glyph_cache_thaw(cache: *GlyphCache) void;
    pub const thaw = pixman_glyph_cache_thaw;

    extern fn pixman_glyph_cache_lookup(cache: *GlyphCache, font_key: ?*c_void, glyph_key: ?*c_void) ?*const c_void;
    pub const lookup = pixman_glyph_cache_lookup;

    extern fn pixman_glyph_cache_insert(cache: *GlyphCache, font_key: ?*c_void, glyph_key: ?*c_void, origin_x: c_int, origin_y: c_int, glyph_image: *Image) ?*const c_void;
    pub const insert = pixman_glyph_cache_insert;

    extern fn pixman_glyph_cache_remove(cache: *GlyphCache, font_key: ?*c_void, glyph_key: ?*c_void) void;
    pub const remove = pixman_glyph_cache_remove;
};

extern fn pixman_composite_glyphs(
    op: Op,
    src: *Image,
    dest: *Image,
    mask_format: FormatCode,
    src_x: i32,
    src_y: i32,
    mask_x: i32,
    mask_y: i32,
    dest_x: i32,
    dest_y: i32,
    width: i32,
    height: i32,
    cache: *GlyphCache,
    n_glyphs: c_int,
    glyphs: [*]const Glyph,
) void;
pub const compositeGlyphs = pixman_composite_glyphs;

extern fn pixman_composite_glyphs_no_mask(
    op: Op,
    src: *Image,
    dest: *Image,
    src_x: i32,
    src_y: i32,
    dest_x: i32,
    dest_y: i32,
    cache: *GlyphCache,
    n_glyphs: c_int,
    glyphs: [*]const Glyph,
) void;
pub const compositeGlyphsNoMask = pixman_composite_glyphs_no_mask;

pub const Edge = extern struct {
    x: Fixed,
    e: Fixed,
    stepx: Fixed,
    signdx: Fixed,
    dy: Fixed,
    dx: Fixed,

    stepx_small: Fixed,
    stepx_big: Fixed,
    dx_small: Fixed,
    dx_big: Fixed,

    extern fn pixman_edge_init(e: *Edge, bpp: c_int, y_start: Fixed, x_top: Fixed, y_top: Fixed, x_bot: Fixed, y_bot: Fixed) void;
    pub const init = pixman_edge_init;

    extern fn pixman_line_fixed_edge_init(e: *Edge, bpp: c_int, y: Fixed, line: *const LineFixed, x_off: c_int, y_off: c_int) void;
    pub const initFromLineFixed = pixman_line_fixed_edge_init;

    extern fn pixman_edge_step(e: *Edge, n: c_int) void;
    pub const step = pixman_edge_step;
};

pub const Trapezoid = extern struct {
    top: Fixed,
    bottom: Fixed,
    left: LineFixed,
    right: LineFixed,

    pub fn valid(t: Trapezoid) bool {
        return t.left.p1.y != t.left.p2.y and
            t.right.p1.y != t.right.p2.y and
            t.bottom > t.top;
    }
};

pub const Trap = extern struct {
    top: SpanFix,
    bot: SpanFix,
};

pub const SpanFix = extern struct {
    l: Fixed,
    r: Fixed,
    y: Fixed,
};

pub const Triangle = extern struct {
    p1: PointFixed,
    p2: PointFixed,
    p3: PointFixed,
};

extern fn pixman_sample_ceil_y(y: Fixed, bpp: c_int) Fixed;
pub const sampleCeilY = pixman_sample_ceil_y;

extern fn pixman_sample_floor_y(y: Fixed, bpp: c_int) Fixed;
pub const sampleFloorY = pixman_sample_floor_y;

extern fn pixman_composite_trapezoids(
    op: Op,
    src: *Image,
    dst: *Image,
    mask_format: FormatCode,
    x_src: c_int,
    y_src: c_int,
    x_dst: c_int,
    y_dst: c_int,
    n_traps: c_int,
    traps: [*c]const Trapezoid,
) void;
pub const compositeTrapezoids = pixman_composite_trapezoids;

extern fn pixman_composite_triangles(
    op: Op,
    src: *Image,
    dst: *Image,
    mask_format: FormatCode,
    x_src: c_int,
    y_src: c_int,
    x_dst: c_int,
    y_dst: c_int,
    n_tris: c_int,
    tris: [*c]const Triangle,
) void;
pub const compositeTriangles = pixman_composite_triangles;
