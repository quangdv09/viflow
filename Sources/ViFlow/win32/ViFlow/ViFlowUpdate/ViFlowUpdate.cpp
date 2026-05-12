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

#include "framework.h"
#include "ViFlowUpdate.h"
#include <Urlmon.h>
#include <fstream>
#include <sstream>
#include <string>
#pragma comment(lib, "Urlmon.lib")

using namespace std;

INT_PTR CALLBACK MainDialogProcess(HWND, UINT, WPARAM, LPARAM);
void StartUpdate();
HWND hDlg;
int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

	hDlg = CreateDialogParam(hInstance, MAKEINTRESOURCE(IDD_DIALOG_UPDATER), 0, MainDialogProcess, 0);
	ShowWindow(hDlg, SW_SHOWNORMAL);
 
	MSG msg;
	// Main message loop:
	while (GetMessage(&msg, nullptr, 0, 0)) {
		if (!IsDialogMessage(hDlg, &msg)) {
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}
	return 0;
}

// Message handler for about box.
INT_PTR CALLBACK MainDialogProcess(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
	switch (message) {
	case WM_INITDIALOG:{
		HICON hIcon = LoadIcon(GetModuleHandle(NULL), MAKEINTRESOURCE(IDI_VIFLOWUPDATE));
		if (hIcon) {
			SendMessage(hDlg, WM_SETICON, ICON_BIG, (LPARAM)hIcon);
		}
		StartUpdate();
		return (INT_PTR)TRUE;
	}
    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}

DWORD WINAPI UpdateThreadFunction(LPVOID lpParam) {
	WCHAR path[MAX_PATH];
	WCHAR currentDir[MAX_PATH];
	GetCurrentDirectory(MAX_PATH, currentDir);
	wsprintf(path, TEXT("%s\\_ViFlow.tempf"), currentDir);
	HRESULT res = URLDownloadToFile(NULL, L"https://raw.githubusercontent.com/quangdv09/viflow/main/version.json", path, 0, NULL);

	wstring data;
	if (res == S_OK) {
		std::wifstream t(path);
		std::wstringstream buffer;
		buffer << t.rdbuf();
		t.close();
		DeleteFile(path);
		data = buffer.str();
	} else {
		MessageBox(hDlg, _T("Có lỗi trong quá trình cập nhật, vui lòng thử lại sau!"), _T("ViFlow Update"), MB_OK);
		ExitProcess(0);
		return 0;
	}

	//simple parse
	data = data.substr(data.find(L"latestWinVersion"));
	data = data.substr(data.find(L"\"versionName\":"));
	data = data.substr(14);
	data = data.substr(data.find(L"\""));
	data = data.substr(1);
	wstring versionName = data.substr(0, data.find(L"\""));
	
	//download zip file
	WCHAR updateUrl[MAX_PATH];
	wsprintf(updateUrl, TEXT("https://github.com/quangdv09/viflow/releases/download/%s/ViFlow%s-Windows.zip"),
		versionName.c_str(),
		versionName.c_str());
	wsprintf(path, TEXT("%s\\_ViFlowUpdate.zip"), currentDir);
	res = URLDownloadToFile(NULL, updateUrl, path, 0, NULL);

	if (res == S_OK) {
		//remove old file
		DeleteFile(L"ViFlow64.exe");
		//extract zip file
		WinExec("powershell.exe -NoP -NonI -Command \"Expand-Archive '.\\_ViFlowUpdate.zip' '.\\_ViFlowUpdate'\" ", SW_HIDE);
		Sleep(5000);
		MoveFile(L"_ViFlowUpdate\\ViFlow64.exe", L"ViFlow64.exe");
		DeleteFile(path);
		DeleteFile(L"_ViFlowUpdate\\ViFlowUpdate.exe");
		DeleteFile(L"_ViFlowUpdate\\ViFlow64.exe");
		DeleteFile(L"_ViFlowUpdate\\ViFlow32.exe");
		RemoveDirectory(L".\\_ViFlowUpdate");
		MessageBox(hDlg, _T("Bạn đã cập nhật ViFlow bản mới nhất thành công!"), _T("ViFlow Update"), MB_OK);
		ExitProcess(0);
	} else {
		MessageBox(hDlg, _T("Có lỗi trong quá trình cập nhật, vui lòng thử lại sau!"), _T("ViFlow Update"), MB_OK);
		ExitProcess(0);
	}
	return 0;
}

void StartUpdate() {
	DWORD hThread;
	HANDLE t = CreateThread(
							NULL,                   // default security attributes
							0,                      // use default stack size  
							UpdateThreadFunction,       // thread function name
							0,          // argument to thread function 
							0,                      // use default creation flags 
							&hThread);   // returns the thread identifier 
}