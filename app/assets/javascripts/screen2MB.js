// Global Variables
var map1zips = [];
var map2zips = [];
var chart1Data = {map1 : { x : {}, y : {}, z : {} }, map2 : { x : {}, y : {}, z : {} }, allZipData : { x : {}, y : {}, z : {} } };
var chart2Data = {map1 : { x : {}, y : {}, z : {} }, map2 : { x : {}, y : {}, z : {} }, allZipData : { x : {}, y : {}, z : {} } };
var chartData = {chart1 : chart1Data, chart2 : chart2Data};

// AJAX Call Definitions
amplify.request.define("getVarDataForZips", "ajax", {
  url: "/charts/get_variable_values_for_zips/{chart}/{axis}/{varID}/{map1Selected}/{map2Selected}",
  dataType: "json",
  type: "GET"
});

amplify.request.define("getTimeSeriesDataForZips", "ajax", {
  url: "/charts/get_timeseries_data_for_zips/{chart}/{varID}/{map1Selected}/{map2Selected}",
  dataType: "json",
  type: "GET"
});

// screen2MB Methods
var dragStart = function() {
	// Store currently dragged div ID in session storage
	amplify.store.sessionStorage('current_drag_variable', $(this).attr('id'));
};

var drop_behavior = function(event, ui) {
	// Retrieve dropped variable div and ID from session storage
	var currentVar = amplify.store.sessionStorage('current_drag_variable');
	if(currentVar != null) {
		var currentVarName = $('#' + currentVar).find('span').html();
		$(this).find('span').html(currentVarName).removeClass('default-axis-label').addClass('dropped-var');
		var whichChart = $(this).attr('id').split('-')[0];
		var whichAxis = $(this).attr('id').split('-')[1];
		amplify.request("getVarDataForZips", {
			chart: whichChart,
			axis : whichAxis,
			varID : currentVar,
			map1Selected : map1zips.length != 0 ? map1zips.toString() : ",",
			map2Selected : map2zips.length != 0 ? map2zips.toString() : ","
		},
		function(results) {
			chartData[results.chart]["map1"][results.axis]["varName"] = results.varName;
			chartData[results.chart]["map1"][results.axis]["data"] = JSON.parse(results.map1Results);
			chartData[results.chart]["map2"][results.axis]["varName"] = results.varName;
			chartData[results.chart]["map2"][results.axis]["data"] = JSON.parse(results.map2Results);
			chartData[results.chart]["allZipData"][results.axis]["varName"] = results.varName;
			chartData[results.chart]["allZipData"][results.axis]["data"] = JSON.parse(results.allResults);
			$('#' + results.chart + '-select').change();
		});
	}
	// Clean up session storage
	amplify.store.sessionStorage('current_drag_variable', null);
};

var reCalcStyle = function() {
	$('.rotate').height($('.chart-vardrop-y').height() + 'px');
	$('.rotate').width($('.chart-vardrop-y').height() + 'px');
};

var addZip = function(data) {
	var dataHash = JSON.parse(data);
	var targetNum = dataHash.targetNum.toString();
	var targetID = "zip-box-map" + targetNum;
	var zipCode = dataHash.zipCode.toString();

	if(targetNum == '1') {
		if(map1zips.indexOf(zipCode) == -1) {
			map1zips.push(zipCode);
		} else { return 0; }
	}
	else if(targetNum == '2') {
		if(map2zips.indexOf(zipCode) == -1) {
			map2zips.push(zipCode);
		} else { return 0; }
	}

	$('#' + targetID).append('<div class="selected-zip selected-zip-map' + targetNum + '"><span>' + zipCode + '</span><span class="ui-icon ui-icon-delete ui-icon-shadow" onclick="removeZip(this,\'' + targetNum +'\',\'' + zipCode + '\');">&nbsp;</span></div>');
};

var removeZip = function(target, targetNum, zipCode) {
	$(target).parent().remove();

	if(targetNum.toString() == '1') {
		map1zips.splice(map1zips.indexOf(zipCode),1);
	}
	else if(targetNum.toString() == '2') {
		map2zips.splice(map2zips.indexOf(zipCode),1);
	}
};

var setFilterStatus = function(data) {
	var dataHash = JSON.parse(data);
	amplify.store.sessionStorage('filter_state', dataHash["FilterString"]);
};

var toggleCharts = function() {
	if($('#chart2').css('display') == 'none') {
		$('#chart1 svg').remove();
		$('#chart1 .rsquaredVal').remove();
		$('#chart1').width('49%');
		$('.chart_svg_container').addClass('chart-div-collapsed');
		setTimeout("$('#chart2').css('display', 'inline-block');$('#chart1-select').change();", 710);
	} else {
		$('#chart1 svg').remove();
		$('#chart1 .rsquaredVal').remove();
		$('#chart2 svg').remove();
		$('#chart2 .rsquaredVal').remove();
		$('#chart2').css('display', 'none');
		$('#chart1').width('100%');
		$('.chart_svg_container').removeClass('chart-div-collapsed');
		setTimeout("$('#chart1-select').change();", 710);
		$('#chart2-select').val('');
		$('#chart2-select').selectmenu("refresh");
	}
};

