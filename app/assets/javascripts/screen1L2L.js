var updateMap = function() {
	// Send WS message with random int 0 - 2
  var data = {};
  data["map"] = Math.floor(Math.random()*3).toString();
	sendWSMessage('updateMapKML', JSON.stringify(data));
};

function addVarPieChart(chartID){


nv.addGraph(function() {
    // var width,
    //     height;

    // 8106a9: purple
    // e9fb00: yellow
    // 057d9f: blue
    // ff8100: orange
    // 339933: green

    var myColors = ["#e9fb00", "#8106A9", "#339933", "#ff8100" ];
    d3.scale.myColors = function() {
        return d3.scale.ordinal().range(myColors);
    };

    var chartD = nv.models.pieChart()
        .x(function(d) { return d.key })
        .y(function(d) { return d.y })
        //.showLabels(false)
        .values(function(d) { return d })
        .color(d3.scale.myColors().range())
        // .width(width)
        // .height(height);
        .showLegend(false);

      d3.select('#' + chartID + ' svg')
          .datum([varPieData])
        .transition().duration(1200)
          // .attr('width', width)
          // .attr('height', height)
          .call(chartD);

    chartD.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });

    nv.utils.windowResize(chartD.update);
    return chartD;
});
}

var varPieData





  /******************************************************************************************
    controlPanelValues() deals with the 2 sets of control panels on 1L2L
    whichtab = the source tab (e.g., "Map 1", "Map 2")
    whichmap = the target map to be updated (1 = Map1, 2 = Map2, 3 = both maps)
   ******************************************************************************************/
  function controlPanelValues(whichtab, whichmap) {

    // when the "Update Both Maps" button is clicked, we need to transfer all control panel settings from 1 tab to the other
    // updating slider values is easy enough; updating the checkboxes is trickier
    // this section loops through each category, then each checkbox, building out the HTML to rebuild the checkboxes
    // (can't just take the hTML from one tab and paste into the other because you'd need to reapply the jQuery, 
    //  but you can't just run checkboxradio() because it adds extra spans that were already copied over)
    if (whichmap == 3) {
      targettab = (whichtab == 1 ? 2 : 1);  // targettab is the opposite of the source tab (1 or 2)
      for (i=1; i<5; i++) {                 // loop from 1-4, representing the 4 categories
        $('#slider' + targettab + '-' + i.toString()).val($('#slider' + whichtab + '-' + i.toString()).val()); // update slider values
        $('#slider' + targettab + '-' + i.toString()).slider('refresh'); // refresh slider to reflect value
        msg = "";
        j = 0;
        varid_array = [];   // use this to capture list of checkbox IDs, used to reapply jQuery to the checkboxes
        $('#subVar' + whichtab + '-' + i + ' li div input').each(function() { 
          msg += "<li>";
          msg += "<input type=\"checkbox\" name=\"" + $(this).attr('id') + "\" id=\"" + $(this).attr('id') + "\" class=\"custom\"" ;
          msg += $(this).is(':checked') ? " checked=\"checked\">" : ">";
          msg += "<label class=\"sliderLabel\" for=\"" + $(this).attr('id') + "\">" + $('#subVar' + whichtab + '-' + i + ' li div label span span')[j].innerHTML + "</label>"
          msg += "</li>";
          j += 2;
          varid_array.push($(this).attr('id'));
        })
        
        $('#subVar' + targettab + '-' + i.toString()).html(msg);  // update the HTML to be correct
        for (j=0; j<varid_array.length; j++) {                    // reapply jQuery to each checkbox
          $('#subVar' + targettab + '-' + i.toString() + ' #' + varid_array[j]).checkboxradio();
        }
        
      }


      // // loop through each category, creating an array of arrays of arrays:
      // // category_checkboxes: [[cat1], [cat2], [cat3], [cat4]]
      // // cat1 = [[varid1, checked], [varid2, not checked], [varid3, checked]]
      // var category_checkboxes = [];
      // for (j=1; j<5; j++) {
      //   catX_checkboxes = [];
      //   $('#subVar1-' + j + ' li div input').each(function() { 
      //     temp = [];                                  // create a temporary array
      //     temp.push($(this).attr('id'));              // add input ID
      //     temp.push($(this).is(':checked') ? 1 : 0);  // add '1' if checked, '0' if not checked
      //     catX_checkboxes.push(temp);
      //   });
      //   category_checkboxes.push(catX_checkboxes);
      // }
      // // alert(category_checkboxes);

      // <li>
      //   <input type=​"checkbox" name=​"checkbox-26" id=​"checkbox-26" class=​"custom" checked=​"checked">​
      //   <label class="sliderLabel" for="checkbox-26">Var Name</label>
      // </li>

      // msg = "";
      // msg += "<li>";
      // for (i=0; i<$('#subVar1-1 li div input').length; i++) {
      //   msg += $('#subVar1-1 li div input')[i].outerHTML;
      // }
      // msg += "</li>";
      // // alert(msg);

      // // $('#subVar1-1').html()
    }


    var MPstring = '';
    var APstring = '';
    var CAstring = '';
    var CDstring = '';
    var data = {};



    MPstring += $('#slider' + whichtab + '-1').val() + "-";
    APstring += $('#slider' + whichtab + '-2').val() + "-";
    CAstring += $('#slider' + whichtab + '-3').val() + "-";
    CDstring += $('#slider' + whichtab + '-4').val() + "-";  



    // alert('MP: ' + MPstring + ', AP: ' + APstring + ', CA: ' + CAstring + ', CD: ' + CDstring);
    
    $('#subVar' + whichtab + '-1 li div input').each(function() {
      if ($(this).is(':checked')) {
      MPstring += $(this).attr('id').substring(9) + "," 
      }
    });
    MPstring = MPstring.substring(0,MPstring.length-1);
    data["MPstring"] = MPstring;
    // alert('MPstring: ' + MPstring);
    
    $('#subVar' + whichtab + '-2 li div input').each(function() {
      if ($(this).is(':checked')) {
      APstring += $(this).attr('id').substring(9) + "," 
      }
    });
    APstring = APstring.substring(0,APstring.length-1);
    data["APstring"] = APstring;
    // alert('APstring: ' + APstring);

    $('#subVar' + whichtab + '-3 li div input').each(function() {
      if ($(this).is(':checked')) {
      CAstring += $(this).attr('id').substring(9) + "," 
      }
    });
    CAstring = CAstring.substring(0,CAstring.length-1);
    data["CAstring"] = CAstring;
    // alert('CAstring: ' + CAstring);

    $('#subVar' + whichtab + '-4 li div input').each(function() {
      if ($(this).is(':checked')) {
      CDstring += $(this).attr('id').substring(9) + "," 
      }
    });
    CDstring = CDstring.substring(0,CDstring.length-1);
    data["CDstring"] = CDstring;
    // alert('CDstring: ' + CDstring);

    var FilterString = '';
    FilterString += $('#Urbanicity1').prop('checked') ? '1' : '0';
    FilterString += $('#Urbanicity2').prop('checked') ? '1' : '0';
    FilterString += $('#Urbanicity3').prop('checked') ? '1' : '0';
    FilterString += $('#CompanyFootprint1').prop('checked') ? '1' : '0';
    FilterString += $('#CompanyFootprint2').prop('checked') ? '1' : '0';
    // FilterString += $('#openness-3').prop('checked') ? '1' : '0';
    data["FilterString"] = FilterString;
    // alert('FilterString: ' + FilterString);

    data["whichmap"] = whichmap;

    map1data = {};
    map1data["Market Potential"] = $('#slider1-1').val();
    map1data["Agency Presence"] = $('#slider1-2').val();
    map1data["Competitive Assessment"] = $('#slider1-3').val();
    map1data["Customer Behavior"] = $('#slider1-4').val();
    map2data = {};
    map2data["Market Potential"] = $('#slider2-1').val();
    map2data["Agency Presence"] = $('#slider2-2').val();
    map2data["Competitive Assessment"] = $('#slider2-3').val();
    map2data["Customer Behavior"] = $('#slider2-4').val();
    pieData = {};
    pieData["map1data"] = map1data;
    pieData["map2data"] = map2data;


    sendWSMessage('updateMapKML', JSON.stringify(data));
    sendWSMessage('update2MTpies', JSON.stringify(pieData));
  }

// tabs

function animate_1L2L_tabs(target) {
  // Format tabs & links
  $('.cluster-tab').removeClass('selected').addClass('unselected');
  $('.cluster-tab a').removeClass('selectedLink').addClass('unselectedLink');
  $(target).removeClass('unselectedLink').addClass('selectedLink');
  $(target).parent().removeClass('unselected').addClass('selected');

  // Show/Hide tab content panels
  var contentPanelID = $(target).parent().attr('id') + "-content";
  $('.tab-content-panel').css('display', 'none');
  $('#' + contentPanelID).css('display', 'block');

  $(window).resize();
}



