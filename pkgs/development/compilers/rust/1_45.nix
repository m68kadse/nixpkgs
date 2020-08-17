# New rust versions should first go to staging.
# Things to check after updating:
# 1. Rustc should produce rust binaries on x86_64-linux, aarch64-linux and x86_64-darwin:
#    i.e. nix-shell -p fd or @GrahamcOfBorg build fd on github
#    This testing can be also done by other volunteers as part of the pull
#    request review, in case platforms cannot be covered.
# 2. The LLVM version used for building should match with rust upstream.
# 3. Firefox and Thunderbird should still build on x86_64-linux.

{ stdenv, lib
, buildPackages
, newScope, callPackage
, CoreFoundation, Security
, llvmPackages_5
, pkgsBuildTarget, pkgsBuildBuild
} @ args:

import ./default.nix {
  rustcVersion = "1.45.0";
  rustcSha256 = "0z6dh0yd3fcm3qh960wi4s6fa6pxz9mh77psycsqfkkx5kqra15s";

  # Note: the version MUST be one version prior to the version we're
  # building
  bootstrapVersion = "1.44.1";

  # fetch hashes by running `print-hashes.sh 1.45.0`
  bootstrapHashes = {
    i686-unknown-linux-gnu = "e69689b0a1b66599cf83e7dd54f839419007e44376195e93e301a3175da3d854";
    x86_64-unknown-linux-gnu = "a41df89a461a580536aeb42755e43037556fba2e527dd13a1e1bb0749de28202";
    arm-unknown-linux-gnueabihf = "ea18ccdfb62a153c2d43d013fdec56993cc9267f1cdc6f3834df8a2b9b468f08";
    armv7-unknown-linux-gnueabihf = "d44294732cf268ea84908f1135f574ab9489132a332eaa9d5bda547374b15d54";
    aarch64-unknown-linux-gnu = "a2d74ebeec0b6778026b6c37814cdc91d14db3b0d8b6d69d036216f4d9cf7e49";
    x86_64-apple-darwin = "a5464e7bcbce9647607904a4afa8362382f1fc55d39e7bbaf4483ac00eb5d56a";
  };

  selectRustPackage = pkgs: pkgs.rust_1_45;

  rustcPatches = [
  ];
}

(builtins.removeAttrs args [ "fetchpatch" ])
