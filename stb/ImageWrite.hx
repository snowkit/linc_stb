package stb;

import haxe.io.BytesData;

@:include('../linc_stb/linc_stb_image_write.h')
extern class ImageWrite {

	@:native("linc::stb_image_write::write_bmp")
	static function write_bmp(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::write_tga")
	static function write_tga(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::write_hdr")
	static function write_hdr(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::write_png")
	static function write_png(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int, stride_in_bytes:Int):Int;

} //ImageWrite


@:buildXml("
<set name='LINC_STB_LIB_PATH' value='${haxelib:linc_stb}'/>
<files id='haxe'>
    <compilerflag value='-I${LINC_STB_LIB_PATH}/lib/'/>
    <file name='${LINC_STB_LIB_PATH}/linc_stb/linc_stb_image_write.cpp' />
</files>
")
@:keep private class ImageWriteLinc { function __init__(){} }
