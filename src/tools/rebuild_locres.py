"""
Script tái tạo file MarkOfTheDeep.locres chuẩn Unreal Engine 5 (Locres Version 3)
Hỗ trợ cả chuỗi ASCII và chuỗi ký tự Unicode tiếng Việt (UTF-16LE).
"""
import struct
import json
import os
import sys

TOOLS_DIR = os.path.dirname(os.path.abspath(__file__))
SRC_DIR = os.path.dirname(TOOLS_DIR)
ROOT_DIR = os.path.dirname(SRC_DIR)

def rebuild_locres(
    original_locres_path=os.path.join(TOOLS_DIR, "templates", "MarkOfTheDeep_en.locres"),
    strings_json_path=os.path.join(SRC_DIR, "translated_text", "vi_strings.json"),
    meta_json_path=os.path.join(TOOLS_DIR, "string_meta.json"),
    output_locres_path=os.path.join(ROOT_DIR, "build", "MarkOfTheDeep", "Content", "Localization", "MarkOfTheDeep", "en", "MarkOfTheDeep.locres")
):
    with open(original_locres_path, "rb") as f:
        header_and_keys = f.read(137737)

    with open(strings_json_path, "r", encoding="utf-8") as f:
        strings = json.load(f)

    with open(meta_json_path, "r", encoding="utf-8") as f:
        meta = json.load(f)

    if len(strings) != len(meta):
        raise ValueError(f"So luong chuoi ({len(strings)}) khong khop voi metadata ({len(meta)})!")

    os.makedirs(os.path.dirname(output_locres_path), exist_ok=True)

    out_data = bytearray()
    out_data.extend(header_and_keys)
    out_data.extend(struct.pack("<I", len(strings)))

    for s, ref in zip(strings, meta):
        try:
            ascii_bytes = s.encode("ascii")
            slen = len(ascii_bytes) + 1
            out_data.extend(struct.pack("<i", slen))
            out_data.extend(ascii_bytes)
            out_data.append(0)
        except UnicodeEncodeError:
            u16_bytes = s.encode("utf-16le")
            slen = -(len(s) + 1)
            out_data.extend(struct.pack("<i", slen))
            out_data.extend(u16_bytes)
            out_data.extend(b"\x00\x00")
        
        out_data.extend(struct.pack("<i", ref))

    with open(output_locres_path, "wb") as f:
        f.write(out_data)

    print(f"Build thanh cong: {output_locres_path}")
    print(f"Kich thuoc file: {len(out_data):,} bytes ({len(strings)} chuoi).")

if __name__ == "__main__":
    src_json = sys.argv[1] if len(sys.argv) > 1 else os.path.join(SRC_DIR, "translated_text", "vi_strings.json")
    dst_locres = sys.argv[2] if len(sys.argv) > 2 else os.path.join(ROOT_DIR, "build", "MarkOfTheDeep", "Content", "Localization", "MarkOfTheDeep", "en", "MarkOfTheDeep.locres")
    rebuild_locres(strings_json_path=src_json, output_locres_path=dst_locres)
