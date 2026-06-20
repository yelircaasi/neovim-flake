from pathlib import Path
import re

def format_seq(s: str) -> str:
    s =  re.sub(",\\s+", ", ", s).strip("}")
    s = re.sub("\\n\\s+", " <> ", s)
    return s

pattern = re.compile(r'"<leader>.+?"\s*.+?\}', re.DOTALL)
config_dir = Path.home() / "repos/neovim-flake/config_hooks_mirror"
seqs = []
for file in config_dir.rglob("*.lua"):
    try:
        new_seqs = [f"{format_seq(x)} |    {file}" for x in re.findall(pattern, file.read_text())]
    except:
        print(f"Error in {file}")
    seqs.extend(new_seqs)


out = Path.home() / "repos/neovim-flake/scripts/seqs.txt"
out.write_text("\n".join(sorted(seqs)))
