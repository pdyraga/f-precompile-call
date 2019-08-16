```
➜  f-precompile-call git:(master) ✗ truffle migrate --reset --network local 

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.


Starting migrations...
======================
> Network name:    'local'
> Network id:      1101
> Block gas limit: 0x7a1200


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0x02806c290281c95ccb4b57fdf864dce841fae490b3335633d83089963bc8a89a
   > Blocks: 0            Seconds: 0
   > contract address:    0xAC1eBb83e51d21666e6DCD40E3E83c475E259E20
   > block number:        14789
   > block timestamp:     1565964313
   > account:             0xFa3DA235947AaB49D439f3BcB46effD1a7237E32
   > balance:             44367
   > gas used:            234370
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0046874 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.0046874 ETH


2_deploy_contracts.js
=====================

   Replacing 'PrecompileCall'
   --------------------------
   > transaction hash:    0x82bf867a0e6395c844a15ddacfb561dbab9975b9e94237976f83b658d7e5d814
   > Blocks: 0            Seconds: 12
   > contract address:    0x57cf8140Ef46CC65c803a68a338116C3b4fD8339
   > block number:        14791
   > block timestamp:     1565964316
   > account:             0xFa3DA235947AaB49D439f3BcB46effD1a7237E32
   > balance:             44373
   > gas used:            482180
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0096436 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.0096436 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.014331 ETH

➜  f-precompile-call git:(master) ✗ truffle exec scripts/query-f.js --network local
Using network 'local'.

querying...
0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d1,0x7d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
```