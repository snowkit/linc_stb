#include "./linc_stb_image.h"

#define STB_IMAGE_IMPLEMENTATION
#define STBI_FAILURE_USERMSG

#include "../lib/stb_image.h"

#include <hxcpp.h>

namespace linc {

    namespace stb_image {

        //forward

        Dynamic to_image_data(Array<unsigned char> bytes, int w, int h, int comp, int req_comp);
        Array<unsigned char> to_haxe_bytes(unsigned char* image_bytes, int length);
        Dynamic to_image_info(int w, int h, int comp);

            //fudge this to cause a recompile when stb_image.h updates
        static int force_recompile = 1;

        //errors

        ::String failure_reason() {

            const char* reason = stbi_failure_reason();

            if(!reason) return null();

            return ::String(reason);

        } //failure_reason

        //info

        Dynamic info(char const *filename) {

            int w = 0;
            int h = 0;
            int comp = 0;

            int res = stbi_info(filename, &w, &h, &comp);

            if(!res) return null();

            return to_image_info(w, h, comp);

        } //info

        Dynamic info_from_memory(Array<unsigned char> src_bytes, int src_length) {


            int w = 0;
            int h = 0;
            int comp = 0;

            int res = stbi_info_from_memory(&src_bytes[0], src_length, &w, &h, &comp);

            if(!res) return null();

            return to_image_info(w, h, comp);

        } //info_from_memory


        //load

        Dynamic load(char const *filename, int req_comp) {

            int w = 0;
            int h = 0;
            int comp = 0;

            unsigned char* image_bytes = stbi_load(filename, &w, &h, &comp, req_comp);

            if(!image_bytes) return null();

            if(req_comp == 0)
                req_comp = comp;

            Array<unsigned char> bytes = to_haxe_bytes(image_bytes, w * h * req_comp);

            return to_image_data(bytes, w, h, comp, req_comp);

        } //load

        Dynamic load_from_memory(Array<unsigned char> src_bytes, int src_length, int req_comp) {

            int w = 0;
            int h = 0;
            int comp = 0;

            unsigned char* image_bytes = stbi_load_from_memory(&src_bytes[0], src_length, &w, &h, &comp, req_comp);

            if(!image_bytes) return null();
            
            if(req_comp == 0)
                req_comp = comp;

            Array<unsigned char> bytes = to_haxe_bytes(image_bytes, w * h * req_comp);

            return to_image_data(bytes, w, h, comp, req_comp);

        } //load_from_memory

    //helpers

            //note this calls stb_image_free on the image_bytes
        Array<unsigned char> to_haxe_bytes(unsigned char* image_bytes, int length) {

            Array<unsigned char> haxe_bytes = new Array_obj<unsigned char>(length,length);

            memcpy(haxe_bytes->GetBase(), image_bytes, length);

            stbi_image_free(image_bytes);

            return haxe_bytes;

        } //to_haxe_bytes

        Dynamic to_image_info(int w, int h, int comp) {

            hx::Anon result = hx::Anon_obj::Create();

                result->Add(HX_CSTRING("w"), w);
                result->Add(HX_CSTRING("h"), h);
                result->Add(HX_CSTRING("comp"), comp);

            return result;

        } //to_image_info

        Dynamic to_image_data(Array<unsigned char> bytes, int w, int h, int comp, int req_comp) {

            hx::Anon result = hx::Anon_obj::Create();

                result->Add(HX_CSTRING("w"), w);
                result->Add(HX_CSTRING("h"), h);
                result->Add(HX_CSTRING("comp"), comp);
                result->Add(HX_CSTRING("req_comp"), req_comp);
                result->Add(HX_CSTRING("bytes"), bytes);

            return result;

        } //to_image_data

    } //stb_image namespace

} //linc