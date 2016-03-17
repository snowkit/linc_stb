package stb;

import haxe.io.BytesData;

typedef StbBakedFont = {
    pixels:BytesData, 
    charData:Array<StbBakedChar>
}

typedef StbBakedChar = {
    x0:Int, y0:Int,
    x1:Int, y1:Int,
    xoff:Float, yoff:Float,
    xadvance:Float, 
}

typedef StbPackedChar = {
    > StbBakedChar,
    xoff2:Float, yoff2:Float,
}

typedef StbPackRange = {
    font_size:Float,
    
    /**
        if set, use this array of char indices, has higher priority over first_unicode_codepoint_in_range & num_chars
    */
    ?array_of_unicode_codepoints:Array<Int>,
    
    /**
        set starting char index, to be used together with num_chars
    */
    ?first_unicode_codepoint_in_range:Int,
    
    /**
        set number of chars, to be used together with first_unicode_codepoint_in_range
    */
    ?num_chars:Int,
}

@:keep
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('stb_truetype'))
@:include('linc_stb_truetype.h')
extern class TrueType {

    //info

        @:native("linc::stb_truetype::bake_font_bitmap")
        static function bake_font_bitmap(filename:String, pixel_height:Float, px:Int, py:Int, first_char:Int, num_chars:Int):StbBakedFont;
        
        @:native("linc::stb_truetype::pack_begin")
        static function pack_begin(width:Int, height:Int, stride_in_bytes:Int, padding:Int):Int;
        
        @:native("linc::stb_truetype::pack_font_range")
        static function pack_font_range(filename:String, font_index:Int, font_size:Float, first_unicode_char_in_range:Int, num_chars_in_range:Int):Array<StbPackedChar>;
        
        @:native("linc::stb_truetype::pack_font_ranges")
        static function pack_font_ranges(filename:String, font_index:Int, ranges:Array<StbPackRange>):Array<StbPackedChar>;
        
        @:native("linc::stb_truetype::pack_end")
        static function pack_end():BytesData;



} //TrueType
