require('dotenv').config();
const key = process.env.PINATA_KEY;
const secret = process.env.PINATA_SECRET;
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK(key, secret);

const fs = require('fs');
const readableStreamForFile = fs.createReadStream('AALlogo.png');

const options = {
	pinataMetadata: {
		name: "AALNFT",
	},
	pinataOptions: {
		cidVersion: 0
	}
};

//Pin a file in IPFS => if ok we get an "IpfsHash"
pinata.pinFileToIPFS(readableStreamForFile, options).then((result) => {
	const body = {
		description: "Un NFT tres beau pour moi.",
		image: result.IpfsHash,
		name: "AALNft",
		properties:[
		{
			size:192,
			sexe:"m"
		},
		{
			cle:"a",
			cle2:"b"
		}]
	};

	//Pin a JSon to that IpfsHash => if ok print it or error
	pinata.pinJSONToIPFS(body, options).then((json) => {
		console.log(result.IpfsHash);
		console.log(json);
	}).catch((err) => {
		console.log(err);
	});

}).catch((err) => {
	console.log(err);
});
