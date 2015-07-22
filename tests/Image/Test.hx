class Test {

    static function main() {

        var file_prefix = './';
        var files = [
            'image.png',
            'image.gif',
            'image.tga',
            'image.jpg',
            'image.bmp',
            'image.psd',
            'image.hdr',
        ];

        var req_comp = 4;
        for(file in files) {
            var data = stb.Image.load(haxe.io.Path.join([file_prefix,file]), req_comp);
            print_image_info(file, data);
            data = null;
        }

    }

    static function print_image_info(file:String, image:stb.Image.ImageData) {
        trace('$file');
        trace('   image ${image.w} x ${image.w} comp:${image.comp} req_comp:${image.comp}');
        trace('   image data length: ${image.bytes.length} bytes');
        for(i in 0 ... image.w) {
            var s = '';
            for(j in 0 ... image.comp) {
                s += ' ${image.bytes[i*j]}';
            }
            trace(s);
        }
    }

    // a simple macro to force compilation each time allowing faster iteration
    static inline var forcer:String = Forcer.get();

} //Test
