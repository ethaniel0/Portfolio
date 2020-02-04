
///////////// TRIANGLE LIGHTS VARS /////////////
{
    var numLights = 10;
    var lightSize = 4;
    var lightBorder = 0.3;
    var distFromTop = 25;
    var distFromMid = 23;
    var topSep = lightSize*0.7;
    
    var slopePct = 100*(100 - 2*distFromTop)/distFromMid;
   
   // two arrays, left and right strip from top to bottom
   var lights = [[], []];
}

///////////// TRIANGLE MODIFIERS VARS /////////////
{
    var cChooseDist = lightSize*1.5;
    var dotSize = lightSize/3;
    var dotBorder = 0.1;
    
    // contains the divs for the four boxes that determine color
    
    // CCs = color choosers
    var leftCCs = [];
    var rightCCs = [];
    
    var noMotionCCs = [];
    
    var stripConnector;
}


///////////// VARS FOR TRI MODIFIERS /////////////
{
    var colorPickerOn = false;
    var colorpicker = document.getElementById('colorpicker');
    var currentColorPicker = 0;
    var cpPatternNum = 0; // colorpicker pattern num
    var patternElts = document.getElementById('patterns').getElementsByClassName('patternSelector');
    var transitionElts = document.getElementById('patterns').getElementsByClassName('transition');
    
    var cpmenu = document.getElementById('cpmenu');
    var addcp = document.getElementById('addcp');
    
    var topDot;
    
}

///////////// TRIANGLE DESCRIPTION /////////////
// holds everything needed for everything on screen
var triPts = {
    
    numLEDs: 91, // number of LEDs per strip
    frameRate: 20,
    
    left: {
        motion: true,
        ledSameValues: false,
        
        patterns: [
            {
                led: 0, // led number
                direction: 2, // 0 = none, 1 = up, 2 = down, 3 = both directions
                parts: [
                    {
                        colors: [[0, 100, 50], [0, 100, 50]], // all colors
                        mods: 0, // none, random, mic
                        frames: 1, // seconds the color stays on before moving on
                        transition_type: "Fade",
                        transition_time: 0 // transition time in frames
                    }
                ]
            }
        ]
        
    },
    right: {
        motion: true,
        ledSameValues: false,
        
        patterns: [
            // led
            {
                led: 0, // led number
                direction: 2, // 0 = none, 1 = up, 2 = dpwn, 3 = both directions
                // parts of the pattern for the LED
                parts: [
                    {
                        colors: [[0, 100, 50], [0, 100, 50]], // all colors
                        mods: 0, // none, random, mic
                        frames: 1, // seconds the color stays on before moving on
                        transition_type: "Fade",
                        transition_time: 0 // transition time in frames
                    }
                ]
            }
        ]
    },
    
    // top dot
    stripConnect: false
}

function round(num, decimals){
    if (decimals == undefined) return Math.round(num);
    
    return Math.round(num*Math.pow(10, decimals)) / Math.pow(10, decimals);
}

// toggles the 'hide' class (true = show, false = hide)
function toggleElement(element, value){
    if (element.classList.contains('hide') == value){
        element.classList.toggle('hide');
    }
}

// toggles any class of an element (value: true = toggle on, false = toggle off)
function toggleClass(cls, element, value){
    if (element.classList.contains(cls) != value){
        element.classList.toggle(cls);
    }
}

// the class that holds everything needed for a colorchooser
class CC{
    
