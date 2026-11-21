"""
Script dong goi font tieng Viet hoan chinh vao asset ufont cua Unreal Engine 5.
Khac phuc 100% loi mat dau, o vuong dau hoi <?> do font Cardo goc thieu 64 ky tu tieng Viet.
"""
import struct
import os
import shutil

TOOLS_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.abspath(os.path.join(TOOLS_DIR, "..", ".."))

FONT_SRC_REG = r"C:\Windows\Fonts\times.ttf"
FONT_SRC_BOLD = r"C:\Windows\Fonts\timesbd.ttf"

EXTRACTED_FONT_DIR = os.path.join(TOOLS_DIR, "templates")
BUILD_FONT_DIR = os.path.join(ROOT_DIR, "build", "MarkOfTheDeep", "Content", "__Project", "Art", "Widgets", "HUD", "Textures", "_FONT")

def create_ufont(ttf_path, output_ufont_path):
    with open(ttf_path, "rb") as f:
        ttf_data = f.read()

    ufont_data = bytearray()
    ufont_data.extend(struct.pack("<I", len(ttf_data)))
    ufont_data.extend(ttf_data)
    
    rem = len(ufont_data) % 4
    if rem != 0:
        ufont_data.extend(b"\x00" * (4 - rem))
        
    ufont_data.extend(b"\x00\x00\x00\x00")

    os.makedirs(os.path.dirname(output_ufont_path), exist_ok=True)
    with open(output_ufont_path, "wb") as f:
        f.write(ufont_data)

    print(f"Da tao: {output_ufont_path} ({len(ufont_data):,} bytes)")

def build_fonts():
    os.makedirs(BUILD_FONT_DIR, exist_ok=True)

    create_ufont(FONT_SRC_REG, os.path.join(BUILD_FONT_DIR, "Cardo-Regular.ufont"))
    create_ufont(FONT_SRC_BOLD, os.path.join(BUILD_FONT_DIR, "Cardo-Bold.ufont"))

    for fname in ["Cardo-Regular.uasset", "Cardo-Regular.uexp", "Cardo-Bold.uasset", "Cardo-Bold.uexp"]:
        src = os.path.join(EXTRACTED_FONT_DIR, fname)
        dst = os.path.join(BUILD_FONT_DIR, fname)
        shutil.copy2(src, dst)
        print(f"Da copy: {fname}")

    print("============================================================")
    print("HOAN TAT DONG GOI FONT ASSETS CHO UNREAL ENGINE 5!")
    print("============================================================")

if __name__ == "__main__":
    build_fonts()
