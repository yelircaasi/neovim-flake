local function remove_blank_lines(content)
	content = content:gsub("\n%s-\n", "\n")
	content = content:gsub("^\n+", ""):gsub("\n+$", "\n")
	return content
end

local function compact_blocks(content)
	content = content:gsub(
		"if%s+([^\n]-)%s+then\n%s*([^\n]-)%s*\n%s*else%s*([^\n]-)%s*([^\n]-)%s*end",
		"if %1 then %2 else %3 end"
	)
	content = content:gsub("if%s+([^\n]-)%s*then\n%s*([^\n]-)%s*\n%s*end", "if %1 then %2 end")
	content = content:gsub("function%s*([^\n]-)%s*\n%s*([^\n]-)%s%s-end", "function%1 %2 end")
	content = content:gsub('%{%s*("[^"]*",)', "{ %1")
	content = content:gsub('",\n%s*"', '", "')
	content = content:gsub('",?\n%s*%}', '" }')
	content = content:gsub("%{\n%s*([^\n]+)%s*%}", "{ %1 }")
	content = content:gsub("%{%s*([^\n]+),\n%s+([^\n][^\n]-)%s*%}", "{ %1, %2 }")
	content = content:gsub("\nend%)", " end)")
	content = content:gsub("\n%s*print", "; print")
	content = content:gsub("\n%s*utils%.print", "; utils.print")
	content = content:gsub("([a-z0-9_]+ = [a-z0-9_]+),\n%s*([a-z0-9_]+ = [a-z0-9_]+)", "%1, %2")
	content = content:gsub(";(\n%s*)%(([a-z]+%.[a-z]+)%)%(", "%1%2(")
	content = content:gsub("%(([a-z]+%.[a-z]+)%)%(", "%1(")
	return content
end

local function clean_file(filename, compact)
	local f = io.open(filename, "rb")
	if not f then
		return print("File not found: " .. filename)
	end
	local text = f:read("*all")
	f:close()

	-- remove all blank lines (even those with whitespace)
	text = remove_blank_lines(text)

	-- fold blocks
	if compact then
		text = compact_blocks(text)
	end

	local out = io.open(filename, "wb")
	if out then
		out:write(text)
		out:close()
		print("Cleaned: " .. filename)
	end
end

local target = arg[1]
if target then
	clean_file(target .. "/init.lua", true)
	clean_file(target .. "/meta/plugin_layers.lua", false)
else
	print("Usage: lua clean.lua <filename>")
end