    // sets up and places all of the elements
    constructor(side, ledNum, index){
        
        // initial vars
        this.index = index;
        this.side = side;
        this.led = ledNum;
        this.cc = document.createElement('div'); // colorchooser (container)
        this.rect = document.createElement('div'); // color box
        this.dot = document.createElement('div'); // direction dot
        this.dotDir = 0; // direction of the dot
        
        // 0 = dot, 1 = up, 2 = down, 3 = both
        if (ledNum == 0) this.dotDir = 2; 
        else if(ledNum == triPts.numLEDs) this.dotDir = 1;
        else this.dotDir = 3;
        
        
        
        // set the color box
        this.rect.setAttribute('class', 'rect');
        this.rect.style.position = 'absolute';
        this.rect.style.width = lightSize + "vw";
        this.rect.style.height = lightSize + "vh";
        this.rect.style.border = lightBorder + "vw solid black";
        this.rect.style.background = "hsl(0, 100%, 50%)";
        this.rect.style.cursor = "pointer";
        this.rect.oncontextmenu = cpOptions.bind(this);
        
        // set the direction dot
        this.dot.setAttribute('class', 'dot');
        this.dot.style = "position: absolute; " + 
                         "width: " + dotSize + "vw; " + 
                         "height: " + dotSize + "vh; " + 
                         "top: " + (lightSize/2 + lightBorder - dotSize/2) + 'vh;' + 
                         "cursor: pointer;";
        
        this.changeDot(2);
        
        
        if (side == 'left'){
            this.dot.style.right = '0vw';

            
            
            this.cc.appendChild(this.rect);
            this.cc.appendChild(this.dot);
        }
        else{
            this.dot.style.left = '0vw';
            this.rect.style.right = '0vw';
            
            this.cc.appendChild(this.dot);
            this.cc.appendChild(this.rect);
        }
        
        
        this.rect.onclick = makeColorPicker.bind(this);
        
        // binds the onclick to the changeDot function in this class
        this.dot.onclick = this.changeDot.bind(this);
        
        
        ///////////////////////////////////////
        
        
        var sidePos = side == 'left'? 'right' : 'left';
        
        
        var xy = this.getXY(side, ledNum);
        var xdist = xy[0];
        var ydist = xy[1];
        
        this.cc.style = "position: absolute; " + 
                        sidePos + ": " + xdist + "vh; " + 
                        "top: " + ydist + "vh; " + 
                        "height: " + (lightSize + 2*lightBorder) + "vh; " + 
                        "width: " + (2*lightSize) + "vw;";
        
        document.body.appendChild(this.cc);
    }
    
    // gets the x and y positions for elements based on the side of the triangle it's on and the LED number
    getXY(side, ledNum){
        
        var xMod = topSep + lightSize/2 + cChooseDist/2 + ledNum*distFromMid/91
        
        var xdist = 50 + xMod;
        
        var sidePos = side == 'left'? 'right' : 'left';
        
        var ydist = distFromTop + (ledNum/triPts.numLEDs)*(100 - 2*distFromTop) - lightSize/2 - lightBorder/2;
        
        return [xdist, ydist];
        

    }
    
    // shows the colorchooser
    show(){
        toggleElement(this.cc, true);
    }
    
    // hides the colorchooser
    hide(){
        toggleElement(this.cc, false);
    }
    
    // moves the colorchooser to an LED (uses getXY)
    move(ledNum){
        
        this.led = ledNum;
        
        var xy = this.getXY(this.side, ledNum);
        
        var xdist = xy[0];
        var ydist = xy[1];
        
            
        this.cc.style.top = ydist + "vh";
        var sidePos = this.side == 'left'? 'right' : 'left';
        this.cc.style[sidePos] = xdist + "vh";
        
    }
    
    // changes dot from dot --> arrow up --> arrow down --> both directions
    changeDot(dir){
        // dotDir: 0 = dot, 1 = up, 2 = down, 3 = both
        if (typeof(dir) != 'number'){
            
            if (this.led == 0 && !triPts.stripConnect){
                // 0 and 2

                this.dotDir = this.dotDir < 2 ? 2 : 0;

            }
            else if (this.led == triPts.numLEDs-1){
                // 0 and 1
                this.dotDir = this.dotDir < 1 ? 1 : 0;
            }
            else{
                this.dotDir = (this.dotDir + 1) % 4
            }
    
        } 
        else{
            this.dotDir = dir;
        }
        
        if (this.index < triPts[this.side].patterns.length){
            triPts[this.side].patterns[this.index].direction = this.dotDir;
        }
        
        
        var deg = 180 * Math.atan(slopePct/100)/Math.PI;
        if (this.dotDir == 1) deg += 180;
    
        if (this.dotDir == 0){
            this.dot.style.width = dotSize + "vw";
            this.dot.style.height = dotSize + "vh";
            
            toggleClass('dot', this.dot, true);
            toggleClass('arrow', this.dot, false);
            toggleClass('dualArrow', this.dot, false);
        }
        else{
            this.dot.style.width = dotSize + "vw";
            this.dot.style.height = 2*dotSize + "vh";
            toggleClass('dot', this.dot, false);
            
            if (this.dotDir == 3){ // both directions
                toggleClass('arrow', this.dot, false);
                toggleClass('dualArrow', this.dot, true);
            }
            else{ // up or down
                toggleClass('arrow', this.dot, true);
                toggleClass('dualArrow', this.dot, false);
            }
        }
        
        
        var dir = (90 - deg) * this.side == 'right' ? -1 : 1;
        
        // if the left side
        if (this.side == "left"){
            
            this.dot.style.transform = "rotate(" + (90 - dir*deg) + "deg)";
            
            
        }
        // if the right side
        else{
            this.dot.style.transform = "rotate(" + (270 + deg*dir) + "deg)";
        }
        
    }
    
