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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "agtAgentTypes", primary_key: "agentTypeID", force: :cascade do |t|
    t.string "agentType", limit: 50
  end

  create_table "agtAgents", primary_key: "agentID", force: :cascade do |t|
    t.integer "divisionID"
    t.integer "corporationID"
    t.integer "locationID"
    t.integer "level"
    t.integer "quality"
    t.integer "agentTypeID"
    t.boolean "isLocator"
    t.index ["corporationID"], name: "ix_agtAgents_corporationID"
    t.index ["locationID"], name: "ix_agtAgents_locationID"
  end

  create_table "agtResearchAgents", primary_key: ["agentID", "typeID"], force: :cascade do |t|
    t.integer "agentID", null: false
    t.integer "typeID", null: false
    t.index ["typeID"], name: "ix_agtResearchAgents_typeID"
  end

  create_table "certCerts", primary_key: "certID", force: :cascade do |t|
    t.text "description"
    t.integer "groupID"
    t.string "name", limit: 255
  end

  create_table "certMasteries", id: false, force: :cascade do |t|
    t.integer "typeID"
    t.integer "masteryLevel"
    t.integer "certID"
  end

  create_table "certSkills", id: false, force: :cascade do |t|
    t.integer "certID"
    t.integer "skillID"
    t.integer "certLevelInt"
    t.integer "skillLevel"
    t.string "certLevelText", limit: 8
    t.index ["skillID"], name: "ix_certSkills_skillID"
  end

  create_table "chrAncestries", primary_key: "ancestryID", force: :cascade do |t|
    t.string "ancestryName", limit: 100
    t.integer "bloodlineID"
    t.string "description", limit: 1000
    t.integer "perception"
    t.integer "willpower"
    t.integer "charisma"
    t.integer "memory"
    t.integer "intelligence"
    t.integer "iconID"
    t.string "shortDescription", limit: 500
  end

  create_table "chrAttributes", primary_key: "attributeID", force: :cascade do |t|
    t.string "attributeName", limit: 100
    t.string "description", limit: 1000
    t.integer "iconID"
    t.string "shortDescription", limit: 500
    t.string "notes", limit: 500
  end

  create_table "chrBloodlines", primary_key: "bloodlineID", force: :cascade do |t|
    t.string "bloodlineName", limit: 100
    t.integer "raceID"
    t.string "description", limit: 1000
    t.string "maleDescription", limit: 1000
    t.string "femaleDescription", limit: 1000
    t.integer "shipTypeID"
    t.integer "corporationID"
    t.integer "perception"
    t.integer "willpower"
    t.integer "charisma"
    t.integer "memory"
    t.integer "intelligence"
    t.integer "iconID"
    t.string "shortDescription", limit: 500
    t.string "shortMaleDescription", limit: 500
    t.string "shortFemaleDescription", limit: 500
  end

  create_table "chrFactions", primary_key: "factionID", force: :cascade do |t|
    t.string "factionName", limit: 100
    t.string "description", limit: 1000
    t.integer "raceIDs"
    t.integer "solarSystemID"
    t.integer "corporationID"
    t.float "sizeFactor"
    t.integer "stationCount"
    t.integer "stationSystemCount"
    t.integer "militiaCorporationID"
    t.integer "iconID"
  end

  create_table "chrRaces", primary_key: "raceID", force: :cascade do |t|
    t.string "raceName", limit: 100
    t.string "description", limit: 1000
    t.integer "iconID"
    t.string "shortDescription", limit: 500
  end

  create_table "crpActivities", primary_key: "activityID", force: :cascade do |t|
    t.string "activityName", limit: 100
    t.string "description", limit: 1000
  end

  create_table "crpNPCCorporationDivisions", primary_key: ["corporationID", "divisionID"], force: :cascade do |t|
    t.integer "corporationID", null: false
    t.integer "divisionID", null: false
    t.integer "size"
  end

  create_table "crpNPCCorporationResearchFields", primary_key: ["skillID", "corporationID"], force: :cascade do |t|
    t.integer "skillID", null: false
    t.integer "corporationID", null: false
  end

  create_table "crpNPCCorporationTrades", primary_key: ["corporationID", "typeID"], force: :cascade do |t|
    t.integer "corporationID", null: false
    t.integer "typeID", null: false
  end

  create_table "crpNPCCorporations", primary_key: "corporationID", force: :cascade do |t|
    t.string "size", limit: 1
    t.string "extent", limit: 1
    t.integer "solarSystemID"
    t.integer "investorID1"
    t.integer "investorShares1"
    t.integer "investorID2"
    t.integer "investorShares2"
    t.integer "investorID3"
    t.integer "investorShares3"
    t.integer "investorID4"
    t.integer "investorShares4"
    t.integer "friendID"
    t.integer "enemyID"
    t.integer "publicShares"
    t.integer "initialPrice"
    t.float "minSecurity"
    t.boolean "scattered"
    t.integer "fringe"
    t.integer "corridor"
    t.integer "hub"
    t.integer "border"
    t.integer "factionID"
    t.float "sizeFactor"
    t.integer "stationCount"
    t.integer "stationSystemCount"
    t.string "description", limit: 4000
    t.integer "iconID"
  end

  create_table "crpNPCDivisions", primary_key: "divisionID", force: :cascade do |t|
    t.string "divisionName", limit: 100
    t.string "description", limit: 1000
    t.string "leaderType", limit: 100
  end

  create_table "dgmAttributeCategories", primary_key: "categoryID", force: :cascade do |t|
    t.string "categoryName", limit: 50
    t.string "categoryDescription", limit: 200
  end

  create_table "dgmAttributeTypes", primary_key: "attributeID", force: :cascade do |t|
    t.string "attributeName", limit: 100
    t.string "description", limit: 1000
    t.integer "iconID"
    t.float "defaultValue"
    t.boolean "published"
    t.string "displayName", limit: 150
    t.integer "unitID"
    t.boolean "stackable"
    t.boolean "highIsGood"
    t.integer "categoryID"
  end

  create_table "dgmEffects", primary_key: "effectID", force: :cascade do |t|
    t.string "effectName", limit: 400
    t.integer "effectCategory"
    t.integer "preExpression"
    t.integer "postExpression"
    t.string "description", limit: 1000
    t.string "guid", limit: 60
    t.integer "iconID"
    t.boolean "isOffensive"
    t.boolean "isAssistance"
    t.integer "durationAttributeID"
    t.integer "trackingSpeedAttributeID"
    t.integer "dischargeAttributeID"
    t.integer "rangeAttributeID"
    t.integer "falloffAttributeID"
    t.boolean "disallowAutoRepeat"
    t.boolean "published"
    t.string "displayName", limit: 100
    t.boolean "isWarpSafe"
    t.boolean "rangeChance"
    t.boolean "electronicChance"
    t.boolean "propulsionChance"
    t.integer "distribution"
    t.string "sfxName", limit: 20
    t.integer "npcUsageChanceAttributeID"
    t.integer "npcActivationChanceAttributeID"
    t.integer "fittingUsageChanceAttributeID"
    t.text "modifierInfo"
  end

  create_table "dgmExpressions", primary_key: "expressionID", force: :cascade do |t|
    t.integer "operandID"
    t.integer "arg1"
    t.integer "arg2"
    t.string "expressionValue", limit: 100
    t.string "description", limit: 1000
    t.string "expressionName", limit: 500
    t.integer "expressionTypeID"
    t.integer "expressionGroupID"
    t.integer "expressionAttributeID"
  end

  create_table "dgmTypeAttributes", primary_key: ["typeID", "attributeID"], force: :cascade do |t|
    t.integer "typeID", null: false
    t.integer "attributeID", null: false
    t.integer "valueInt"
    t.float "valueFloat"
    t.index ["attributeID"], name: "ix_dgmTypeAttributes_attributeID"
  end

  create_table "dgmTypeEffects", primary_key: ["typeID", "effectID"], force: :cascade do |t|
    t.integer "typeID", null: false
    t.integer "effectID", null: false
    t.boolean "isDefault"
  end

  create_table "eveGraphics", primary_key: "graphicID", force: :cascade do |t|
    t.string "sofFactionName", limit: 100
    t.string "graphicFile", limit: 100
    t.string "sofHullName", limit: 100
    t.string "sofRaceName", limit: 100
    t.text "description"
  end

  create_table "eveIcons", primary_key: "iconID", force: :cascade do |t|
    t.string "iconFile", limit: 500
    t.text "description"
  end

  create_table "eveUnits", primary_key: "unitID", force: :cascade do |t|
    t.string "unitName", limit: 100
    t.string "displayName", limit: 50
    t.string "description", limit: 1000
  end

  create_table "industryActivity", primary_key: ["typeID", "activityID"], force: :cascade do |t|
    t.integer "typeID", null: false
    t.integer "activityID", null: false
    t.integer "time"
    t.index ["activityID"], name: "ix_industryActivity_activityID"
  end

  create_table "industryActivityMaterials", id: false, force: :cascade do |t|
    t.integer "typeID"
    t.integer "activityID"
    t.integer "materialTypeID"
    t.integer "quantity"
    t.index ["typeID", "activityID"], name: "industryActivityMaterials_idx1"
    t.index ["typeID"], name: "ix_industryActivityMaterials_typeID"
  end

  create_table "industryActivityProbabilities", id: false, force: :cascade do |t|
    t.integer "typeID"
    t.integer "activityID"
    t.integer "productTypeID"
    t.decimal "probability"
    t.index ["productTypeID"], name: "ix_industryActivityProbabilities_productTypeID"
    t.index ["typeID"], name: "ix_industryActivityProbabilities_typeID"
  end

  create_table "industryActivityProducts", id: false, force: :cascade do |t|
    t.integer "typeID"
    t.integer "activityID"
    t.integer "productTypeID"
    t.integer "quantity"
    t.index ["productTypeID"], name: "ix_industryActivityProducts_productTypeID"
    t.index ["typeID"], name: "ix_industryActivityProducts_typeID"
  end

  create_table "industryActivityRaces", id: false, force: :cascade do |t|
    t.integer "typeID"
    t.integer "activityID"
    t.integer "productTypeID"
    t.integer "raceID"
    t.index ["productTypeID"], name: "ix_industryActivityRaces_productTypeID"
    t.index ["typeID"], name: "ix_industryActivityRaces_typeID"
  end

  create_table "industryActivitySkills", id: false, force: :cascade do |t|
    t.integer "typeID"
    t.integer "activityID"
    t.integer "skillID"
    t.integer "level"
    t.index ["skillID"], name: "ix_industryActivitySkills_skillID"
    t.index ["typeID", "activityID"], name: "industryActivitySkills_idx1"
    t.index ["typeID"], name: "ix_industryActivitySkills_typeID"
  end

  create_table "industryBlueprints", primary_key: "typeID", force: :cascade do |t|
    t.integer "maxProductionLimit"
  end

  create_table "invCategories", primary_key: "categoryID", force: :cascade do |t|
    t.string "categoryName", limit: 100
    t.integer "iconID"
    t.boolean "published"
  end

  create_table "invContrabandTypes", primary_key: ["factionID", "typeID"], force: :cascade do |t|
    t.integer "factionID", null: false
    t.integer "typeID", null: false
    t.float "standingLoss"
    t.float "confiscateMinSec"
    t.float "fineByValue"
    t.float "attackMinSec"
    t.index ["typeID"], name: "ix_invContrabandTypes_typeID"
  end

  create_table "invControlTowerResourcePurposes", primary_key: "purpose", force: :cascade do |t|
    t.string "purposeText", limit: 100
  end

  create_table "invControlTowerResources", primary_key: ["controlTowerTypeID", "resourceTypeID"], force: :cascade do |t|
    t.integer "controlTowerTypeID", null: false
    t.integer "resourceTypeID", null: false
    t.integer "purpose"
    t.integer "quantity"
    t.float "minSecurityLevel"
    t.integer "factionID"
  end

  create_table "invFlags", primary_key: "flagID", force: :cascade do |t|
    t.string "flagName", limit: 200
    t.string "flagText", limit: 100
    t.integer "orderID"
  end

  create_table "invGroups", primary_key: "groupID", force: :cascade do |t|
    t.integer "categoryID"
    t.string "groupName", limit: 100
    t.integer "iconID"
    t.boolean "useBasePrice"
    t.boolean "anchored"
    t.boolean "anchorable"
    t.boolean "fittableNonSingleton"
    t.boolean "published"
    t.index ["categoryID"], name: "ix_invGroups_categoryID"
  end

  create_table "invItems", primary_key: "itemID", force: :cascade do |t|
    t.integer "typeID", null: false
    t.integer "ownerID", null: false
    t.integer "locationID", null: false
    t.integer "flagID", null: false
    t.integer "quantity", null: false
    t.index ["locationID"], name: "ix_invItems_locationID"
    t.index ["ownerID", "locationID"], name: "items_IX_OwnerLocation"
  end

  create_table "invMarketGroups", primary_key: "marketGroupID", force: :cascade do |t|
    t.integer "parentGroupID"
    t.string "marketGroupName", limit: 100
    t.string "description", limit: 3000
    t.integer "iconID"
    t.boolean "hasTypes"
  end

  create_table "invMetaGroups", primary_key: "metaGroupID", force: :cascade do |t|
    t.string "metaGroupName", limit: 100
    t.string "description", limit: 1000
    t.integer "iconID"
  end

  create_table "invMetaTypes", primary_key: "typeID", force: :cascade do |t|
    t.integer "parentTypeID"
    t.integer "metaGroupID"
  end

  create_table "invNames", primary_key: "itemID", force: :cascade do |t|
    t.string "itemName", limit: 200, null: false
  end

  create_table "invPositions", primary_key: "itemID", force: :cascade do |t|
    t.float "x", null: false
    t.float "y", null: false
    t.float "z", null: false
    t.float "yaw"
    t.float "pitch"
    t.float "roll"
  end

  create_table "invTraits", primary_key: "traitID", force: :cascade do |t|
    t.integer "typeID"
    t.integer "skillID"
    t.float "bonus"
    t.text "bonusText"
    t.integer "unitID"
  end

  create_table "invTypeMaterials", primary_key: ["typeID", "materialTypeID"], force: :cascade do |t|
    t.integer "typeID", null: false
    t.integer "materialTypeID", null: false
    t.integer "quantity", null: false
  end

  create_table "invTypeReactions", primary_key: ["reactionTypeID", "input", "typeID"], force: :cascade do |t|
    t.integer "reactionTypeID", null: false
    t.boolean "input", null: false
    t.integer "typeID", null: false
    t.integer "quantity"
  end

  create_table "invTypes", primary_key: "typeID", force: :cascade do |t|
    t.integer "groupID"
    t.string "typeName", limit: 100
    t.text "description"
    t.float "mass"
    t.float "volume"
    t.float "capacity"
    t.integer "portionSize"
    t.integer "raceID"
    t.decimal "basePrice"
    t.boolean "published"
    t.integer "marketGroupID"
    t.integer "iconID"
    t.integer "soundID"
    t.integer "graphicID"
    t.index ["groupID"], name: "ix_invTypes_groupID"
  end

  create_table "invUniqueNames", primary_key: "itemID", force: :cascade do |t|
    t.string "itemName", limit: 200, null: false
    t.integer "groupID"
    t.index ["groupID", "itemName"], name: "invUniqueNames_IX_GroupName"
    t.index ["itemName"], name: "ix_invUniqueNames_itemName", unique: true
  end

  create_table "invVolumes", primary_key: "typeID", force: :cascade do |t|
    t.integer "volume"
  end

  create_table "mapCelestialStatistics", primary_key: "celestialID", force: :cascade do |t|
    t.float "temperature"
    t.string "spectralClass", limit: 10
    t.float "luminosity"
    t.float "age"
    t.float "life"
    t.float "orbitRadius"
    t.float "eccentricity"
    t.float "massDust"
    t.float "massGas"
    t.boolean "fragmented"
    t.float "density"
    t.float "surfaceGravity"
    t.float "escapeVelocity"
    t.float "orbitPeriod"
    t.float "rotationRate"
    t.boolean "locked"
    t.float "pressure"
    t.float "radius"
    t.integer "mass"
  end

  create_table "mapConstellationJumps", primary_key: ["fromConstellationID", "toConstellationID"], force: :cascade do |t|
    t.integer "fromRegionID"
    t.integer "fromConstellationID", null: false
    t.integer "toConstellationID", null: false
    t.integer "toRegionID"
  end

  create_table "mapConstellations", primary_key: "constellationID", force: :cascade do |t|
    t.integer "regionID"
    t.string "constellationName", limit: 100
    t.float "x"
    t.float "y"
    t.float "z"
    t.float "xMin"
    t.float "xMax"
    t.float "yMin"
    t.float "yMax"
    t.float "zMin"
    t.float "zMax"
    t.integer "factionID"
    t.float "radius"
  end

  create_table "mapDenormalize", primary_key: "itemID", force: :cascade do |t|
    t.integer "typeID"
    t.integer "groupID"
    t.integer "solarSystemID"
    t.integer "constellationID"
    t.integer "regionID"
    t.integer "orbitID"
    t.float "x"
    t.float "y"
    t.float "z"
    t.float "radius"
    t.string "itemName", limit: 100
    t.float "security"
    t.integer "celestialIndex"
    t.integer "orbitIndex"
    t.index ["constellationID"], name: "ix_mapDenormalize_constellationID"
    t.index ["groupID", "constellationID"], name: "mapDenormalize_IX_groupConstellation"
    t.index ["groupID", "regionID"], name: "mapDenormalize_IX_groupRegion"
    t.index ["groupID", "solarSystemID"], name: "mapDenormalize_IX_groupSystem"
    t.index ["orbitID"], name: "ix_mapDenormalize_orbitID"
    t.index ["regionID"], name: "ix_mapDenormalize_regionID"
    t.index ["solarSystemID"], name: "ix_mapDenormalize_solarSystemID"
    t.index ["typeID"], name: "ix_mapDenormalize_typeID"
  end

  create_table "mapJumps", primary_key: "stargateID", force: :cascade do |t|
    t.integer "destinationID"
  end

  create_table "mapLandmarks", primary_key: "landmarkID", force: :cascade do |t|
    t.string "landmarkName", limit: 100
    t.text "description"
    t.integer "locationID"
    t.float "x"
    t.float "y"
    t.float "z"
    t.integer "iconID"
  end

  create_table "mapLocationScenes", primary_key: "locationID", force: :cascade do |t|
    t.integer "graphicID"
  end

  create_table "mapLocationWormholeClasses", primary_key: "locationID", force: :cascade do |t|
    t.integer "wormholeClassID"
  end

  create_table "mapRegionJumps", primary_key: ["fromRegionID", "toRegionID"], force: :cascade do |t|
    t.integer "fromRegionID", null: false
    t.integer "toRegionID", null: false
  end

  create_table "mapRegions", primary_key: "regionID", force: :cascade do |t|
    t.string "regionName", limit: 100
    t.float "x"
    t.float "y"
    t.float "z"
    t.float "xMin"
    t.float "xMax"
    t.float "yMin"
    t.float "yMax"
    t.float "zMin"
    t.float "zMax"
    t.integer "factionID"
    t.float "radius"
  end

  create_table "mapSolarSystemJumps", primary_key: ["fromSolarSystemID", "toSolarSystemID"], force: :cascade do |t|
    t.integer "fromRegionID"
    t.integer "fromConstellationID"
    t.integer "fromSolarSystemID", null: false
    t.integer "toSolarSystemID", null: false
    t.integer "toConstellationID"
    t.integer "toRegionID"
  end

  create_table "mapSolarSystems", primary_key: "solarSystemID", force: :cascade do |t|
    t.integer "regionID"
    t.integer "constellationID"
    t.string "solarSystemName", limit: 100
    t.float "x"
    t.float "y"
    t.float "z"
    t.float "xMin"
    t.float "xMax"
    t.float "yMin"
    t.float "yMax"
    t.float "zMin"
    t.float "zMax"
    t.float "luminosity"
    t.boolean "border"
    t.boolean "fringe"
    t.boolean "corridor"
    t.boolean "hub"
    t.boolean "international"
    t.boolean "regional"
    t.boolean "constellation"
    t.float "security"
    t.integer "factionID"
    t.float "radius"
    t.integer "sunTypeID"
    t.string "securityClass", limit: 2
    t.index ["constellationID"], name: "ix_mapSolarSystems_constellationID"
    t.index ["regionID"], name: "ix_mapSolarSystems_regionID"
    t.index ["security"], name: "ix_mapSolarSystems_security"
  end

  create_table "mapUniverse", primary_key: "universeID", force: :cascade do |t|
    t.string "universeName", limit: 100
    t.float "x"
    t.float "y"
    t.float "z"
    t.float "xMin"
    t.float "xMax"
    t.float "yMin"
    t.float "yMax"
    t.float "zMin"
    t.float "zMax"
    t.float "radius"
  end

  create_table "planetSchematics", primary_key: "schematicID", force: :cascade do |t|
    t.string "schematicName", limit: 255
    t.integer "cycleTime"
  end

  create_table "planetSchematicsPinMap", primary_key: ["schematicID", "pinTypeID"], force: :cascade do |t|
    t.integer "schematicID", null: false
    t.integer "pinTypeID", null: false
  end

  create_table "planetSchematicsTypeMap", primary_key: ["schematicID", "typeID"], force: :cascade do |t|
    t.integer "schematicID", null: false
    t.integer "typeID", null: false
    t.integer "quantity"
    t.boolean "isInput"
  end

  create_table "ramActivities", primary_key: "activityID", force: :cascade do |t|
    t.string "activityName", limit: 100
    t.string "iconNo", limit: 5
    t.string "description", limit: 1000
    t.boolean "published"
  end

  create_table "ramAssemblyLineStations", primary_key: ["stationID", "assemblyLineTypeID"], force: :cascade do |t|
    t.integer "stationID", null: false
    t.integer "assemblyLineTypeID", null: false
    t.integer "quantity"
    t.integer "stationTypeID"
    t.integer "ownerID"
    t.integer "solarSystemID"
    t.integer "regionID"
    t.index ["ownerID"], name: "ix_ramAssemblyLineStations_ownerID"
    t.index ["regionID"], name: "ix_ramAssemblyLineStations_regionID"
    t.index ["solarSystemID"], name: "ix_ramAssemblyLineStations_solarSystemID"
  end

  create_table "ramAssemblyLineTypeDetailPerCategory", primary_key: ["assemblyLineTypeID", "categoryID"], force: :cascade do |t|
    t.integer "assemblyLineTypeID", null: false
    t.integer "categoryID", null: false
    t.float "timeMultiplier"
    t.float "materialMultiplier"
    t.float "costMultiplier"
  end

  create_table "ramAssemblyLineTypeDetailPerGroup", primary_key: ["assemblyLineTypeID", "groupID"], force: :cascade do |t|
    t.integer "assemblyLineTypeID", null: false
    t.integer "groupID", null: false
    t.float "timeMultiplier"
    t.float "materialMultiplier"
    t.float "costMultiplier"
  end

  create_table "ramAssemblyLineTypes", primary_key: "assemblyLineTypeID", force: :cascade do |t|
    t.string "assemblyLineTypeName", limit: 100
    t.string "description", limit: 1000
    t.float "baseTimeMultiplier"
    t.float "baseMaterialMultiplier"
    t.float "baseCostMultiplier"
    t.float "volume"
    t.integer "activityID"
    t.float "minCostPerHour"
  end

  create_table "ramInstallationTypeContents", primary_key: ["installationTypeID", "assemblyLineTypeID"], force: :cascade do |t|
    t.integer "installationTypeID", null: false
    t.integer "assemblyLineTypeID", null: false
    t.integer "quantity"
  end

  create_table "skinLicense", primary_key: "licenseTypeID", force: :cascade do |t|
    t.integer "duration"
    t.integer "skinID"
  end

  create_table "skinMaterials", primary_key: "skinMaterialID", force: :cascade do |t|
    t.integer "displayNameID"
    t.integer "materialSetID"
  end

  create_table "skinShip", id: false, force: :cascade do |t|
    t.integer "skinID"
    t.integer "typeID"
    t.index ["skinID"], name: "ix_skinShip_skinID"
    t.index ["typeID"], name: "ix_skinShip_typeID"
  end

  create_table "skins", primary_key: "skinID", force: :cascade do |t|
    t.string "internalName", limit: 70
    t.integer "skinMaterialID"
  end

  create_table "staOperationServices", primary_key: ["operationID", "serviceID"], force: :cascade do |t|
    t.integer "operationID", null: false
    t.integer "serviceID", null: false
  end

  create_table "staOperations", primary_key: "operationID", force: :cascade do |t|
    t.integer "activityID"
    t.string "operationName", limit: 100
    t.string "description", limit: 1000
    t.integer "fringe"
    t.integer "corridor"
    t.integer "hub"
    t.integer "border"
    t.integer "ratio"
    t.integer "caldariStationTypeID"
    t.integer "minmatarStationTypeID"
    t.integer "amarrStationTypeID"
    t.integer "gallenteStationTypeID"
    t.integer "joveStationTypeID"
  end

  create_table "staServices", primary_key: "serviceID", force: :cascade do |t|
    t.string "serviceName", limit: 100
    t.string "description", limit: 1000
  end

  create_table "staStationTypes", primary_key: "stationTypeID", force: :cascade do |t|
    t.float "dockEntryX"
    t.float "dockEntryY"
    t.float "dockEntryZ"
    t.float "dockOrientationX"
    t.float "dockOrientationY"
    t.float "dockOrientationZ"
    t.integer "operationID"
    t.integer "officeSlots"
    t.float "reprocessingEfficiency"
    t.boolean "conquerable"
  end

  create_table "staStations", primary_key: "stationID", force: :cascade do |t|
    t.float "security"
    t.float "dockingCostPerVolume"
    t.float "maxShipVolumeDockable"
    t.integer "officeRentalCost"
    t.integer "operationID"
    t.integer "stationTypeID"
    t.integer "corporationID"
    t.integer "solarSystemID"
    t.integer "constellationID"
    t.integer "regionID"
    t.string "stationName", limit: 100
    t.float "x"
    t.float "y"
    t.float "z"
    t.float "reprocessingEfficiency"
    t.float "reprocessingStationsTake"
    t.integer "reprocessingHangarFlag"
    t.index ["constellationID"], name: "ix_staStations_constellationID"
    t.index ["corporationID"], name: "ix_staStations_corporationID"
    t.index ["operationID"], name: "ix_staStations_operationID"
    t.index ["regionID"], name: "ix_staStations_regionID"
    t.index ["solarSystemID"], name: "ix_staStations_solarSystemID"
    t.index ["stationTypeID"], name: "ix_staStations_stationTypeID"
  end

  create_table "translationTables", primary_key: ["sourceTable", "translatedKey"], force: :cascade do |t|
    t.string "sourceTable", limit: 200, null: false
    t.string "destinationTable", limit: 200
    t.string "translatedKey", limit: 200, null: false
    t.integer "tcGroupID"
    t.integer "tcID"
  end

  create_table "trnTranslationColumns", primary_key: "tcID", force: :cascade do |t|
    t.integer "tcGroupID"
    t.string "tableName", limit: 256, null: false
    t.string "columnName", limit: 128, null: false
    t.string "masterID", limit: 128
  end

  create_table "trnTranslationLanguages", primary_key: "numericLanguageID", force: :cascade do |t|
    t.string "languageID", limit: 50
    t.string "languageName", limit: 200
  end

  create_table "trnTranslations", primary_key: ["tcID", "keyID", "languageID"], force: :cascade do |t|
    t.integer "tcID", null: false
    t.integer "keyID", null: false
    t.string "languageID", limit: 50, null: false
    t.text "text", null: false
  end

  create_table "warCombatZoneSystems", primary_key: "solarSystemID", force: :cascade do |t|
    t.integer "combatZoneID"
  end

  create_table "warCombatZones", primary_key: "combatZoneID", force: :cascade do |t|
    t.string "combatZoneName", limit: 100
    t.integer "factionID"
    t.integer "centerSystemID"
    t.string "description", limit: 500
  end

end
