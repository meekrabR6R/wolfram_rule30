/**************************************************************
* RuleThirty Namespace Object Literal: 
* Holds functions that control the display of the rows as they 
* are computed. Also holds functions which control the start/stop/
* reset functionality on the page.
* @author : Nicholas Miano
* @version: 1.0
* @date   : 08/14/2013
***************************************************************/
var RuleThirty = {

	//variables
	rowCount : 0,
	line : [],
	timerID : 0,
	stopLoop : 0,

	/*****************************************************
	* Begins a loop which sends current line data 
	* to server and retrieves calculated next line.
	******************************************************/
	start : function() {

		if(RuleThirty.stopLoop === 1) {
			RuleThirty.line = [];
			$('.row'+RuleThirty.rowCount).children('.cell').each(function(){ RuleThirty.line.push(this.id);});
		}

		RuleThirty.stopLoop = 0;
		$('#start').attr("disabled", true);
		RuleThirty.getNewLine(RuleThirty.line);
	},

	/*****************************************************
	* Stops execution of the loop.
	******************************************************/
	stop : function() {

		RuleThirty.stopLoop = 1;
		$('#start').removeAttr('disabled');
		RuleThirty.reset();
	},

	/*******************************************************
	* Resets loop and clears all calculated rows,
	* leaving only the first row.
	*********************************************************/
	reset : function() {

		$('#reset').css('visibility', 'visible');
		$('#reset').click(function(){
			$('#iterations').html('');
			$('#start').css('visibility', 'visible');
			RuleThirty.rowCount = 0;
			RuleThirty.line = [];

		});
	},

	/*********************************************************
	* Begins execution of the loop.
	**********************************************************/
	getLines : function() {

		$('#reset').css('visibility', 'hidden');
		$('.row'+RuleThirty.rowCount).children('.cell').each(function(){ RuleThirty.line.push(this.id);});
		RuleThirty.start();
		$('#stop').click(function(){ RuleThirty.stop();});

	},

    /***********************************************************
    * Wraps an ajax post to server with current line info to get
    * next line.
    * @param: line - current line
    ************************************************************/
	getNewLine : function(line) {
		$.ajax({
			url: '/getline',
			type: 'post',
			data: {last_line: JSON.stringify(line)},
			async: true,
			success: function(result){ RuleThirty.callBack(result); }
		});
	},

	/***********************************************************
	* Callback function for post to /getline. Handles the data
	* returned by the server. Exported out of the jQuery $.post
	* primarily for readability.
	* @param : result - cellular on/off statuses for next line
	************************************************************/
	callBack : function(result) {
		RuleThirty.rowCount++;
		$('#iterations').append('<br><div class="row row'+RuleThirty.rowCount+'"></div>');

		var id = "";
		var stopCheck = 0;
		RuleThirty.line = [];

		for(i=0; i<result.length; i++){

			if((i === 0 || i === result.length-1) && result[i] === '1')
				stopCheck = 1;

			RuleThirty.line[i] = result[i];

			if(result[i] === '1') id = "1";
			else id="0";

			$('.row'+RuleThirty.rowCount).append('<div class="cell cell'+id+'" id="'+id+'"></div>');
		}


        	if(stopCheck === 1){
			$('#start').css('visibility', 'hidden');
			RuleThirty.stop();
		}
		else if(RuleThirty.stopLoop == 1)
			RuleThirty.reset();
		else
			RuleThirty.getNewLine(RuleThirty.line);
	}
};

//begins execution
$(document).ready(function() {
	$("#start").click(function() { RuleThirty.getLines(); });
});
