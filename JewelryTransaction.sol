pragma solidity ^0.4.24;

contract JewelryTransaction {
    /**This contract is a basic jewelry resume program which records ownershipHistory of jewelry*/
	
	struct Jewelry{
        uint jewelryId; // each jewelry has an unique jewelryId
        Detail[] ownershipHistory; 
    }
	
	//Jewelry ownership is a historical data that has a name, a type, a certificate (0 if not), a seller, an owner/buyer, a price and a date of transaction
	struct Detail{
		bytes32 jname;
		bytes32 jtype;
		bytes32 jcertificate;
		bytes32 jseller;
		bytes32 jowner;
		uint jprice;
		bytes32 jDOT;
	}
	
    Jewelry[] jewels; // registered jewels
    address initiator; //initiator is the user who has initiated the contract
    
    mapping (uint => bool) public allJewelry;
	mapping(uint => Detail[]) public history;
	
    /**JewelrySold is an event that informs on success or failure of a transaction*/
    event JewelrySold(uint jewelryId,
						string owner,
                        bool flag,
                        string message);
						
    /**Constructor params
	jewelryIds: [0, 1, 2, 3]
	ownershipHistorys: ["Buyer:b0, Seller:s0, Price:p0, DOT:dt0", "...", "...", "..."]
	*/
    constructor() public {
        initiator = msg.sender; // initiate the initiator as the contract creator and initiate some jewelry
    }
    
    /**Alter ownership to any of the registered jewels*/
    function addNewOwner(uint _jewelryId, bytes32 _jname, bytes32 _jtype, bytes32 _jcertificate, bytes32 _jseller, bytes32 _jowner, uint _jprice, bytes32 _jDOT) public {
		
		Detail memory ownership = Detail(_jname, _jtype, _jcertificate, _jseller, _jowner, _jprice, _jDOT);
		
		// jewelryId does exist in record
		if (allJewelry[_jewelryId]){
			require(
				_jowner != _jseller,
				"Buyer can't be seller ."
			);
			require(
				history[_jewelryId][history[_jewelryId].length-1].jowner != _jowner,
				"Buyer is the owner ."
			);
			require(
				history[_jewelryId][history[_jewelryId].length-1].jowner == _jseller,
				"Seller doesn't own the jewelry ."
			);
			history[_jewelryId].push(ownership);
			emit JewelrySold(_jewelryId,
									bytes32ToString(_jowner), // owner
									true,
									'New ownership added to existing jewelry');
										
		} else { // jewelryId does not exist in record, hence create a new transaction and add to registered jewels
			allJewelry[_jewelryId] = true;
			history[_jewelryId].push(ownership);
			emit JewelrySold(_jewelryId,
								bytes32ToString(_jowner), // owner
								true,
								'New Jewelry added');
		}
    }
    
	function getHistoryCount(uint _jewelryId) public constant returns (uint) {
		require(
			allJewelry[_jewelryId] == true,
			"Jewelry is not registered!"
		);
		return history[_jewelryId].length;
	}
	
    function retrieveJewelryHistory(uint _jewelryId, uint index) public view returns(bytes32, bytes32, bytes32, uint, bytes32){
        require(
			allJewelry[_jewelryId] == true,
			"Jewelry is not registered!"
		);
		Detail storage detail = history[_jewelryId][index];
		return (detail.jcertificate, detail.jseller, detail.jowner, detail.jprice, detail.jDOT);
    }
    
    function bytes32ToString(bytes32 x) private pure returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
}