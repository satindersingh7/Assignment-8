function documentvideo(src, arg) {

    var fileName = arg.Value;
    var ext;
    ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
    if (fileName == '') {
        arg.IsValid = false;
    }
    if ('.mp4,.MP4'.indexOf(ext + ',') < 0) {
        arg.IsValid = false;
    }
    else
        arg.IsValid = true;
}

function documentType(src, arg) {

    var fileName = arg.Value;
    var ext;
    ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
    if (fileName == '') {
        arg.IsValid = false;
    }
    if ('.jpg,.JPG,.gif,.GIF,.png,.PNG,.jpeg,.JPEG,.bmp,.BMP'.indexOf(ext + ',') < 0) {
        arg.IsValid = false;
    }
    else
        arg.IsValid = true;
}

function imageType(src, arg) {

    var fileName = arg.Value;
    var ext;
    ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
    if (fileName == '') {
        arg.IsValid = false;
    }
    if ('.jpg,.JPG,.gif,.GIF,.png,.PNG,.jpeg,.JPEG,.bmp,.BMP'.indexOf(ext + ',') < 0) {
        arg.IsValid = false;
    }
    else
        arg.IsValid = true;
}

function imagePdfType(src, arg) {

    var fileName = arg.Value;
    var ext;
    ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
    if (fileName == '') {
        arg.IsValid = false;
    }
    if ('.jpg,.JPG,.gif,.GIF,.png,.PNG,.jpeg,.JPEG,.pdf,.PDF,.bmp,.BMP'.indexOf(ext + ',') < 0) {
        arg.IsValid = false;
    }
    else
        arg.IsValid = true;
}

function documentType2(src, arg) {

    var fileName = arg.Value;
    var ext;
    ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
    if (fileName == '') {
        arg.IsValid = false;
    }
    if ('.pdf,.PDF,.doc,.DOC,.docx,.DOCX,.ppt,.PPT,.pptx,.PPTX,.xls,.XLS,.xlsx,.XLSX'.indexOf(ext + ',') < 0) {
        arg.IsValid = false;
    }
    else
        arg.IsValid = true;
}

function documentExcel(src, arg) {

    var fileName = arg.Value;
    var ext;
    ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
    if (fileName == '') {
        arg.IsValid = false;
    }
    if ('.xls,.XLS'.indexOf(ext + ',') < 0) {
        arg.IsValid = false;
    }
    else
        arg.IsValid = true;
}