#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include "../lib/stb_truetype.h"


namespace linc {

    namespace stb_truetype {

        extern Dynamic bake_font_bitmap(char const *filename, float pixel_height, int px, int py, int first_char, int num_chars);

        extern int pack_begin(int width, int height, int stride_in_bytes, int padding);
        extern Array<Dynamic> pack_font_range(const char *filename, int font_index, float font_size, int first_unicode_char_in_range, int num_chars_in_range);
        extern Array<Dynamic> pack_font_ranges(const char *filename, int font_index, Array<Dynamic> ranges);
        extern Array<unsigned char> pack_end();

    } //stb_truetype namespace

} //linc
