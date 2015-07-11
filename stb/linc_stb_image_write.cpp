#ifndef _LINC_STB_IMAGE_WRITE_CPP_
#define _LINC_STB_IMAGE_WRITE_CPP_

#define STB_IMAGE_WRITE_IMPLEMENTATION

#include "../lib/stb/stb_image_write.h"
#include <hxcpp.h>

namespace linc {
    namespace stb_image_write {
        int stbi_write_bmp_wrapper(char const *filename, int x, int y, int comp, Array<unsigned char> bytes, 
        	unsigned int byteOffset, unsigned int byteLength)
	    {
	        return stbi_write_bmp(filename, x, y, comp, &bytes[0] + byteOffset);
	    }

	    int stbi_write_tga_wrapper(char const *filename, int x, int y, int comp, Array<unsigned char> bytes, 
        	unsigned int byteOffset, unsigned int byteLength)
	    {
	        return stbi_write_tga(filename, x, y, comp, &bytes[0] + byteOffset);
	    }

	    int stbi_write_hdr_wrapper(char const *filename, int x, int y, int comp, Array<unsigned char> bytes, 
        	unsigned int byteOffset, unsigned int byteLength)
	    {
	        return stbi_write_hdr(filename, x, y, comp, (float*)(&bytes[0] + byteOffset));
	    }

	    int stbi_write_png_wrapper(char const *filename, int x, int y, int comp, Array<unsigned char> bytes, 
        	unsigned int byteOffset, unsigned int byteLength, int stride_in_bytes)
	    {
	        return stbi_write_png(filename, x, y, comp, &bytes[0] + byteOffset, stride_in_bytes);
	    }
    }
}

#endif