var selectChart = function(chartID, chartType) {
	$('#' + chartID + ' svg').remove();
	$('#' + chartID + ' .rsquaredVal').remove();
	$('#' + chartID + '_svg_container').append('<svg></svg>');

	switch(chartType) {
		case 'scatterplot-all-noR2':
			addScatterNoR2(chartID, true);
			break;
		case 'scatterplot-selected-noR2':
			addScatterNoR2(chartID, false);
			break;
		case 'scatterplot-all':
			$('#' + chartID + '_svg_container').prepend('<span class="rsquaredVal"><h3></h3></span>');
			addScatter(chartID, true);
			break;
		case 'TS-Total':
			getTimeSeriesData(chartID, 'totalPIF', 'Total PIF');
			break;
		case 'TS-PC':
			getTimeSeriesData(chartID, 'PCPIF', 'PC PIF');
			break;
		case 'TS-AF':
			getTimeSeriesData(chartID, 'AFPIF', 'AF PIF');
			break;
		case 'TS-Multi':
			getTimeSeriesData(chartID, 'percentMultiLine', '% Multi-Line');
			break;
		case 'TS-Retention':
			getTimeSeriesData(chartID, 'percentRetention', '% Retention');
			break;
		default:
			break;
	}
};

function getTimeSeriesData(chartID, yVar, yLabel) {
	$('#' + chartID + "-x").find('span').html("Time").removeClass('default-axis-label').addClass('dropped-var');
  $('#' + chartID + "-y").find('span').html(yLabel).removeClass('default-axis-label').addClass('dropped-var');

	amplify.request("getTimeSeriesDataForZips", {
			chart: chartID,
      varID : yVar,
      map1Selected : map1zips.length != 0 ? map1zips.toString() : ",",
      map2Selected : map2zips.length != 0 ? map2zips.toString() : ","
    },
    function(results) {
			var xLabels = ["2012Q1", "2012Q2", "2012Q3", "2012Q4", "2013Q1"];
			chartData[results.chart].map1.x.varName = "Time";
			chartData[results.chart].map1.x.data = xLabels;
			chartData[results.chart].map2.x.varName = "Time";
			chartData[results.chart].map2.x.data = xLabels;

      chartData[results.chart].map1.y.varName = results.varID;
      chartData[results.chart].map1.y.data = JSON.parse(results.map1Results);
      chartData[results.chart].map2.y.varName = results.varID;
      chartData[results.chart].map2.y.data = JSON.parse(results.map2Results);
      addTimeSeries(results.chart, results.varID);
  });
}

function setupScreen2MB() {
	$('.chart-var').draggable({
		cursor: "pointer",
		handle: "span",
		revert: true,
		start: dragStart
	});

	$('.chart-vardrop-x').droppable({
		accept: ".chart-var",
		hoverClass: "chart-vardrop-hover",
		drop: drop_behavior
	});

	$('.chart-vardrop-y').droppable({
		accept: ".chart-var",
		hoverClass: "chart-vardrop-hover",
		drop: drop_behavior
	});

	$('#choose-btn-1').click(function() {
		if(map1zips.length > 0) {
			var zipList = "";
			$.each(map1zips, function(index, value) {
				zipList += value + ",";
			});
			zipList = zipList.substring(0, zipList.length - 1);
			var data = {};
			data["map"] = "1";
			data["zipList"] = zipList;
			sendWSMessage('addCluster', JSON.stringify(data));
			$('#zip-box-map1 .selected-zip').remove();
			map1zips = [];
		} else {console.log('No zips selected for map 1.')};
	});

	$('#choose-btn-2').click(function() {
		if(map2zips.length > 0) {
			var zipList = "";
			$.each(map2zips, function(index, value) {
				zipList += value + ",";
			});
			zipList = zipList.substring(0, zipList.length - 1);
			var data = {};
			data["map"] = "2";
			data["zipList"] = zipList;
			sendWSMessage('addCluster', JSON.stringify(data));
			$('#zip-box-map2 .selected-zip').remove();
			map2zips = [];
		} else {console.log('No zips selected for map 2.')};
	});

	$(window).resize(function() {
		reCalcStyle();
	});
}
function animate_2MB_tabs(target) {
  // Format tabs & links
  $('.var-tab').removeClass('selected').addClass('unselected');
  $('.var-tab a').removeClass('selectedLink').addClass('unselectedLink');
  $(target).removeClass('unselectedLink').addClass('selectedLink');
  $(target).parent().removeClass('unselected').addClass('selected');

  // Show/Hide tab content panels
  var contentPanelID = $(target).parent().attr('id') + "-content";
  $('.tab-content-panel').css('display', 'none');
  $('#' + contentPanelID).css('display', 'block');
}