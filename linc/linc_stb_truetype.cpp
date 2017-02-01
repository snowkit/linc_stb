#include <hxcpp.h>

#include "./linc_stb_truetype.h"

#define STB_TRUETYPE_IMPLEMENTATION
#define STB_RECT_PACK_IMPLEMENTATION
#include "../lib/stb_rect_pack.h"
#include "../lib/stb_truetype.h"

#include <stdio.h>

namespace linc {

    namespace stb_truetype {

        //forward
        Array<unsigned char> to_haxe_bytes(unsigned char* image_bytes, int length);
        Array<Dynamic> to_baked_char_data(stbtt_bakedchar *cdata, int length);
        Array<Dynamic> to_packed_char_data(stbtt_packedchar *cdata, int length);

        unsigned char ttf_buffer[1<<25];
        unsigned char *pack_pixels;
        stbtt_pack_context *spc;

        Dynamic bake_font_bitmap(char const *filename, float pixel_height, int px, int py, int first_char, int num_chars) {

            unsigned char *bake_pixels = new unsigned char[px*py];
            stbtt_bakedchar *backed_char_data = new stbtt_bakedchar[num_chars];

            fread(ttf_buffer, 1, 1<<25, fopen(filename, "rb"));
            stbtt_BakeFontBitmap(ttf_buffer, 0, pixel_height, bake_pixels, px, py, first_char, num_chars, backed_char_data);
            
            hx::Anon result = hx::Anon_obj::Create();
            
            result->Add(HX_CSTRING("pixels"), to_haxe_bytes(bake_pixels, px * py));
            result->Add(HX_CSTRING("charData"), to_baked_char_data(backed_char_data, num_chars));

            return result;
        }
        
        int pack_begin(int width, int height, int stride_in_bytes, int padding) {
            
            pack_pixels = new unsigned char[width * height];
            spc = new stbtt_pack_context();
            
            int r = stbtt_PackBegin(spc, pack_pixels, width, height, stride_in_bytes, padding, NULL);
            
            return r;
        }
        
        Array<Dynamic> pack_font_range(const char *filename, int font_index, float font_size, int first_unicode_char_in_range, int num_chars_in_range) {
            
            stbtt_packedchar *packed_char_data = new stbtt_packedchar[num_chars_in_range];
            
            fread(ttf_buffer, 1, 1<<25, fopen(filename, "rb"));
            stbtt_PackFontRange(spc, ttf_buffer, font_index, font_size, first_unicode_char_in_range, num_chars_in_range, packed_char_data);
            
            return to_packed_char_data(packed_char_data, num_chars_in_range);
            
        }
        
        
        Array<Dynamic> pack_font_ranges(const char *filename, int font_index, Array<Dynamic> ranges) {
            
            int i;
            int num_ranges = ranges.__length();
            int num_chars = 0;
            stbtt_pack_range *pr = new stbtt_pack_range[num_ranges];
            
            for(i = 0; i < num_ranges; i++) {
                
                hx::Anon range = (hx::Anon) ranges[i];
                
                Array<int> array_of_unicode_codepoints = range->__Field(HX_CSTRING("array_of_unicode_codepoints"), HX_PROP_NEVER);
                if(array_of_unicode_codepoints != null()) {
                    
                    pr[i].array_of_unicode_codepoints = (int*) array_of_unicode_codepoints->GetBase();
                    pr[i].num_chars = array_of_unicode_codepoints.__length();
                    
                } else {
                    
                    pr[i].first_unicode_codepoint_in_range = range->__Field(HX_CSTRING("first_unicode_codepoint_in_range"), HX_PROP_NEVER);
                    pr[i].num_chars = range->__Field(HX_CSTRING("num_chars"), HX_PROP_NEVER);
                    pr[i].array_of_unicode_codepoints = 0;
                    
                }
                
                pr[i].font_size = range->__Field(HX_CSTRING("font_size"), HX_PROP_NEVER);
                
                num_chars += pr[i].num_chars;
            }
            
            stbtt_packedchar *packed_char_data = new stbtt_packedchar[num_chars];
            int pdata_index = 0;
            
            for(i = 0; i < num_ranges; i++) {
            
                pr[i].chardata_for_range = packed_char_data + pdata_index;
                pdata_index += pr[i].num_chars;
                
            }
            
            fread(ttf_buffer, 1, 1<<25, fopen(filename, "rb"));
            stbtt_PackFontRanges(spc, ttf_buffer, font_index, pr, num_ranges);
            
            return to_packed_char_data(packed_char_data, num_chars);
            
        }
        
        Array<unsigned char> pack_end() {
            
            stbtt_PackEnd(spc);
            
            return to_haxe_bytes(spc->pixels, spc->width * spc->height);
            
        }

        //helpers

                //note this calls free() on the image_bytes
            Array<unsigned char> to_haxe_bytes(unsigned char* image_bytes, int length) {

                Array<unsigned char> haxe_bytes = new Array_obj<unsigned char>(length,length);

                memcpy(haxe_bytes->GetBase(), image_bytes, length);

                free(image_bytes);

                return haxe_bytes;

            } //to_haxe_bytes
            
            Array<Dynamic> to_baked_char_data(stbtt_bakedchar *cdata, int length) {
                
                Array<Dynamic> result = new Array_obj<Dynamic>(length, length);
                
                for(int i = 0; i < length; i++) {
                    
                    hx::Anon data = hx::Anon_obj::Create();
                    
                    data->Add(HX_CSTRING("x0"), cdata[i].x0);
                    data->Add(HX_CSTRING("y0"), cdata[i].y0);
                    data->Add(HX_CSTRING("x1"), cdata[i].x1);
                    data->Add(HX_CSTRING("y1"), cdata[i].y1);
                    data->Add(HX_CSTRING("xoff"), cdata[i].xoff);
                    data->Add(HX_CSTRING("yoff"), cdata[i].yoff);
                    data->Add(HX_CSTRING("xadvance"), cdata[i].xadvance);

                    result[i] = data;
                }
                
                return result;
                
            } //to_baked_char_data
            
            Array<Dynamic> to_packed_char_data(stbtt_packedchar *cdata, int length) {
                
                Array<Dynamic> result = new Array_obj<Dynamic>(length, length);
                
                for(int i = 0; i < length; i++) {
                    
                    hx::Anon data = hx::Anon_obj::Create();
                    
                    data->Add(HX_CSTRING("x0"), cdata[i].x0);
                    data->Add(HX_CSTRING("y0"), cdata[i].y0);
                    data->Add(HX_CSTRING("x1"), cdata[i].x1);
                    data->Add(HX_CSTRING("y1"), cdata[i].y1);
                    data->Add(HX_CSTRING("xoff"), cdata[i].xoff);
                    data->Add(HX_CSTRING("yoff"), cdata[i].yoff);
                    data->Add(HX_CSTRING("xoff2"), cdata[i].xoff2);
                    data->Add(HX_CSTRING("yoff2"), cdata[i].yoff2);
                    data->Add(HX_CSTRING("xadvance"), cdata[i].xadvance);

                    result[i] = data;
                }
                
                return result;
                
            } //to_packed_char_data


    } //stb_truetype namespace

} //linc
