#! /bin/bash

SRC_HOME=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
XCS_NAME="CodeSnippets"
XCS_PATH="$(cd "${HOME}/Library/Developer/Xcode/UserData"; pwd)/${XCS_NAME}"

[[ -d "${XCS_PATH}.backup" ]] && mv ${XCS_PATH}.backup ${XCS_PATH}.backup.bk
[[ -d "${XCS_PATH}" ]] && mv ${XCS_PATH} ${XCS_PATH}.backup

ln -s ${SRC_HOME}/${XCS_NAME} ${XCS_PATH}
if [[ $? -ne 0 ]]; then
	[[ -d "${XCS_PATH}.backup" ]] && mv ${XCS_PATH}.backup ${XCS_PATH}
	[[ -d "${XCS_PATH}.backup.bk" ]] && mv ${XCS_PATH}.backup.bk ${XCS_PATH}.backup
	echo -e "\033[31mFailed to setup ${XCS_NAME}.\033[0m"
else
	[[ -d "${XCS_PATH}.backup.bk" ]] && rm -rf ${XCS_PATH}.backup.bk
	echo -e "\033[32mSetup ${XCS_NAME} successfully, please restart Xcode!\033[0m"
fi


