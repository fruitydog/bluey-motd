# Directory containing the .cow files
dir="/path/to/cows"

# Get a random .cow file from the directory
file=$(find "$dir" -name "*.cow" | sort -R | head -1)

# Get the base name of the file (without the .cow extension)
base=$(basename "$file" .cow)

# Extract the character name from the base name
# Replace underscores with spaces and remove everything after and including "-px"
character_name=$(echo "$base" | tr '_' ' ' | cut -d '-' -f 1)

# Strip non-alphabetic characters (except spaces) from character_name
character_name=$(echo "$character_name" | sed 's/[^a-zA-Z ]*//g')

# Capitalize the first character of character_name
character_name=$(echo "$character_name" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

# Get system information
HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
UPTIME=$(uptime | awk '{print $3,$4}' | sed 's/,//')
SYS_MAIN_IP=$(ipconfig getifaddr en0)
SYS_PUBLIC_IP=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')
DISK_SPACE=$(df -h | grep ' /$' | awk '{print "Used/Total Disk Space: " $3 "/" $2}')
PACKAGE_UPDATES=$(brew outdated)

# Get RAM information
TOTAL_RAM=$(sysctl hw.memsize | awk '{print $2/1024/1024/1024 " GB"}')
USED_RAM=$(vm_stat | grep 'Pages active:' | awk '{print $3/256/1024 " GB"}')

# Get CPU information
CPU_USAGE=$(top -l 1 | awk '/CPU usage:/ {print $3}' | sed 's/$/%/')

# Combine all information into one variable
ALL_INFO="Hostname: ${HOSTNAME}\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\nCurrent User: ${CURRENT_USER}\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\nUptime: ${UPTIME}\xA0\xA0\xA0\xA0\xA0\n\nSystem Main IP: ${SYS_MAIN_IP}\n\xA0\xA0\xA0\xA0\nSystem Public 
IP: ${SYS_PUBLIC_IP}\xA0\n\n${DISK_SPACE}\xA0\nUsed/Total RAM: ${USED_RAM}/${TOTAL_RAM}\xA0\xA0\xA0\xA0\nCPU Usage: ${CPU_USAGE}\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\n\nPackage Updates: 
${PACKAGE_UPDATES}\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\n"

# Use the random .cow file with cowsay
cowsay_output=$(printf "$ALL_INFO" | cowsay -f "$file")

# Print the cowsay output
echo "$cowsay_output"
echo "\n  ${character_name} wishes you a wonderful day, for real life!  "
