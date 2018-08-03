pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

/**
 * @dev Decentralize exchange for fundgible and non-fundgible tokens powered by atomic swaps. 
 */
contract Exchange 
{
  /**
   * @dev Enum of available signature kinds.
   */
  enum SignatureKind{
    eth_sign,
    trezor,
    eip712
  }
  
  /**
   * @dev Enum of available tokens kinds.
   */
  enum TokenKind{
    erc20,
    erc721
  }

  /**
   * @dev Structure representing what to send and where.
   * @param token Address of the token we are sending (can be ERC20 or ERC721).
   * @param kind Type od the token we are sending: 0 - ERC20, 1 - ERC721.
   * @param from Address of the sender.
   * @param to Address of the receiver.
   * @param value Amount of ERC20 or ID of ERC721.
   */
  struct TransferData 
  {
    address token;
    TokenKind kind; // Check other options like ERC165 or checking methods that exists.
    address from;
    address to;
    uint256 value;
  }

  /**
   * @dev Structure representing the signature parts.
   * @param r ECDSA signature parameter r.
   * @param s ECDSA signature parameter s.
   * @param v ECDSA signature parameter v.
   * @param kind Type of signature: 0 - eth_sign, 1 - trezor, 2 - EIP712. 
   */
  struct SignatureData
  {
    bytes32 r;
    bytes32 s;
    uint8 v;
    SignatureKind kind;
  }

  /**
   * @dev Structure representing the data needed to do the swap.
   * @param maker Address of the one that made the claim.
   * @param taker Address of the one that is executing the claim.
   * @param transfers Data of all the transfers that should accure it this swap.
   * @param signature Data from the signed claim.
   * @param seed Arbitrary number to facilitate uniqueness of the order's hash. Usually timestamp.
   * @param expiration Timestamp of when the claim expires. 0 if indefinet. 
   */
  struct SwapData 
  {
    address maker;
    address taker;
    TransferData[] transfers;
    SignatureData signature;
    uint256 seed;
    uint256 expiration;
  }

  constructor () 
    public
  {

  }

}