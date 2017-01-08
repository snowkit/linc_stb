
    #if (!mac && !android && !ios && !linux && !windows)
        #error "You should define a target, please read and modify build.hxml"
    #end

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

        HDRWrite.test();

    }

} //Test

class HDRWrite {

    public static function test() {

        var floats = new haxe.io.BytesOutput();

            floats.writeFloat(1);
            floats.writeFloat(0);
            floats.writeFloat(0);
            floats.writeFloat(1);

            floats.writeFloat(0);
            floats.writeFloat(1);
            floats.writeFloat(0);
            floats.writeFloat(1);

            floats.writeFloat(0);
            floats.writeFloat(0);
            floats.writeFloat(1);
            floats.writeFloat(1);

            floats.writeFloat(0);
            floats.writeFloat(0);
            floats.writeFloat(0);
            floats.writeFloat(1);

        var size = floats.length;
        var bytes = floats.getBytes();
        var bytes_data = bytes.getData();

        var result = stb.ImageWrite.write_hdr("test.hdr", 2, 2, 4, bytes_data, 0, size);
        trace("ImageWrite.write_hdr result: " + (result == 0 ? "Error" : "Success"));

    } //test

} //HDRWrite
