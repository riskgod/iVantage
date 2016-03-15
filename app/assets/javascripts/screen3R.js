// AJAX Call Definitions
amplify.request.define("getReverseGeocode", "ajax", {
  url: "http://maps.googleapis.com/maps/api/geocode/json?latlng={lat},{lng}&sensor=false",
  dataType: "json",
  type: "GET"
});

amplify.request.define("getZillowDeepSearch", "ajax", {
  url: "/maps/get_zillow_deep_search_results/{address}/{zip}",
  dataType: "json",
  type: "GET"
});


// screen3R Methods
var addClusterLayers = function(msg) {
  var dataHash = JSON.parse(msg);
  var count = 0;

  for(var key in dataHash) {
    drawOneLayer(count, key, dataHash[key]);
    count += 1;
  }

  drawUSOutline();
};

function clickClusterMap(whichCluster) {
  var msgData = {
    cluster : 'tab-' + whichCluster.replace(' ','-').replace('C','c')
  };

  sendWSMessage("showClusterTab", JSON.stringify(msgData));
}

function showHideZillowWindow() {
  if($('#zillow_data_window').height() < 5) {
    $('#zillow_data_window').height('185px');
    $('#zillow_window_control').html('(hide)');
  }
  else {
    $('#zillow_data_window').height('0px');
    $('#zillow_window_control').html('(show)');
  }
}

function getZillowDeepSearchResults(address_components) {
  if(address_components["status"] != -1) {
    amplify.request("getZillowDeepSearch", {
      address: address_components["street"],
      zip: address_components["zip"]
    },
    function(results){
      //console.log(results);
      var propDetails = results.property_details;
      $('#zillow_address', top.document).html(propDetails.address.street + ", " + propDetails.address.city + ", " + propDetails.address.state + " " + propDetails.address.zipcode);
      $('#zillow_home_type', top.document).html(propDetails.use_code);
      $('#zillow_built', top.document).html(propDetails.year_built);
      $('#zillow_price', top.document).html("$" + propDetails.price);
      $('#zillow_sqft', top.document).html(propDetails.finished_square_feet);
      $('#zillow_lot', top.document).html(propDetails.lot_size_square_feet);
    });
  } else {
    $('#zillow_address', top.document).html(address_components["full_address"]);
    $('#zillow_home_type', top.document).html("");
    $('#zillow_built', top.document).html("");
    $('#zillow_price', top.document).html("");
    $('#zillow_sqft', top.document).html("");
    $('#zillow_lot', top.document).html("");
  }
}

var prepareStreetAddressForZillow = function(full_address) {
  var address_components = {};
  address_components["full_address"] = full_address;
  var addressParts = full_address.trim().split(',');

  // Check to ensure that full address (street, city, state zip, country) has been captured
  if(addressParts.length == 4) {
    var address_street = addressParts[0].trim().replace(/ /g,'+');
    var address_zip = addressParts[2].trim().split(' ')[1].trim();

    // Check to ensure that exact street address has been found (no address ranges and numeric street address is present)
    if(address_street.indexOf('-') == -1 && !isNaN(address_street.split('+')[0])) {
      address_components["street"] = address_street;
      address_components["zip"] = address_zip;
      address_components["status"] = 0;
    } else {
      address_components["status"] = -1;
    }
  } else {
    address_components["status"] = -1;
  }

  return address_components;
};

function getReadableAddress(lat, lng) {
  amplify.request("getReverseGeocode", {
    lat: lat,
    lng: lng
  },
  function(results){
    console.log("Nearest Address: " + results.results[0].formatted_address);
    getZillowDeepSearchResults(prepareStreetAddressForZillow(results.results[0].formatted_address));
  });
}









