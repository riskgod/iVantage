class VariablesController < ApplicationController

  $categories = VariableDim.select("var_id, var_name, default_rank").where(:var_parent => 0).order(:var_id)
  $variables = VariableDim.select("var_id, var_parent, var_name, default_rank, default_checked").where("control_panel = true AND var_parent > 0").order(:var_parent, :default_rank)
  $varvals = VarZipRaw.select("zip, hvh_count, hvh_policies, ivantage_pif, agent_count")
  $filter_categories = VariableDim.select("var_id, var_name, default_rank").where(:var_parent => -2).order(:default_rank)
  $filters = VariableDim.select("var_name, var_parent, default_rank").where("var_parent >= 36").order(:default_rank)



  def screen1L2L

  end

  def getNextQtrScore (hvh_count, hvh_policies, ivantage_pif, agent_count, gdp_growth, agent_engagement, product_availability, retention_rate, provide_agents_data, baseline_conversion_rate_per_opp, percnt_ivantage_agents)
  	  # hard-coded
	  sum_ivantage_pif = 1155937
	  sum_agent_count = 8240
	  hardcode_95 = 0.95
	  hardcode_1 = 0.1
	  # calculated
	  agent_proxy = (ivantage_pif * 100000 / sum_ivantage_pif).round(10) * sum_agent_count / 100000
	  new_hvh_in_geo = hvh_count * gdp_growth / 100 / 4
	  churning_hvh = hvh_count * (1-hardcode_95)
	  total_hvh_opps_in_usa = new_hvh_in_geo + churning_hvh
	  new_hvh_per_travel_zone = total_hvh_opps_in_usa * hardcode_1
	  new_hvh_per_agent_travel_zone = new_hvh_per_travel_zone * provide_agents_data
	  sales_conversion_per_opportunity = product_availability * baseline_conversion_rate_per_opp
	  new_hvh_sales_per_active_agent = new_hvh_per_agent_travel_zone * sales_conversion_per_opportunity
	  agents_actively_selling_hvh = agent_proxy * agent_engagement * percnt_ivantage_agents
	  new_hvh_sales = agents_actively_selling_hvh * new_hvh_sales_per_active_agent
	  hvh_policies_lost_to_churn = hvh_policies * (1 - retention_rate)
	  hvh_policies_next = hvh_policies + new_hvh_sales - hvh_policies_lost_to_churn
	  hvh_count_next = hvh_count * (1 + gdp_growth / 100)
  	return [hvh_count_next.round(3), hvh_policies_next.round(3)]
  end


  def get_map_KML_DB
	# ------------------------------------------------------------------------------------------------------------------------
	# How this works
	#
	# 1) Define ROC (Rank Order Centroids)
	#
	# 2) Pull from the database:
	#  - categories (e.g., Market Potential, Customer Demographics, etc...)
	#  - variables (variables, their IDs, their parent category, and the default rank (order) for the control panel)
	#  - scores (how variables stack up against each ZIP code)
	#  - zips (list of ZIP codes)
	#
	# 3) Define ordered list of Variables for each Category
	#  - if we have custom parameters in the URL, parse the strings to get that info
	#  - otherwise, grab the defaults from the database
	#
	# 4) Create a nested hash containing all ZIPs and their scores for all variables
	#  - this way, we can call a ZIP by name, then call its corresponding variable by ID
	#
	# 5) Create an Array for each Category containing all ZIPs and their scores for "Only The Selected Variables"
	#
	# 6) Calculate a final score for each Category (integrating ROC)
	#
	# 7) Calculate the final scores for each ZIP
	# 7.5) Adjust final scores for screen 3R
	#
	# 8) Calculate the hex Colors for each ZIP
	#
	# 9) Build the KML file
  # ------------------------------------------------------------------------------------------------------------------------

	# 1) Define ROC (Rank Order Centroids) weightings
	roc = []
	roc[0] = [0]
	roc[1] = [1]
	roc[2] = [0.750, 0.250]
	roc[3] = [0.611, 0.278, 0.111]
	roc[4] = [0.521, 0.271, 0.146, 0.063]
	roc[5] = [0.457, 0.257, 0.157, 0.090, 0.040]
	roc[6] = [0.408, 0.242, 0.158, 0.103, 0.061, 0.028]
	roc[7] = [0.370, 0.228, 0.156, 0.109, 0.073, 0.044, 0.020]
	roc[8] = [0.340, 0.215, 0.152, 0.111, 0.079, 0.054, 0.033, 0.016]
	roc[9] = [0.314, 0.203, 0.148, 0.111, 0.083, 0.061, 0.042, 0.026, 0.012]
	roc[10] = [0.293, 0.193, 0.143, 0.110, 0.085, 0.065, 0.048, 0.034, 0.021, 0.010]
	roc[11] = [0.275, 0.184, 0.138, 0.108, 0.085, 0.067, 0.052, 0.039, 0.027, 0.017, 0.008]
	roc[12] = [0.259, 0.175, 0.134, 0.106, 0.085, 0.068, 0.054, 0.043, 0.032, 0.023, 0.015, 0.007]
	roc[13] = [0.245, 0.168, 0.129, 0.104, 0.084, 0.069, 0.056, 0.045, 0.036, 0.027, 0.019, 0.012, 0.006]
	roc[14] = [0.232, 0.161, 0.125, 0.101, 0.083, 0.069, 0.057, 0.047, 0.038, 0.030, 0.023, 0.017, 0.011, 0.005]
	roc[15] = [0.221, 0.155, 0.121, 0.099, 0.082, 0.069, 0.058, 0.048, 0.040, 0.033, 0.026, 0.020, 0.014, 0.009, 0.004]
	roc[16] = [0.211, 0.149, 0.118, 0.097, 0.081, 0.069, 0.058, 0.049, 0.041, 0.034, 0.028, 0.023, 0.017, 0.013, 0.008, 0.004]
	roc[17] = [0.202, 0.144, 0.114, 0.094, 0.080, 0.068, 0.058, 0.050, 0.042, 0.036, 0.030, 0.025, 0.020, 0.015, 0.011, 0.007, 0.003]
	roc[18] = [0.194, 0.139, 0.111, 0.092, 0.078, 0.067, 0.058, 0.050, 0.043, 0.037, 0.031, 0.026, 0.022, 0.017, 0.014, 0.010, 0.006, 0.003]
	roc[19] = [0.187, 0.134, 0.108, 0.090, 0.077, 0.067, 0.058, 0.050, 0.044, 0.038, 0.033, 0.028, 0.023, 0.019, 0.016, 0.012, 0.009, 0.006, 0.003]
	roc[20] = [0.180, 0.130, 0.105, 0.088, 0.076, 0.066, 0.057, 0.050, 0.044, 0.038, 0.033, 0.029, 0.025, 0.021, 0.017, 0.014, 0.011, 0.008, 0.005, 0.003]


	if(params.has_key?(:filters))
		filters = params[:filters]

		filters1_include_array = []
		filters1_exclude_array = []
		filters2_include_array = []
		filters2_exclude_array = []
		if filters[0] == "1"
			filters1_include_array.push "varid_38 = 1"
		else
			filters1_exclude_array.push "varid_38 = 0"
		end
		if filters[1] == "1"
			filters1_include_array.push "varid_39 = 1"
		else
			filters1_exclude_array.push "varid_39 = 0"
		end
		if filters[2] == "1"
			filters1_include_array.push "varid_40 = 1"
		else
			filters1_exclude_array.push "varid_40 = 0"
		end
		if filters[3] == "1"
			filters2_include_array.push "varid_41 = 1"
		else
			filters2_exclude_array.push "varid_41 = 0"
		end
		if filters[4] == "1"
			filters2_include_array.push "varid_42 = 1"
		else
			filters2_exclude_array.push "varid_42 = 0"
		end

		where_clause = "("
		# First set of filters (3)
		if filters1_include_array.length == 0 and filters1_exclude_array.length > 0
			filters1_exclude_array.each do |f|
				where_clause += f
				where_clause += " and "
			end
			where_clause = where_clause[0..-6]
		elsif filters1_include_array.length > 0 and filters1_exclude_array.length == 0
			filters1_include_array.each do |f|
				where_clause += f
				where_clause += " or "
			end
			where_clause = where_clause[0..-5]
		else
			where_clause += "("
			filters1_include_array.each do |f|
				where_clause += f
				where_clause += " or "
			end
			where_clause = where_clause[0..-5]
			where_clause += ") and "
			filters1_exclude_array.each do |f|
				where_clause += f
				where_clause += " and "
			end
			where_clause = where_clause[0..-6]
		end
		where_clause  += ") and ("
		# Second set of filters (2)
		if filters2_include_array.length == 0 and filters2_exclude_array.length > 0
			filters2_exclude_array.each do |f|
				where_clause += f
				where_clause += " and "
			end
			where_clause = where_clause[0..-6]
		elsif filters2_include_array.length > 0 and filters2_exclude_array.length == 0
			filters2_include_array.each do |f|
				where_clause += f
				where_clause += " or "
			end
			where_clause = where_clause[0..-5]
		else
			where_clause += filters2_include_array[0]
			where_clause += " and "
			where_clause += filters2_exclude_array[0]
		end 	
		where_clause += ")"
		print " -------------"
		print where_clause
		print " -------------"





		# include_array = []
		# exclude_array = []
		# if filters[0] == "1"
		# 	include_array.push "varid_39 = 1"
		# else
		# 	exclude_array.push "varid_39 = 0"
		# end
		# if filters[1] == "1"
		# 	include_array.push "varid_40 = 1"
		# else
		# 	exclude_array.push "varid_40 = 0"
		# end
		# if filters[2] == "1"
		# 	include_array.push "varid_41 = 1"
		# else
		# 	exclude_array.push "varid_41 = 0"
		# end
		# if filters[3] == "1"
		# 	include_array.push "varid_42 = 1"
		# else
		# 	exclude_array.push "varid_42 = 0"
		# end
		# if filters[4] == "1"
		# 	include_array.push "varid_43 = 1"
		# else
		# 	exclude_array.push "varid_43 = 0"
		# end

		# where_clause = ""
		# include_count = 0
		# exclude_count = 0

		# if include_array.length > 1
		# 	where_clause += "("
		# end
		# if include_array.length > 0
		# 	include_array.each do |i|
		# 		if include_count != 0
		# 			where_clause += " or "
		# 		end
		# 		where_clause += i
		# 		include_count += 1
		# 	end
		# end
		# if include_array.length > 1
		# 	where_clause += ")"
		# end
		# if include_array.length > 0 and exclude_array.length > 0
		# 	where_clause += " and "
		# end
		# if exclude_array.length > 1
		# 	where_clause += "("
		# end
		# if exclude_array.length > 0
		# 	exclude_array.each do |e|
		# 		if exclude_count != 0
		# 			where_clause += " and "
		# 		end
		# 		where_clause += e
		# 		exclude_count += 1
		# 	end
		# end
		# if exclude_array.length > 1
		# 	where_clause += ")"
		# end
		# where_clause = "varid_39 = 1 or varid_40 = 1 or varid_41 = 1 or varid_42 = 1 or varid_43 = 1"




		scores = Variable3Zip.select("zip, varid_5, varid_6, varid_7, varid_8, varid_9, varid_10, varid_11, varid_12, varid_13, varid_14, varid_15, varid_16, varid_17, varid_18, varid_19, varid_20, varid_21, varid_22, varid_23, varid_24, varid_25, varid_26, varid_27, varid_28, varid_29, varid_30, varid_31, varid_32, varid_33, varid_34, varid_35, varid_36, varid_37, varid_38, varid_39, varid_40, varid_41, varid_42").where(where_clause)
	else
		scores = Variable3Zip.select("zip, varid_5, varid_6, varid_7, varid_8, varid_9, varid_10, varid_11, varid_12, varid_13, varid_14, varid_15, varid_16, varid_17, varid_18, varid_19, varid_20, varid_21, varid_22, varid_23, varid_24, varid_25, varid_26, varid_27, varid_28, varid_29, varid_30, varid_31, varid_32, varid_33, varid_34, varid_35, varid_36, varid_37, varid_38, varid_39, varid_40, varid_41, varid_42")
	end


	# 2) Pull from the database
	# scores = Variable3Zip.select("zip, varid_5, varid_6, varid_7, varid_8, varid_9, varid_10, varid_11, varid_12, varid_13, varid_14, varid_15, varid_16, varid_17, varid_18, varid_19, varid_20, varid_21, varid_22, varid_23, varid_24, varid_25, varid_26, varid_27, varid_28, varid_29, varid_30, varid_31, varid_32, varid_33, varid_34, varid_35, varid_36, varid_37, varid_38, varid_39, varid_40, varid_41, varid_42, varid_43, varid_44, varid_45, varid_46, varid_47, varid_48, varid_49, varid_50")
	if(params.has_key?(:filters))
		zips = Variable3Zip.select("zip").where(where_clause).order(:zip)
	else
		zips = Variable3Zip.select("zip").order(:zip)
	end

	zips_array = []
	zips.each do |z|
	  zips_array << z.zip
	end


	# 3) Define ordered list of Variables for each Category
	if(params.has_key?(:cat1_vars) && params.has_key?(:cat2_vars) && params.has_key?(:cat3_vars) && params.has_key?(:cat4_vars) && params.has_key?(:filters))
		# split "50-117,118,119,120" into array: ["50", "117,118,119,120"]
		cat1Vars = params[:cat1_vars].split "-"
		cat2Vars = params[:cat2_vars].split "-"
		cat3Vars = params[:cat3_vars].split "-"
		cat4Vars = params[:cat4_vars].split "-"
		# assign weights (always the first variable in the array)
		cat_weights = []
		cat_weights << cat1Vars[0].to_i
		cat_weights << cat2Vars[0].to_i
		cat_weights << cat3Vars[0].to_i
		cat_weights << cat4Vars[0].to_i
		# split "117,118,119,120" into array: ["117", "118", "119", "120"]
		cat1 = cat1Vars[1].split ","
		cat2 = cat2Vars[1].split ","
		cat3 = cat3Vars[1].split ","
		cat4 = cat4Vars[1].split ","


	else
		cat_weights = []
		for j in 0..3 do
			cat_weights << $categories[j].default_rank.to_i
		end
		cat1_obj = VariableDim.select("var_id").where("var_parent = 1 and control_panel = TRUE").order(:default_rank)
		cat2_obj = VariableDim.select("var_id").where("var_parent = 2 and control_panel = TRUE").order(:default_rank)
		cat3_obj = VariableDim.select("var_id").where("var_parent = 3 and control_panel = TRUE").order(:default_rank)
		cat4_obj = VariableDim.select("var_id").where("var_parent = 4 and control_panel = TRUE").order(:default_rank)

		cat1 = []
		cat1_obj.each do |c|
			cat1 << c.var_id
		end
		cat2 = []
		cat2_obj.each do |c|
			cat2 << c.var_id
		end
		cat3 = []
		cat3_obj.each do |c|
			cat3 << c.var_id
		end
		cat4 = []
		cat4_obj.each do |c|
			cat4 << c.var_id
		end
	end

	# 4) Create a nested hash containing all ZIPs and their scores for all variables
	#  - {010 => {117 => 0.15, 118 => 0.23, 119 => 0.75}, 011 => {117 => 0.18, 118 => 0.31, 119 => 0.40}}
	all_scores = {}
	scores.each do |score|
		temp = {}
		score.attributes.each do |attr_name, attr_value|
			if(attr_name.to_s != "zip")
				temp[attr_name.to_s.split("_")[1].to_i] = attr_value
			end
		end
		all_scores[score.zip] = temp
	end


	# 5) Create an Array for each Category containing all ZIPs and their scores for only the selected variables
	#  - [[010, 0.5, 0.6, 0.7, 0.8], [011, 0.3, 0.4, 0.5], [012, 0.7, 0.8, 0.9]]
	cat1_scores = []
	zips.each do |zip|
	  temp = []
	  temp << zip.zip
	  cat1.each do |var|
			temp << all_scores[zip.zip][var.to_i].to_f
	  end
	  cat1_scores << temp
	end

	cat2_scores = []
	zips.each do |zip|
	  temp = []
	  temp << zip.zip
	  cat2.each do |var|
			temp << all_scores[zip.zip][var.to_i].to_f
	  end
	  cat2_scores << temp
	end

	cat3_scores = []
	zips.each do |zip|
	  temp = []
	  temp << zip.zip
	  cat3.each do |var|
			temp << all_scores[zip.zip][var.to_i].to_f
	  end
	  cat3_scores << temp
	end

	cat4_scores = []
	zips.each do |zip|
	  temp = []
	  temp << zip.zip
	  cat4.each do |var|
			temp << all_scores[zip.zip][var.to_i].to_f
	  end
	  cat4_scores << temp
	end

	# 6) Calculate a final score for each Category (integrating ROC)
	#  - [[010, 0.5, 0.6, 0.7, 0.8], [011, 0.6, 0.7, 0.8, 0.9]]
	cat_scores = []
	zips.each_with_index do |zip, i|
	  temp = []
	  temp << zip.zip
	  additup = 0
	  for j in 1..cat1_scores[i].length-1
			additup += cat1_scores[i][j] * roc[cat1.length][j-1]
	  end
	  temp << additup
	  additup = 0
	  for j in 1..cat2_scores[i].length-1
			additup += cat2_scores[i][j] * roc[cat2.length][j-1]
	  end
	  temp << additup
	  additup = 0
	  for j in 1..cat3_scores[i].length-1
			additup += cat3_scores[i][j] * roc[cat3.length][j-1]
	  end
	  temp << additup
	  additup = 0
	  for j in 1..cat4_scores[i].length-1
			additup += cat4_scores[i][j] * roc[cat4.length][j-1]
	  end
	  temp << additup
	  cat_scores << temp
	end

	# 7) Calculate the final scores for each ZIP
	final_scores = {}
	weight_total = 0
	cat_weights.each do |weight|
		weight_total += weight
	end

	zips.each_with_index do |zip, i|
	  additup = 0
	  for j in 1..4
	  	$current_zip_scores[zip.zip]["cat" + j.to_s + "_score"] = cat_scores[i][j].round(2)
			additup += (cat_scores[i][j] * (cat_weights[j-1].to_f / weight_total.to_f))
	  end
	  $current_zip_scores[zip.zip]["agg_score"] = additup.round(2)
	  final_scores[zip.zip] = additup
	end

	# 7.5) Adjust final scores for screen 3R
	if(params.has_key?(:present_future))

	  present_final_scores = {}
	  future_final_scores = {}

	  # print params[:present_future] + " ---------------- "
	  # params[:present_future]
	  # params[:projected_value]
	  # if (present && val <= 1) OR (future && val >= 1), SAME
	  # if (present && val > 1) OR (future && val < 1), DECREASE

	  pres_fut = params[:present_future]
	  # val = params[:projected_value].to_f / 100 	# % change
	  val = params[:projected_value].to_f / 100 * 1	# % change

	  levers3L = params[:levers3L].split(",")
	  levers3L[0..3].each_with_index do |lever, i|
	  	if i == 1 || i == 3
	  		levers3L[i] = levers3L[i].to_f/1000
	  	else
	  		levers3L[i] = levers3L[i].to_f/10
	  	end
	  end
	  levers3L[4..6].each_with_index do |lever, i|
	  	levers3L[i+4] = levers3L[i+4].to_f
	  end
	  # sliders
	  gdp_growth = levers3L[0]
	  agent_engagement = levers3L[1]
	  product_availability = levers3L[2]
	  retention_rate = levers3L[3]
	  # checkboxes
	  provide_agents_data = (levers3L[4] == 0 ? 0.025 : 0.04)
	  baseline_conversion_rate_per_opp = (levers3L[5] == 0 ? 0.1 : 0.15)
	  percnt_ivantage_agents = (levers3L[6] == 0 ? 0.25 : 0.4)
	  $varvals.each do |v|

	  	# if v.zip == '70'
	  	  startvar = v.hvh_policies
	  	  # print "Start: " + v.hvh_policies.to_s + ", "
		  results = getNextQtrScore(v.hvh_count, v.hvh_policies, v.ivantage_pif, v.agent_count, gdp_growth, agent_engagement, product_availability, retention_rate, provide_agents_data, baseline_conversion_rate_per_opp, percnt_ivantage_agents)
		  9.times do
			results = getNextQtrScore(results[0], results[1], v.ivantage_pif, v.agent_count, gdp_growth, agent_engagement, product_availability, retention_rate, provide_agents_data, baseline_conversion_rate_per_opp, percnt_ivantage_agents)
		  end
		  endvar = results[1]
		  # print "End: " + results[1].to_s
		  # if endvar > startvar
		  # 	print " ... going UP! \n"
		  # else
		  # 	print " ... (down) \n"
		  # end
	  	# end

	  	# print v.zip
	  	# print v.zip.length
	  	# print ":"


	  	present_final_scores[v.zip] = (startvar > 0 ? Math::log2(startvar) : startvar)
	  	future_final_scores[v.zip] = (endvar > 0 ? Math::log2(endvar) : endvar)

	  	if pres_fut == "present"
	  	  final_scores[v.zip] = (startvar > 0 ? Math::log2(startvar) : startvar)
	  	  # print final_scores[v.zip]
	  	  # print startvar
	  	else
	  	  final_scores[v.zip] = (endvar > 0 ? Math::log2(endvar) : endvar)
	  	  # print endvar
	  	end

	    # print "   "


	  end






	  # This block of code overwrites the Scenario Analysis value
	  # instead of taking the value from the slider, it just checks if it's supposed to trend up or down
	  # It also checks which variable is being selected, because the value needs to be fine-tuned to match the output
	  # If you don't want to overwrite "val" anymore, just comment this out.
	  # whichvar = params[:whichvar]
	  # # print whichvar
	  # if whichvar == 'var2'
	  # 	val = val < 1 ? 0.55 : 1.28
	  # else
	  # 	# val = val < 1 ? 0.0001 : 68
	  # 	val = val < 1 ? 0.55 : 1.58
	  # end



	  # print "present min: "
	  # print present_final_scores.values.min
	  # print "present max: "
	  # print present_final_scores.values.max
	  # print "future min: "
	  # print future_final_scores.values.min
	  # print "future max: "
	  # print future_final_scores.values.max

	  $min = present_final_scores.values.min < future_final_scores.values.min ? present_final_scores.values.min : future_final_scores.values.min
	  $max = present_final_scores.values.max > future_final_scores.values.max ? present_final_scores.values.max : future_final_scores.values.max



	  # $max = final_scores.values.max
	  # $min = final_scores.values.min * (1-(1-val).abs)

	  # $max = whichvar == 'var2' ? 0.25 : 0.6




	  # even_dist_pct = 0.99 							# even distribution %
	  # rel_dist_pct = 0.01 							# relative distribution %

	  # # I know these are long/confusing formulas. Please see the spreadsheet that explains it all.
	  # smallest_min = $min + ((((final_scores.values.sum * val) - final_scores.values.sum) * even_dist_pct) / final_scores.count) + ((((final_scores.values.sum * val) - final_scores.values.sum) * rel_dist_pct) * ($min / final_scores.values.sum))
	  # step = (($max + ((((final_scores.values.sum * val) - final_scores.values.sum) * even_dist_pct) / final_scores.count) +((((final_scores.values.sum * val) - final_scores.values.sum) * rel_dist_pct) * ($max / final_scores.values.sum)) - smallest_min)) / 100

	  # if pres_fut == "present"

	  # 	if val < 1
	  # 	  zips.each do |z|
	  # 	  	# final_scores[z.zip] = (final_scores[z.zip] - smallest_min) / step / 100
	  # 	  	final_scores[z.zip] = final_scores[z.zip] > $max ? 1 : (final_scores[z.zip] - smallest_min) / step / 100
	  # 	  end
	  # 	else
	  # 	  zips.each do |z|
	  # 	  	# final_scores[z.zip] = final_scores[z.zip] / step / 100
	  # 	  	final_scores[z.zip] = final_scores[z.zip] > $max ? 1 : final_scores[z.zip] / step / 100
	  # 	  end
	  # 	end
	  # else
	  # 	zips.each do |z|
	  # 	  # final_scores[z.zip] = ((final_scores[z.zip] + ((((final_scores.values.sum * val) - final_scores.values.sum) * even_dist_pct) / final_scores.count) + ((((final_scores.values.sum * val) - final_scores.values.sum) * rel_dist_pct) * (final_scores[z.zip] / final_scores.values.sum))) - smallest_min) / step / 100
	  # 	  final_scores[z.zip] = final_scores[z.zip] > $max ? 1 : ((final_scores[z.zip] + ((((final_scores.values.sum * val) - final_scores.values.sum) * even_dist_pct) / final_scores.count) + ((((final_scores.values.sum * val) - final_scores.values.sum) * rel_dist_pct) * (final_scores[z.zip] / final_scores.values.sum))) - smallest_min) / step / 100
	  # 	end
	  # end






	  # if (pres_fut == "present" && val > 1) || (pres_fut == "future" && val < 1)
	  # 	zips.each do |z|
	  # 	  final_scores[z.zip] = (1-(1-val).abs) * final_scores[z.zip]
	  # 	end
	  # end
	else
	  $max = final_scores.values.max
	  $min = final_scores.values.min
	end


	# 8) Calculate the hex Colors for each ZIP
	#  - Color arrays
	blue_hex_array = ['4C0000', '660000', '800000', '990000', 'B20000', 'CC0000', 'E60000', 'FF0000', 'FF1919', 'FF3333', 'FF4D4D', 'FF6666', 'FF8080', 'FF9999', 'FFB2B2', 'FFCCCC', 'FFE6E6'].reverse
	red_hex_array = ['00004C', '000066', '000080', '000099', '0000B2', '0000CC', '0000E6', '0000FF', '1919FF', '3333FF', '4D4DFF', '6666FF', '8080FF', '9999FF', 'B2B2FF', 'CCCCFF', 'E6E6FF'].reverse
	#  - Max, Min, Range, Step

	# $max = final_scores.values.max
	# $min = final_scores.values.min

	if $max.blank? and $min.blank?
		range = 0
	else
		range = $max - $min
	end

	step = (range.to_f / blue_hex_array.length.to_f)
	#  - get Color Hue from URL parameter
	color_hue = params[:colors_array].to_i
	#  - Blue vs Red
	final_colors = {}

	zips.each do |zip|
		color_index = ((final_scores[zip.zip].to_f - $min.to_f) / step).to_i - 1
		color_index = color_index < 0 ? 0 : color_index
		# if (color_index < 1)
		if (final_scores[zip.zip] == 0)
			final_colors[zip.zip] = 'DONOTDISPLAY'
		else
			if(color_hue == 0)
				final_colors[zip.zip] = blue_hex_array[color_index]
			else
				final_colors[zip.zip] = red_hex_array[color_index]
			end
		end
	end

	# 9) Build the KML file
	contents = Nokogiri::XML::Builder.new do |xml|
	  xml.kml('xmlns' => "http://earth.google.com/kml/2.2", 'xmlns:atom' => "http://www.w3.org/2005/Atom") {
		xml.Document {
		  xml.ScreenOverlay {
		  	xml.name (color_hue == 0 ? "Map Legend Blue" : "Map Legend Red")
		  	xml.Icon {
		  	  xml.href "http://#{$serverURL}:3000/map_legend_" + (color_hue == 0 ? "blue" : "red") + ".png"
		  	}
		  	xml.overlayXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
		  	xml.screenXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
		  	xml.rotationXY('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
		  	xml.size('x' => "0", 'y' => "0", 'xunits' => "fraction", 'yunits' => "fraction")
		  }
		  @@three_digit_zips.each { |zip, coordinates|
		  	if zips_array.include? zip.to_s
		  		if (final_colors[zip.to_s] != 'DONOTDISPLAY')
		  		# if (final_colors[zip.to_s] not in(blue_hex_array[0], blue_hex_array[1])

				  	xml.Placemark {
				  	  xml.Style {
				  	  	xml.LineStyle {
				  	  	  xml.s "aaffffff"						# Border color
				  	  	  xml.width 1 							# Border width
				  	  	}
				  	  	xml.PolyStyle { 						# Fill color
				  	  	  xml.color '99' + (final_colors[zip.to_s].nil? ? 'ffffff' : final_colors[zip.to_s])
				  	  	}
				  	  }
				  	  xml.description zip.to_s 					# ZIP code
				  	  xml.MultiGeometry {
				  	  	xml.MultiGeometry {
				  	  	  xml.Polygon {
				  	  	  	xml.outerBoundaryIs {
				  	  	  	  xml.LinearRing {
				  	  	  	  	xml.coordinates coordinates		# ZIP coordinates
				  	  	  	  }
				  	  	  	}
				  	  	  }
				  	  	}
				  	  }
					}

				end
			end
		  }
		}
	  }
	end

	render :xml => contents
  end

end
