require('dotenv').config();
const key = process.env.PINATA_KEY;
const secret = process.env.PINATA_SECRET;
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK(key, secret);

const fs = require('fs');
const readableStreamForFile1 = fs.createReadStream('bonhomme180cheveux.png');
const options1 = {
	pinataMetadata: {
		name: "bonhommeNFT",
		height:180,
		hair:true
	},
	pinataOptions: {
		cidVersion: 0
	}
};

const readableStreamForFile2 = fs.createReadStream('bonhomme185pascheveux.png');
const options2 = {
	pinataMetadata: {
		name: "bonhommeNFT",
		height:185,
		hair:false
	},
	pinataOptions: {
		cidVersion: 0
	}
};

//Pin a file in IPFS => if ok we get an "IpfsHash"
pinata.pinFileToIPFS(readableStreamForFile1, options1).then((result) => {
	const body = {
		description: "Un bonhomme 1.",
		image: result.IpfsHash,
		name: "bonhommeNFT1",
	};

	//Pin a JSon to that IpfsHash => if ok print it or error
	pinata.pinJSONToIPFS(body, options1).then((json) => {
		console.log(json);
	}).catch((err) => {
		console.log(err);
	});

}).catch((err) => {
	console.log(err);
});

pinata.pinFileToIPFS(readableStreamForFile2, options2).then((result) => {
	const body = {
		description: "Un bonhomme 2.",
		image: result.IpfsHash,
		name: "bonhommeNFT2",
	};

	//Pin a JSon to that IpfsHash => if ok print it or error
	pinata.pinJSONToIPFS(body, options2).then((json) => {
		console.log(json);
	}).catch((err) => {
		console.log(err);
	});

}).catch((err) => {
	console.log(err);
});
