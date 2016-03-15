# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

datafile = Rails.root + 'db/agent_dims_cleansed_insurance_20140911.csv'

CSV.foreach(datafile, headers: true) do |row|

  if !AgentDim.find_by_id(row[0])
    AgentDim.create({id: row[0]}) do |agent_dim|
      agent_dim.id = row[0]
      agent_dim.agent_id =  row[1]
      agent_dim.agent_name =  row[2]
      agent_dim.tier_ivantage =  row[3]
      agent_dim.tier_allstate =  row[4]
      agent_dim.tenure =  row[5]
      agent_dim.pif_allstate_auto =  row[6]
      agent_dim.pif_allstate_home =  row[7]
      agent_dim.pif_allstate_otherpc =  row[8]
      agent_dim.pif_allstate_financial =  row[9]
      agent_dim.pif_allstate_total =  row[10]
      agent_dim.busZip5 =  row[11]
      agent_dim.busZip3 =  row[12]
      agent_dim.created_at =  row[13]
      agent_dim.updated_at =  row[14]
      agent_dim.multiline =  row[15]
      agent_dim.retention =  row[16]
      agent_dim.pif_ivantage_home =  row[17]
      agent_dim.pif_ivantage_hvh =  row[18]
      agent_dim.pif_ivantage_other =  row[19]
      agent_dim.pif_ivantage_total =  row[20]
      agent_dim.premium_ivantage_total =  row[21]
      agent_dim.agent_city =  row[22]
    end
  end
end


datafile_variable_dims = Rails.root + 'db/variable_dims_cleansed_insurance_20131113.csv'

CSV.foreach(datafile_variable_dims, headers: true) do |row|
  if !VariableDim.find_by_id(row[0])
    VariableDim.create({id: row[0]}) do |variabledims|
      variabledims.id = row[0]
      variabledims.var_id =  row[1]
      variabledims.var_name =  row[2]
      variabledims.var_category =  row[3]
      variabledims.var_parent =  row[4]
      variabledims.created_at =  row[5]
      variabledims.updated_at =  row[6]
      variabledims.control_panel =  row[7]
      variabledims.default_rank =  row[8]
      variabledims.default_checked =  row[9]
    end
  end
end  


datafile_variable_3zips_5zips = Rails.root + 'db/variable_3zips_5zips_cleansed_insurance_20131114.csv'

