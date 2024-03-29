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

    function F(uint32 rounds, bytes32[2] memory h, bytes32[4] memory m, bytes8[2] memory t, bool f) public view returns (bytes32[2] memory) {
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
    // 48c9bdf267e6096a3ba7ca8485ae67bb2bf894fe72f36e3cf1361d5f3af54fa5
    // d182e6ad7f520e511f6c3e2b8c68059b6bbd41fbabd9831f79217e1319cde05b
    // 6162630000000000000000000000000000000000000000000000000000000000
    // 0000000000000000000000000000000000000000000000000000000000000000
    // 0000000000000000000000000000000000000000000000000000000000000000
    // 0000000000000000000000000000000000000000000000000000000000000000
    // 0300000000000000
    // 0000000000000000
    // 01
    //
    // EXPECTED:
    // ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d1
    // 7d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
    function callF() public view returns (bytes32[2] memory) {
      uint32 rounds = 12;

      bytes32[2] memory h;
      h[0] = hex"48c9bdf267e6096a3ba7ca8485ae67bb2bf894fe72f36e3cf1361d5f3af54fa5"; 
      h[1] = hex"d182e6ad7f520e511f6c3e2b8c68059b6bbd41fbabd9831f79217e1319cde05b";
  
      bytes32[4] memory m;
      m[0] = hex"6162630000000000000000000000000000000000000000000000000000000000";
      m[1] = hex"0000000000000000000000000000000000000000000000000000000000000000";
      m[2] = hex"0000000000000000000000000000000000000000000000000000000000000000";
      m[3] = hex"0000000000000000000000000000000000000000000000000000000000000000";
 
      bytes8[2] memory t;
      t[0] = hex"03000000";
      t[1] = hex"00000000";

      bool f = true;

      return F(rounds, h, m, t, f);
    }
}
