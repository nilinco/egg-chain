# egg-chain
Blockchain based product traceability sample for eggs ;)  
More general contracts for tracing different types of products is now available at: https://github.com/nilinco/tracer-contract.git

## additional explaine
in this sample we tried to built contract for egg production and tracking it from farm to factory
and create packages of eggs from diffrent source in factory and tracking them from factories to stores.
then when customer scan the ًQR_code on the package in store , can see history off eggs and each contents of it :) 
it is a simple sample of [supply chain](https://en.wikipedia.org/wiki/Supply_chain).

## deployment
you can deploy contract on ethereum network and call it's function.
you can use this [toturial](https://medium.com/coinmonks/ethereum-blockchain-hello-world-smart-contract-with-java-9b6ae2961ad1) to deploy egg contract .

## example

when i call  getEggsDetail(valid eggsLabel in network) shows me :

```
{
	"eggsLabel": "1235601098753456784567890",
	"createAt": "1543915512",
	"packageType": "123456",
	"lastOwner": "a330dD804fb48e340498eEeb966d5581766556Aa",
	"eggsHistory": [{
		"transferTime": "1543915567",
		"from": "C2C12A241ED9efcd9eB003221Ca3F8D1634b519a",
		"to": "a330dD804fb48e340498eEeb966d5581766556Aa"
	}, ...],
	"eggContents": [{
				"eggLabel": "1237801017680987654",
				"birthTime": "1543915443",
				"checkenProfile": {
					"label": "128888987543569073560500",
					"owner": "71b01f05e77d6a515c6b551cb0227b05d4990d8f",
					"race": "leghorn",
					"foodType": "organic",
					"avicultureLocation": "hayat : city:pakdasht , st:falah , p:234"
				}, ...
			]}
    }  
```
and to see contents's history I can call getEggDatail(each label of package's eggs) that shows me:

```
{
	"eggLabel": "1237801017680987654",
	"birthDay": "1543915443",
	"chickenProfile": {
		"label": "128888987543569073560500",
		"owner": "71b01f05e77d6a515c6b551cb0227b05d4990d8f",
		"race": "leghorn",
		"foodType": "organic",
		"avicultureLocation": "hayat : city:pakdasht , st:falah , p:234"
	},
	"lastOwner": "a330dD804fb48e340498eEeb966d5581766556Aa",
	"eggHistory": [{
		"transferTime": "1543915443",
		"from": "71b01f05e77d6a515c6b551cb0227b05d4990d8f",
		"to": "0xC2C12A241ED9efcd9eB003221Ca3F8D1634b519a"
	}, ...
	}]
}
```


