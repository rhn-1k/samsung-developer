# Samsung Galaxy Developer Tools

repository provides automated Github Actions workflows to prepare your Samsung device for development stuff.


## How to Use

1. Fork this repository
2. Go to the "Actions" tab in your forked repository.
3. Choose the workflow you want to run.


# 1. To Patch `recovery.img` (Enable `fastbootd mode`)

1.  Select the "RECOVERY" workflow.
2.  Click "Run workflow".
3.  Paste the direct download link for your stock `recovery.img` into the **`RECOVERY_URL`** field.
4.  Click the green "Run workflow" button.

`fastbootd-recovery.tar` file will be available in the Artifacts, Flash it in Odin's `AP` slot.

**`please make sure the file inside the tar ends with .img, if not just extract it and flash normally.`**

# To Patch `vbmeta.img` (Disable dm-verity)

This workflow disables `dm-verity` and Android Verified Boot, allowing you to boot modified partitions without security errors like bootloop due to dm-verity fail.

1.  Select "VBMeta" workflow.
2.  Click "Run workflow".
3.  Paste your stock vbmeta download in the field (should be direct link).
4.  Click the green "Run workflow".


`patched_vbmeta.tar` file will be available in the Artifacts, Flash it in Odin's `AP` slot.

`please make sure the file inside the tar ends with .img, if not just extract it and flash normally`

## Disclaimer

You are only who responsible for any actions you take. Always back up your stock firmware before proceeding.

# Credits

@phhusson original reverse engineering code developer.

@ravindu644 patches for more devices.
