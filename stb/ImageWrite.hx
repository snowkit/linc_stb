package stb;

import haxe.io.BytesData;

@:keep
@:build(linc.Touch.apply())
@:include('linc_stb_image_write.h')
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


@:buildXml("<include name='${haxelib:linc_stb}/linc/linc_stb_image_write.xml'/>")
@:keep private class ImageWriteLinc {}
