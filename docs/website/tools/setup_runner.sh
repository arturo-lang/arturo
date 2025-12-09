#!/bin/sh
#==================================================
# Arturo Runner Setup
#--------------------------------------------------
# Creates an isolated FreeBSD jail 
# with Arturo + all packages
#==================================================

if [ $# -lt 1 ]; then
    echo "Usage: $0 /path/to/arturo [template_id]"
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/master/backend/arturo master"
    echo "  $0 /path/to/release/backend/arturo"
    echo ""
    echo "If template_id is not provided, it will be derived from the binary path"
    #exit 1
fi

ARTURO_BIN="$1"

if [ ! -f "$ARTURO_BIN" ]; then
    echo "Error: Arturo binary not found at $ARTURO_BIN"
    exit 1
fi

#==================================================
# Determine template ID
#==================================================

if [ -n "$2" ]; then
    TEMPLATE_ID="$2"
else
    # Extract from path
    # e.g., /path/to/BRANCH/backend/arturo -> BRANCH
    TEMPLATE_ID=$(dirname "$ARTURO_BIN" | xargs dirname | xargs basename)
fi

TEMPLATE_NAME="arturo_runner_${TEMPLATE_ID}"

echo "======================================"
echo "Arturo Jail Template Setup"
echo "======================================"
echo "Binary:      $ARTURO_BIN"
echo "Template ID: $TEMPLATE_ID"
echo "Template:    $TEMPLATE_NAME"
echo "======================================"
echo ""

#==================================================
# Clean slate - destroy existing template
#==================================================

echo "Cleaning up existing template (if any)..."
sudo zfs destroy -R zroot/jails/$TEMPLATE_NAME 2>/dev/null && \
    echo "✓ Old template destroyed" || \
    echo "✓ No existing template found"
echo ""

#==================================================
# Create jail filesystem
#==================================================

echo "Creating jail template..."
zfs create zroot/jails/$TEMPLATE_NAME

JAIL_ROOT="/zroot/jails/$TEMPLATE_NAME"

# Create correct directory structure
mkdir -p "$JAIL_ROOT/lib"
mkdir -p "$JAIL_ROOT/usr/lib"
mkdir -p "$JAIL_ROOT/usr/local/lib"
mkdir -p "$JAIL_ROOT/usr/local/bin"
mkdir -p "$JAIL_ROOT/usr/local/share/certs"
mkdir -p "$JAIL_ROOT/bin"
mkdir -p "$JAIL_ROOT/usr/bin"
mkdir -p "$JAIL_ROOT/libexec"
mkdir -p "$JAIL_ROOT/tmp"
mkdir -p "$JAIL_ROOT/root/.arturo"
mkdir -p "$JAIL_ROOT/etc"

#==================================================
# Copy binaries and libraries
#==================================================

cp "$ARTURO_BIN" "$JAIL_ROOT/usr/local/bin/arturo"
cp /bin/sh "$JAIL_ROOT/bin/"
cp /usr/bin/timeout "$JAIL_ROOT/usr/bin/"
cp /usr/local/bin/aha "$JAIL_ROOT/usr/local/bin/"

# Copy all system libraries
cp -a /lib/*.so* "$JAIL_ROOT/lib/" 2>/dev/null
cp -a /usr/lib/*.so* "$JAIL_ROOT/usr/lib/" 2>/dev/null
cp -a /usr/local/lib/*.so* "$JAIL_ROOT/usr/local/lib/" 2>/dev/null
cp /libexec/ld-elf.so.1 "$JAIL_ROOT/libexec/"

# Copy SSL certificates + DNS resolver
# (required for HTTPS & Package installation)
cp /usr/local/share/certs/ca-root-nss.crt "$JAIL_ROOT/usr/local/share/certs/"
cp /etc/resolv.conf "$JAIL_ROOT/etc/"

chmod 1777 "$JAIL_ROOT/tmp"

#==================================================
# Copy examples directory
#==================================================

EXAMPLES_DIR=$(dirname "$ARTURO_BIN" | xargs dirname)/examples
if [ -d "$EXAMPLES_DIR" ]; then
    echo "Copying examples directory..."
    mkdir -p "$JAIL_ROOT/examples"
    cp -r "$EXAMPLES_DIR"/* "$JAIL_ROOT/examples/"
    echo "✓ Examples copied"
fi

#==================================================
# Install all Arturo packages
#==================================================

echo "Fetching package list from pkgr.art..."
PACKAGES=$("$ARTURO_BIN" -e "print keys # {https://pkgr.art/list.art}")

if [ -z "$PACKAGES" ]; then
    echo "Warning: Could not fetch package list, skipping package installation"
else
    echo "Installing all Arturo packages..."
    for pkg in $PACKAGES; do
        # Run jail with network access for package installation
        sudo jail -c name=arturo_setup path=$JAIL_ROOT ip4=inherit \
            exec.start="/bin/sh -c 'HOME=/root LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/arturo -p install $pkg'" \
            exec.stop="" 2>&1 | grep -E "(Installing package|Done|Something went wrong)"
        sudo jail -r arturo_setup 2>/dev/null
    done
fi

#==================================================
# Finalize and create snapshot
#==================================================

# Remove resolv.conf:
# jails should *not* have network access
rm "$JAIL_ROOT/etc/resolv.conf"

# Create ZFS snapshot
zfs snapshot zroot/jails/$TEMPLATE_NAME@clean

echo ""
echo "======================================"
echo "✓ Template jail: $JAIL_ROOT"
echo "✓ Snapshot: zroot/jails/$TEMPLATE_NAME@clean"
echo "======================================"
echo ""
echo "Clone with:"
echo "   sudo zfs clone zroot/jails/$TEMPLATE_NAME@clean zroot/jails/run/<jail_name>"
echo ""