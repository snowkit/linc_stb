#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include "../lib/stb_image.h"

namespace linc {

    namespace stb_image {

        extern ::String failure_reason();

        extern Dynamic info(char const *filename);
        extern Dynamic info_from_memory(Array<unsigned char> src_bytes, int src_length);

        extern Dynamic load(char const *filename, int req_comp);
        extern Dynamic load_from_memory(Array<unsigned char> src_bytes, int src_length, int req_comp);

        extern Dynamic loadf(char const *filename, int req_comp);
        extern Dynamic loadf_from_memory(Array<unsigned char> src_bytes, int src_length, int req_comp);

        extern bool is_hdr(char const *filename);
        extern bool is_hdr_from_memory(Array<unsigned char> src_bytes, int src_length);

    } //stb_image namespace

} //linc
