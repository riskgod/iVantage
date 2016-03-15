function getContentPanelHTML(id, ziplist) {
  var html = '<div id="tab-' + id + '-content" class="tab-content-panel" data-role="content"><span>' + ziplist + '</div>';
  return html;
}

function getTabHTML(id, label) {
  var html = '<li id="tab-' + id + '" class="unselected cluster-tab"><a href="javascript:void(0);" onClick="animate_tab(this);"><strong>' + label + '</strong></a></li>';
  return html;
}

var createClusterTabs = function(msg){
  var dataHash = JSON.parse(msg);

  // build out the string of ZIPs for each cluster to look like this: 1,2,3-4,5-6,7,8,9
  selected_zips = "";
  cluster_names = [];
  for(var key in dataHash) {
    selected_zips += dataHash[key];
    selected_zips += "-";
    cluster_names.push(key.toString());
  }

  for(var key in dataHash) {
    var clusterID = key.toString();
    var clusterLabel = key.replace("-", " ");
    clusterLabel = clusterLabel[0].toUpperCase() + clusterLabel.slice(1); // Create camel case cluster label text
    var tempHTML = getTabHTML(clusterID, clusterLabel);
    $('#cluster_tabs_container').append(tempHTML);
    recalcTabWidth();
    tempHTML = getContentPanelHTML(clusterID, dataHash[key].toString());
    var clusterZips = [dataHash[key].toString()];
  }
};

var showClusterTab = function(msg) {
  var dataHash = JSON.parse(msg);
  $('#' + dataHash.cluster + " a").click();
}

function recalcTabWidth() {
  var coll = $('.cluster-tab');
  var width = (100 / coll.length - 0.16).toString() + "%";
  coll.css('width', width);
}

function animate_tab(target) {
  // Format tabs
  $('.cluster-tab').removeClass('selected').addClass('unselected');
  $(target).parent().removeClass('unselected').addClass('selected');

  // Show/Hide tab content panels
  var contentPanelID = $(target).parent().attr('id') + "-content";
  $('.tab-content-panel').css('display', 'none');
  $('#' + contentPanelID).css('display', 'block');

  // Trigger resize event to redraw charts
  $(window).resize();
}


var var2_projection_value = 0;
var var3_projection_value = 0;
function update3RProjections(whichvar) {
  // goal is to get the future score for the specified variable
  projection_value = (whichvar == 'var2' ? var2_projection_value : var3_projection_value);
  // alert(whichvar + ', projected: ' + projection_value.toString());

  data = {};
  data["projection_value"] = projection_value;
  data["whichvar"] = whichvar;
  data["levers3L"] = ($('#scenSlider1').val()*10).toString() + "," + ($('#scenSlider2').val()*10).toString() + "," + ($('#scenSlider3').val()*10).toString() + "," + ($('#scenSlider4').val()*10).toString() + "," + ($('#checkbox-v-2a').is(':checked') ? "1" : "0") + "," + ($('#checkbox-v-2b').is(':checked') ? "1" : "0") + "," + ($('#checkbox-v-2c').is(':checked') ? "1" : "0");
  sendWSMessage('update3RMapKML', JSON.stringify(data));
}
