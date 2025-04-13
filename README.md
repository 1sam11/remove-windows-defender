# 🛡️ Remove Windows Defender (Win 7, 10, 11)

This batch script disables and removes Microsoft Windows Defender and related components such as real-time scanning, scheduled tasks, drivers, telemetry (SpyNet), and antivirus UI from the Windows Security app.

> ⚠️ For educational/lab use only. Not recommended for production or internet-connected systems.

---

## 🔧 Features

- Disables Defender real-time protection
- Removes Defender scheduled tasks
- Deletes associated services and drivers
- Removes context menu scan entries
- Disables Defender definition updates and telemetry (SpyNet)
- Hides Antivirus section from Windows Security app
- Fully compatible with **Windows 7**, **10**, and **11**

---

## 🚀 Usage

1. Download or clone this repository
2. Right-click `remove_defender_compatible.bat` → **Run as Administrator**
3. Reboot your system after completion

---

## ⚠️ Disclaimer

This script disables core antivirus functionality. Use only in controlled lab environments or virtual machines. Always create a backup or system restore point beforehand.

---

## 📄 License

Licensed under the [MIT License](LICENSE).
