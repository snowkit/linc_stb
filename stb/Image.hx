package stb;

import haxe.io.BytesData;


typedef ImageInfo = {
    var w: Int;
    var h: Int;
    var comp: Int;
} //ImageInfo

typedef ImageData = {

    > ImageInfo,

    var req_comp: Int;
    var bytes: BytesData;

} //ImageData


@:include('../linc_stb/linc_stb_image.h')
extern class Image {

    @:native("linc::stb_image::info")
    static function info(filename:String) : ImageInfo;

    @:native("linc::stb_image::info_from_memory")
    static function info_from_memory(bytes:BytesData, length:Int) : ImageInfo;


    @:native("linc::stb_image::load")
    static function load(filename:String, req_comp:Int = 0) : ImageData;

    @:native("linc::stb_image::load_from_memory")
    static function load_from_memory(bytes:BytesData, length:Int, req_comp:Int = 0) : ImageData;


    // static function load_from_callbacks(length:Int, req_comp:Int = 0) : ImageData;

} //Image


@:buildXml("
<set name='LINC_STB_LIB_PATH' value='${haxelib:linc_stb}'/>
<files id='haxe'>
    <compilerflag value='-I${LINC_STB_LIB_PATH}/lib/'/>
    <file name='${LINC_STB_LIB_PATH}/linc_stb/linc_stb_image.cpp' />
</files>
")
@:keep private class ImageLinc { function __init__(){} }
