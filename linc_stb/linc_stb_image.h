#ifndef _LINC_STB_IMAGE_H_
#define _LINC_STB_IMAGE_H_

#include "../lib/stb_image.h"

#include <hxcpp.h>

namespace linc {

    namespace stb_image {

        extern Dynamic info(char const *filename);
        extern Dynamic info_from_memory(Array<unsigned char> src_bytes, int src_length);

        extern Dynamic load(char const *filename, int req_comp);
        extern Dynamic load_from_memory(Array<unsigned char> src_bytes, int src_length, int req_comp);

    } //stb_image namespace

} //linc

#endif //_LINC_STB_IMAGE_H_
