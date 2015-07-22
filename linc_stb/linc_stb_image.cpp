#include "./linc_stb_image.h"

#define STB_IMAGE_IMPLEMENTATION
#include "../lib/stb_image.h"

#include <hxcpp.h>

namespace linc {

    namespace stb_image {

        extern Dynamic load(char const *filename, int req_comp) {

            int w = 0;
            int h = 0;
            int comp = 0;

            unsigned char* image_bytes = stbi_load(filename, &w, &h, &comp, req_comp);

            if(!image_bytes) return null();

            unsigned int length = w * h * comp;
            Array<unsigned char> bytes = new Array_obj<unsigned char>(length,length);

            memcpy(bytes->GetBase(), image_bytes, length);

            stbi_image_free(image_bytes);

            hx::Anon result = hx::Anon_obj::Create();

                result->Add(HX_CSTRING("w"), w);
                result->Add(HX_CSTRING("h"), h);
                result->Add(HX_CSTRING("comp"), comp);
                result->Add(HX_CSTRING("req_comp"), req_comp);
                result->Add(HX_CSTRING("bytes"), bytes);

            return result;

        } //load

    } //stb_image namespace

} //linc