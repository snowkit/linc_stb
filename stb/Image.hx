package stb;

import haxe.io.BytesData;

typedef ImageData = {
    var w: Int;
    var h: Int;
    var comp: Int;
    var req_comp: Int;
    var bytes: BytesData;
}

@:include('../linc_stb/linc_stb_image.h')
extern class Image {

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