CSV.foreach(datafile_variable_3zips_5zips, headers: true) do |row|
  if !Variable3Zip.find_by_id(row[0])
    Variable3Zip.create({id: row[0]}) do |variable3zips5zips|
      variable3zips5zips.id = row[0]
      variable3zips5zips.zip =  row[1]
      variable3zips5zips.varid_1 =  row[2]
      variable3zips5zips.varid_2 =  row[3]
      variable3zips5zips.varid_3 =  row[4]
      variable3zips5zips.varid_4 =  row[5]
      variable3zips5zips.varid_5 =  row[6]
      variable3zips5zips.varid_6 =  row[7]
      variable3zips5zips.varid_7 =  row[8]
      variable3zips5zips.varid_8 =  row[9]
      variable3zips5zips.varid_9 =  row[10]
      variable3zips5zips.varid_10 =  row[11]
      variable3zips5zips.varid_11 =  row[12]
      variable3zips5zips.varid_12 =  row[13]
      variable3zips5zips.varid_13 =  row[14]
      variable3zips5zips.varid_14 =  row[15]
      variable3zips5zips.varid_15 =  row[16]
      variable3zips5zips.varid_16 =  row[17]
      variable3zips5zips.varid_17 =  row[18]
      variable3zips5zips.varid_18 =  row[19]
      variable3zips5zips.varid_19 =  row[20]
      variable3zips5zips.varid_20 =  row[21]
      variable3zips5zips.varid_21 =  row[22]
      variable3zips5zips.varid_22 =  row[23]
      variable3zips5zips.varid_23 =  row[24]
      variable3zips5zips.varid_24 =  row[25]
      variable3zips5zips.varid_25 =  row[26]
      variable3zips5zips.varid_26 =  row[27]
      variable3zips5zips.varid_27 =  row[28]
      variable3zips5zips.varid_28 =  row[29]
      variable3zips5zips.varid_29 =  row[30]
      variable3zips5zips.varid_30 =  row[31]
      variable3zips5zips.varid_31 =  row[32]
      variable3zips5zips.varid_32 =  row[33]
      variable3zips5zips.varid_33 =  row[34]
      variable3zips5zips.varid_34 =  row[35]
      variable3zips5zips.varid_35 =  row[36]
      variable3zips5zips.varid_36 =  row[37]
      variable3zips5zips.varid_37 =  row[38]
      variable3zips5zips.varid_38 =  row[39]
      variable3zips5zips.varid_39 =  row[40]
      variable3zips5zips.varid_40 =  row[41]
      variable3zips5zips.varid_41 =  row[42]
      variable3zips5zips.varid_42 =  row[43]
      variable3zips5zips.varid_43 =  row[44]
      variable3zips5zips.varid_44 =  row[45]
      variable3zips5zips.varid_45 =  row[46]
      variable3zips5zips.varid_46 =  row[47]
      variable3zips5zips.varid_47 =  row[48]
      variable3zips5zips.varid_48 =  row[49]
      variable3zips5zips.varid_49 =  row[50]
      variable3zips5zips.varid_50 =  row[51]
      variable3zips5zips.varid_51 =  row[52]
      variable3zips5zips.varid_52 =  row[53]
      variable3zips5zips.varid_53 =  row[54]
      variable3zips5zips.varid_54 =  row[55]
      variable3zips5zips.varid_55 =  row[56]
      variable3zips5zips.varid_56 =  row[57]
      variable3zips5zips.varid_57 =  row[58]
      variable3zips5zips.varid_58 =  row[59]
      variable3zips5zips.varid_59 =  row[60]
      variable3zips5zips.varid_60 =  row[61]
      variable3zips5zips.varid_61 =  row[62]
      variable3zips5zips.varid_62 =  row[63]
      variable3zips5zips.varid_63 =  row[64]
      variable3zips5zips.varid_64 =  row[65]
      variable3zips5zips.varid_65 =  row[66]
      variable3zips5zips.varid_66 =  row[67]
      variable3zips5zips.varid_67 =  row[68]
      variable3zips5zips.varid_68 =  row[69]
      variable3zips5zips.varid_69 =  row[70]
      variable3zips5zips.varid_70 =  row[71]
      variable3zips5zips.varid_71 =  row[72]
      variable3zips5zips.varid_72 =  row[73]
      variable3zips5zips.varid_73 =  row[74]
      variable3zips5zips.varid_74 =  row[75]
      variable3zips5zips.varid_75 =  row[76]
      variable3zips5zips.varid_76 =  row[77]
      variable3zips5zips.varid_77 =  row[78]
      variable3zips5zips.varid_78 =  row[79]
      variable3zips5zips.varid_79 =  row[80]
      variable3zips5zips.varid_80 =  row[81]
      variable3zips5zips.varid_81 =  row[82]
      variable3zips5zips.varid_82 =  row[83]
      variable3zips5zips.varid_83 =  row[84]
      variable3zips5zips.varid_84 =  row[85]
      variable3zips5zips.varid_85 =  row[86]
      variable3zips5zips.varid_86 =  row[87]
      variable3zips5zips.varid_87 =  row[88]
      variable3zips5zips.varid_88 =  row[89]
      variable3zips5zips.varid_89 =  row[90]
      variable3zips5zips.varid_90 =  row[91]
      variable3zips5zips.varid_91 =  row[92]
      variable3zips5zips.varid_92 =  row[93]
      variable3zips5zips.varid_93 =  row[94]
      variable3zips5zips.varid_94 =  row[95]
      variable3zips5zips.varid_95 =  row[96]
      variable3zips5zips.varid_96 =  row[97]
      variable3zips5zips.varid_97 =  row[98]
      variable3zips5zips.varid_98 =  row[99]
      variable3zips5zips.varid_99 =  row[100]
      variable3zips5zips.varid_100 =  row[101]
      variable3zips5zips.varid_101 =  row[102]
      variable3zips5zips.varid_102 =  row[103]
      variable3zips5zips.varid_103 =  row[104]
      variable3zips5zips.varid_104 =  row[105]
      variable3zips5zips.varid_105 =  row[106]
      variable3zips5zips.varid_106 =  row[107]
      variable3zips5zips.varid_107 =  row[108]
      variable3zips5zips.varid_108 =  row[109]
      variable3zips5zips.varid_109 =  row[110]
      variable3zips5zips.varid_110 =  row[111]
      variable3zips5zips.varid_111 =  row[112]
      variable3zips5zips.varid_112 =  row[113]
      variable3zips5zips.varid_113 =  row[114]
      variable3zips5zips.varid_114 =  row[115]
      variable3zips5zips.varid_115 =  row[116]
      variable3zips5zips.varid_116 =  row[117]
      variable3zips5zips.varid_117 =  row[118]
      variable3zips5zips.varid_118 =  row[119]
      variable3zips5zips.varid_119 =  row[120]
      variable3zips5zips.varid_120 =  row[121]
      variable3zips5zips.varid_121 =  row[122]
      variable3zips5zips.varid_122 =  row[123]
      variable3zips5zips.varid_123 =  row[124]
      variable3zips5zips.varid_124 =  row[125]
      variable3zips5zips.varid_125 =  row[126]
      variable3zips5zips.varid_126 =  row[127]
      variable3zips5zips.varid_127 =  row[128]
      variable3zips5zips.varid_128 =  row[129]
      variable3zips5zips.varid_129 =  row[130]
      variable3zips5zips.varid_130 =  row[131]
      variable3zips5zips.varid_131 =  row[132]
      variable3zips5zips.varid_132 =  row[133]
      variable3zips5zips.varid_133 =  row[134]
      variable3zips5zips.varid_134 =  row[135]
      variable3zips5zips.varid_135 =  row[136]
      variable3zips5zips.varid_136 =  row[137]
      variable3zips5zips.varid_137 =  row[138]
      variable3zips5zips.varid_138 =  row[139]
      variable3zips5zips.varid_139 =  row[140]
      variable3zips5zips.varid_140 =  row[141]
      variable3zips5zips.varid_141 =  row[142]
      variable3zips5zips.varid_142 =  row[143]
      variable3zips5zips.varid_143 =  row[144]
      variable3zips5zips.varid_144 =  row[145]
      variable3zips5zips.varid_145 =  row[146]
      variable3zips5zips.varid_146 =  row[147]
      variable3zips5zips.varid_147 =  row[148]
      variable3zips5zips.varid_148 =  row[149]
      variable3zips5zips.varid_149 =  row[150]
      variable3zips5zips.varid_150 =  row[151]
      variable3zips5zips.created_at =  row[152]
      variable3zips5zips.updated_at =  row[153]
    end
  end
