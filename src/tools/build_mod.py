"""
Script tự động hóa quy trình Build toàn bộ Mod Việt hóa cho Mark of the Deep.
Tự động biên dịch locres, tạo font asset và đóng gói ra file pakchunk0-VietHoa_P.pak.
Author: Diiexe (https://github.com/diiexe)
"""
import os
import sys
import subprocess
import shutil

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SRC_DIR = os.path.join(ROOT_DIR, "src")
TOOLS_DIR = os.path.join(SRC_DIR, "tools")
DIST_DIR = os.path.join(ROOT_DIR, "dist")
BUILD_DIR = os.path.join(ROOT_DIR, "build")

def main():
    print("================================================================")
    print(" BẮT ĐẦU QUY TRÌNH BUILD MOD VIỆT HÓA: MARK OF THE DEEP")
    print("================================================================")

    # 1. Tao thu muc build tam thoi
    loc_dir = os.path.join(BUILD_DIR, "MarkOfTheDeep", "Content", "Localization", "MarkOfTheDeep")
    loc_en_dir = os.path.join(loc_dir, "en")
    font_dir = os.path.join(BUILD_DIR, "MarkOfTheDeep", "Content", "__Project", "Art", "Widgets", "HUD", "Textures", "_FONT")
    
    os.makedirs(loc_en_dir, exist_ok=True)
    os.makedirs(font_dir, exist_ok=True)
    os.makedirs(DIST_DIR, exist_ok=True)

    # 2. Bien dich Locres
    print("[1/4] Đang biên dịch file nhị phân ngôn ngữ MarkOfTheDeep.locres...")
    sys.path.insert(0, TOOLS_DIR)
    import rebuild_locres
    
    vi_json = os.path.join(SRC_DIR, "translated_text", "vi_strings.json")
    meta_json = os.path.join(TOOLS_DIR, "string_meta.json")
    locres_out = os.path.join(loc_en_dir, "MarkOfTheDeep.locres")
    
    # Locmeta
    locmeta_src = os.path.join(TOOLS_DIR, "MarkOfTheDeep.locmeta")
    if os.path.exists(locmeta_src):
        shutil.copy2(locmeta_src, os.path.join(loc_dir, "MarkOfTheDeep.locmeta"))

    # Rebuild
    orig_locres = os.path.join(TOOLS_DIR, "templates", "MarkOfTheDeep_en.locres")
    rebuild_locres.rebuild_locres(
        original_locres_path=orig_locres,
        strings_json_path=vi_json,
        meta_json_path=meta_json,
        output_locres_path=locres_out
    )

    # 3. Dong goi Font Asset
    print("[2/4] Đang tích hợp bộ Font tiếng Việt đầy đủ vào assets...")
    import build_font_mod
    build_font_mod.BUILD_FONT_DIR = font_dir
    build_font_mod.build_fonts()

    # 4. Repak Pakchunk
    print("[3/4] Đang đóng gói file mod với repak.exe...")
    repak_exe = os.path.join(TOOLS_DIR, "repak.exe")
    pak_out = os.path.join(DIST_DIR, "pakchunk0-VietHoa_P.pak")
    
    cmd = [
        repak_exe, "pack",
        "--version", "V11",
        "--mount-point", "../../../",
        BUILD_DIR,
        pak_out
    ]
    subprocess.run(cmd, check=True)

    # 5. Tao file checksum SHA256
    print("[4/4] Đang tính mã băm SHA256 cho bản phát hành...")
    import hashlib
    with open(pak_out, "rb") as f:
        h = hashlib.sha256(f.read()).hexdigest()
    
    sums_file = os.path.join(DIST_DIR, "SHA256SUMS.txt")
    with open(sums_file, "w", encoding="utf-8") as f:
        f.write(f"{h} *pakchunk0-VietHoa_P.pak\n")

    print(f"SHA256: {h}")
    print("================================================================")
    print(f"[V] HOÀN TẤT BUILD! Thành phẩm đã xuất ra: {pak_out}")
    print("================================================================")

if __name__ == "__main__":
    main()
