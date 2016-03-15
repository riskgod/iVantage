class ChartsController < ApplicationController

  $categories = VariableDim.select("var_id, var_name, default_rank").where(:var_parent => 0).order(:var_id)

  def screen2MB
    @categories = VariableDim.select("var_id, var_name, default_rank").where(:var_parent => 0).order(:var_id)
    @variables = VariableDim.select("var_parent, var_name, default_rank, var_id").where("control_panel = true AND var_parent > 0").order(:var_parent, :default_rank)
  end

  def get_timeseries_data_for_zips
    chart = params[:chart]
    varID = params[:varID]
    map1Zips = params[:map1_selected].split(',')
    map2Zips = params[:map2_selected].split(',')
    map1Results = {}
    map2Results = {}

    selectStatement = varID + "_2012Q1,"  + varID + "_2012Q2," + varID + "_2012Q3," + varID + "_2012Q4," + varID + "_2013Q1"
    varKeys = selectStatement.split(',')

    map1Zips.each do |zip|
      begin
        tempResults = Timeseries.where(:zip => " " + zip + " ")[0]
        tempArray = []
        varKeys.each do |key|
          tempArray << tempResults[key]
        end
        map1Results[zip] = tempArray
      rescue Exception => e
        puts e.message + ": " + zip.to_s
      end
    end

    map2Zips.each do |zip|
      begin
        tempResults = Timeseries.where(:zip => " " + zip + " ")[0]
        tempArray = []
        varKeys.each do |key|
          tempArray << tempResults[key]
        end
        map2Results[zip] = tempArray
      rescue Exception => e
        puts e.message + ": " + zip.to_s
      end
    end

    results = {"chart" => chart, "varID" => varID, "map1Results" => map1Results.to_json, "map2Results" => map2Results.to_json}

    render :json => results.to_json
  end

  def get_variable_values_for_zips
    chart = params[:chart]
    axis = params[:axis]
    varID = params[:varID]
    varName = varID[0,3] != "cat" ? VariableDim.select("var_name").where(:var_id => varID.split('_')[1].to_s)[0]["var_name"] : varID
    map1Zips = params[:map1_selected].split(',')
    map2Zips = params[:map2_selected].split(',')
    map1Results = {}
    map2Results = {}
    allResults = {}

    map1Zips.each do |zip|
      begin
        tempResults = {}
        tempVarValues = varID[0,3] != "cat" ? Variable3Zip.select(varID +  ", varid_38, varid_39, varid_40, varid_41, varid_42").where(:zip => zip)[0] : Variable3Zip.select("varid_38, varid_39, varid_40, varid_41, varid_42").where(:zip => zip)[0]
        tempResults["value"] = varID[0,3] != "cat" ? (zip.length == 3 ? tempVarValues[varID] : "0.0") : (zip.length == 3 ? $current_zip_scores[zip.to_s][varID] : "0.0")
        tempResults["filter_state"] = tempVarValues["varid_38"].to_i.to_s + tempVarValues["varid_39"].to_i.to_s + tempVarValues["varid_40"].to_i.to_s + tempVarValues["varid_41"].to_i.to_s + tempVarValues["varid_42"].to_i.to_s
        map1Results[zip] = tempResults
      rescue Exception => e
        puts e.message + ": " + zip
      end
    end

    map2Zips.each do |zip|
      begin
        tempResults = {}
        tempVarValues = varID[0,3] != "cat" ? Variable3Zip.select(varID +  ", varid_38, varid_39, varid_40, varid_41, varid_42").where(:zip => zip)[0] : Variable3Zip.select("varid_38, varid_39, varid_40, varid_41, varid_42").where(:zip => zip)[0]
        tempResults["value"] = varID[0,3] != "cat" ? (zip.length == 3 ? tempVarValues[varID] : "0.0") : (zip.length == 3 ? $current_zip_scores[zip.to_s][varID] : "0.0")
        tempResults["filter_state"] = tempVarValues["varid_38"].to_i.to_s + tempVarValues["varid_39"].to_i.to_s + tempVarValues["varid_40"].to_i.to_s + tempVarValues["varid_41"].to_i.to_s + tempVarValues["varid_42"].to_i.to_s
         map2Results[zip] = tempResults
      rescue Exception => e
        puts e.message + ": " + zip
      end
    end

    puts $current_zip_scores
    puts $current_zip_scores["777"]

    @@three_digit_zips.each_key {|zip|
      begin
        tempResults = {}
        tempVarValues = varID[0,3] != "cat" ? Variable3Zip.select(varID +  ", varid_38, varid_39, varid_40, varid_41, varid_42").where(:zip => zip)[0] : Variable3Zip.select("varid_38, varid_39, varid_40, varid_41, varid_42").where(:zip => zip)[0]
        tempResults["value"] = varID[0,3] != "cat" ? (zip.length == 3 ? tempVarValues[varID] : "0.0") : (zip.length == 3 ? $current_zip_scores[zip.to_s][varID] : "0.0")
        tempResults["filter_state"] = tempVarValues["varid_38"].to_i.to_s + tempVarValues["varid_39"].to_i.to_s + tempVarValues["varid_40"].to_i.to_s + tempVarValues["varid_41"].to_i.to_s + tempVarValues["varid_42"].to_i.to_s
        allResults[zip] = tempResults
      rescue Exception => e
        puts e.message + ": " + zip.to_s
      end
    }

    results = {"chart" => chart, "axis" => axis, "varID" => varID, "varName" => varName, "map1Results" => map1Results.to_json, "map2Results" => map2Results.to_json, "allResults" => allResults.to_json}

    render :json => results.to_json
  end
end