end  







datafile_timeseries = Rails.root + 'db/timeseries_cleansed_20140918.csv'

CSV.foreach(datafile_timeseries, headers: true) do |row|
  if !Timeseries.find_by_id(row[0])
    Timeseries.create({id: row[0]}) do |timeseries|
      timeseries.id = row[0]
      timeseries.zip =  row[1]
      timeseries.totalPIF_2012Q1 =  row[2]
      timeseries.totalPIF_2012Q2 =  row[3]
      timeseries.totalPIF_2012Q3 =  row[4]
      timeseries.totalPIF_2012Q4 =  row[5]
      timeseries.totalPIF_2013Q1 =  row[6]
      timeseries.PCPIF_2012Q1 =  row[7]
      timeseries.PCPIF_2012Q2 =  row[8]
      timeseries.PCPIF_2012Q3 =  row[9]
      timeseries.PCPIF_2012Q4 =  row[10]
      timeseries.PCPIF_2013Q1 =  row[11]
      timeseries.AFPIF_2012Q1 =  row[12]
      timeseries.AFPIF_2012Q2 =  row[13]
      timeseries.AFPIF_2012Q3 =  row[14]
      timeseries.AFPIF_2012Q4 =  row[15]
      timeseries.AFPIF_2013Q1 =  row[16]
      timeseries.percentMultiLine_2012Q1 =  row[17]
      timeseries.percentMultiLine_2012Q2 =  row[18]
      timeseries.percentMultiLine_2012Q3 =  row[19]
      timeseries.percentMultiLine_2012Q4 =  row[20]
      timeseries.percentMultiLine_2013Q1 =  row[21]
      timeseries.percentRetention_2012Q1 =  row[22]
      timeseries.percentRetention_2012Q2 =  row[23]
      timeseries.percentRetention_2012Q3 =  row[24]
      timeseries.percentRetention_2012Q4 =  row[25]
      timeseries.percentRetention_2013Q1 =  row[26]
      timeseries.created_at =  row[27]
      timeseries.updated_at =  row[28]      
    end
  end
end  

