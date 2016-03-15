HDWall
======


### Running the 'Popup' branch for a demo:
 * This branch uses Web Sockets, not SSE
 * Quirks that this version has:
    - Big Maps (1R, 3R) require Firefox (it craps out in Chrome)
    - 1L2L requires requires Chrome (the pie chart craps out in Firefox)
    - 3R requires zoom to remove white space below the map
    - The more Firefox is zoomed in, the larger the 3R popup will be. I suggest keeping it at the appropriate zoom so that the popup is sized properly, then zoom into 3R after it's open
 * Setup: 
    - Open the homepage in Chrome in the left 2 panels
    - Open the homepage in Firefox somewhere in the right 6 panels
 * Act I:
    - In Chrome, click the 1L2L button (it should pop up to fill the left 2 panels)
    - In Firefox, click the 1R button
 * Act II: 
    - Close 1R
    - In Chrome, scroll down in 1L2L, and click the "Act II" button
 * Act III:
    - Close 2MT1, 2MT2, 2MB, 2R
    - In Chrome, click the 3L button
    - In Firefox, click the 3R button
    - Zoom into 3R until the white space underneath the maps is gone




This app is intended to be displayed on a very large wall. We displayed on 8 55" HD monitors stacked 4 wide, 2 tall, for an active screen area of about 16' wide x 4.5' tall. 

The app is divided into 3 separate layouts (depicted below). Each layout has separate screens (labeled below). 

	Layout 1:					Layout 2:					Layout 3:
	 ___________________     _____________________      _____________________
	|1L2L|     1R       |	   |1L2L| 2MT|2MT | 2R |      | 3L |      3R      |
	|    |              |	   |    |____|____|    |      |    |              |
	|    |              |	   |    |   2MB   |    |      |    |              |
	|____|______________|    |____|_________|____|      |____|______________|


Key Technologies
 - jQuery Mobile and Theme Roller
    To get it to work, be sure to not only 'bundle install', but also 'bundle install --path vendor' 
 - Google Maps API (v3) and Google Earth API
    In order to use it, you'll need to use an API key. See this site for more info: 
    https://developers.google.com/maps/documentation/javascript/tutorial 
 - WebSockets 
    Used for intra-screen communication. For example, clicking on 1L2L sends messages via WebSockets to 1R and 2MT
 - AJAX
    Used to update the page with database content without refreshing the entire page. For example, whenever a new cluster is built, 2R makes a database call and adds the new content to itself. 
 - Amplify.js
    Used to simplify WebSocket and AJAX commands. 




How does the "Update Map" button on 1L2L work? 
 1) 1L2L.html 	- click the "Update Map" button
 				- controlPanelValues() function is called
 2) 1L2L.js 	- controlPanelValues() function is executed
 				- 5 URL parameters are built (one for each variable Category, and one for the Filters)
 				- WebSocket message is sent
 3) 1R.html 	- updateMapKML is defined, so that screen 1R will handle the incoming WebSocket message
 4) 1R.js 		- updateMapKML is executed
 				- drawLayer() function is called, using parameters
 5) 1R.html 	- drawLayer() function is executed, using parameters


How does the "Next" button on 2R work? 
 1) 2R.html 	- click the "Next" button
  				- sendClusters() function is called
 2) 2R.js 		- sendClusters() function is executed
  				- WebSocket message is sent ("createClusterTabs")
 3) 3L.html		- createClusterTabs is defined, so that screen 3L will handle the incoming WebSocket message
 4) 3L.js 		- createClusterTabs() is executed
 5) 3L.html 	- new cluster tab is added, and its tab contents are added
  				- update3Lgroupbar() function is called
  				






