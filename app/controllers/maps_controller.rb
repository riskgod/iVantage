class MapsController < ApplicationController
	layout 'maps'

  $blue_hex_array = ['4C0000', '660000', '800000', '990000', 'B20000', 'CC0000', 'E60000', 'FF0000', 'FF1919', 'FF3333', 'FF4D4D', 'FF6666', 'FF8080', 'FF9999', 'FFB2B2', 'FFCCCC', 'FFE6E6']
	$green_hex_array = ['004C00', '006600', '008000', '009900', '00B200', '00CC00', '00E600', '00FF00', '19FF19', '33FF33', '4DFF4D', '66FF66', '80FF80', '99FF99', 'B2FFB2', 'CCFFCC', 'E6FFE6']
	$red_hex_array = ['00004C', '000066', '000080', '000099', '0000B2', '0000CC', '0000E6', '0000FF', '1919FF', '3333FF', '4D4DFF', '6666FF', '8080FF', '9999FF', 'B2B2FF', 'CCCCFF', 'E6E6FF']
	$colors_array = [$blue_hex_array, $green_hex_array, $red_hex_array]

  def screen1R
  end

  def get_zillow_deep_search_results  #Zillow Web Service ID listed in rubillow_config.rb initializer files
  	results = {}
  	propertyResults = Rubillow::PropertyDetails.deep_search_results({ :address => params[:address].to_s, :citystatezip => params[:zip].to_s })

  	if propertyResults.success?
  		puts "ZILLOW SUCCESS"
  		results["status"] = "SUCCESS"
  		results["property_details"] = propertyResults
  	else
  		results["status"] = "FAIL"
  		results["property_details"] = {}
		end

  	render :json => results.to_json
  end

  def get_map_KML_blue

  	color_hue = params[:colors_array].to_i

		contents = Nokogiri::XML::Builder.new do |xml|
		  xml.kml('xmlns' => "http://earth.google.com/kml/2.2", 'xmlns:atom' => "http://www.w3.org/2005/Atom") {
			xml.Document {
			  xml.ScreenOverlay {
			  	xml.name "Map Legend Blue"
			  	xml.Icon {
			  	  xml.href "http://#{$serverURL}:3000/map_legend_blue.png"
			  	}
			  	xml.overlayXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  	xml.screenXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  	xml.rotationXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  	xml.size('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  }
			  @@three_digit_zips.each { |zip, coordinates|
				  	xml.Placemark {
				  	  xml.Style {
				  	  	xml.LineStyle {
				  	  	  xml.color "eeffffff"												# Border color
				  	  	  xml.width 2 														# Border width
				  	  	}
				  	  	xml.PolyStyle {
				  	  	  xml.color '99' + $colors_array[color_hue][rand($blue_hex_array.length)]	# Fill color
				  	  	}
				  	  }
				  	  xml.description zip.to_s 												# ZIP code
				  	  xml.MultiGeometry {
				  	  	xml.MultiGeometry {
				  	  	  xml.Polygon {
				  	  	  	xml.outerBoundaryIs {
				  	  	  	  xml.LinearRing {
				  	  	  	  	xml.coordinates coordinates 								# ZIP coordinates
				  	  	  	  }
				  	  	  	}
				  	  	  }
				  	  	}
				  	  }
						}
					}
				}
	  	}
		end

		render :xml => contents
  end


  def get_map_KML_red

  	color_hue = params[:colors_array].to_i

		contents = Nokogiri::XML::Builder.new do |xml|
		  xml.kml('xmlns' => "http://earth.google.com/kml/2.2", 'xmlns:atom' => "http://www.w3.org/2005/Atom") {
			xml.Document {
			  xml.ScreenOverlay {
			  	xml.name "Map Legend Red"
			  	xml.Icon {
			  	  xml.href "http://#{$serverURL}:3000/map_legend_red.png"
			  	}
			  	xml.overlayXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  	xml.screenXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  	xml.rotationXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  	xml.size('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
			  }
			  @@three_digit_zips.each { |zip, coordinates|
				  	xml.Placemark {
				  	  xml.Style {
				  	  	xml.LineStyle {
				  	  	  xml.color "eeffffff"												# Border color
				  	  	  xml.width 2 														# Border width
				  	  	}
				  	  	xml.PolyStyle {
				  	  	  xml.color '99' + $colors_array[color_hue][rand($red_hex_array.length)]	# Fill color
				  	  	}
				  	  }
				  	  xml.description zip.to_s 												# ZIP code
				  	  xml.MultiGeometry {
				  	  	xml.MultiGeometry {
				  	  	  xml.Polygon {
				  	  	  	xml.outerBoundaryIs {
				  	  	  	  xml.LinearRing {
				  	  	  	  	xml.coordinates coordinates 								# ZIP coordinates
				  	  	  	  }
				  	  	  	}
				  	  	  }
				  	  	}
				  	  }
						}
					}
				}
		  }
		end

		render :xml => contents
  end


  def get_map_KML_selected
  	overlay_colors = ['3399bb00', '33cc0077', '3300eeff', '33ff5500', '3311cc00', '3300bbff', '33eeff00', '339900ff', '330000ff', '3388ff00', '3388ff00', '3300ffcc', '33006600']
  	clusterNum = params[:clusterNum].to_i
  	clusterName = params[:clusterName].sub(/-/, ' ').camelize
  	clusterZipList = params[:clusterZipList].split(",")
  	clusterColor = (clusterNum < overlay_colors.length) ? overlay_colors[clusterNum] : overlay_colors[clusterNum % overlay_colors.length]

		mapLayerXML = Nokogiri::XML::Builder.new do |xml|
		  xml.kml('xmlns' => "http://earth.google.com/kml/2.2", 'xmlns:atom' => "http://www.w3.org/2005/Atom") {
				xml.Document {
				  	clusterZipList.each { |zip|
					  	xml.Placemark {
					  	  xml.Style {
					  	  	xml.LineStyle {
					  	  	  xml.color "aaffffff"							# Border color
					  	  	  xml.width 2 											# Border width
					  	  	}
					  	  	xml.PolyStyle {
					  	  	  xml.color clusterColor 						# Fill color
					  	  	}
					  	  }
					  	  xml.description clusterName 					# Cluster name
					  	  xml.MultiGeometry {
					  	  	xml.MultiGeometry {
					  	  	  xml.Polygon {
					  	  	  	xml.outerBoundaryIs {
					  	  	  	  xml.LinearRing {
					  	  	  	  	xml.coordinates @@three_digit_zips[zip.to_sym] 	# ZIP coordinates
					  	  	  	  }
					  	  	  	}
					  	  	  }
					  	  	}
					  	  }
						}
					}
			  }
			}
		end

  	render :xml => mapLayerXML
  end

end
