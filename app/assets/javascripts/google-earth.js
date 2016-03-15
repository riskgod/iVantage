var ge;

function setupGE() {
  google.load("earth", "1");
  google.setOnLoadCallback(init);
}

function init() {
  google.earth.createInstance('map3d', initCB, failureCB);
}

function initCB(instance) {
  ge = instance;
  ge.getWindow().setVisibility(true);
  initializeMap();
}

function failureCB(errorCode) {
  console.log("Google Earth Error Code: " + errorCode);
}

function removeLastLayer() {
  var features = ge.getFeatures();
  features.removeChild(features.getLastChild());
}

function removeFirstLayer() {
  var features = ge.getFeatures();
  features.removeChild(features.getFirstChild());
}