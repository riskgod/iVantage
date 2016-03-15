var groupFormattedData = [];
var chosenClusters = [];

function formatDataGroupBar(clusterID, var1y, var2y, var3y, var4y) {

 for (var i = 0; i < chosenClusters.length; i++) {
        if (chosenClusters[i] == clusterID) {
            groupFormattedData[i]['values'][0]['y'] = var1y;
            groupFormattedData[i]['values'][1]['y'] = var2y;
            groupFormattedData[i]['values'][2]['y'] = var3y;
            groupFormattedData[i]['values'][3]['y'] = var4y;
            return groupFormattedData;
        }
    }

  if (clusterID!="" && clusterID!="remove"){
    groupFormattedData.push({
      key : clusterID,
      values : [{x : "var1", y : var1y}, {x : "var2", y : var2y}, {x : "var3", y : var3y}, {x : "var4", y : var4y}]
    });
   chosenClusters.push([clusterID]);
  }

  if(clusterID === "remove"){
    return groupFormattedData;
  }

  return groupFormattedData;
}

function formatDataSummaryBar(whichVal) {
  var formattedData = [];
  var xVal = whichVal.indexOf("Percent") == -1 ? 0 : 1;

  for(var key in the_agents) {
    formattedData.push({
      key : key,
      values : [{x : xVal, y : the_agents[key]['summaryChartVals'][whichVal]}]
    });
  }

  return formattedData;
}

function formatDataTimeSeries(whichChart, yVar) {
  var formattedData = [];
  var dataHash;

  dataHash = whichChart == "chart1" ? chart1Data : chart2Data;

  for(var key in dataHash.map1.y.data) {
    tempvalues = [];
    for(var i=0;i<dataHash.map1.x.data.length;i++){
      tempvalues.push({x: i, y: dataHash.map1.y.data[key][i], label: dataHash.map1.x.data[i]});
    }

    formattedData.push({
      key: "Map1-" + key,
      values: tempvalues,
      color: d3.scale.category10().range()[0]
    });
  }

  for(var key in dataHash.map2.y.data) {
    tempvalues = [];
    for(var i=0;i<dataHash.map2.x.data.length;i++){
      tempvalues.push({x: i, y: dataHash.map2.y.data[key][i], label: dataHash.map2.x.data[i]});
    }

    formattedData.push({
      key: "Map2-" + key,
      values: tempvalues,
      color: d3.scale.category10().range()[3]
    });
  }
  console.log(formattedData);

  return formattedData
}

function formatDataScatterNoR2(whichChart, showAll) {
  var formattedData = [];
  var passFilterData = [];
  var failFilterData = [];
  var dataHash;
  var filterString_PML = amplify.store.sessionStorage('filter_state').substring(0,3);
  var filterString_WriteBiz = amplify.store.sessionStorage('filter_state').substring(3);
  var tempFilterString;
  var passIndexPML;
  var passIndexWriteBiz;
  var pass_PML;
  var pass_WriteBiz;
  var tempHash;
  var maxZipCount;

  if(showAll) {
    dataHash = whichChart == "chart1" ? chart1Data["allZipData"] : chart2Data["allZipData"];
  } else {
    dataHash = whichChart == "chart1" ? chart1Data : chart2Data;
  }

  if(showAll) { // if showing all ZIPs, only have to worry about two data sets -> zips that pass filters and zips that fail filters
    for(var key in dataHash.x.data) {
      tempFilterString = dataHash.x.data[key].filter_state;
      passIndexPML = tempFilterString.substring(0,3).indexOf("1");
      passIndexWriteBiz = tempFilterString.substring(3).indexOf("1");
      pass_PML = filterString_PML[passIndexPML] == "1" ? true : false;
      pass_WriteBiz = filterString_WriteBiz[passIndexWriteBiz] == "1" ? true : false;
      tempHash = {
        key : key,
        values : [{
          x : dataHash.x.data[key].value,
          y : dataHash.y.data[key].value,
          size: pass_PML && pass_WriteBiz ? 5 : 2
        }]
      };
      if(pass_PML && pass_WriteBiz) {
        passFilterData.push(tempHash);
      } else {
        failFilterData.push(tempHash);
      }
    }

    // alternate entries in final data set to support two color scheme
    maxZipCount = passFilterData.length > failFilterData.length ? passFilterData.length : failFilterData.length;
    for(var j=0;j<maxZipCount;j++) {
      if(typeof passFilterData[j] != 'undefined') {
        formattedData.push(passFilterData[j]);
      } else {
        formattedData.push({
          key: null, values: [{ x : null, y : null, size : 1}]
        });
      }
      if(typeof failFilterData[j] != 'undefined') {
        formattedData.push(failFilterData[j]);
      } else {
        formattedData.push({
          key: null, values: [{ x : null, y : null, size : 1}]
        });
      }
    }
  } else { // if showing zips from map selections, need to ensure that passing zips and failing zips alternate in 'formattedData' for 3 colors --> [passMap1, passMap2, fail, passMap1, passMap2, fail, ... , passMap1, passMap2, fail]
    var tempMap1PassFilterData = [];
    var tempMap2PassFilterData = [];

    // build data sets for each map separately
    for(var key1 in dataHash.map1.x.data) {
      tempFilterString = dataHash.map1.x.data[key1].filter_state;
      passIndexPML = tempFilterString.substring(0,3).indexOf("1");
      passIndexWriteBiz = tempFilterString.substring(3).indexOf("1");
      pass_PML = filterString_PML[passIndexPML] == "1" ? true : false;
      pass_WriteBiz = filterString_WriteBiz[passIndexWriteBiz] == "1" ? true : false;
      tempHash = {
        key : key1,
        values : [{
          x : dataHash.map1.x.data[key1].value,
          y : dataHash.map1.y.data[key1].value,
          size: pass_PML && pass_WriteBiz ? 5 : 2
        }]
      };
      if(pass_PML && pass_WriteBiz) {
        tempMap1PassFilterData.push(tempHash);
      } else {
        failFilterData.push(tempHash);
      }
    };

    for(var key2 in dataHash.map2.x.data) {
      tempFilterString = dataHash.map2.x.data[key2].filter_state;
      passIndexPML = tempFilterString.substring(0,3).indexOf("1");
      passIndexWriteBiz = tempFilterString.substring(3).indexOf("1");
      pass_PML = filterString_PML[passIndexPML] == "1" ? true : false;
      pass_WriteBiz = filterString_WriteBiz[passIndexWriteBiz] == "1" ? true : false;
      tempHash = {
        key : key2,
        values : [{
          x : dataHash.map2.x.data[key2].value,
          y : dataHash.map2.y.data[key2].value,
          size: pass_PML && pass_WriteBiz ? 5 : 2
        }]
      };
      if(pass_PML && pass_WriteBiz) {
        tempMap2PassFilterData.push(tempHash);
      } else {
        failFilterData.push(tempHash);
      }
    };

    // alternate entries from separate map selections and failFilterData in final data set to guarantee three color scheme
    maxZipCount = tempMap1PassFilterData.length > tempMap2PassFilterData.length ? tempMap1PassFilterData.length : tempMap2PassFilterData.length;
    maxZipCount = maxZipCount > failFilterData.length ? maxZipCount : failFilterData.length;
    for(var i=0;i<maxZipCount;i++) {
      if(typeof tempMap1PassFilterData[i] != 'undefined') {
        formattedData.push(tempMap1PassFilterData[i]);
      } else {
        formattedData.push({
          key: null, values: [{ x : null, y : null, size : 1}]
        });
      }
      if(typeof tempMap2PassFilterData[i] != 'undefined') {
        formattedData.push(tempMap2PassFilterData[i]);
      } else {
        formattedData.push({
          key: null, values: [{ x : null, y : null, size : 1}]
        });
      }
      if(typeof failFilterData[i] != 'undefined') {
        formattedData.push(failFilterData[i]);
      } else {
        formattedData.push({
          key: null, values: [{ x : null, y : null, size : 1}]
        });
      }
    }
    // add one extra element with size = 1 to guarantee that scatter points display larger
    if(formattedData.length > 0){
      formattedData.push({
          key: null, values: [{ x : null, y : null, size : 1}]
      });
    }
  }

  return formattedData;
}

