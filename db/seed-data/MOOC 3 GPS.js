var starter_path = 'W1_L1_Starter_GPS_Scraping.xml';
// The id is to act as a course identifier.
// NOTE: FOR NOW YOU ALSO HAVE TO ADD THE ID TO THE BOTTOM OF THE PAGE.
var courseID = "BJC.3x";  // e.g. "BJCx"
// Specify a prerequisite task id, should be null if no such requirement.
var preReqTaskID = null;
var preReqID = courseID + preReqTaskID;
// taskID uniquely identifies the task for saving in browser sessionStorage.
var taskID = "_M3_W1_L1_T?_E?";
var id = courseID + taskID;
var isEDX = isEDXurl();
// if this question is not meant to be graded, change this flag to false
var graded = true;
// to hide feedback for this problem, set this to false
var showFeedback = true;
// to allow ability to regrade certain tests, set this to true
var regradeOn = true;
function AGTest(outputLog) {
    var fb = new FeedbackLog(
        world,
        id,
        'Generate a list of coordinates'
    );

    var blockName = "coordinates list from url %"
    var chunk_1 = fb.newChunk('Complete the ' + blockName + ' block.');

    var blockExists_1 = function () {
        return spriteContainsBlock(blockName);
    }

    var tip_1_1 = chunk_1.newTip('Make sure you name your block exactly ' + blockName + ' and place it in the scripting area.',
        'The coordinates block exists.');

    tip_1_1.newAssertTest(
        blockExists_1,
        "Testing if the " + blockName + " block is in the scripting area.",
        "The " + blockName + " block is in the scripting area.",
        "Make sure you name your block exactly " + blockName + " and place it in the scripting area.",
        1
    );

    var tip_1_2 = chunk_1.newTip(
        'Your block should return a list of coordinates.',
        'Great job! Your block reports a list of coordinates.'
    );
    var inputCSVURL = 'bjc.edc.org/bjc-r/cur/programming/4-internet/2-gps-data/GPS-NYC.csv';
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        inputCSVURL,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expectedLength,
                type,
                outLength, item, i;

            type = Process.prototype.reportTypeOf(output);
            expectedLength = 223;
            if (type !== 'list') {
                tip_1_2.suggestion = 'Your block must return a list,';
                tip_1_2.suggestion += ' but returned a type "' + type + '".';
                return false;
            }
            outLength = output.length();
            if (outLength !== expectedLength) {
                tip_1_2.suggestion = 'You list should have length 223;';
                tip_1_2.suggestion += ' but was ' + outLength + '.';
                return false;
            }
            // FIXME: Not great if list is linked.
            for (i = 1; i <= outLength; i+= 1) {
                item = output.at(i);
                if (Process.prototype.reportTypeOf(item) !== 'list') {
                    tip_1_2.suggestion = 'Output item ' + i + ' should be a list.';
                    return false;
                }
                if (item.length() !== 2) {
                    tip_1_2.suggestion = 'Output item ' + i + ' should have length 2.';
                    return false;
                }
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    return fb;
}