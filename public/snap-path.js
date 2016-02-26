IDE_Morph.prototype.resourceURL = function () {
    var args = Array.prototype.slice.call(arguments, 0);
    return '/snap/snap/' + args.join('/');
};

// TODO: Move this:
function submitAutograderResults(ag_log) {
    console.log('submitting AG');
    var xml, score, results, ide;
    ide = ag_log.snapWorld.children[0];
    
    if (ag_log.savedXML) {
        xml = ag_log.savedXML;
    } else if (ide) {
        xml = ide.serializer.serialize(ide.stage);
    } else {
        xml = 'ERROR: XML COULD NOT BE SERIALIZED';
    }
    
    score = ag_log.points || 0;
    // Allow JSON stringification
    ag_log.snapWorld = null;
    try {
        results = JSON.stringify(ag_log);
    } catch (e) {
        try {
            results = ag_log.toString();
        } catch (e2) {
            results = JSON.stringify({
                error: 'Could not convert test results to string.',
                message: e2
            });
        }
    }
    
    var formId = '#submission-form'; 
    var dataForm = $(formId);
    console.log('URL: ', dataForm.attr('action'));
    
    var inputs = dataForm.find('input');
    $.ajax({
        type: 'POST',
        url: dataForm.attr('action'),
        data: {
            'score': score,
            'code_submission': xml,
            'test_results': results,
            'utf8': $(inputs[0]).attr('value'),
            'authenticity_token': $(inputs[1]).attr('value')
        },
        success: function () {
            console.log('SUCCESS');
        }
    });
    console.log('Submitted.');
}