    generateBackground(colors){
        
        if (colors.length == 1){
            return "hsl(" + colors[0][0] + ", " + colors[0][1] + "%, " + colors[0][2] + "%)";
        }
        
        var background = "linear-gradient(to right, ";
        
        colors.forEach(function(i){
            background += "hsl(" + i[0] + ", " + i[1] + "%, " + i[2] + "%), ";
        });
        
        background = background.substring(0, background.length - 2);
        background += ")";
        
        return background;
        
    }
    
    
    setBackground(colors){
        
        var background = this.generateBackground(colors);

        this.rect.style.background = background;
    }
    
    
}
           
// makes a circle and immediately places it on the screen and returns it
function ellipse(x, y, width, height, color, strokeWeight){
    if (color == undefined) color = 'red';
    if (strokeWeight == undefined) strokeWeight = 1;
    var c = document.createElement("div");
    c.setAttribute('class', 'circle');
    
    
    c.style = 
       "left: " + (x-width/2 - strokeWeight) + "vw;" + 
       "top: " + (y-height/2 - strokeWeight) + "vh;" + 
       "width: " + width + "vw;" + 
       "height: " + height + "vh;" + 
       "border: " + strokeWeight + "vw solid black;" + 
       "background: " + color + ";";
    
    
    document.getElementById("tri-container").appendChild(c);
    return c; 
}

// makes and sets the circles that make up the triangle
function makeTriangle(){
   for (var i = 0; i < numLights; i++){
       var c1 = ellipse(
           50 - topSep - i*(distFromMid - topSep)/(numLights-1), 
           
           distFromTop + i*(100-2*distFromTop)/(numLights-1), 
           
           lightSize, lightSize, 'rgba(0, 0, 0, 0)', lightBorder);


       var c2 = ellipse(
           50 + topSep + i*(distFromMid - topSep)/(numLights-1),
           
           distFromTop + i*(100-2*distFromTop)/(numLights-1),
           
           lightSize, lightSize, 'rgba(0, 0, 0, 0)', lightBorder);

       lights[0].push(c1);
       lights[1].push(c2);
   }
}

// for middle dot
function dirDots(){

   // middle
   var m = ellipse(
       50,
       
       distFromTop - 5,
       
       dotSize, dotSize, 'rgba(0, 0, 0, 255)', dotBorder);

}

function makePatternSelector(changeTriPts){
    if (changeTriPts == undefined) changeTriPts = true;
    
    // make the transition -- fade vs sweep
    
    var transBox = document.createElement("div");
    transBox.setAttribute("class", "transitionBox");
    
    var transtype = document.createElement("span");
    transtype.setAttribute("onclick", "changeTransType(this)");
    transtype.style.cursor = "pointer";
    transtype.innerHTML = "Fade";
    
    
    var transition = document.createElement("input");
    transition.setAttribute('class', 'rgbinput transition');
    transition.setAttribute('type', 'number');
    transition.setAttribute('style', 'width: 3vw; height: 2.5vh; font-size: 1.8vh;');
    transition.setAttribute('value', 0);
    transition.setAttribute('onchange', 'setPatternTransition(this)');
    
    transBox.appendChild(transtype);
    transBox.appendChild(transition);
    
    // make the selector
    var c = document.createElement('div');
    c.setAttribute('class', 'patternSelector');
    c.setAttribute('onclick', 'changePatternNum(this)');
    
    var input = document.createElement('input');
    input.setAttribute('class', 'rgbinput psinput');
    input.setAttribute('type', 'number');
    input.setAttribute('style', 'width: 3vw; height: 2.5vh; text-align: center; font-size: 1.8vh;');
    input.setAttribute('value', 1);
    input.setAttribute("onchange", "setPatternFrames(this)");
    
    
    var dot = document.createElement('div');
    dot.setAttribute("class", "patternDot");
    dot.style.background = "red";
    
    // append the parts of the selector to the selector
    c.appendChild(input);
    c.appendChild(dot);
    
    // put in the nodes after the currently selected node
    var ce = patternElts[cpPatternNum];
    
    if (cpPatternNum < patternElts.length-1){
        var after = patternElts[cpPatternNum + 1];
        
        ce.parentNode.insertBefore(c, after);
        ce.parentNode.insertBefore(transBox, after);
        
    }
    else{
        ce.parentNode.appendChild(c);
        ce.parentNode.appendChild(transBox);
    }
    
    
    if (changeTriPts){
        var side = currentColorPicker.side;
        var index = currentColorPicker.index;
        triPts[side].patterns[index].parts.splice(cpPatternNum+1, 0, {
            colors: [[0, 100, 50]], // all colors
            mods: 0, // none, random, mic
            frames: 1, // seconds the color stays on before moving on
            transition_type: "Fade",
            transition_time: 0 // transition time in frames
        });
    }
    
}
function removePatternSelector(changeTriPts){
    if (changeTriPts == undefined) changeTriPts = true;
    
    if (patternElts.length > 1){
        // remove the elements
        var current = patternElts[cpPatternNum]; 
        current.parentElement.removeChild(transitionElts[cpPatternNum].parentNode);
        current.parentElement.removeChild(current);

        setCpPatternNum(cpPatternNum);

        if (changeTriPts){
            // make the changes in triPts
            var side = currentColorPicker.side;
            var index = currentColorPicker.index;
            
            triPts[side].patterns[index].parts.splice(cpPatternNum,1);
        }
    }
    
}

