const PrecompileCall = artifacts.require('PrecompileCall.sol');

module.exports = async function () {

  const precompileCall = await PrecompileCall.deployed();

  async function query() {
    console.log('querying...');
    let result = await precompileCall.callExpmod().catch((err) => {
      console.log(`Contract call failed: ${err}`);
    });

    console.log(result.toString());
  }

  await query();
}

