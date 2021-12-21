extends Node

# this autoload manages character nodes and character resources

# --Public Variables--

# path to character scene
const CHARACTER_SCENE_PATH: String = "res://character/character.tscn"
var characterScene: PackedScene = preload(CHARACTER_SCENE_PATH)

# --Private Variables--



# _characterNodes and _characterResources are private variables because only this 
# 	script should be editing them

# stores character nodes keyed by network id
# {<network id>: <character node>}
var _characterNodes: Dictionary = {}

# stores character resources keyed by network id
# {<network id>: <character resource>}
var _characterResources: Dictionary = {}

# --Public Functions--

# create a new character for the given network id
# returns the character resource because I think it would be more useful than
# 	the character node - TheSecondReal0
func createCharacter(networkId: int) -> CharacterResource:
	# create character node and resource
	var characterNode: Node = _createCharacterNode(networkId)
	var characterResource: CharacterResource = _createCharacterResource(networkId)
	
	# assign character nodes and resources to each other
	characterNode.setCharacterResource(characterResource)
	characterResource.setCharacterNode(characterNode)
	
	# register character node and resource
	registerCharacterNode(networkId, characterNode)
	registerCharacterResource(networkId, characterResource)
	
	#return character resource
	return characterResource

# add a character node to the characterNodes dictionary
func registerCharacterNode(id: int, characterNode: Node):
	# if there is already a character node for this network id
	if id in _characterNodes:
		# throw an error
		printerr("Registering a character node that already exists, network id: ", id)
	_characterNodes[id] = characterNode

# add a character resource to the characterResources dictionary
func registerCharacterResource(id: int, characterResource: CharacterResource):
	# if there is already a character node for this network id
	if id in _characterNodes:
		# throw an error
		printerr("Registering a character node that already exists, network id: ", id)
	_characterResources[id] = characterResource

# get character node for the input network id
func getCharacterNode(id: int) -> Node:
	# if there is no character node corresponding to this network id
	if not id in _characterNodes:
		# throw an error
		printerr("Trying to get a nonexistant character node with network id ", id)
		# crash the game (if running in debug mode) to assist with debugging
		assert(false)
		# if running in release mode, return null
		return null
	return _characterNodes[id]

# get character resource for the input network id
func getCharacterResource(id: int) -> CharacterResource:
	# if there is no character node corresponding to this network id
	if not id in _characterResources:
		# throw an error
		printerr("Trying to get a nonexistant character resource with network id ", id)
		# crash the game (if running in debug mode) to assist with debugging
		assert(false)
		# if running in release mode, return null
		return null
	return _characterResources[id]

func getCharacterNodes() -> Dictionary:
	return _characterNodes

func getCharacterResources() -> Dictionary:
	return _characterResources

# --Private Functions--

# create a character node, this function is used when creating a new character
func _createCharacterNode(networkId: int = -1) -> Node:
	# instance character scene
	var characterNode: Node = characterScene.instance()
	# set its network id
	characterNode.networkId = networkId
	# here is where we would set its player name, but that is not implemented yet
	return characterNode

# create a character resource, this function is used when creating a new character
func _createCharacterResource(networkId: int = -1) -> CharacterResource:
	# instance a new CharacterResource object
	var characterResource: CharacterResource = CharacterResource.new()
	# set its network id
	characterResource.networkId = networkId
	# here is where we would set its player name, but that is not implemented yet
	return characterResource
