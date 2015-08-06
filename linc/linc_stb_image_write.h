#ifndef _LINC_STB_IMAGE_WRITE_H_
#define _LINC_STB_IMAGE_WRITE_H_

#include "../lib/stb_image_write.h"

#include <hxcpp.h>

namespace linc {

    namespace stb_image_write {

        extern int write_bmp(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
            unsigned int byteOffset, unsigned int byteLength);

        extern int write_tga(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
            unsigned int byteOffset, unsigned int byteLength);

        extern int write_hdr(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
            unsigned int byteOffset, unsigned int byteLength);

        extern int write_png(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
            unsigned int byteOffset, unsigned int byteLength, int stride_in_bytes);

    } //stb_image_write namespace

} //linc

#endif //_LINC_STB_IMAGE_WRITE_H_
