// Global Variables
var cluster_labels = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,AA,BB,CC,DD,EE,FF,GG,HH,II,JJ,KK,LL,MM,NN,OO,PP,QQ,RR,SS,TT,UU,VV,WW,XX,YY,ZZ".split(',');
var zip_clusters = {};
var zip_clusters_mapping = {};

// AJAX Call Definitions
amplify.request.define("getAgentsForZips", "ajax", {
  url: "/agents/get_agents_for_zips/{clusterID}/{zips}/",
  dataType: "json",
  type: "GET"
});

amplify.request.define("getAgentModalInfo", "ajax", {
  url: "/agents/get_agent_info_for_modal/{agentID}",
  dataType: "json",
  type: "GET"
});

function toCamelCase(str) {
  str = str.toLowerCase();
    return str.replace(/(?:^|\s)\w/g, function(match) {
        return match.toUpperCase();
    });
}

// Screen Functions
function animate_2R_tabs(target) {
  // Format tabs & links
  $('.cluster-tab').removeClass('selected').addClass('unselected');
  $('.cluster-tab a').removeClass('selectedLink').addClass('unselectedLink');
  $(target).removeClass('unselectedLink').addClass('selectedLink');
  $(target).parent().removeClass('unselected').addClass('selected');

  // Show/Hide tab content panels
  var contentPanelID = $(target).parent().attr('id') + "-content";
  $('.tab-content-panel').css('display', 'none');
  $('#' + contentPanelID).css('display', 'block');
}

var removeCluster = function(target, clusterID) {
  delete zip_clusters[zip_clusters_mapping[clusterID]];
  delete the_agents[zip_clusters_mapping[clusterID]];
	$(target).parent().remove();
  $('#tab-' + clusterID + '-content').remove();

  if($('.cluster-tab a').length > 0) {
    $('.cluster-tab a')[0].click();
  }

  drawSummaryCharts();
};

function updateClusterName(target) {
  var newName = $(target).val();
  var tempZipList = zip_clusters[zip_clusters_mapping[$(target).parent().parent().attr('id').substring(4)]];
  var tempThe_Agents = the_agents[zip_clusters_mapping[$(target).parent().parent().attr('id').substring(4)]];

  // Update Zip Cluster, Agent, and Zip Mapping hashes with new name
  zip_clusters[newName] = tempZipList;
  delete zip_clusters[zip_clusters_mapping[$(target).parent().parent().attr('id').substring(4)]];

  the_agents[newName] = tempThe_Agents;
  delete the_agents[zip_clusters_mapping[$(target).parent().parent().attr('id').substring(4)]];

  var span_id = $(target).parent().parent().attr('id').replace("cluster", "content-title-cluster");
  $('#' + span_id).html(newName);

  // Update cluster name mapping
  zip_clusters_mapping[$(target).parent().parent().attr('id').substring(4)] = newName;

  // Redraw summary Charts
  drawSummaryCharts();
}

var sendClusters = function() {
    var count = 0;

    for(var key in zip_clusters) {
        count++;
    }

    if(count > 0) {
        sendWSMessage("createClusterTabs", JSON.stringify(zip_clusters));
        // zip_clusters = {};
    } else {console.log("No clusters have been chosen.");}
};
