package stb;

@:include('./linc_stb_image_write.cpp')
extern class ImageWrite {

	@:native("linc::stb_image_write::stbi_write_bmp_wrapper")
	public static function write_bmp(filename:String, x:Int, y:Int, comp:Int, bytes:haxe.io.BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::stbi_write_tga_wrapper")
	public static function write_tga(filename:String, x:Int, y:Int, comp:Int, bytes:haxe.io.BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::stbi_write_hdr_wrapper")
	public static function write_hdr(filename:String, x:Int, y:Int, comp:Int, bytes:haxe.io.BytesData, byteOffset:Int, byteLength:Int):Int;

	@:native("linc::stb_image_write::stbi_write_png_wrapper")
	public static function write_png(filename:String, x:Int, y:Int, comp:Int, bytes:haxe.io.BytesData, byteOffset:Int, byteLength:Int, stride_in_bytes:Int):Int;
}