// updates graphics
function showTriangle(){

    function doSide(part, side){
        var ccs = side == 'left' ? leftCCs : rightCCs;
        if (part.motion){
            
            for (var i = 0; i < part.patterns.length; i++){
                ccs[i].move(part.patterns[i].led);
               
                ccs[i].changeDot(part.patterns[i].direction)
                ccs[i].setBackground(part.patterns[i].parts[0].colors);
            }
        }
        else{

        }
        
    }
    
    doSide(triPts.left, 'left');
    doSide(triPts.right, 'right');
    
    
}

function setCpPatternNum(num){
    cpPatternNum = num;
    
    var patterns = document.getElementById('patterns').getElementsByClassName('patternSelector');
    
    for (var i = 0; i < patternElts.length; i++){
        
        toggleClass('patternSelected', patterns[i], i == num);
        
    }
}

function cpCheckboxes(part, index, patternNum){
    
    var sliderIU = monSlider;
    
    // check or uncheck the boxes
    var rand = document.getElementById('use-random');
    var mic = document.getElementById('use-mic');
    
    rand.checked = part.patterns[index].parts[patternNum].mods == 1;
    mic.checked = part.patterns[index].parts[patternNum].mods == 2;
    
    // variable, used to check if the bottom slider is out
    var monSlider = document.getElementById('monSlider');
    var randSliders = document.getElementById('randSliders');
    var micSliders = document.getElementById('micSliders');
    
    toggleElement(micSliders, false);
    toggleElement(monSlider, false);
    toggleElement(randSliders, false);
    
    // if random is checked, hide the other types of sliders
    if (rand.checked){
        toggleElement(randSliders, true);
        
        sliderIU = randSliders;
    }
    // if mic is checked, hide the other types of sliders
    else if (mic.checked){
        toggleElement(micSliders, true);
        
        sliderIU = micSliders;
    }
    // if neither mic nore random are used, use the monoslider
    else{
        toggleElement(monSlider, true);   
        
        sliderIU = monSlider;
    }
    
    return sliderIU;
    
}
function adjustSliders(part, sliderIU, index, patternNum){
    
    // get the colors
    var colors = part.patterns[index].parts[patternNum].colors
    
    var inputs = sliderIU.getElementsByClassName('hslIn');
    
    // get the sliders
    sliderIU = sliderIU.getElementsByClassName('cslider');
    
    // change the slider value
    for (var i = 0; i < sliderIU.length; i+= 2){
        sliderIU[i].value = colors[(i/2)%colors.length][0];
        sliderIU[i+1].value = colors[(i/2)%colors.length][2];
    }
    
    // change input values
    for (var i = 0; i < inputs.length; i++){
        inputs[i][0].value = colors[i][0];
        inputs[i][1].value = colors[i][1];
        inputs[i][2].value = colors[i][2];
    }
    
}
function placeRectId(rect, side, led){
    // set the background of the the reference colorchooser
    var rectId = document.getElementById('rectId');
    rectId.style.background = rect.style.background;
        
    
    // set the x and y position of the reference colorchooser
    if (side == 'left'){
        rectId.style.left = "1vw";
        rectId.style.right = "";
    }
    else{
        rectId.style.right = "1vw";
        rectId.style.left = "";
    }
    
    rectId.style.top = ((75 - 100*rectId.clientHeight/window.innerHeight - 2)*(led/triPts.numLEDs) + 1) + "vh";
    
    // get the input
    var input = document.getElementById("moveLED");
    var value = parseInt(input.value);
    
    if (input.style.top == "" && value < triPts.numLEDs/2){
        input.style.top = input.style.bottom;
        input.style.bottom = "";
        
    }
    if (input.style.bottom == "" && value > triPts.numLEDs/2){
        input.style.bottom = input.style.top;
        input.style.top = "";
    }
}

