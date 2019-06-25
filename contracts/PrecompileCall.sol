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

      bytes memory args = abi.encodePacked(h[0], h[1], m[0], m[1], m[2], m[3], t[0], t[1], f, rounds);

      assembly {
            if iszero(staticcall(not(0), 0x09, add(args, 32), 0xd5, output, 0x40)) {
                revert(0, 0)
            }
      }

      return output;
    }

    function callF() public view returns (bytes32[2] memory) {
      bytes32[2] memory h;
      h[0] = hex"6a09e627f3bcc909bb67ae8484caa73b3c6ef372fe94b82ba54ff53a5f1d36f2"; 
      h[1] = hex"510e527fade682d19b05688c2b3e6c1f1f83d9abfb41bd6b5be0cd19137e2179";
  
      bytes32[4] memory m;
      m[0] = hex"278400340e6b05c5752592c52c4f121292eafc51cc01a997b4aed13409298fad";
      m[1] = hex"0d99ccc8f76453d9b3661e5c4d325d7751147db17489046d1682d50eefa4a1da";
      m[2] = hex"0000000000000000000000000000000000000000000000000000000000000000";
      m[3] = hex"0000000000000000000000000000000000000000000000000000000000000000";
 
      uint64[2] memory t;
      t[0] = 18446744073709551552;  // ffffffffffffffc0
      t[1] = 18446744073709551615;	// ffffffffffffffff

      bool f = true;

      uint32 rounds = 12;

      return F(h, m, t, f, rounds);
    }
}
