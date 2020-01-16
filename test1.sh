declare -a group_output_array
declare -a root_user_array
declare -a user_name

 

uid_min="$(grep -E '^UID_MIN' /etc/login.defs)"
min_uid_value=$(echo "$uid_min" | (grep -Eo '[0-9]*'))
uid_max="$(grep -E '^UID_MAX' /etc/login.defs)"
max_uid_value=$(echo "$uid_max" | (grep -Eo '[0-9]*'))

 

mapfile -t group_output_array < <( getent group sudo )  
mapfile -t root_user_array < <( getent passwd 0)

 

for element in "${group_output_array[@]}"
do
 temp=("$(cut -d':' -f4 <<<"$element")")
if [[ $temp == *","* ]]; then
 IFS=',' # space is set as delimiter
read -ra ADDR <<< "$temp" 
for i in "${ADDR[@]}"; do 
   user_name+=("$i")
done
else
user_name+=("$temp")
fi
done

 

for element in "${root_user_array[@]}"
do
user_name+=("$(cut -d':' -f1 <<<"$element")")
done
 for i in "${user_name[@]}"; do 
 if [ ! -z "$i" ]; then 
    #id "$i" >> userIdOutput;
    mapfile -t userIdOutput < <( id "$i")  
    IFS=' ' read -ra NAMES <<< "$userIdOutput" 
    userID=$(echo "${NAMES[0]}" | (grep -Eo '[0-9]*'))
     if [ $userID -ge $min_uid_value  -a $userID -le $max_uid_value ]; then 
        filtered_user_name+=("$i")
     fi
  fi
 
done
echo "${filtered_user_name[@]}"
echo "Local user Section Ends"
mapfile -t sudousers < <( ls /etc/sudoers.d )
  echo "${sudousers[@]}"