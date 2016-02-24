var starter_path = 'spam-ham-starter.xml';
// The id is to act as a course identifier.
// NOTE: FOR NOW YOU ALSO HAVE TO ADD THE ID TO THE BOTTOM OF THE PAGE.
var courseID = "BJC.3x";  // e.g. "BJCx"
// Specify a prerequisite task id, should be null if no such requirement.
var preReqTaskID = null;
var preReqID = courseID + preReqTaskID;
// taskID uniquely identifies the task for saving in browser sessionStorage.
var taskID = "_M3_W2_L1_T3_E1";
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
        'Find average length of words in a given list'
    );

    var blockName = "average length of messages in %"
    var chunk_1 = fb.newChunk('Complete the "' + blockName + '" block.');

    var blockExists_1 = function () {
        return spriteContainsBlock(blockName);
    }

    var tip_1_1 = chunk_1.newTip('Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        'The average length of messages in dataset block exists.');

    tip_1_1.newAssertTest(
        blockExists_1,
        'Testing if the "' + blockName + '" block is in the scripting area.',
        'The "' + blockName + '" block is in the scripting area.',
        'Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        1
    );

    var tip_1_2 = chunk_1.newTip(
        'Your block should return the average length of a message in a given list of messages.',
        'Great job! Your block reports the average length of a message in a given list of messages.'
    );
    var inputWords_1_2 = [['hey how goes it', 'did you have a good day?', 'what is your favorite color!']];
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        inputWords_1_2,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expectedAverage,
                actualAverage;

            expectedAverage = 5;
            actualAverage = output;
            if (actualAverage !== expectedAverage) {
                tip_1_2.suggestion = 'The average length should be ' + expectedAverage + ';';
                tip_1_2.suggestion += ' but was ' + actualAverage + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var inputWords_1_2_0 = [['hi there', 'trees!']];
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        inputWords_1_2_0,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expectedAverage,
                actualAverage;

            expectedAverage = 1.5;
            actualAverage = output;
            if (actualAverage !== expectedAverage) {
                tip_1_2.suggestion = 'The average length should be ' + expectedAverage + ';';
                tip_1_2.suggestion += ' but was ' + actualAverage + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var inputWords_1_2_1 = [['the', 'trees!', 'are', 'waves', '.com']];
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        inputWords_1_2_1,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expectedAverage,
                actualAverage;

            expectedAverage = 1;
            actualAverage = output;
            if (actualAverage !== expectedAverage) {
                tip_1_2.suggestion = 'The average length should be ' + expectedAverage + ';';
                tip_1_2.suggestion += ' but was ' + actualAverage + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    return fb;
}