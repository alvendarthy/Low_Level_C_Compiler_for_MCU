C_FILE=$1
FILE=${C_FILE%.*}
HARDWARE="mcu/s53"

echo "lex parsing file:" $C_FILE
# ./lexparser src tar
./lexparser $C_FILE  ${FILE}.mcu
echo "lex file:" ${FILE}.mcu " created"

echo "analyse var list file"
# to mcu mode, and get var list
# lua compiler2mcu src tar var_list(auto created)
lua compiler2mcu.lua ${FILE}.mcu ${FILE}.code ${FILE}_var.lua

echo "var list file ok:" ${FILE}_var.lua
echo "compile to specific hardware: " $HARDWARE
# to specific hardware
# lua compiler2hw mcu_type var_list_file( created last step) src tar
lua compiler2hw.lua $HARDWARE ${FILE}_var  ${FILE}.code ${FILE}.s
echo "assembly file ok:" ${FILE}.s
