#ifndef _LINC_STB_IMAGE_WRITE_CPP_
#define _LINC_STB_IMAGE_WRITE_CPP_

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../lib/stb_image_write.h"

#include <hxcpp.h>

namespace linc {

    namespace stb_image_write {

        int write_bmp(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
        	unsigned int byteOffset, unsigned int byteLength)
	    {
	        return stbi_write_bmp(filename, x, y, comp, &bytes[0] + byteOffset);
	    }

	    int write_tga(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
        	unsigned int byteOffset, unsigned int byteLength)
	    {
	        return stbi_write_tga(filename, x, y, comp, &bytes[0] + byteOffset);
	    }

	    int write_hdr(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
        	unsigned int byteOffset, unsigned int byteLength)
	    {
	        return stbi_write_hdr(filename, x, y, comp, (float*)(&bytes[0] + byteOffset));
	    }

	    int write_png(char const *filename, int x, int y, int comp, Array<unsigned char> bytes,
        	unsigned int byteOffset, unsigned int byteLength, int stride_in_bytes)
	    {
	        return stbi_write_png(filename, x, y, comp, &bytes[0] + byteOffset, stride_in_bytes);
	    }

    } //stb_image_write namespace

} //linc

#endif //_LINC_STB_IMAGE_WRITE_CPP_
