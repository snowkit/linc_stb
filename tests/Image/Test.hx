class Test {

    static function main() {

        test_memory();
        test_files();

    } //main

    static function test_memory() {

        trace('------- FROM MEMORY');

        var bytes = haxe.Resource.getBytes('image.png');

        inline function test_memory_info() {

            var info = stb.Image.info_from_memory(bytes.getData(), bytes.length);
            print_image_info('memory@image.png', info);
            info = null;

        } //test_memory_info

        inline function test_memory_data() {

            var data = stb.Image.load_from_memory(bytes.getData(), bytes.length);
            print_image_data('memory@image.png', data);
            data = null;

        } //test_memory_data

        test_memory_info();
        test_memory_data();

    } //test_memory

    static function test_files() {

        trace('------- FROM FILES');

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

        inline function test_file_data() {

            var req_comp = 4;
            for(file in files) {
                var data = stb.Image.load(haxe.io.Path.join([file_prefix,file]), req_comp);
                print_image_data(file, data);
                data = null;
            }

        } //test_file_data

        inline function test_file_info() {
            for(file in files) {
                var info = stb.Image.info(haxe.io.Path.join([file_prefix,file]));
                print_image_info(file, info);
                info = null;
            }
        } //test_file_info

        test_file_info();
        test_file_data();

    } //test_files

    static function print_image_data(file:String, image:stb.Image.ImageData) {

        trace('DATA:  $file ${image.w} x ${image.w} comp:${image.comp} req_comp:${image.comp} / ${image.bytes.length} bytes');

        for(i in 0 ... image.w) {
            var s = '';
            for(j in 0 ... image.comp) s += ' ${image.bytes[i*j]}';
            trace(s);
        }

    } //print_image_data

    static function print_image_info(file:String, image:stb.Image.ImageInfo) {

        trace('INFO:  $file ${image.w} x ${image.w} comp:${image.comp}');

    } //print_image_info

    // a simple macro to force compilation each time allowing faster iteration
    static inline var forcer:String = Forcer.get();

} //Test