function formatDataScatter(whichChart, showAll) {
  var formattedData = [];
  var linRegArray = [];
  var passFilterData = [];
  var failFilterData = [];
  var dataHash;
  var filterString_PML = amplify.store.sessionStorage('filter_state').substring(0,3);
  var filterString_WriteBiz = amplify.store.sessionStorage('filter_state').substring(3);
  var tempFilterString;
  var passIndexPML;
  var passIndexWriteBiz;
  var pass_PML;
  var pass_WriteBiz;
  var tempHash;
  var maxZipCount;

  if(showAll) {
    dataHash = whichChart == "chart1" ? chart1Data["allZipData"] : chart2Data["allZipData"];
  } else {
    dataHash = whichChart == "chart1" ? chart1Data : chart2Data;
  }

  if(showAll) { // if showing all ZIPs, only have to worry about two data sets -> zips that pass filters and zips that fail filters
    for(var key in dataHash.x.data) {
      linRegArray.push([parseFloat(dataHash.x.data[key].value), parseFloat(dataHash.y.data[key].value)]);
      tempFilterString = dataHash.x.data[key].filter_state;
      passIndexPML = tempFilterString.substring(0,3).indexOf("1");
      passIndexWriteBiz = tempFilterString.substring(3).indexOf("1");
      pass_PML = filterString_PML[passIndexPML] == "1" ? true : false;
      pass_WriteBiz = filterString_WriteBiz[passIndexWriteBiz] == "1" ? true : false;
      tempHash = {
        key : key,
        values : [{
          x : dataHash.x.data[key].value,
          y : dataHash.y.data[key].value,
          size: pass_PML && pass_WriteBiz ? 5 : 2
        }],
        slope : 0,
        intercept : -1
      };
      if(pass_PML && pass_WriteBiz) {
        passFilterData.push(tempHash);
      } else {
        failFilterData.push(tempHash);
      }
    }

    // alternate entries in final data set to support two color scheme
    maxZipCount = passFilterData.length > failFilterData.length ? passFilterData.length : failFilterData.length;
    for(var j=0;j<maxZipCount;j++) {
      if(typeof passFilterData[j] != 'undefined') {
        formattedData.push(passFilterData[j]);
      } else {
        formattedData.push({
          key: null, values: [], slope : 0, intercept : -1
        });
      }
      if(typeof failFilterData[j] != 'undefined') {
        formattedData.push(failFilterData[j]);
      } else {
        formattedData.push({
          key: null, values: [], slope : 0, intercept : -1
        });
      }
    }

    // Calculate regression line and add one additional item to formattedData to draw the line
    var line = ss.linear_regression().data(linRegArray).line();
    var yintercept = line(0);
    var regLineSlope = line(1) - line(0);
    var rsquared = ss.r_squared(linRegArray,line).toFixed(2).toString();
    $('#' + whichChart + ' h3').html('R^2 = ' + rsquared);
    formattedData.push({
      key: null,
      values: [{
        x : 0,
        y : 0,
        size : 1
      }],
      slope : regLineSlope,
      intercept : yintercept
    });
  } else {
    return [];
  }

  return formattedData;
}