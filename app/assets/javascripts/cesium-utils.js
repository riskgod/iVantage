    var viewer;
    var x2js = new X2JS();
    var overlayClass = 'screenOverlay';

    // Initialize Cesium view
    function initViewer(mapID) {
        viewer = new Cesium.Viewer(mapID, {
            geocoder: false,
            homeButton: false,
            sceneModePicker: false,
            baseLayerPicker: false,
            navigationHelpButton: false,
            animation: false,
            timeline: false
        });
        drawLayer();
    }

    // Render ScreenOverlay on viewer using kmlData
    function renderScreenOverlay(kmlData) {
        var oScreenOverlay = x2js.xml2json(kmlData.getElementsByTagName('ScreenOverlay')[0]);
        // console.log(oScreenOverlay);

        //Add overlay by creating an HTML element
        var img = document.createElement('img');
        img.src = oScreenOverlay.Icon.href;
        viewer.container.appendChild(img);

        var rotation = oScreenOverlay.rotationXY._x + 'deg';
        var topOffset = oScreenOverlay.overlayXY._y;
        var leftOffset = oScreenOverlay.overlayXY._x;

        //Position overlay with CSS styling
        img.className = overlayClass;
        img.style.width = '20%';
        img.style.position = 'absolute';
        img.style.top = 'calc(60% + ' + topOffset + 'px)';
        img.style.left = 'calc(0% + ' + leftOffset + 'px)';
        img.style['pointer-events'] = 'none';
        img.style['-ms-transform'] = 'rotate(' + rotation + ')'; /* IE 9 */
        img.style['-webkit-transform'] = 'rotate(' + rotation + ')'; /* Chrome, Safari, Opera */
        img.style.transform = 'rotate(' + rotation + ')';
    }

    // Remove old layer
    function removeOldLayer() {
        viewer.dataSources.remove(viewer.dataSources.get(0));
        viewer.container.removeChild(viewer.container.getElementsByClassName(overlayClass)[0]);
    }