-include .env

build:; forge build

compile:; forge compile

anvil:; forge anvil

test :; forge test

gas :; forge snapshot

deploy-sepolia:
	forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

mint-NFT:
	forge script script/interactions.s.sol:BasicNFTInteractions --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast