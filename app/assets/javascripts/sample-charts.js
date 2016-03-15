// Sample Charts
function addStackedBar(chartID) {
  nv.addGraph(function() {
  var chartB = nv.models.multiBarHorizontalChart()
  .x(function(d) { return d.label })
  .y(function(d) { return d.value })
  .margin({top: 30, right: 20, bottom: 50, left: 175})
  .showValues(true)
  .tooltips(false)
  .showControls(false);

  chartB.yAxis
  .tickFormat(d3.format(',.2f'));

  d3.select('#' + chartID + ' svg')
  .datum(stackedData)
  .transition().duration(500)
  .call(chartB);

  nv.utils.windowResize(chartB.update);

  return chartB;
  });
};

// Sample Data
var stackedData = [
{
"key": "Series1",
"color": "#d62728",
"values": [
  {
    "label" : "Group A" ,
    "value" : -1.8746444827653
  } ,
  {
    "label" : "Group B" ,
    "value" : -8.0961543492239
  } ,
  {
    "label" : "Group C" ,
    "value" : -0.57072943117674
  } ,
  {
    "label" : "Group D" ,
    "value" : -2.4174010336624
  } ,
  {
    "label" : "Group E" ,
    "value" : -0.72009071426284
  } ,
  {
    "label" : "Group F" ,
    "value" : -0.77154485523777
  } ,
  {
    "label" : "Group G" ,
    "value" : -0.90152097798131
  } ,
  {
    "label" : "Group H" ,
    "value" : -0.91445417330854
  } ,
  {
    "label" : "Group I" ,
    "value" : -0.055746319141851
  }
]
},
{
"key": "Series2",
"color": "#1f77b4",
"values": [
  {
    "label" : "Group A" ,
    "value" : 25.307646510375
  } ,
  {
    "label" : "Group B" ,
    "value" : 16.756779544553
  } ,
  {
    "label" : "Group C" ,
    "value" : 18.451534877007
  } ,
  {
    "label" : "Group D" ,
    "value" : 8.6142352811805
  } ,
  {
    "label" : "Group E" ,
    "value" : 7.8082472075876
  } ,
  {
    "label" : "Group F" ,
    "value" : 5.259101026956
  } ,
  {
    "label" : "Group G" ,
    "value" : 0.30947953487127
  } ,
  {
    "label" : "Group H" ,
    "value" : 0
  } ,
  {
    "label" : "Group I" ,
    "value" : 0
  }
]
}
];

function groupBarData() {
  return stream_layers(3,10+Math.random()*100,.1).map(function(dataX, i) {
    return {
      key: 'Cluster ' + i,
      values: dataX
    };
  });
}

/* Inspired by Lee Byron's test data generator. */
function stream_layers(n, m, o) {
if (arguments.length < 3) o = 0;
function bump(a) {
var x = 1 / (.1 + Math.random()),
    y = 2 * Math.random() - .5,
    z = 10 / (.1 + Math.random());
for (var i = 0; i < m; i++) {
  var w = (i / m - y) * z;
  a[i] += x * Math.exp(-w * w);
}
}
return d3.range(n).map(function() {
  var a = [], i;
  for (i = 0; i < m; i++) a[i] = o + o * Math.random();
  for (i = 0; i < 5; i++) bump(a);
  return a.map(stream_index);
});
}

/* Another layer generator using gamma distributions. */
function stream_waves(n, m) {
return d3.range(n).map(function(i) {
return d3.range(m).map(function(j) {
    var x = 20 * j / m - i / 3;
    return 2 * x * Math.exp(-.5 * x);
  }).map(stream_index);
});
}

function stream_index(d, i) {
return {x: i, y: Math.max(0, d)};
}

  var testdata = [
    {
      key: "One",
      y: 5
    },
    {
      key: "Two",
      y: 2
    },
    {
      key: "Three",
      y: 9
    },
    {
      key: "Four",
      y: 7
    },
    {
      key: "Five",
      y: 4
    },
    {
      key: "Six",
      y: 3
    },
    {
      key: "Seven",
      y: .5
    }
  ];

function addPieChart(chartID, showLegend, thedata){
nv.addGraph(function() {
    // var width,
    //     height;

    var myColors = ["#ff8100", "#e9fb00", "#8106A9", "#339933"];
    d3.scale.myColors = function() {
      return d3.scale.ordinal().range(myColors);
    };

    var chartD = nv.models.pieChart()
        .x(function(d) { return d.key })
        .y(function(d) { return d.y })
        //.showLabels(false)
        .values(function(d) { return d })
        .color(d3.scale.myColors().range())

        if( typeof showLegend != 'undefined') {
          chartD.showLegend(showLegend);
        }

        // .width(width)
        // .height(height);

      d3.select('#' + chartID + ' svg')
          .datum([thedata])
        .transition().duration(1200)
          // .attr('width', width)
          // .attr('height', height)
          .call(chartD);

    // chartD.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });

    nv.utils.windowResize(chartD.update);
    return chartD;
});
}

