# Samsung Recovery Patcher

This script uses GitHub Actions to patch a Samsung recovery image.

## How to Use

1.  **Add files to your repository:**
    *   `run.sh`
    *   `magiskboot`
    *   `avbtool`
    *   `.github/workflows/recovery.yml`

2.  **Run the workflow:**
    *   Go to the "Actions" tab.
    *   Run the "Patch Recovery" workflow.
    *   Provide the direct download link for your Samsung firmware's `recovery.img` in the `RECOVERY_URL` field.

The workflow will patch the recovery image and upload it as a `fastbootd-recovery.tar` file, which you can then download and flash.