class_name BlockTagParser
extends Object




static func parse_bt(input: String) -> Dictionary[String, Variant]:

	var rt: Dictionary[String, Variant] = {}
	
	while !input.is_empty():
		input = input.strip_edges()
		assert(input[0]=="[", input[0])
		assert(input[-1]=="]")
		var b: Dictionary[String, String] = _isolate_block(input)
		rt.merge(_create_block(b["block"]))
		input=b["remainder"]
	
	return rt

static func _create_block(input: String) -> Dictionary[String, Variant]:
	if input.is_empty(): return {}
	assert(input[0]=="[")
	assert(input[-1]=="]")
	
	input=input.trim_prefix("[")
	input=input.trim_suffix("]")
	var key: String = RegEx.create_from_string(r'\s*\w*').search(input).get_string()
	
	var rt: Dictionary[String, Variant] = {}
	rt.get_or_add(key.to_lower().strip_edges())
	var val_string: String = input.trim_prefix(key).strip_edges()
	key=key.to_lower().strip_edges()
	if val_string.is_empty(): return rt
	elif val_string.is_valid_int(): rt[key]=val_string.to_int()
	elif val_string.is_valid_float(): rt[key]=val_string.to_float()
	elif val_string.replace(",", ".").is_valid_float(): rt[key]=val_string.to_float()
	elif val_string[0]=="[": rt[key]=parse_bt(val_string)
	else: 
		rt[key]=val_string.replace("\\", "").trim_prefix("\"").trim_suffix("\"")

	return rt


static func _isolate_block(input: String) -> Dictionary[String, String]:
	if input.is_empty(): return {"block": "", "remainder": ""}
	assert(input[0]=="[") #!=[ -> missing open
	var rt: Dictionary[String, String] = {"block" : "[", "remainder" : ""}
	
	var depth: int = 1
	var string_mode: bool=false
	
	var index: int = 1
	while index < input.length():
		if depth==0: break
		rt["block"]+=input[index]
		if input[index]=="\\": 
			rt["block"]+=input[index+1]
			index+=2
			continue
		if string_mode:
			if input[index]=="\"":
				string_mode=false
		else:
			if input[index]=="\"":
				string_mode=true
			if input[index]=="[": depth+=1
			if input[index]=="]": depth-=1
		index+=1
	
	assert(depth==0) #>0 -> missing close
	assert(!string_mode) # string_mode -> missing "
	rt["remainder"]=input.trim_prefix(rt["block"])
	return rt
