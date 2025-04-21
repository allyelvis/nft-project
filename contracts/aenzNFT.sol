// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title AenzbiNFT
  * @dev Auto-maintainable and clean ERC721 NFT with IPFS integration and royalty support.
   */
   contract AenzbiNFT is ERC721URIStorage, Ownable {
        uint256 private _tokenIdCounter;
            address private _royaltyReceiver;
                uint96 private _royaltyFee; // Basis points (1000 = 10%)

                    constructor() ERC721("Aenzbi: Future City NFT", "AENZ") Ownable(msg.sender) {
                                _royaltyReceiver = msg.sender;
                                        _royaltyFee = 500; // Default 5%
                    }

                        /**
                             * @notice Mint a new NFT with IPFS-hosted metadata
                                  * @param recipient Address to receive the NFT
                                       * @param ipfsCID Content Identifier (CID) for metadata.json
                                            * @return tokenId The ID of the minted NFT
                                                 */
                                                     function mint(address recipient, string memory ipfsCID) public onlyOwner returns (uint256 tokenId) {
                                                                tokenId = _tokenIdCounter;
                                                                        _mint(recipient, tokenId);
                                                                                _setTokenURI(tokenId, string(abi.encodePacked("ipfs://", ipfsCID)));
                                                                                        _tokenIdCounter++;
                                                     }

                                                         /**
                                                              * @notice Update metadata for an existing NFT
                                                                   * @param tokenId The token ID
                                                                        * @param ipfsCID The new IPFS CID
                                                                             */
                                                                                 function updateMetadata(uint256 tokenId, string memory ipfsCID) public onlyOwner {
                                                                                            _setTokenURI(tokenId, string(abi.encodePacked("ipfs://", ipfsCID)));
                                                                                 }

                                                                                     /**
                                                                                          * @notice Get royalty details according to EIP-2981 (optional external usage)
                                                                                               * @param salePrice Sale amount
                                                                                                    * @return receiver Royalty receiver
                                                                                                         * @return amount Royalty amount in wei
                                                                                                              */
                                                                                                                  function royaltyInfo(uint256, uint256 salePrice) public view returns (address receiver, uint256 amount) {
                                                                                                                            amount = (salePrice * _royaltyFee) / 10000;
                                                                                                                                    receiver = _royaltyReceiver;
                                                                                                                  }

                                                                                                                      /**
                                                                                                                           * @notice Set royalty receiver and percentage (max 10%)
                                                                                                                                * @param newReceiver Address to receive royalties
                                                                                                                                     * @param newFee Fee in basis points (e.g., 500 = 5%)
                                                                                                                                          */
                                                                                                                                              function setRoyalty(address newReceiver, uint96 newFee) public onlyOwner {
                                                                                                                                                        require(newFee <= 1000, "Royalty too high");
                                                                                                                                                                _royaltyReceiver = newReceiver;
                                                                                                                                                                        _royaltyFee = newFee;
                                                                                                                                              }

                                                                                                                                                  /**
                                                                                                                                                       * @dev Utility: Returns the chain ID for diagnostics
                                                                                                                                                            */
                                                                                                                                                                function getChainId() public view returns (uint256 id) {
                                                                                                                                                                            assembly {
                                                                                                                                                                                            id := chainid()
                                                                                                                                                                            }
                                                                                                                                                                }

                                                                                                                                                                    /**
                                                                                                                                                                         * @dev Utility: Returns current token counter
                                                                                                                                                                              */
                                                                                                                                                                                  function totalMinted() public view returns (uint256) {
                                                                                                                                                                                            return _tokenIdCounter;
                                                                                                                                                                                  }
   }
                                                                                                                                                                                  }
                                                                                                                                                                            }
                                                                                                                                                                }
                                                                                                                                              }
                                                                                                                  }
                                                                                 }
                                                     }
                    }
   }