var updateMapKML = function(data) {

  var cp_values = JSON.parse(data);
  drawLayer(cp_values.MPstring, cp_values.APstring, cp_values.CAstring, cp_values.CDstring, cp_values.FilterString);
  setTimeout("removeFirstLayer()", 8000);

};
