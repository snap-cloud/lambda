IDE_Morph.prototype.resourceURL = function (path, filename) {
    return '/snap/snap/' + (path ? path + '/' : '') + filename;
};