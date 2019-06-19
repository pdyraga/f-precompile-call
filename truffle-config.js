module.exports = {
  networks: {
    local: {
      host: "localhost",
      port: 8547,
      network_id: "*",
      gas: 4612388,
    },
  },
  compilers: {
    solc: {
      version: "0.5.4"
    }
  }
};
