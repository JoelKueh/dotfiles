
# Wine Configuration Tips

## Font Trick

```bash
wine reg add 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\FontSubstitutes' \
    /v 'MS Shell Dlg 2' /t REG_SZ /d 'Noto Sans' /f
wine reg add 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\FontSubstitutes' \
    /v 'MS Shell Dlg 2' /t REG_SZ /d 'Noto Sans' /f
```
