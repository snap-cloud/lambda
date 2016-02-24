var starter_path = 'subset_starter.xml';
// The id is to act as a course identifier.
// NOTE: FOR NOW YOU ALSO HAVE TO ADD THE ID TO THE BOTTOM OF THE PAGE.
var courseID = "BJC.3x";  // e.g. "BJCx"
// Specify a prerequisite task id, should be null if no such requirement.
var preReqTaskID = null;
var preReqID = courseID + preReqTaskID;
// taskID uniquely identifies the task for saving in browser sessionStorage.
var taskID = "_M3_W5_L1_T5";
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
        'Subset Sum'
    );

    var blockName = "2 ^ %"
    var chunk_1 = fb.newChunk('Complete the "' + blockName + '" block.');

    var blockExists_1 = function () {
        return spriteContainsBlock(blockName);
    }

    var tip_1_1 = chunk_1.newTip('Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        'The "' + blockName + '" block exists.');

    tip_1_1.newAssertTest(
        blockExists_1,
        'Testing if the "' + blockName + '" block is in the scripting area.',
        'The "' + blockName + '" block is in the scripting area.',
        'Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        1
    );


    var tip_1_2 = chunk_1.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_1_2_1 = [4];
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_1_2_1,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = 16;
            actual = output;
            if (actual !== expected) {
                tip_1_2.suggestion = 'The output should be ' + expected + ';';
                tip_1_2.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var input_1_2_2 = [5];
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_1_2_2,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = 32;
            actual = output;
            if (actual !== expected) {
                tip_1_2.suggestion = 'The output should be ' + expected + ';';
                tip_1_2.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var input_1_2_3 = [17];
    tip_1_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_1_2_3,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = 131072;
            actual = output;
            if (actual !== expected) {
                tip_1_2.suggestion = 'The output should be ' + expected + ';';
                tip_1_2.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );








    var blockName = "% $arrowRight binary list padded to % digits"
    var chunk_2 = fb.newChunk('Complete the "' + blockName + '" block.');

    var blockExists_2 = function () {
        return spriteContainsBlock(blockName);
    }

    var tip_2_1 = chunk_2.newTip('Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        'The "' + blockName + '" block exists.');

    tip_2_1.newAssertTest(
        blockExists_2,
        'Testing if the "' + blockName + '" block is in the scripting area.',
        'The "' + blockName + '" block is in the scripting area.',
        'Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        1
    );


    var tip_2_2 = chunk_2.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_2_2 = [13, 5];
    tip_2_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_2_2,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected1,
                expected2,
                actual;

            expected1 = [1, 0, 1, 1, 0];
            expected2 = [0, 1, 1, 0, 1];

            if (output instanceof List) {
                actual = _.map(output.asArray(), Number);
            } else {
                actual = output;
            }
            //if (!actual.equalTo(expected1) && !actual.equalTo(expected2)) {
            if (!_.isEqual(actual, expected1) && !_.isEqual(actual, expected2)) {
                tip_2_2.suggestion = 'The output should be ' + expected1 + ' or ' + expected2 + ' ;';
                tip_2_2.suggestion += ' but was ' + actual + '.';
                return false;
            } else if (_.isEqual(actual, expected1) || _.isEqual(actual, expected2)) {
                return true;
            } else {
                return false;
            }
            //return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var tip_2_3 = chunk_2.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_2_3 = [13, 4];
    tip_2_3.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_2_3,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected1,
                expected2,
                actual;

            expected1 = [1, 0, 1, 1];
            expected2 = [1, 1, 0, 1];
            if (output instanceof List) {
                actual = _.map(output.asArray(), Number);
            } else {
                actual = output;
            }
            
            if (!_.isEqual(actual, expected1) && !_.isEqual(actual, expected2)) {
                tip_2_2.suggestion = 'The output should be ' + expected1 + ' or ' + expected2 + ' ;';
                tip_2_2.suggestion += ' but was ' + actual + '.';
                return false;
            } else if (_.isEqual(actual, expected1) || _.isEqual(actual, expected2)) {
                return true;
            } else {
                return false;
            }
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );








    var blockName = "Binary List Mask % with %"
    var chunk_3 = fb.newChunk('Complete the "' + blockName + '" block.');

    var blockExists_3 = function () {
        return spriteContainsBlock(blockName);
    }

    var tip_3_1 = chunk_3.newTip('Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        'The "' + blockName + '" block exists.');

    tip_3_1.newAssertTest(
        blockExists_3,
        'Testing if the "' + blockName + '" block is in the scripting area.',
        'The "' + blockName + '" block is in the scripting area.',
        'Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        1
    );


    var tip_3_2 = chunk_3.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_3_2 = [[1, 0, 1], [3, 4, 5]];
    tip_3_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_3_2,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = [3, 0, 5];

            if (output instanceof List) {
                actual = _.map(output.asArray(), Number);
            } else {
                actual = output;
            }
            if (!_.isEqual(actual, expected)) {
                tip_3_2.suggestion = 'The output should be ' + expected + ';';
                tip_3_2.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var tip_3_3 = chunk_3.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_3_3 = [[1, 0, 1, 1, 0], [3, 4, 22, 33, 1087]];
    tip_3_3.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_3_3,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = [3, 0, 22, 33, 0];

            if (output instanceof List) {
                actual = _.map(output.asArray(), Number);
            } else {
                actual = output;
            }
            if (!_.isEqual(actual, expected)) {
                tip_3_3.suggestion = 'The output should be ' + expected + ';';
                tip_3_3.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );





    var blockName = "Subset Sum Solution %"
    var chunk_4 = fb.newChunk('Complete the "' + blockName + '" block.');

    var blockExists_4 = function () {
        return spriteContainsBlock(blockName);
    }

    var tip_4_1 = chunk_4.newTip('Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        'The "' + blockName + '" block exists.');

    tip_4_1.newAssertTest(
        blockExists_4,
        'Testing if the "' + blockName + '" block is in the scripting area.',
        'The "' + blockName + '" block is in the scripting area.',
        'Make sure you name your block exactly "' + blockName + '" and place it in the scripting area.',
        1
    );


    var tip_4_2 = chunk_4.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_4_2 = [[-2, -3, 15, 14, 7, -10]];
    tip_4_2.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_4_2,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = [-2, -3, 15, -10];

            if (output instanceof List) {
                var ar = output.asArray();

                if (ar[0] instanceof List) {
                    actual = _.map(ar[0].asArray(), Number);
                } else {
                    actual = _.map(ar, Number);
                }
            } else {
                actual = output;
            }
            if (!_.isEqual(actual, expected)) {
                tip_4_2.suggestion = 'The output should be ' + expected + ';';
                tip_4_2.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var tip_4_3 = chunk_4.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_4_3 = [[-2, -3, 16, 14, 7, -10]];
    tip_4_3.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_4_3,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = [];

            if (output instanceof List) {
                actual = _.map(output.asArray(), Number);
            } else {
                actual = output;
            }
            if (!_.isEqual(actual, expected)) {
                tip_4_3.suggestion = 'The output should be ' + expected + ';';
                tip_4_3.suggestion += ' but was ' + actual + '.';
                return false;
            }
            return true;
        },
        4 * 1000, // 4 second time out.
        true, // is isolated
        1 // points
    );

    var tip_4_4 = chunk_4.newTip(
        'Your block should return the correct values for given inputs.',
        'Great job! Your block reports the correct value for given inputs.'
    );

    var input_4_4 = [[-2, -3, 0, 14, 7, -10]];
    tip_4_4.newIOTest('r',  // testClass
        blockName,          // blockSpec
        input_4_4,        // input
        function (output) {
            // Output should be a list of 2D lists.
            var expected,
                actual;

            expected = [0];

            if (output instanceof List) {
                actual = _.map(output.asArray(), Number);
            } else {
                actual = output;
            }
            if (_.isEqual(actual, ["0"])) {
                return true;
            } else if (!_.isEqual(actual, expected)) {
                tip_4_4.suggestion = 'The output should be ' + expected + ';';
                tip_4_4.suggestion += ' but was ' + actual + '.';
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