class Test {
    static function main() {
        var bytes = new haxe.io.BytesOutput();
        bytes.writeInt32(0xFFFF0000);
        bytes.writeInt32(0xFF00FF00);
        bytes.writeInt32(0xFF0000FF);
        bytes.writeInt32(0xFF000000);

        var data = bytes.getBytes().getData();

        var result = stb.ImageWrite.write_bmp("test.bmp", 2, 2, 4, data, 0, data.length);
        trace("ImageWrite.write_bmp result: " + (result == 0 ? "Error" : "Success"));

        result = stb.ImageWrite.write_png("test.png", 2, 2, 4, data, 0, data.length, 2 * 4);
        trace("ImageWrite.write_png result: " + (result == 0 ? "Error" : "Success"));

        result = stb.ImageWrite.write_tga("test.tga", 2, 2, 4, data, 0, data.length);
        trace("ImageWrite.write_tga result: " + (result == 0 ? "Error" : "Success"));

        result = stb.ImageWrite.write_hdr("test.hdr", 2, 2, 4, data, 0, data.length);
        trace("ImageWrite.write_hdr result: " + (result == 0 ? "Error" : "Success"));
    }

    // a simple macro to force compilation each time
    // allowing faster iteration
    static inline var forcer:String = Forcer.get();

}