function addLineChart(chartID){

var chartE;

nv.addGraph(function() {
  chartE = nv.models.lineChart();

  chartE
      .x(function(d,i) { return i })


  chartE.xAxis // chart sub-models (ie. xAxis, yAxis, etc) when accessed directly, return themselves, not the parent chart, so need to chain separately
      .tickFormat(d3.format(',.1f'));

  chartE.yAxis
      .axisLabel('Voltage (v)')
      .tickFormat(d3.format(',.2f'));

  d3.select('#' + chartID + ' svg')
      //.datum([]) //for testing noData
      .datum(sinAndCos())
    .transition().duration(500)
      .call(chartE);

  //TODO: Figure out a good way to do this automatically
  nv.utils.windowResize(chartE.update);
  //nv.utils.windowResize(function() { d3.select('#chart1 svg').call(chart) });

  //chartE.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });

  return chartE;
});
}


function sinAndCos() {
  var sin = [],
      cos = [];

  for (var i = 0; i < 100; i++) {
    // sin.push({x: i, y: i % 10 == 5 ? null : Math.sin(i/10) }); //the nulls are to show how defined works
    // cos.push({x: i, y: .5 * Math.cos(i/10)});
  sin.push({x: i, y: Math.sin(i/10)});
  cos.push({x: i, y: .5 * Math.cos(i/10)});
  }

  return [
    {
      area: true,
      values: sin,
      key: "Cluster 1",
      color: "#ff7f0e"
    },
    {
      values: cos,
      key: "Cluster 2",
      color: "#2ca02c"
    }
  ];
}



/* This function draws (or redraws) the 3L Scenario Analysis charts, one at a time.
  it calls the sinAndCosScenarioAnalysis (horrible name based on old stuff) function to get the data */
function add_3L_ScenarioAnalysis_LineCharts(chartID) {
  getScenarioValues();
  var chartE;

  nv.addGraph(function() {
    chartE = nv.models.lineChart();
    chartE.x(function(d,i) { return i });
    chartE.xAxis // chart sub-models (ie. xAxis, yAxis, etc) when accessed directly, return themselves, not the parent chart, so need to chain separately
        .tickFormat(function(d) {
          var newDate = new Date('2012-03-15');           // start date
          newDate.setDate(newDate.getDate() + (d*91.5));  // makes dates increase quarterly
          var nd = new Date(newDate);
          if([0,1,2].indexOf(nd.getMonth()) != -1) {
            var quarterName = "1Q";
          } else if([3,4,5].indexOf(nd.getMonth()) != -1) {
            var quarterName = "2Q";
          } else if([6,7,8].indexOf(nd.getMonth()) != -1) {
            var quarterName = "3Q";
          } else {
            var quarterName = "4Q";
          }

          return quarterName + d3.time.format('%Y')(nd).toString();
        });
    chartE.yAxis
        .tickFormat(d3.format(',.f'));
    d3.select('#' + chartID + ' svg')
        .datum(data_for_3L_ScenarioAnalysis_LineCharts(chartID))
        .transition().duration(500)
        .call(chartE);
    nv.utils.windowResize(chartE.update);
    return chartE;
  });
}


function getScenAnalysisCount_NextQtr(agent_proxy, HVH_count, HVH_policies) {

  getScenarioValues();

  var GDP_growth = scenario_cv['cv1'];
  var new_HVH_in_geo = HVH_count * GDP_growth / 100 / 4;
  var hardcode_95 = 0.95
  var hardcode_1 = 0.1;
  var churning_HVH = HVH_count * (1-hardcode_95);
  var total_HVH_opps_in_USA = new_HVH_in_geo + churning_HVH;
  var new_HVH_per_travel_zone = total_HVH_opps_in_USA * hardcode_1;
  var provide_agents_data = scenario_cv['cv5'];
  var new_HVH_per_agent_travel_zone = new_HVH_per_travel_zone * provide_agents_data;
  var competitiveness_of_HVH_product = scenario_cv['cv3'];
  var baseline_conversion_rate_per_opp = scenario_cv['cv6'];
  var sales_conversion_per_opportunity = competitiveness_of_HVH_product * baseline_conversion_rate_per_opp;
  var new_HVH_sales_per_active_agent = new_HVH_per_agent_travel_zone * sales_conversion_per_opportunity;
  var agent_engagement = scenario_cv['cv2'];
  var percnt_ivantage_agents = scenario_cv['cv7'];
  var agents_actively_selling_HVH = agent_proxy * agent_engagement * percnt_ivantage_agents;
  var new_HVH_sales = agents_actively_selling_HVH * new_HVH_sales_per_active_agent;
  var retention_rate = scenario_cv['cv4'];
  var HVH_policies_lost_to_churn = HVH_policies * (1-retention_rate);
  var HVH_policies_next = HVH_policies + new_HVH_sales - HVH_policies_lost_to_churn;
  var HVH_count_next = HVH_count * (1 + scenario_cv['cv1'] / 100);

  return [HVH_count_next.toFixed(0), HVH_policies_next];

}


