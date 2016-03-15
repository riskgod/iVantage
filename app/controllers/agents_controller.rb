class AgentsController < ApplicationController

  $agents = AgentDim.select("agent_id, agent_name, tier_ivantage, tier_allstate, tenure, \"busZip3\", \"busZip5\", agent_city")




  def screen2R
  end


  # generates an array of hashes (one hash per agent)
  # results =
  # [{agent_id, agent_name, tier_ivantage, tier_allstate, tenure}]
  # [{agent_id, agent_name, tier_ivantage, tier_allstate, tenure}]
  # [{agent_id, agent_name, tier_ivantage, tier_allstate, tenure}]
  def get_agents_for_zips
    zips = params[:zips]
    zips = "'" + zips.gsub(",", "','") + "'"

    cluster_agents = AgentDim.select("agent_id, agent_name, tier_ivantage, tier_allstate, tenure, pif_allstate_home, pif_allstate_total, pif_ivantage_total, pif_ivantage_hvh, \"busZip3\"").where("\"busZip3\" IN(" + zips + ") or \"busZip5\" IN(" + zips + ")")

    results = {}
    results['clusterID'] = params[:clusterID]
    results['agents'] = []
    cluster_agents.each do |ca|
      temp = {}
      temp['agent_id'] = ca.agent_id
      temp['agent_name'] = ca.agent_name.titlecase
      temp['tier_ivantage'] = ca.tier_ivantage
      temp['tier_allstate'] = ca.tier_allstate
      temp['tenure'] = ca.tenure
      temp['pif_allstate_home'] = ca.pif_allstate_home
      temp['pif_allstate_total'] = ca.pif_allstate_total
      temp['pif_ivantage_total'] = ca.pif_ivantage_total
      temp['pif_ivantage_hvh'] = ca.pif_ivantage_hvh
      results['agents'].push(temp)
    end

    render :json => results.to_json
  end

  def get3Lvars
    clusterZips = params[:clusterZips]
    clusterZips = "'" + clusterZips.gsub(",", "','") + "'"
    cluster_vars = Variable3Zip.select("varid_5, varid_15, varid_23, varid_29, varid_31, varid_32, varid_38, varid_41, zip").where("zip IN(" + clusterZips + ")")

    results = []

    cluster_vars.each do |cv|
      temp = {}
      temp['varid_5'] = cv.varid_5
      temp['varid_15'] = cv.varid_15
      temp['varid_38'] = cv.varid_38
      temp['varid_23'] = cv.varid_23
      temp['varid_29'] = cv.varid_29
      temp['varid_31'] = cv.varid_31
      temp['varid_32'] = cv.varid_32
      temp['varid_41'] = cv.varid_41
      results.push(temp)

    end

    render :json => results.to_json

  end



  # this method is used to get the Total PIF counts for each ZIP Cluster
  # This is obviously used on 3L's summary tab
  def get3LvarsSummary
    clusterZips = params[:clusterZips]  # get the list of ZIPs for each cluster, in this format: 1,2-3,4,5-6,7,8,9
    clusterZips = "'" + clusterZips.gsub(",", "','").gsub("-", "'-'") + "'"   # add ' around commas
    clusterCount = clusterZips.count '-'

    # Start with this: '1','2','3'-'4','5'-'6','7','8'-'
    # For each ZIP Cluster:
    #   take the first chunk: '1','2','3', run it through SQL, and push the result (total PIF for that cluster) to "results"
    results = []
    for i in 1..clusterCount do
      tempClusterZips = clusterZips[0..clusterZips.index('-')-1]
      total_pif = AgentDim.select("sum(pif_allstate_total + pif_ivantage_total) as total_pif").where("\"busZip3\" IN(" + tempClusterZips + ")")
      temp = {}
      temp['total_pif'] = total_pif[0].total_pif
      results.push(temp)
      clusterZips = clusterZips[tempClusterZips.length+1..clusterZips.length]
    end

    render :json => results.to_json
  end

def get_agent_info_for_modal

  agentID = params[:agentID]
  agent_modal_info = AgentDim.select("agent_id, agent_name, tier_ivantage, tier_allstate, tenure, pif_allstate_auto, pif_allstate_home, pif_allstate_otherpc, pif_allstate_financial, pif_allstate_total, \"busZip5\", \"busZip3\", multiline, retention, pif_ivantage_home, pif_ivantage_hvh, pif_ivantage_other, pif_ivantage_total, premium_ivantage_total, agent_city").where("agent_id = \'" + agentID +"\'")

  results = agent_modal_info
  render :json => results.to_json
end


end
