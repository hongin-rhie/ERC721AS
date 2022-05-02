// SPDX-License-Identifier: MIT
// Creator: MoeKun, JayB
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

interface IERC721AS is IERC721, IERC721Metadata {
    /**
     * The caller must own the token or be an approved operator.
     */
    error ApprovalCallerNotOwnerNorApproved();

    /**
     * The token does not exist.
     */
    error ApprovalQueryForNonexistentToken();

    /**
     * The token does not exist.
     */
    error URIQueryForNonexistentToken();

    /**
     * The token does not exist.
     */
    error OwnerQueryForNonexistentToken();

    /**
     * The caller cannot approve to their own address.
     */
    error ApproveToCaller();

    /**
     * The caller cannot approve to the current owner.
     */
    error ApprovalToCurrentOwner();

    /**
     * Cannot query the balance for the zero address.
     */
    error BalanceQueryForZeroAddress();

    /**
     * Cannot mint to the zero address.
     */
    error MintToZeroAddress();

    /**
     * The quantity of tokens minted must be more than zero.
     */
    error MintZeroQuantity();

    /**
     * The caller must own the token or be an approved operator.
     */
    error TransferCallerNotOwnerNorApproved();

    /**
     * The token must be owned by `from`.
     */
    error TransferFromIncorrectOwner();

    /**
     * Cannot safely transfer to a contract that does not implement the ERC721Receiver interface.
     */
    error TransferToNonERC721ReceiverImplementer();

    /**
     * Cannot transfer to the zero address.
     */
    error TransferToZeroAddress();

    /**
     * The token does not exist.
     */
    error SchoolingQueryForNonexistentToken();

    // Compiler will pack this into a single 256bit word.
    struct TokenStatus {
        // The address of the owner.
        address owner;
        // Keeps track of the latest time User toggled schooling.
        uint48 schoolingTimestamp;
        // Keeps track of the total time of schooling.
        uint32 schoolingTotal;
        // Whether the token has been burned.
        bool burned;
    }

    // Compiler will pack this into a single 256bit word.
    struct SchoolingPolicy {
        uint64 alpha;
        uint64 beta;
        uint32 breaktime;
        uint48 schoolingBegin;
        uint48 schoolingEnd;
    }

    /**
     * @dev Returns total schooling time.
     */
    function schoolingTotal(uint256 tokenId) external view returns (uint256);

    /**
     * @dev Returns latest change time of schooling status.
     */
    function schoolingTimestamp(uint256 tokenId)
        external
        view
        returns (uint256);

    /**
     * @dev Returns whether token is schooling or not.
     */
    function isTakingBreak(uint256 tokenId) external view returns (bool);

    /**
     * @dev Returns time when schooling begin
     */
    function schoolingBegin() external view returns (uint256);

    /**
     * @dev Returns time when schooling end
     */
    function schoolingEnd() external view returns (uint256);

    /**
     * @dev Sets the time period which blocks users from transfering their tokens.
     * @dev Will stay on current grade until time goes by.
     */
    function schoolingBreaktime() external view returns (uint256);

    /**
     * @dev Returns the total amount of tokens stored by the contract.
     * @dev Burned tokens are calculated here, use _totalMinted() if you want to count just minted tokens.
     */
    function totalSupply() external view returns (uint256);
}