/* This function builds the data for use in the 3L Scenario Analysis charts
   The first 5 'y' values of each chart are hard-coded. The next few are generated by a formula unique to each chart,
   based on a spreadsheet sent by Ryan Hughes */
function data_for_3L_ScenarioAnalysis_LineCharts(chartID) {

  var past = [];
  var future = [];
  var max_future_projections = 7;


  // ***  Chart #1  ***
  if (chartID == 'scenChart1') {
    // past values
      y_values = [91.9, 96.2, 98.1, 98.3, 100.0];
      for (i=0; i<y_values.length; i++) {
        past.push({x: i+1, y: y_values[i]});
        future.push({x: i+1, y: y_values[i]});
      }
    // future values
      for (i=0; i<max_future_projections; i++) {
        temp_y = ((scenario_cv['cv2'] * scenario_cv['cv3'] * scenario_cv['cv5'] * scenario_cv['cv6'] * scenario_cv['cv7'] * 8400 * Math.pow(1.005, i) * ((937341.099999992 + (9373410.99999992 * (scenario_cv['cv1']/400)))/3600))/603);
        future.push({x: i+6, y: temp_y * 100 });
      }
    // return values
      return [
        { area: true, values: future, key: "New HVH Sales FUTURE", color: "#737373" },
        { area: true, values: past, key: "New HVH Sales PAST", color: "#ff7f0e" }
      ];


  // ***  Chart #2  ***
  } else if (chartID == 'scenChart2') {

    // these values are hard-coded from Ryan's S3L_ScenarioAnalysis-Summary-Equ_v122.xlsx doc
    // Ideally these would come from the national sums and averages, but that's too much data for JavaScript to handle
    // So instead, we're using one zip code to represent the national average. 070 is pretty close.

    // // Zip 070
    // HVH_policies = 66.8419;
    // HVH_count = 73071.4255269195;
    // agent_proxy = 69.816;

    // Zip 078
    HVH_policies = 8.3552319;
    HVH_count = 26198.912765589;
    agent_proxy = 17.272;

    // past_scores = [0.907, 0.929, 0.946, 0.970, 1.000];
    // past_scores = [4068.8, 4167.5, 4243.8, 4351.4, 4486];
    past_scores = [4069, 4168, 4244, 4351, 4486];

    future_scores = [];
    future_og = [];
    future_og.push({x:1, y:4069});
    future_og.push({x:2, y:4168});
    future_og.push({x:3, y:4244});
    future_og.push({x:4, y:4351});
    future_og.push({x:5, y:4486});
    future_og.push({x:5, y:4606});
    future_og.push({x:5, y:4722});
    future_og.push({x:5, y:4835});
    future_og.push({x:5, y:4944});
    future_og.push({x:5, y:5051});
    future_og.push({x:5, y:5155});
    future_og.push({x:5, y:5258});  /* PICK BETTER VALUES?!??? */

    next = getScenAnalysisCount_NextQtr(agent_proxy, HVH_count, HVH_policies);
    future_scores.push(Math.round((next[1]/HVH_policies) * 4486));

    for (year = 2013; year <= 2015; year++) {
      for (q = 1; q <= 4; q++) {
        if ((year == 2013 && q > 2) || year == 2014 || (year == 2015 && q <= 1)) {
          next = getScenAnalysisCount_NextQtr(agent_proxy, next[0], next[1]);
          // msg += 'HVH Count / ' + year + ' Q' + q + ': ' + next[0] + ' / ' + (next[0]/HVH_count).toFixed(3) + '\n';
          future_scores.push(Math.round((next[1]/HVH_policies) * 4486));
        }
      }
    }

    // past values
    for (i=0; i<past_scores.length; i++) {
      past.push({x: i+1, y: past_scores[i]});
      future.push({x: i+1, y: past_scores[i]});
    }
    // future values
    for (i=1; i<future_scores.length; i++) {
      future.push({x: i+5, y: future_scores[i-1]});
      console.log(future_scores[i-1]);
    }



    return [
      { area: true, values: future_og, key: "Total Policies FUTURE {Original}", color: "#ffBf4e" }, /* PICK A NEW COLOR */
      { area: true, values: future, key: "Total Policies FUTURE", color: "#000000" },
      { area: true, values: past, key: "Total Policies PAST", color: "#ff7f0e" }
    ];

  // ***  Chart #3  ***
  } else {
    // past values
      y_values = [98.2, 98.5, 99.3, 99.4, 100.0];
      for (i=0; i<y_values.length; i++) {
        past.push({x: i+1, y: y_values[i]});
        future.push({x: i+1, y: y_values[i]});
      }
    // future values
      for (i=0; i<max_future_projections; i++) {
        temp_y = Math.pow((1 + (scenario_cv['cv1'] / 400)), i);
        future.push({x: i+6, y: temp_y * 100});
      }
    // return values
    var3_projection_value = future[future.length-1]['y'];
      return [
        { area: true, values: future, key: "Market Potential FUTURE", color: "#737373" },
        { area: true, values: past, key: "Market Potential PAST", color: "#ff7f0e" }
      ];
  }
}



