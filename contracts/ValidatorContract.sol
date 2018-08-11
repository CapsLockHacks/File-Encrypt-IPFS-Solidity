pragma solidity ^0.4.17;

contract ValidatorContract {

	// current item id increments on every upload object
	uint currentId = 1;
	struct UploadObject {
		string fileHash;
		string alias1;
		string alias2;
		string policyId;
		string capsule;
		string signedPublicKey;
		string alicePubKey;
	}

	//user will have multiple upload items
	mapping (address => uint[]) public userAddressToUploadObjectIds;

	// each item will have a user
	mapping (uint => UploadObject) public uploadObjectIdToData;

	// add new entry
	function addDocument(address _from, string fileHash, string alias1, string alias2, string policyId, string capsule, string signedPublicKey, string alicePubKey) public returns(uint) {
		// UploadObject memory uploadObjectIdToData[id] = UploadObject({
		// 	id: currentId,
		// 	fileHash: fileHash,
		// 	alias1: alias1,
		// 	alias2: alias2,
		// 	policyId: policyId,
		// 	capsule: capsule,
		// 	signedPublicKey: signedPublicKey,
		// 	alicePubKey: alicePubKey
		// });
		
		uploadObjectIdToData[currentId].fileHash = fileHash;
		uploadObjectIdToData[currentId].alias1 = alias1;
		uploadObjectIdToData[currentId].alias2 = alias2;
		uploadObjectIdToData[currentId].policyId = policyId;
		uploadObjectIdToData[currentId].capsule = capsule;
		uploadObjectIdToData[currentId].signedPublicKey = signedPublicKey;
		uploadObjectIdToData[currentId].alicePubKey = alicePubKey;

		// now settle relationships
		userAddressToUploadObjectIds[_from].push(currentId);

		currentId = currentId + 1;
		return currentId;
	}

	// get existing documents
	function getDocumentIds(address _address) public constant returns(uint[]) {
		return userAddressToUploadObjectIds[_address];
	}

	// get document data from document id
	function getDocument(uint id) public constant returns(string, string, string, string, string, string, string) {
			return (uploadObjectIdToData[id].fileHash, uploadObjectIdToData[id].alias1, uploadObjectIdToData[id].alias2, 
				uploadObjectIdToData[id].policyId, uploadObjectIdToData[id].capsule, uploadObjectIdToData[id].signedPublicKey, uploadObjectIdToData[id].alicePubKey);
	}

	function getCurrentId() public constant returns(uint) {
		return currentId;
	}
}