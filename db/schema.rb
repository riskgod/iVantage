# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130915050135) do

  create_table "agent_3zip_sums", :force => true do |t|
    t.integer  "agent_id"
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "agent_3zips", :force => true do |t|
    t.integer  "agent_id"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "agent_dims", :force => true do |t|
    t.integer  "agent_id"
    t.string   "agent_name"
    t.string   "tier_ivantage"
    t.string   "tier_allstate"
    t.string   "tenure"
    t.integer  "pif_allstate_auto"
    t.integer  "pif_allstate_home"
    t.integer  "pif_allstate_otherpc"
    t.integer  "pif_allstate_financial"
    t.integer  "pif_allstate_total"
    t.string   "busZip5"
    t.string   "busZip3"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "multiline"
    t.float    "retention"
    t.integer  "pif_ivantage_home"
    t.integer  "pif_ivantage_hvh"
    t.integer  "pif_ivantage_other"
    t.integer  "pif_ivantage_total"
    t.integer  "premium_ivantage_total"
    t.string   "agent_city"
  end

  create_table "segment_dims", :force => true do |t|
    t.integer  "segment_id"
    t.string   "segment_name"
    t.string   "hh_age_range"
    t.string   "hh_income"
    t.string   "hh_race_ethnicity"
    t.string   "urbanicity"
    t.string   "hh_education"
    t.string   "hh_employment"
    t.float    "hh_avg_count"
    t.integer  "has_newcar_loan"
    t.integer  "has_firsthome_mortgage"
    t.integer  "value_401k"
    t.integer  "savings_balance"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "timeseries", :force => true do |t|
    t.string   "zip"
    t.integer  "totalPIF_2012Q1"
    t.integer  "totalPIF_2012Q2"
    t.integer  "totalPIF_2012Q3"
    t.integer  "totalPIF_2012Q4"
    t.integer  "totalPIF_2013Q1"
    t.integer  "PCPIF_2012Q1"
    t.integer  "PCPIF_2012Q2"
    t.integer  "PCPIF_2012Q3"
    t.integer  "PCPIF_2012Q4"
    t.integer  "PCPIF_2013Q1"
    t.integer  "AFPIF_2012Q1"
    t.integer  "AFPIF_2012Q2"
    t.integer  "AFPIF_2012Q3"
    t.integer  "AFPIF_2012Q4"
    t.integer  "AFPIF_2013Q1"
    t.integer  "percentMultiLine_2012Q1"
    t.integer  "percentMultiLine_2012Q2"
    t.integer  "percentMultiLine_2012Q3"
    t.integer  "percentMultiLine_2012Q4"
    t.integer  "percentMultiLine_2013Q1"
    t.integer  "percentRetention_2012Q1"
    t.integer  "percentRetention_2012Q2"
    t.integer  "percentRetention_2012Q3"
    t.integer  "percentRetention_2012Q4"
    t.integer  "percentRetention_2013Q1"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "top_segments_by_zips", :force => true do |t|
    t.string   "zip"
    t.string   "first"
    t.string   "second"
    t.string   "third"
    t.string   "fourth"
    t.string   "fifth"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "var_raw_zips", :force => true do |t|
    t.string   "zip"
    t.integer  "hvh_count"
    t.float    "hvh_policies"
    t.integer  "ivantage_pif"
    t.integer  "agent_count"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "variable_3zips_5zips", :force => true do |t|
    t.string   "zip"
    t.decimal  "varid_1"
    t.decimal  "varid_2"
    t.decimal  "varid_3"
    t.decimal  "varid_4"
    t.decimal  "varid_5"
    t.decimal  "varid_6"
    t.decimal  "varid_7"
    t.decimal  "varid_8"
    t.decimal  "varid_9"
    t.decimal  "varid_10"
    t.decimal  "varid_11"
    t.decimal  "varid_12"
    t.decimal  "varid_13"
    t.decimal  "varid_14"
    t.decimal  "varid_15"
    t.decimal  "varid_16"
    t.decimal  "varid_17"
    t.decimal  "varid_18"
    t.decimal  "varid_19"
    t.decimal  "varid_20"
    t.decimal  "varid_21"
    t.decimal  "varid_22"
    t.decimal  "varid_23"
    t.decimal  "varid_24"
    t.decimal  "varid_25"
    t.decimal  "varid_26"
    t.decimal  "varid_27"
    t.decimal  "varid_28"
    t.decimal  "varid_29"
    t.decimal  "varid_30"
    t.decimal  "varid_31"
    t.decimal  "varid_32"
    t.decimal  "varid_33"
    t.decimal  "varid_34"
    t.decimal  "varid_35"
    t.decimal  "varid_36"
    t.decimal  "varid_37"
    t.decimal  "varid_38"
    t.decimal  "varid_39"
    t.decimal  "varid_40"
    t.decimal  "varid_41"
    t.decimal  "varid_42"
    t.decimal  "varid_43"
    t.decimal  "varid_44"
    t.decimal  "varid_45"
    t.decimal  "varid_46"
    t.decimal  "varid_47"
    t.decimal  "varid_48"
    t.decimal  "varid_49"
    t.decimal  "varid_50"
    t.decimal  "varid_51"
    t.decimal  "varid_52"
    t.decimal  "varid_53"
    t.decimal  "varid_54"
    t.decimal  "varid_55"
    t.decimal  "varid_56"
    t.decimal  "varid_57"
    t.decimal  "varid_58"
    t.decimal  "varid_59"
    t.decimal  "varid_60"
    t.decimal  "varid_61"
    t.decimal  "varid_62"
    t.decimal  "varid_63"
    t.decimal  "varid_64"
    t.decimal  "varid_65"
    t.decimal  "varid_66"
    t.decimal  "varid_67"
    t.decimal  "varid_68"
    t.decimal  "varid_69"
    t.decimal  "varid_70"
    t.decimal  "varid_71"
    t.decimal  "varid_72"
    t.decimal  "varid_73"
    t.decimal  "varid_74"
    t.decimal  "varid_75"
    t.decimal  "varid_76"
    t.decimal  "varid_77"
    t.decimal  "varid_78"
    t.decimal  "varid_79"
    t.decimal  "varid_80"
    t.decimal  "varid_81"
    t.decimal  "varid_82"
    t.decimal  "varid_83"
    t.decimal  "varid_84"
    t.decimal  "varid_85"
    t.decimal  "varid_86"
    t.decimal  "varid_87"
    t.decimal  "varid_88"
    t.decimal  "varid_89"
    t.decimal  "varid_90"
    t.decimal  "varid_91"
    t.decimal  "varid_92"
    t.decimal  "varid_93"
    t.decimal  "varid_94"
    t.decimal  "varid_95"
    t.decimal  "varid_96"
    t.decimal  "varid_97"
    t.decimal  "varid_98"
    t.decimal  "varid_99"
    t.decimal  "varid_100"
    t.decimal  "varid_101"
    t.decimal  "varid_102"
    t.decimal  "varid_103"
    t.decimal  "varid_104"
    t.decimal  "varid_105"
    t.decimal  "varid_106"
    t.decimal  "varid_107"
    t.decimal  "varid_108"
    t.decimal  "varid_109"
    t.decimal  "varid_110"
    t.decimal  "varid_111"
    t.decimal  "varid_112"
    t.decimal  "varid_113"
    t.decimal  "varid_114"
    t.decimal  "varid_115"
    t.decimal  "varid_116"
    t.decimal  "varid_117"
    t.decimal  "varid_118"
    t.decimal  "varid_119"
    t.decimal  "varid_120"
    t.decimal  "varid_121"
    t.decimal  "varid_122"
    t.decimal  "varid_123"
    t.decimal  "varid_124"
    t.decimal  "varid_125"
    t.decimal  "varid_126"
    t.decimal  "varid_127"
    t.decimal  "varid_128"
    t.decimal  "varid_129"
    t.decimal  "varid_130"
    t.decimal  "varid_131"
    t.decimal  "varid_132"
    t.decimal  "varid_133"
    t.decimal  "varid_134"
    t.decimal  "varid_135"
    t.decimal  "varid_136"
    t.decimal  "varid_137"
    t.decimal  "varid_138"
    t.decimal  "varid_139"
    t.decimal  "varid_140"
    t.decimal  "varid_141"
    t.decimal  "varid_142"
    t.decimal  "varid_143"
    t.decimal  "varid_144"
    t.decimal  "varid_145"
    t.decimal  "varid_146"
    t.decimal  "varid_147"
    t.integer  "varid_148"
    t.integer  "varid_149"
    t.integer  "varid_150"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "variable_dims", :force => true do |t|
    t.integer  "var_id"
    t.string   "var_name"
    t.string   "var_category"
    t.integer  "var_parent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "control_panel"
    t.integer  "default_rank"
    t.boolean  "default_checked"
  end

  create_table "zip3_agent_sums", :force => true do |t|
    t.string   "zip"
    t.text     "agent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
