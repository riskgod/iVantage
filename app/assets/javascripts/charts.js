function addGroupBar(chartID, clusterID, var1y, var2y, var3y, var4y) {

  var myColors = ["#5F9EA0", "#DEB887", "#D2691E", "#008B8B", "#9932CC", "#B22222", "#696969", "#FFD700", "#ADFF2F", "#FF69B4", "#32CD32", "#FF4500", "#4169E1"];
  d3.scale.myColors = function() {
      return d3.scale.ordinal().range(myColors);
  };

  nv.addGraph(function() {
  var chartC = nv.models.multiBarChart().showControls(false)
    .color(d3.scale.myColors().range());

  chartC.xAxis
  .tickFormat(function(d) { return "";}); // return d for text axis label

  chartC.yAxis
  .tickFormat(d3.format(',f'));

  d3.select('#' + chartID + ' svg')
  .datum(formatDataGroupBar(clusterID, var1y, var2y, var3y, var4y))
  .transition().duration(500).call(chartC);

  nv.utils.windowResize(chartC.update);

  return chartC;
  });
}

function addSummaryBar(chartID, chartVal) {
  var myColors = ["#5F9EA0", "#DEB887", "#D2691E", "#008B8B", "#9932CC", "#B22222", "#696969", "#FFD700", "#ADFF2F", "#FF69B4", "#32CD32", "#FF4500", "#4169E1"];
  d3.scale.myColors = function() {
      return d3.scale.ordinal().range(myColors);
  };

  nv.addGraph(function() {
    var chart = nv.models.multiBarChart()
      .showControls(false)
      .tooltip(function(key, x, y, e, graph) {
        if(e.point.x == 0) {
          return '<h3>' + key + '</h3>' + '<p>' +  y + '</p>';
        } else {
          return '<h3>' + key + '</h3>' + '<p>' +  y + '%</p>';
        }
      })
      .color(d3.scale.myColors().range());

    chart.xAxis
      .tickFormat(function(d) { return "";}); // return d for text axis label

    chart.yAxis
      .showMaxMin(false);

    if(chartVal == 'avgHVHPIF') {
      chart.yAxis.tickFormat(d3.format(',1f'));
    } else {
      chart.yAxis.tickFormat(d3.format(',0f'));
    }

    d3.select('#' + chartID + ' svg')
      .datum(formatDataSummaryBar(chartVal))
      .transition().duration(500).call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}

function addScatterNoR2(chartID, showAll) {
  var whichChart = chartID.split('_')[0];
  var failSeriesColor = d3.scale.category10().range()[1];
  var allZipPassColor = d3.scale.category10().range()[0];
  var map1PassColor = d3.scale.category10().range()[0];
  var map2PassColor = d3.scale.category10().range()[3];

  nv.addGraph(function() {
    var chart = nv.models.scatterChart()
    .showDistX(true)
    .showDistY(true)
    .color(showAll ? [allZipPassColor,failSeriesColor] : [map1PassColor,map2PassColor,failSeriesColor])
    .tooltipXContent(function(key) {return '<h3>ZIP Code: ' + key + '</h3>'})
    .tooltipYContent(null)
    .showLegend(false)
    .showControls(false);

    chart.xAxis.tickFormat(d3.format('.02f'));
    chart.yAxis.tickFormat(d3.format('.02f'));

    d3.select('#' + chartID + ' svg')
    .datum(formatDataScatterNoR2(whichChart, showAll))
    .transition().duration(500)
    .call(chart);

    return chart;
  });
};

function addScatter(chartID, showAll) {
  var whichChart = chartID.split('_')[0];
  var failSeriesColor = d3.scale.category10().range()[1];
  var allZipPassColor = d3.scale.category10().range()[0];
  var map1PassColor = d3.scale.category10().range()[0];
  var map2PassColor = d3.scale.category10().range()[3];

  nv.addGraph(function() {
    var chart = nv.models.scatterPlusLineChart()
    .showDistX(true)
    .showDistY(true)
    .color(showAll ? [allZipPassColor,failSeriesColor] : [map1PassColor,map2PassColor,failSeriesColor])
    .tooltipXContent(null)
    .tooltipYContent(null)
    .tooltipContent(function(key) { return '<h3>ZIP Code: ' + key + '</h3>'})
    .showLegend(false)
    .showControls(false);

    chart.xAxis.tickFormat(d3.format('.02f'));
    chart.yAxis.tickFormat(d3.format('.02f'));

    d3.select('#' + chartID + ' svg')
    .datum(formatDataScatter(whichChart, showAll))
    .transition().duration(500)
    .call(chart);

    return chart;
  });
};

function addTimeSeries(chartID, yVar) {
  nv.addGraph(function() {
    var chart = nv.models.lineChart()
      .showLegend(false);

    chart.xAxis
      .tickValues([0,1,2,3,4])
      .tickFormat(function(d){
        switch(d) {
          case 0:
            return "2012Q1";
          case 1:
            return "2012Q2";
          case 2:
            return "2012Q3";
          case 3:
            return "2012Q4";
          case 4:
            return "2013Q1";
        }
      });

    chart.yAxis
      .tickFormat(d3.format(',f'));

    d3.select('#' + chartID + ' svg')
      .datum(formatDataTimeSeries(chartID, yVar))
      .transition().duration(500)
      .call(chart);

    return chart;
  });
}