function add_3L_LineChart(chartID, startValues, clusterNames){

  nv.addGraph(function() {
    var chartE = nv.models.lineChart()
      .x(function(d,i) { return i })

    chartE.xAxis // chart sub-models (ie. xAxis, yAxis, etc) when accessed directly, return themselves, not the parent chart, so need to chain separately
        .tickFormat(function(d) {
          var newDate = new Date('2013-03-15');                         // start date
          newDate.setDate(newDate.getDate() - (50 - d) * 45.6 + 2100);  // makes dates increase quarterly
          var nd = new Date(newDate);
          return d3.time.format('%b %Y')(nd);
        });
    chartE.yAxis
        .axisLabel('Voltage (v)')
        .tickFormat(d3.format(',f'));

    d3.select('#' + chartID + ' svg')
        .datum(data_for_3L_LineChart(startValues, clusterNames))
        .transition().duration(500)
        .call(chartE);
    nv.utils.windowResize(chartE.update);

    return chartE;
  });
}


function data_for_3L_LineChart(startValues, clusterNames) {
  var past = [];
  var future = [];
  var max_future_projections = 17;
  var rand_range_min = 89;
  var rand_range_max = 112;
  var myColors = ["#5F9EA0", "#DEB887", "#D2691E", "#008B8B", "#9932CC", "#B22222", "#696969", "#FFD700", "#ADFF2F", "#FF69B4", "#32CD32", "#FF4500", "#4169E1"];
  var myColorCounter = 0;

  if (startValues) {
    returnValues = [];
    for (i=0; i<startValues.length; i++) {
      var past = [];
      var future = [];
      // past values
        y_values = [startValues[i]*0.92, startValues[i]*0.95, startValues[i]*0.97, startValues[i]];
        for (j=0; j<y_values.length; j++) {
          past.push({x: j+1, y: y_values[j]});
          future.push({x: j+1, y: y_values[j]});
        }
      // future values
        prev = y_values[y_values.length-1];
        for (j=0; j<max_future_projections; j++) {
          temp_y = prev * 1.02019114486 * (Math.round(Math.random()*(rand_range_max - rand_range_min) + rand_range_min) / 100);
          future.push({x: j+y_values.length+1, y: temp_y });
          prev = temp_y;
        }
      // return values (future)
        temp = {};
        temp['area'] = true;
        temp['values'] = future;
        temp['key'] = clusterNames[i] + "-FUTURE";  // give it a name + "future"
        temp['color'] = "#737373";                  // grey
        returnValues.push(temp);
      // return values (past)
        temp = {};
        temp['area'] = true;
        temp['values'] = past;
        temp['key'] = clusterNames[i] + "-PAST";    // give it a name + "past"
        temp['color'] = myColors[myColorCounter];
        myColorCounter ++;
        returnValues.push(temp);
    }
    return returnValues;

  } else {
    // past values
      y_values = [4362940, 4472592, 4551533, 4665523, 4812212];
      for (i=0; i<y_values.length; i++) {
        past.push({x: i+1, y: y_values[i]});
        future.push({x: i+1, y: y_values[i]});
      }
    // future values
      prev = y_values[y_values.length-1];
      for (i=0; i<max_future_projections; i++) {
        temp_y = prev * 1.02019114486 * (Math.round(Math.random()*(rand_range_max - rand_range_min) + rand_range_min) / 100);
        future.push({x: i+6, y: temp_y });
        prev = temp_y;
      }
    // return values
      return [
        { area: true, values: future, key: "FUTURE", color: "#737373" },
        { area: true, values: past, key: "PAST", color: "#ff7f0e" }
      ];
  }

}


