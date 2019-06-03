#! /bin/bash

SRC_HOME=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
XCT_SRC_PATH='File Templates'
XCT_SRC_PATH="${SRC_HOME}/${XCT_SRC_PATH}"
XCT_PATH='/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File Templates'

[[ -d "${XCT_SRC_PATH}" ]] || { echo -e "\033[31mNot found xcode templates source path.\033[0m" && exit 1;}
[[ -d "${XCT_PATH}" ]] || { echo -e "\033[31mNot found xcode templates path.\033[0m" && exit 1;}

permission_denied() {
	local text
	text=`$@ 2>&1` && return 0
	if [[ -n "${text}" ]] && [[ "${text}" == *Permission* ]] && [[ "${text}" == *denied* ]]; then
		echo -e "\033[31mSet up templates: Permission denied.\033[0m"	
		echo -e "\033[33mTry again with 'sudo ${BASH_SOURCE[0]}'.\033[0m"		
		exit 1
	fi
	[[ -n "${text}" ]] && echo -e "${text}"
	return 1
}

xcts=`find "${XCT_SRC_PATH}" -name "*.xctemplate"`
success_flag=0
OLD_IFS=${IFS}
IFS=$'\n'
for xct in ${xcts}; do
	[[ -d "${xct}" ]] || continue

	xct_name="${xct##*/}"
	xct_x_path="${xct/${XCT_SRC_PATH}/${XCT_PATH}}"
	xct_x_bk_path="${xct_x_path}_bk"
	xct_x_o_path="${xct_x_path%/*}/Xcode_${xct_name}"

	[[ -d "${xct_x_path}" ]] && permission_denied mv "${xct_x_path}" "${xct_x_bk_path}"

	permission_denied cp -rf "${xct}" "${xct_x_path}"
	if [[ $? -eq 0 ]]; then
		if [[ -d "${xct_x_o_path}" ]]; then
			[[ -d "${xct_x_bk_path}" ]] && rm -rf "${xct_x_bk_path}"
		else
			[[ -d "${xct_x_bk_path}" ]] && mv "${xct_x_bk_path}" "${xct_x_o_path}"
		fi
		echo -e "\033[32mSet up ${xct_name} successfully.\033[0m"
		success_flag=1
	else
		[[ -d "${xct_x_bk_path}" ]] && mv "${xct_x_bk_path}" "${xct_x_path}"
		echo -e "\033[31mFailed to set up ${xct_name}.\033[0m"
	fi
done
IFS=${OLD_IFS}
[[ ${success_flag} -eq 1 ]] && echo -e "\033[33mPlease restart Xcode!\033[0m"



