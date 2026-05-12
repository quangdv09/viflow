/*----------------------------------------------------------
ViFlow - The Cross platform Open source Vietnamese Keyboard application.

Copyright (C) 2019 Mai Vu Tuyen
Contact: maivutuyen.91@gmail.com
Github: https://github.com/quangdv09/viflow
Fanpage: https://github.com/quangdv09/viflow

This file is belong to the ViFlow project, Win32 version
which is released under GPL license.
You can fork, modify, improve this program. If you
redistribute your new version, it MUST be open source.
-----------------------------------------------------------*/
#include "ViFlowManager.h"
#include <shlobj.h>

static vector<LPCTSTR> _inputType = {
	_T("Telex"),
	_T("VNI"),
	_T("Simple Telex"),
};

static vector<LPCTSTR> _tableCode = {
	_T("Unicode"),
	_T("TCVN3 (ABC)"),
	_T("VNI Windows"),
	_T("Unicode Tổ hợp"),
	_T("Vietnamese Locale CP 1258")
};

/*-----------------------------------------------------------------------*/

extern void ViFlowInit();
extern void ViFlowFree();

unsigned short  ViFlowManager::_lastKeyCode = 0;

vector<LPCTSTR>& ViFlowManager::getInputType() {
	return _inputType;
}

vector<LPCTSTR>& ViFlowManager::getTableCode() {
	return _tableCode;
}

void ViFlowManager::initEngine() {
	ViFlowInit();
}

void ViFlowManager::freeEngine() {
	ViFlowFree();
}

bool ViFlowManager::checkUpdate(string& newVersion) {
	wstring dataW = ViFlowHelper::getContentOfUrl(L"https://raw.githubusercontent.com/quangdv09/viflow/main/version.json");
	string data = wideStringToUtf8(dataW);

	//simple parse
	constexpr char versionNameStr[] = "\"versionName\":";
	constexpr char versionCodeStr[] = "\"versionCode\":";
	constexpr char numbers[] = "0123456789";
	size_t posBegin = string::npos;
	size_t posEnd = string::npos;

	posBegin = data.find("latestWinVersion");
	posBegin = data.find(versionNameStr, posBegin);
	posBegin += (sizeof(versionNameStr) - 1);
	posBegin = data.find('\"', posBegin);
	posBegin = data.find_first_of(numbers, posBegin);

	posEnd = data.find('\"', posBegin);

	if (posBegin == string::npos || posEnd == string::npos) {
		return false;
	}

	newVersion = data.substr(posBegin, posEnd - posBegin);

	posBegin = posEnd;
	posBegin = data.find(versionCodeStr, posBegin);
	posBegin += (sizeof(versionCodeStr) - 1);

	posEnd = data.find("}", posBegin);

	if (posBegin == string::npos || posEnd == string::npos) {
		return false;
	}

	auto shiftVersion = [](DWORD version) {
		return (version << 16) | (version & 0x00FF00) | (version >> 16 & 0xFF);
		};

	string newVersionCodeStr = data.substr(posBegin, posEnd - posBegin);
	DWORD newVersionCode = (DWORD)atoi(newVersionCodeStr.data());
	newVersionCode = shiftVersion(newVersionCode);

	DWORD currentVersionCode = ViFlowHelper::getVersionNumber();
	currentVersionCode = shiftVersion(currentVersionCode);

	return newVersionCode > currentVersionCode;
}

void ViFlowManager::createDesktopShortcut() {
	CoInitialize(NULL);
	IShellLink* pShellLink = NULL;
	HRESULT hres;
	hres = CoCreateInstance(CLSID_ShellLink, NULL, CLSCTX_ALL,
							IID_IShellLink, (void**)&pShellLink);
	if (SUCCEEDED(hres)) {
		wstring path = ViFlowHelper::getFullPath();
		pShellLink->SetPath(path.c_str());
		pShellLink->SetDescription(_T("ViFlow - Bộ gõ Tiếng Việt"));
		pShellLink->SetIconLocation(path.c_str(), 0);

		IPersistFile* pPersistFile;
		hres = pShellLink->QueryInterface(IID_IPersistFile, (void**)&pPersistFile);

		if (SUCCEEDED(hres)) {
			wchar_t desktopPath[MAX_PATH + 1];
			wchar_t savePath[MAX_PATH + 10];
			SHGetFolderPath(NULL, CSIDL_DESKTOP, NULL, 0, desktopPath);
			wsprintf(savePath, _T("%s\\ViFlow.lnk"), desktopPath);
			hres = pPersistFile->Save(savePath, TRUE);
			pPersistFile->Release();
			pShellLink->Release();
		}
	}
}