function adjustPatterns(side, index){
    var numPatterns = triPts[side].patterns[index].parts.length;
    
    var changes = patternElts.length - numPatterns;
    
    // adjust the amount of pattern modules
    if (changes > 0){
        for (var i = 0; i < changes; i++){
            removePatternSelector(false);
        }
    }
    else{
        for (var i = 0; i < -changes; i++){
            makePatternSelector(false);
        }
    }
    
    // adjust the backgrounds of the modules
    for (var i = 0; i < patternElts.length; i++){
        
        var background = currentColorPicker.generateBackground(triPts[side].patterns[index].parts[i].colors);
        
        patternElts[i].getElementsByClassName("patternDot")[0].style.background = background;
        
    }
    
    
    var transitions = document.getElementsByClassName('transition');
    
    for (var i = 0; i < transitions.length; i++){
        transitions[i].value = triPts[side].patterns[index].parts[i].transition_time;
    }
    
    var frameInputs = document.getElementsByClassName("psinput");
    
    for (var i = 0; i < frameInputs.length; i++){
        frameInputs[i].value = triPts[side].patterns[index].parts[i].frames;
    }
    
    
    
}

// sets up the color picker
function makeColorPicker(){
    var motion = triPts[this.side].motion;
    
    // get the colorpicker, make it visible
    colorpicker = document.getElementById('colorpicker');
    
    colorpicker.classList.toggle('hide');
    
    // set the current colorpicker and pattern number
    currentColorPicker = this;
    
    setCpPatternNum(0);
    
    // show/hide the led mover depending on of there's motion
    toggleElement(document.getElementById("moveLED"), motion);

    // get the led move input to show the right led
    document.getElementById("moveLED").value = this.led + 1;
    
   // set the background of the colorchooser
    this.setBackground(triPts[this.side].patterns[this.index].parts[0].colors);
    

    // the side of the triangle
    var part = triPts[this.side];
    
    var sliderIU = cpCheckboxes(part, this.index, 0);
    
    adjustSliders(part, sliderIU, this.index, 0);
    
    
    placeRectId(this.rect, this.side, this.led);
    
    if(motion){
        toggleElement(document.getElementById("useSameValues"), false);
    }
    else if (!motion && sliderIU.id == 'randSliders'){
        toggleElement(document.getElementById("useSameValues"), true);
    }
    
    // adjust patterns
    adjustPatterns(this.side, this.index);
    
}

function closeCP(obj){
    toggleElement(obj.parentNode, false); 
    showTriangle();
}

function changeColorPicker(patternNum){
    // the side of the triangle
    var part = triPts[currentColorPicker.side];
    
    var index = currentColorPicker.index;
    
    var sliderIU = cpCheckboxes(part, index, patternNum);
    
    adjustSliders(part, sliderIU, currentColorPicker.index, patternNum);
}

// changes the color of the colorchooser when a slider is slid
function setColor(pos){
    // pos: mon = monoslider, rand = randSliders, mic = micSliders
    
    var sliders;
    var inputs;
    
    if (pos == 'mon'){
        sliders = document.getElementById('monSlider').getElementsByClassName('cslider');
        container = document.getElementById('monSlider');
        
        inputs = document.getElementById('monSlider').getElementsByClassName('hslIn');
    }
    else{
        sliders = document.getElementById(pos + "Sliders").getElementsByClassName("cslider");
        
        
         inputs = document.getElementById(pos + "Sliders").getElementsByClassName('hslIn');
    }
    
    var hs1;
    var hs2;

    // get the colors of the sliders
    if (sliders.length == 4){
        hs1 = [parseFloat(sliders[0].value), parseFloat(inputs[0][1].value), parseFloat(sliders[1].value)];
        
        hs2 = [parseFloat(sliders[2].value), parseFloat(inputs[1][1].value), parseFloat(sliders[3].value)];
    }
    else{
        hs1 = [parseFloat(sliders[0].value), parseFloat(inputs[0][1].value), parseFloat(sliders[1].value)];
        
        hs2 = [parseFloat(sliders[0].value), parseFloat(inputs[0][1].value), parseFloat(sliders[1].value)];
        
    }
    
    // get the side of the triangle and index of the colorpicker
    var side = currentColorPicker.side;
    var index = currentColorPicker.index;
    
    // update triPts
    triPts[side].patterns[index].parts[cpPatternNum].colors[0] = hs1;
    
    triPts[side].patterns[index].parts[cpPatternNum].colors[1] = hs2;
    
    // show the color scheme
    currentColorPicker.setBackground([hs1, hs2]);
    
    document.getElementById('rectId').style.background = currentColorPicker.rect.style.background;
    
    // style the patternselector
    patternElts[cpPatternNum].getElementsByClassName("patternDot")[0].style.background = currentColorPicker.rect.style.background;
    
    
    
    
    if (inputs.length == 1){
        inputs[0][0].value = hs1[0];
        inputs[0][1].value = hs1[1];
        inputs[0][2].value = hs1[2];
    }
    else{
        inputs[0][0].value = hs1[0];
        inputs[0][1].value = hs1[1];
        inputs[0][2].value = hs1[2];
        
        inputs[1][0].value = hs2[0];
        inputs[1][1].value = hs2[1];
        inputs[1][2].value = hs2[2];
    }

    
}

