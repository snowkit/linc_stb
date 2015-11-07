
    #if (!mac && !android && !ios && !linux && !windows)
        #error "You should define a target, please read and modify build.hxml"
    #end

class Test {

    static function main() {
        
        test_bake_font_bitmap();
        test_pack_font_range();
        test_pack_font_ranges();
        
    } //main
    
    static function test_bake_font_bitmap() {

        // size of baked bitmap
        var w = 512, h = 300;

        // bake a bitmap
        var baked = stb.TrueType.bake_font_bitmap('LatoLatin-Black.ttf', 32, w, h, 32, 10);
        var bytes = baked.pixels;
        var cdata = baked.charData;
        
        // log the char data
        trace(cdata.length);
        for(c in cdata) trace(c);

        // save the bitmap as png
        stb.ImageWrite.write_png('test.png', w, h, 1, bytes, 0, bytes.length, w);
        
    } //test_bake_font_bitmap
    
    static function test_pack_font_range() {
        
        var w=1024, h=1024;
        
        stb.TrueType.pack_begin(w,h,0,1);
        var cdata = stb.TrueType.pack_font_range('c:/windows/fonts/mingliu.ttc', 0, 80, 32, 10);        trace(cdata.length); for(c in cdata) trace(c);
        var cdata = stb.TrueType.pack_font_range('c:/windows/fonts/mingliu.ttc', 0, 30, 0xa0, 10);      trace(cdata.length); for(c in cdata) trace(c);
        var cdata = stb.TrueType.pack_font_range('c:/windows/fonts/mingliu.ttc', 0, 30, 0x5A20, 10);    trace(cdata.length); for(c in cdata) trace(c);
        var cdata = stb.TrueType.pack_font_range('c:/windows/fonts/mingliu.ttc', 0, 50, 0x6A20, 10);    trace(cdata.length); for(c in cdata) trace(c);
        var bytes = stb.TrueType.pack_end();
        
        // save the bitmap as png
        stb.ImageWrite.write_png('test2.png', w, h, 1, bytes, 0, bytes.length, w);
        
    } //test_pack_font_range
    
    static function test_pack_font_ranges() {
        
        var w=256, h=256;
        
        stb.TrueType.pack_begin(w,h,0,1);
        var cdata = stb.TrueType.pack_font_ranges('c:/windows/fonts/mingliu.ttc', 0, [
            {font_size:40, array_of_unicode_codepoints:[33,34,36,38,39,40,67,69,70,120]},
            {font_size:20, first_unicode_codepoint_in_range:70, num_chars:10},
            {font_size:40, first_unicode_codepoint_in_range:0x5A20, num_chars:10},
            {font_size:20, first_unicode_codepoint_in_range:0x5A20, num_chars:10},
            {font_size:40, first_unicode_codepoint_in_range:0x5A20, num_chars:10},
            {font_size:20, first_unicode_codepoint_in_range:0x6A20, num_chars:10},
        ]);
        var bytes = stb.TrueType.pack_end();

        // log the char data
        trace(cdata.length);
        for(c in cdata) trace(c);
        
        // save the bitmap as png
        stb.ImageWrite.write_png('test3.png', w, h, 1, bytes, 0, bytes.length, w);

    } //test_pack_font_ranges


} //Test
