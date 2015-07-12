package stb;

import haxe.io.BytesData;

@:include('./linc_stb_image_write.cpp')
extern class ImageWrite {

	@:native("linc::stb_image_write::write_bmp")
	public static function write_bmp(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::write_tga")
	public static function write_tga(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::write_hdr")
	public static function write_hdr(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::write_png")
	public static function write_png(filename:String, x:Int, y:Int, comp:Int, bytes:BytesData, byteOffset:Int, byteLength:Int, stride_in_bytes:Int):Int;

} //ImageWrite