// sets the color from the input
function setColorFromHSL(pos){
    
    var sliders;
    var inputs;
    if (pos == 'mon'){
        sliders = document.getElementById('monSlider').getElementsByClassName('cslider');
        
        inputs = document.getElementById('monSlider').getElementsByClassName('hslIn');
    }
    else{
        sliders = document.getElementById(pos + "Sliders").getElementsByClassName("cslider");
        
        inputs = document.getElementById(pos + "Sliders").getElementsByClassName('hslIn');
    }
    
    
    // get the colors of the sliders
    if (sliders.length == 4){
        sliders[0].value = inputs[0][0].value;
        sliders[1].value = inputs[0][2].value;
        sliders[2].value = inputs[1][0].value;
        sliders[3].value = inputs[1][2].value;
    }
    else{
        sliders[0].value = inputs[0][0].value;
        sliders[1].value = inputs[0][2].value;
        
    }
    
    
    
    setColor(pos);
    
}

// when the random or mic checkboxes are clicked, add a second pair of sliders
function addSecondSlider(type){
    
    var rand = document.getElementById('randSliders');
    var mic = document.getElementById('micSliders');
    var mon = document.getElementById('monSlider');
    var cycle = document.getElementById('cycleSliders');
    
    var micCheck = document.getElementById('use-mic');
    var randCheck = document.getElementById('use-random');
    var cycleCheck = document.getElementById('cycle-colors');
    
    toggleElement(rand, false);
    toggleElement(mic, false);
    toggleElement(mon, false);
    
    // toggle the "same light values" if no motion
    if (!triPts[currentColorPicker.side].motion){
        toggleElement(document.getElementById("useSameValues"), randCheck.checked);
    }
    else{
        toggleElement(document.getElementById("useSameValues"), false);
    }
    
    if (type == 'Random'){
        
        if (randCheck.checked){
            toggleElement(rand, true);
            
            micCheck.checked = false;
        }
        else{
            toggleElement(mon, true);
        }
        
        
        
    }
    
    if (type == 'Mic'){
        
        if (micCheck.checked){
            toggleElement(mic, true);
            
            randCheck.checked = false;
            
        }
        else{
            toggleElement(mon, true);
        }
        
    }
    
    var mod = 0;
    if (randCheck.checked) mod = 1;
    if (micCheck.checked) mod = 2;
    
    var side = currentColorPicker.side;
    var index = currentColorPicker.index;
    triPts[side].patterns[index].parts[cpPatternNum].mods = mod;
    
}

// puts the motion checkboxes in the right place
function checkboxes(){
    var formL = document.getElementById('motion-left');
    
    formL.style.right = (50 + distFromMid/2 + lightSize*6) + 'vw';
    formL.style.top = '45vh';
    
    var formR = document.getElementById('motion-right');
    
    formR.style.left = (50 + distFromMid/2 + lightSize*6) + 'vw';
    formR.style.top = '45vh';
}

// changes the motion in TriPts (called by checkbox onclicks)
function changeMotion(side, state){
    triPts[side].motion = state;
    
    var index = side=="left" ? 0 : 1;
    
    var ccs = side=="left" ? leftCCs : rightCCs;
    
    // show or hide the colorpickers
    ccs.forEach(function(i){
            toggleElement(i.cc, state);
    });
    
    // toggle the noMotion CC
    if (state)
        toggleElement(noMotionCCs[index].cc, false);
    else
        toggleElement(noMotionCCs[index].cc, true);
    
    
    
    showTriangle();
    
}

