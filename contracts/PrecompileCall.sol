pragma solidity ^0.5.4;

contract PrecompileCall {

    function precompiledExpmod(uint256 base, uint256 exponent, uint256 p) public view returns (uint256) {
        uint256[1] memory output;
        uint256[6] memory args = [32, 32, 32, base, exponent, p]; //32 * 6 = 192 -> input size

        assembly {
            if iszero(staticcall(not(0), 0x05, args, 0xc0, output, 0x20)) {
                revert(0, 0)
            }
        }
        return output[0];
    }

    function callExpmod() public view returns (uint256) {
        return precompiledExpmod(5, 3, 13);
    }

    function F(bytes32[2] memory h, bytes32[4] memory m, uint64[2] memory t, bool f, uint32 rounds) public view returns (bytes32[2] memory) {
      bytes32[2] memory output;

      bytes memory args = abi.encodePacked(rounds, h[0], h[1], m[0], m[1], m[2], m[3], t[0], t[1], f);

      assembly {
            if iszero(staticcall(not(0), 0x09, add(args, 32), 0xd5, output, 0x40)) {
                revert(0, 0)
            }
      }

      return output;
    }

    // INPUT:
    // 0000000c
    // b02406865b80cde9fec1e321559891be456158a6d71cf0eac1eb845c70d4a3d8
    // 948e82cc975dcbd6984780bab7e236382fb585df5bc4b043cb3e866544413d92
    // 87868584838281808f8e8d8c8b8a898897969594939291909f9e9d9c9b9a9998
    // a7a6a5a4a3a2a1a0afaeadacabaaa9a8b7b6b5b4b3b2b1b0bfbebdbcbbbab9b8
    // c7c6c5c4c3c2c1c0cfcecdcccbcac9c8d7d6d5d4d3d2d1d0dfdedddcdbdad9d8
    // e7e6e5e4e3e2e1e0efeeedecebeae9e8f7f6f5f4f3f2f1f000fefdfcfbfaf9f8
    // 000000000000017f
    // 0000000000000000
    // 01
    //
    // EXPECTED:
    // ccfc282ed60927145b46f8d0fa97afd07010c51d20821e9748923ea42a37a0fa
    // 0609a13be7c1e14b6e10a4b63d85d1d56d3d370d80f97b0a61a4f22ed6462dee
    function callF() public view returns (bytes32[2] memory) {
      uint32 rounds = 12;

      bytes32[2] memory h;
      h[0] = hex"b02406865b80cde9fec1e321559891be456158a6d71cf0eac1eb845c70d4a3d8"; 
      h[1] = hex"948e82cc975dcbd6984780bab7e236382fb585df5bc4b043cb3e866544413d92";
  
      bytes32[4] memory m;
      m[0] = hex"87868584838281808f8e8d8c8b8a898897969594939291909f9e9d9c9b9a9998";
      m[1] = hex"a7a6a5a4a3a2a1a0afaeadacabaaa9a8b7b6b5b4b3b2b1b0bfbebdbcbbbab9b8";
      m[2] = hex"c7c6c5c4c3c2c1c0cfcecdcccbcac9c8d7d6d5d4d3d2d1d0dfdedddcdbdad9d8";
      m[3] = hex"e7e6e5e4e3e2e1e0efeeedecebeae9e8f7f6f5f4f3f2f1f000fefdfcfbfaf9f8";
 
      uint64[2] memory t;
      t[0] = 383; // 000000000000017f
      t[1] = 0;	// 0000000000000000

      bool f = true; // 01

      return F(h, m, t, f, rounds);
    }
}
