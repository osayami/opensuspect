extends Resource
class_name ItemTemplate

# This class is basically only used to store info about items and to allow
# 	new items to be added to the game in a simple and efficient way

# --Public Variables--
# the name of the item (for ex. "Wrench")
export var itemName: String
# the texture used by the item
export var texture: Texture
# scale to be applied to the texture
export var textureScale: Vector2 = Vector2(1, 1)
# the texture and scale used on the HUD for the item
export var hudTexture: Texture = null
export var hudTextureScale: Vector2 = Vector2(1, 1)
# the texture, scale and rotatation used when picked up
export var pickUpTexture: Texture = null
export var pickUpTextureScale: Vector2 = Vector2(1, 1)
export var pickUpRotation: float = 0

# --Private Variables--


# --Public Functions--
# configure an ItemResource based on this item template
func configureItemResource(itemResource: ItemResource):
	# transfer over general item info to itemResource
	var propertyList: Array = [
		"itemName", "texture", "textureScale", "hudTexture",
		"hudTextureScale", "pickUpTexture", "pickUpTextureScale",
		"pickUpRotation"]
	for property in propertyList:
		itemResource.set(property, get(property))
