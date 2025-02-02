#!/bin/bash
echo "Deploying Flap Display Package..."

# Create required directories
mkdir -p /info-beamer-hosted/packages/my_flap_display_package

# Copy files to the package directory
cp -r flap_display_gpio /info-beamer-hosted/packages/my_flap_display_package/
cp -r flap_display /info-beamer-hosted/packages/my_flap_display_package/
cp config.json /info-beamer-hosted/packages/my_flap_display_package/

echo "Deployment complete!"
