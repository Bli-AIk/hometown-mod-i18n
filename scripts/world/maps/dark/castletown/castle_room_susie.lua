return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 16,
  properties = {
    ["inside"] = true,
    ["music"] = "castletown"
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../assets/sprites/world/castle_town/room_susie.png",
      id = 4,
      name = "bg_image",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 88,
          y = 130,
          width = 481,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 160,
          width = 43,
          height = 249,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 346,
          y = 408,
          width = 220,
          height = 72,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 406,
          width = 152,
          height = 74,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 160,
          width = 44,
          height = 246,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 149,
          y = 160,
          width = 89,
          height = 115,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 250,
          y = 162,
          width = 66,
          height = 46,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 354,
          y = 167,
          width = 141,
          height = 31,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 7,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 480,
          width = 74,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "dark/castletown/castle_2f",
            ["marker"] = "entry_susie"
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 151,
          y = 167,
          width = 85,
          height = 103,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "castle_room_susie.bed"
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 255,
          y = 164,
          width = 58,
          height = 44,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "castle_room_susie.fridge"
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 363,
          y = 157,
          width = 62,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "castle_room_susie.manual_stand"
          }
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 439,
          y = 157,
          width = 52,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "castle_room_susie.clothes_drawer"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 10,
          name = "entry",
          type = "",
          shape = "point",
          x = 307,
          y = 436,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "spawn",
          type = "",
          shape = "point",
          x = 310,
          y = 435,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
