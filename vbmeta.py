#2025-03-10
#rhn_1k

import sys
import struct

FLAG_OFFSET = 124
DISABLED_FLAG = 2

if len(sys.argv) != 3:
    print(f"Usage: python {sys.argv[0]} <input_vbmeta> <output_vbmeta>")
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]

try:
    with open(input_file, 'rb') as f:
        data = bytearray(f.read())
except FileNotFoundError:
    print(f"Error: Input file not found at '{input_file}'")
    sys.exit(1)

if len(data) < 256:
    print(f"Error: Input file '{input_file}' is too small to be a valid vbmeta image.")
    sys.exit(1)

original_flags, = struct.unpack_from('<I', data, FLAG_OFFSET)
print(f"Original flags: {original_flags}")

struct.pack_into('<I', data, FLAG_OFFSET, DISABLED_FLAG)
print(f"New flags set to: {DISABLED_FLAG}")

with open(output_file, 'wb') as f:
    f.write(data)

print(f"Successfully patched vbmeta and saved to '{output_file}'.")
