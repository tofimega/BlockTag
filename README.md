# BlockTag: A serialization format written in GDScript for fun

Currently only parses

## Format:
  A BlockTag formatted file describes a tree of data similar to json or xml.
  
  The data is formatted into a series of BLOCKS, each containing data of some kind:
- It could be an integer:
  - `[look_at_this_int 1]`
- A float:
  - `[whoa_decimal 1.0]`
  - `[commas_are_also_supported 1,0]`
- A string:
  - `[s1 "quotation marks need to be \" escaped"]`
  - `[s2 square brackets only need to be \[ \] escaped here also leading and trailing whitespaces are ignored                     ]`
- Or another Block:
  - `[block1 [block2 block3 but i am a string actually]]`

An empty Block is called a TAG. In this case the presence (or absence) of a given tag represents a boolean value:
- `[i_am_true]`
  
Empty TAGS are ignored:

- `[]` <- this does literally nothing


See example.txt for more details