// called by pattern onclicks
function changePatternNum(obj){
    var arrp = []
    
    for (var i = 0; i < patternElts.length; i++){
        arrp.push(patternElts[i]);
    }
    
    var index = arrp.indexOf(obj)
    setCpPatternNum(index);
    changeColorPicker(index);
    
    var side = currentColorPicker.side;
    var pindex = currentColorPicker.index;
    
    var mod = triPts[side].patterns[pindex].parts[index].mods;
    if (mod == 0) setColor("mon");
    if (mod == 1) setColor("rand");
    if (mod == 2) setColor("mic");
}

function setPatternFrames(obj){
    
    obj.value = parseInt(obj.value);
    
    var side = currentColorPicker.side;
    var index = currentColorPicker.index;
    
    triPts[side].patterns[index].parts[cpPatternNum].frames = obj.value;
    
    
}

function setPatternTransition(obj){
    
    obj.value = parseInt(obj.value);
    
    function getIndex(main, obj){
        for (var i = 0; i < main.length; i++){
            if (main[i] == obj) return i;
        }
        return -1;
    }
    
    var side = currentColorPicker.side;
    var index = currentColorPicker.index;
    
    var transitions = document.getElementsByClassName("transition");
    
    var tindex = getIndex(transitions, obj);
    
    if (tindex != -1){  triPts[side].patterns[index].parts[tindex].transition_time = parseInt(obj.value);
    }
    
    
}

function changeFramerate(){
    var el = document.getElementById('framerate');
    if (el.value != ''){
        triPts.frameRate = parseFloat(el.value);
    }
    else{
        el.value = triPts.frameRate;
    }
}

function changeTransType(obj){
    
    var container = document.getElementById('selectors');
    var parts = container.getElementsByTagName('span');
    
    var index = -1;
    
    for (var i = 0; i < parts.length; i++){
        if (parts[i] == obj){
            index = i;
            break;
        }
    }
    
    obj.innerHTML = (obj.innerHTML == "Fade") ? "Sweep" : "Fade";
    
    var cpindex = currentColorPicker.index;
    var side = currentColorPicker.side
    
    triPts[side].patterns[cpindex].parts[index].transition_type = obj.innerHTML;
}

function cpOptions(e){
    
    if (triPts[this.side].motion){
        stopClickPropogtion();

        currentColorPicker = this;

        toggleElement(cpmenu, true);

        cpmenu.style.left = e.clientX + "px";
        cpmenu.style.top = (e.clientY - cpmenu.clientHeight) + "px";


        return false;
    }
}

function deleteCP(){
    
    var side = currentColorPicker.side;
    
    var index = currentColorPicker.index;
    
    var cc = currentColorPicker.cc;
    
    toggleElement(cpmenu, false);
    
    triPts[side].patterns.splice(index, 1);

    
    cc.parentNode.removeChild(cc);
    
    var ccs = side=="left" ? leftCCs : rightCCs;
    
    ccs.splice(index, 1);
    
    for (var i = index; i < ccs.length; i++){
        ccs[i].index --;
    }
    
    showTriangle();
    
}

function moveCP(){
    // get all the variables
    var side = currentColorPicker.side;
    var index = currentColorPicker.index;
    var cc = currentColorPicker.cc;
    var input = document.getElementById("moveLED");
    var value = parseInt(input.value);
    
    var proceed = true;
    var ccs = side == "left" ? leftCCs : rightCCs;
    
//    console.log(value);
    for (var i = 0; i < ccs.length; i++){
//        console.log(ccs[i].led - 1)
        if (ccs[i].led == value - 1){
            proceed = false;
            break;
        }
        
    }
    
    if (proceed){
        // if it's not a valid value, revert it
        if (value > triPts.numLEDs || value < 1){
            value = currentColorPicker.led + 1;
            input.value = value;
        }

        // set the value
        triPts[side].patterns[index].led = value-1;

        // move the rect
        var rectId = document.getElementById('rectId');
        rectId.style.top = ((75 - 100*rectId.clientHeight/window.innerHeight - 2)*((value-1)/triPts.numLEDs) + 1) + "vh";


        // change the position of the input after halfway

        if (input.style.top == "" && value < triPts.numLEDs/2){
            input.style.top = input.style.bottom;
            input.style.bottom = "";

        }
        if (input.style.bottom == "" && value > triPts.numLEDs/2){
            input.style.bottom = input.style.top;
            input.style.top = "";
        }

        showTriangle();
    }
    
}

