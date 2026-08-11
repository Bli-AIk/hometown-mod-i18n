return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 27,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 18,
  properties = {
    ["border"] = "leaves",
    ["inside"] = true,
    ["light"] = true,
    ["music"] = "deltarune/home"
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../../../assets/sprites/world/maps/hometown/torielhouse/toriel_hallway.png",
      id = 2,
      name = "room",
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
      id = 3,
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
          x = 630,
          y = 118,
          width = 210,
          height = 138,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 232,
          y = 118,
          width = 336,
          height = 138,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 118,
          y = 118,
          width = 52,
          height = 138,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 78,
          y = 118,
          width = 40,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 118,
          y = 334,
          width = 840,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 958,
          y = 118,
          width = 40,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 916,
          y = 118,
          width = 42,
          height = 138,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 8,
          name = "mirror",
          type = "",
          shape = "rectangle",
          x = 270,
          y = 172,
          width = 44,
          height = 78,
          rotation = 0,
          visible = true,
          properties = {
            ["offset"] = "10"
          }
        },
        {
          id = 9,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 478,
          y = 222,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.torielhouse.toriel_hallway.cactus_much_say}"
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 354,
          y = 222,
          width = 102,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "{hometown.torielhouse.toriel_hallway.how_draw_dragons_bottom_drawer}",
            ["text2"] = "{hometown.torielhouse.toriel_hallway.purple_character_cover_dressed}",
            ["text3"] = "{hometown.music_player.text}",
            ["text4"] = "{hometown.torielhouse.toriel_hallway.brother_will_never_return_book}"
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 270,
          y = 216,
          width = 44,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.torielhouse.toriel_hallway.what_call}"
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 170,
          y = 214,
          width = 62,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.torielhouse.toriel_hallway.door_locked}"
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 676,
          y = 224,
          width = 102,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.torielhouse.toriel_hallway.time_read_books_generally}"
          }
        },
        {
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 182,
          width = 76,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["exit_delay"] = 0.3,
            ["facing"] = "down",
            ["map"] = "light/hometown/torielhouse/tor_house",
            ["marker"] = "spawn",
            ["sound"] = "escaped"
          }
        },
        {
          id = 15,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 568,
          y = 214,
          width = 62,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["exit_delay"] = 0.3,
            ["exit_sound"] = "doorclose",
            ["facing"] = "up",
            ["map"] = "light/hometown/torielhouse/kris_room",
            ["marker"] = "entry",
            ["sound"] = "dooropen"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 16,
          name = "spawn",
          type = "",
          shape = "point",
          x = 600,
          y = 286,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "entryeast",
          type = "",
          shape = "point",
          x = 880,
          y = 268,
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
