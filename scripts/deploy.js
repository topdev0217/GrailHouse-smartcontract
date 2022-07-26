// scripts/deploy.js
const { ethers, upgrades } = require('hardhat');
const fs = require('fs');

async function main () {
    const GrailHouse = await ethers.getContractFactory('GrailHouse');
    console.log('Deploying...');
    const _GrailHouse = await upgrades.deployProxy(
      GrailHouse, 
        [], 
        { initializer: 'initialize' }
    );
    await _GrailHouse.deployed();
    const addresses = {
        proxy: _GrailHouse.address,
        admin: await upgrades.erc1967.getAdminAddress(_GrailHouse.address), 
        implementation: await upgrades.erc1967.getImplementationAddress(
          _GrailHouse.address)
    };
    console.log('Addresses:', addresses);

    try { 
        await run('verify', { address: addresses.implementation });
    } catch (e) {}

    fs.writeFileSync('deployment-addresses.json', JSON.stringify(addresses));
}

main();