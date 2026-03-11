## Deployment (Sepolia)

- **Network**: Sepolia
- **Deployer**: `0x09B99C5bBD2283038cb918AE46ee256671717B51`
- **Contract**: `WETH` (`src/WETH.sol`)
- **Address**: `0x25dD6C486cD8A9AdC17b5339f830F55f4D6BeC21`
- **Transaction hash**: `0x46f4422a548c3e1e3cfd33b370d366bc1bbd601c85066e0d121224f4b821a150`
- **Explorer (Sepolia Etherscan)**: `https://sepolia.etherscan.io/address/0x25dD6C486cD8A9AdC17b5339f830F55f4D6BeC21`

---

## How to interact with the deployed contract

You can interact either via:

- **Etherscan** (write/read contract tab), or
- **Foundry Cast** from the command line.

Below are example `cast` commands.

### Example: mint WETH (wrap 0.1 ETH)

This calls:

- `mint()` with `msg.value = 0.1 ETH`

```bash
cast send 0x25dD6C486cD8A9AdC17b5339f830F55f4D6BeC21 \
  "mint()" \
  --value 0.1ether \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY
```

### Example: check your WETH balance

This calls:

- `reserves(address user)` which returns the WETH balance of `user`.

```bash
cast call 0x25dD6C486cD8A9AdC17b5339f830F55f4D6BeC21 \
  "reserves(address)" 0xYOUR_ADDRESS \
  --rpc-url $SEPOLIA_RPC_URL
```

### Example: burn WETH (unwrap 0.05 ETH)

This calls:

- `burn(uint256 amount)` with `amount = 0.05 ETH` (denominated in wei).

```bash
cast send 0x25dD6C486cD8A9AdC17b5339f830F55f4D6BeC21 \
  "burn(uint256)" 50000000000000000 \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY
```