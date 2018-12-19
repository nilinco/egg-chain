pragma solidity ^0.4.24;
import"StringUtil.sol";
import"AddressUtil.sol";

    contract Egg

    {

        using StringUtil for *;
        using AddressUtil for address;

		
        struct ChickenProfilStruct {
			uint256 chickenLabel;
			string avicultureLocation;
			address owner;
			string foodType;
			string race;
    }
	
        struct EggStruct {
			uint256 eggLabel;
			uint256 birthTime;
			address lastOwner;
			uint historyNum;
			uint256 chickenProfile;
			mapping(uint256 = > EggHistoryStruct)eggHistory;
    }
	
        struct EggHistoryStruct {
			address _from;
			uint256 transferTime;
			address _to;
    }
	
        struct EggsStruct {
			uint256 eggsLabel;
			uint256 createAt;
			uint32 packageType;
			address lastOwner;
			uint contentNum;
			uint historyNum;
			mapping(uint256 = > EggStruct)listOfContents;
			mapping(uint256 = > EggsHistoryStruct)eggsHistory;
    }

        struct EggsHistoryStruct {
			address _from;
			uint256 transferTime;
			address _to;
    }

        mapping(uint256 = > ChickenProfilStruct)chickens;
        mapping(uint256 = > EggStruct)eggs;
        mapping(uint256 = > EggsStruct)eggPackages;

        mapping(uint256 = > uint256)mappingEggLabelToEggId;
        mapping(uint256 = > uint256)mappingEggsLabelToEggsId;
        mapping(uint256 = > uint256)mappingChickenLabelToChickenId;

        uint256 newEggId;
        uint256 newEggsId;
        uint256 newChickenId;

        uint i = 0;
        uint s = 0;


        event Transfer (uint goodId, address _from, address _to);

        function createChickenProfile (uint256 chickenLabel,string avicultureLocation, string foodType, string race)public {
			ChickenProfilStruct memory newChicken = ChickenProfilStruct({
					chickenLabel :chickenLabel,
					avicultureLocation:avicultureLocation,
					owner :msg.sender,
					foodType :foodType,
					race :race
				});
			newChickenId++;
			mappingChickenLabelToChickenId[chickenLabel] = newChickenId;
			chickens[newChickenId] = newChicken;
    }


        function createEgg (uint256 eggLabel,uint256 chickenLabel)public {
			EggStruct memory newEgg = EggStruct({
					birthTime :now,
					checkenProfile :mappingChickenLabelToChickenId[chickenLabel],
					lastOwner :msg.sender,
					historyNum :0,
					eggLabel :eggLabel
				});
			newEggId++;
			mappingEggLabelToEggId[eggLabel] = newEggId;
			eggs[newEggId] = newEgg;
			transferEgg(eggLabel, msg.sender);
    }

        function createEggs (uint256 eggsLabel, uint32 packageType)public {
			EggsStruct memory newEggs = EggsStruct({
					packageType :packageType,
					lastOwner :msg.sender,
					historyNum :0,
					contentNum :0,
					createAt:now,
					eggsLabel :eggsLabel
				});
			newEggsId++;
			mappingEggsLabelToEggsId[eggsLabel] = newEggsId;
			eggPackages[newEggsId] = newEggs;
			transferEggs(newEggsId, msg.sender);
    }


        function addEggToEggs (uint256 eggLabel, uint256 eggsLabel)public {
        EggStruct storage e = eggs[mappingEggLabelToEggId[eggLabel]];
        EggsStruct storage es = eggPackages[mappingEggsLabelToEggsId[eggsLabel]];
        es.listOfContents[es.contentNum++] = e;
    }


        function transferEgg (uint256 eggLabel, address _to)public {
			EggHistoryStruct memory newEggHistory = EggHistoryStruct({
					transferTime :now,
					_to :_to,
					_from:msg.sender
				});
			EggStruct storage e = eggs[mappingEggLabelToEggId[eggLabel]];
			e.lastOwner = _to;
			e.eggHistory[e.historyNum++] = newEggHistory;
			Transfer(mappingEggLabelToEggId[eggLabel], msg.sender, _to);
    }

        function transferEggs (uint256 eggsLabel, address _to)public {
			EggsHistoryStruct memory newEggsHistory = EggsHistoryStruct({
					transferTime :now,
					_from:msg.sender,
					_to :_to
				});
			EggsStruct storage es = eggPackages[mappingEggsLabelToEggsId[eggsLabel]];
			es.lastOwner = _to;
			es.eggsHistory[es.historyNum++] = newEggsHistory;
			Transfer(mappingEggsLabelToEggsId[eggsLabel], msg.sender, _to);
    }


        function getEggDetail (uint256 eggLabel)constant returns (string) {
			uint256 index1 = mappingEggLabelToEggId[eggLabel];
			EggStruct storage egg = eggs[index1];
			ChickenProfilStruct storage checkenProfile = chickens[egg.checkenProfile];
			var ret = "{";
			ret = ret.toSlice().concat("\"eggLabel\":\"".toSlice());
			ret = ret.toSlice().concat(egg.eggLabel.uint2str().toSlice());
			ret = ret.toSlice().concat("\",\"birthDay\":\"".toSlice());
			ret = ret.toSlice().concat(egg.birthTime.uint2str().toSlice());
			ret = ret.toSlice().concat("\",\"checkenProfile\":".toSlice());
			ret = ret.toSlice().concat("{".toSlice());
			ret = ret.toSlice().concat("\"label\":\"".toSlice());
			ret = ret.toSlice().concat(checkenProfile.chickenLabel.uint2str().toSlice());
			ret = ret.toSlice().concat("\",\"owner\":\"".toSlice());
			ret = ret.toSlice().concat(chickenProfile.owner.toString().toSlice());
			ret = ret.toSlice().concat("\",\"race\":\"".toSlice());
			ret = ret.toSlice().concat(checkenProfile.race.toSlice());
			ret = ret.toSlice().concat("\",\"foodType\":\"".toSlice());
			ret = ret.toSlice().concat(checkenProfile.foodType.toSlice());
			ret = ret.toSlice().concat("\",\"avicultureLocation\":\"".toSlice());
			ret = ret.toSlice().concat(checkenProfile.avicultureLocation.toSlice());
			ret = ret.toSlice().concat("\"}".toSlice());
			ret = ret.toSlice().concat(",\"lastOwner\":\"".toSlice());
			ret = ret.toSlice().concat(egg.lastOwner.toString().toSlice());
			ret = ret.toSlice().concat("\",\"eggHistory\":".toSlice());
			ret = ret.toSlice().concat("[".toSlice());
			i = 0;
			s = 0;
			while (i < eggs[index1].historyNum) {
				if (s > 0)
					ret = ret.toSlice().concat(",".toSlice());
				ret = ret.toSlice().concat("{".toSlice());
				ret = ret.toSlice().concat("\"transferTime\":\"".toSlice());
				ret = ret.toSlice().concat(egg.eggHistory[i].transferTime.uint2str().toSlice());
				ret = ret.toSlice().concat("\",\"from\":\"".toSlice());
				ret = ret.toSlice().concat(egg.eggHistory[i]._from.toString().toSlice());
				ret = ret.toSlice().concat("\",\"to\":\"".toSlice());
				ret = ret.toSlice().concat(egg.eggHistory[i]._to.toString().toSlice());
				ret = ret.toSlice().concat("\"".toSlice());
				ret = ret.toSlice().concat("}".toSlice());
				s = 1;
				i++;
			}
			ret = ret.toSlice().concat("]".toSlice());
			ret = ret.toSlice().concat("}".toSlice());

			return ret;
    }

        function getEggsDetail (uint256 eggsLabel)constant returns (string) {
			uint256 index1 = mappingEggsLabelToEggsId[eggsLabel];
			EggsStruct storage eggPackage = eggPackages[index1];

			var ret = "{";
			
			//eggsInfo
			ret = ret.toSlice().concat("\"eggsLabel\":\"".toSlice());
			ret = ret.toSlice().concat(eggPackage.eggsLabel.uint2str().toSlice());
			ret = ret.toSlice().concat("\",\"createAt\":\"".toSlice());
			ret = ret.toSlice().concat(eggPackage.createAt.uint2str().toSlice());
			ret = ret.toSlice().concat("\",\"packageType\":\"".toSlice());
			ret = ret.toSlice().concat(eggPackage.packageType.uint2str().toSlice());
			ret = ret.toSlice().concat("\",\"lastOwner\":\"".toSlice());
			ret = ret.toSlice().concat(eggPackage.lastOwner.toString().toSlice());

			//eggsHistory

			ret = ret.toSlice().concat("\",\"eggsHistory\":".toSlice());
			ret = ret.toSlice().concat("[".toSlice());
			i = 0;
			s = 0;
			while (i < eggPackage.historyNum) {
				if (s > 0)
				ret = ret.toSlice().concat(",".toSlice());
				ret = ret.toSlice().concat("{".toSlice());
				ret = ret.toSlice().concat("\"transferTime\":\"".toSlice());
				ret = ret.toSlice().concat(eggPackage.eggsHistory[i].transferTime.uint2str().toSlice());
				ret = ret.toSlice().concat("\",\"from\":\"".toSlice());
				ret = ret.toSlice().concat(eggPackage.eggsHistory[i]._from.toString().toSlice());
				ret = ret.toSlice().concat("\",\"to\":\"".toSlice());
				ret = ret.toSlice().concat(eggPackage.eggsHistory[i]._to.toString().toSlice());
				ret = ret.toSlice().concat("\"".toSlice());
				ret = ret.toSlice().concat("}".toSlice());
				s = 1;
				i++;
			}
			ret = ret.toSlice().concat("]".toSlice());

			//eggs content

			ret = ret.toSlice().concat(",\"eggContents\":".toSlice());
			ret = ret.toSlice().concat("[".toSlice());
			i = 0;
			s = 0;
			while (i < eggPackage.contentNum) {
				ChickenProfilStruct storage checkenProfile = chickens[eggPackage.listOfContents[i].checkenProfile];
				if (s > 0)
				ret = ret.toSlice().concat(",".toSlice());
				ret = ret.toSlice().concat("{".toSlice());
				ret = ret.toSlice().concat("\"eggLabel\":\"".toSlice());
				ret = ret.toSlice().concat(eggPackage.listOfContents[i].eggLabel.uint2str().toSlice());
				ret = ret.toSlice().concat("\",\"birthTime\":\"".toSlice());
				ret = ret.toSlice().concat(eggPackage.listOfContents[i].birthTime.uint2str().toSlice());
				ret = ret.toSlice().concat("\",\"checkenProfile\":".toSlice());
				ret = ret.toSlice().concat("{".toSlice());
				ret = ret.toSlice().concat("\"label\":\"".toSlice());
				ret = ret.toSlice().concat(chickenProfile.chickenLabel.uint2str().toSlice());
				ret = ret.toSlice().concat("\",\"owner\":\"".toSlice());
				ret = ret.toSlice().concat(checkenProfile.owner.toString().toSlice());
				ret = ret.toSlice().concat("\",\"race\":\"".toSlice());
				ret = ret.toSlice().concat(checkenProfile.race.toSlice());
				ret = ret.toSlice().concat("\",\"foodType\":\"".toSlice());
				ret = ret.toSlice().concat(checkenProfile.foodType.toSlice());
				ret = ret.toSlice().concat("\",\"avicultureLocation\":\"".toSlice());
				ret = ret.toSlice().concat(checkenProfile.avicultureLocation.toSlice());
				ret = ret.toSlice().concat("\"}".toSlice());
				s = 1;
				i++;
			}
			ret = ret.toSlice().concat("]".toSlice());
			ret = ret.toSlice().concat("}".toSlice());

			return ret;
    }
    }