function addCP(){
    
    var left = parseFloat(addcp.style.left);
    var bottom = parseFloat(addcp.style.top) + addcp.clientHeight;
    
    var x = 100*left/window.innerWidth;
    var y = 100*bottom/window.innerHeight;
    
    x = round(x, 2);
    y = round(y, 2);
    
    
    var ccs = x <= 50 ? leftCCs : rightCCs;
    var side = x <= 50 ? "left" : "right";
    
    var yReference = 0;
    if (y < distFromTop){
        yReference = 0;
    }
    else if (y > 100 - distFromTop){
        yReference = triPts.numLEDs - 1;
    }
    else{
        yReference = Math.floor((y-distFromTop) / ((100-2*distFromTop)/triPts.numLEDs));
    }
    
    
    var cc = new CC(side, yReference, ccs.length);
    ccs.push(cc);
    
    triPts[side].patterns.push({
                led: yReference, // led number
                direction: 0, // 0 = none, 1 = down, 2 = up, 3 = both directions
                parts: [
                    {
                        colors: [[0, 100, 50], [0, 100, 50]], // all colors
                        mods: 0, // none, random, mic
                        frames: 1, // seconds the color stays on before moving on
                        transition_type: "Fade",
                        transition_time: 0 // transition time in frames
                    }
                ]
            });
    
    
    showTriangle();
    
    toggleElement(addcp, false);
}

function stopClickPropogtion(e){
    var evt = e ? e : window.event;

    if (evt.stopPropagation) {evt.stopPropagation();}
    else {evt.cancelBubble=true;}
    return false;
}

function useSameLEDs(obj){
    triPts[currentColorPicker.side].ledSameValues = obj.checked;
}

function makeTopDot(){
    var dot = document.createElement('div'); // direction dot
    // set the direction dot
    dot.setAttribute('class', 'dot');
    dot.style = "position: absolute; " + 
                     "width: " + dotSize + "vw; " + 
                     "height: " + dotSize + "vh; " + 
                     "top: "+(distFromTop-lightSize*2)+'vh;'+
                     "left: "+(50-dotSize/2-dotBorder)+"vh;" + 
                     "cursor: pointer;";
    dot.onclick = changeTopDot.bind(this);
    document.body.appendChild(dot);
    
    topDot = dot;
}

function changeTopDot(){
    console.log(triPts);
    
    topDot.classList.toggle("dot");
    topDot.classList.toggle("cdArrow");
    
    if (topDot.classList.contains("cdArrow")){
        triPts.stripConnect = true;
        topDot.style.width = (4*dotSize) + "vw";
        topDot.style.height = (3*dotSize) + "vw";
        topDot.style.left = (50 - 2*dotSize - dotBorder) + "vw";
    }
    else{
        triPts.stripConnect = false;
        topDot.style.width = dotSize + "vw";
        topDot.style.height = dotSize + "vw";
        topDot.style.left = (50 - dotSize/2 - dotBorder) + "vw";
        
        if (leftCCs[0].led == 0 && leftCCs[0].dotDir%2 != 0){
            leftCCs[0].changeDot();
        }
        if (rightCCs[0].led == 0 && rightCCs[0].dotDir%2 != 0){
            rightCCs[0].changeDot();
        }
    }
    
}

function download(filename, text) {
    var element = document.createElement('a');
    element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
    element.setAttribute('download', filename);

    element.style.display = 'none';
    document.body.appendChild(element);

    element.click();

    document.body.removeChild(element);
}

function downloadFile(){
    var filename = "triangle settings.json";
    var file = JSON.stringify(triPts);
    download(filename, file);
    
  
}

// removes the context menu if there's a click outside it
document.addEventListener('click', function(e){
    if (!(cpmenu.classList.contains('hide') || cpmenu.contains(e.target))){
        toggleElement(cpmenu, false);
        
    }
    
    if (!(addcp.classList.contains('hide') || addcp.contains(e.target))){
        toggleElement(addcp, false);
        
    }
});

// sees when user clicks the background
document.addEventListener('contextmenu', function(e){
    
    var x = 100*e.clientX / window.innerWidth;
    
    
    if (x <= 50 && triPts.left.motion || x > 50 && triPts.right.motion){
    
        toggleElement(addcp, true);

        addcp.style.left = e.clientX + "px";
        addcp.style.top = (e.clientY - addcp.clientHeight) + "px";

        e.preventDefault();
    }
});


// initialization
makeTriangle();

checkboxes();

leftCCs.push(new CC('left', 0, 0));
rightCCs.push(new CC('right', 0, 0));

// the no motion CC stuff
noMotionCCs.push(new CC('left', Math.round(triPts.numLEDs/2.3), 0));
noMotionCCs.push(new CC('right', Math.round(triPts.numLEDs/2.3), 0));
noMotionCCs.forEach(function(i){
    i.dot.parentNode.removeChild(i.dot);
   toggleElement(i.cc, false);
});

makeTopDot();

showTriangle();



