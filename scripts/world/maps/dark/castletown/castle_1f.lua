return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 31,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 11,
  nextobjectid = 37,
  backgroundcolor = { 0, 0, 0 },
  properties = {
    ["inside"] = true,
    ["music"] = "castletown"
  },
  tilesets = {
    {
      name = "castle_inside",
      firstgid = 1,
      filename = "../../../tilesets/castle_inside.tsx",
      exportfilename = "../../../tilesets/castle_inside.lua"
    },
    {
      name = "castle_town_bg",
      firstgid = 129,
      filename = "../../../tilesets/castle_town_bg.tsx",
      exportfilename = "../../../tilesets/castle_town_bg.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 31,
      height = 12,
      id = 1,
      name = "tiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 88, 89, 89, 89, 89, 89, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 75, 76, 77, 78, 79, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 89, 89, 89, 89, 89, 89, 89, 90, 3, 91, 92, 93, 94, 95, 6, 88, 89, 89, 89, 89, 89, 89, 89, 0, 0, 0, 0,
        0, 0, 0, 0, 54, 12, 13, 14, 15, 16, 54, 18, 3, 107, 108, 109, 110, 111, 5, 2, 7, 8, 9, 10, 11, 54, 22, 0, 0, 0, 0,
        0, 0, 0, 0, 54, 28, 29, 30, 31, 32, 4, 5, 35, 123, 124, 125, 126, 127, 37, 3, 23, 24, 25, 26, 27, 6, 54, 0, 0, 0, 0,
        0, 0, 0, 0, 22, 54, 45, 46, 47, 38, 39, 18, 70, 73, 86, 84, 87, 73, 71, 2, 54, 40, 41, 42, 38, 39, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 36, 20, 61, 62, 63, 20, 36, 21, 82, 82, 82, 82, 82, 82, 82, 19, 20, 56, 57, 58, 36, 20, 20, 0, 0, 0, 0,
        0, 0, 0, 0, 70, 72, 86, 82, 87, 72, 73, 74, 52, 82, 82, 82, 82, 82, 82, 72, 73, 86, 82, 87, 72, 73, 71, 0, 0, 0, 0,
        0, 0, 0, 0, 82, 82, 82, 82, 52, 82, 82, 82, 82, 82, 82, 82, 82, 82, 68, 82, 82, 82, 82, 82, 82, 82, 66, 0, 0, 0, 0,
        0, 0, 0, 0, 82, 52, 82, 82, 82, 82, 82, 68, 82, 82, 82, 82, 82, 52, 82, 82, 82, 82, 68, 82, 82, 82, 82, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 82, 82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 82, 82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects_decor_above",
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
          x = 520,
          y = 400,
          width = 200,
          height = 160,
          rotation = 0,
          gid = 168,
          visible = false,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 10,
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
          id = 33,
          name = "spawn",
          type = "",
          shape = "point",
          x = 619,
          y = 434,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "entry",
          type = "",
          shape = "point",
          x = 619,
          y = 434,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "entry_bf",
          type = "",
          shape = "point",
          x = 899,
          y = 314,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "entry_2f",
          type = "",
          shape = "point",
          x = 299,
          y = 314,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
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
          id = 22,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 968,
          y = 205,
          width = 63,
          height = 74,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.dark.castletown.bf_living_quarters_bad_guys}"
          }
        },
        {
          id = 23,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 582,
          y = 126,
          width = 82,
          height = 72,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.dark.castletown.door_locked}"
          }
        },
        {
          id = 24,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 370,
          y = 206,
          width = 58,
          height = 73,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.dark.castletown.2f_living_quarters}"
          }
        },
        {
          id = 25,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 480,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "dark/castletown/castle_front",
            ["marker"] = "entry_1f"
          }
        },
        {
          id = 26,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 857,
          y = 241,
          width = 85,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "dark/castletown/castle_dungeon",
            ["marker"] = "entry",
            ["sound"] = "escaped"
          }
        },
        {
          id = 27,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 238,
          width = 91,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "dark/castletown/castle_2f",
            ["marker"] = "entry",
            ["sound"] = "escaped"
          }
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 352,
          width = 120,
          height = 112,
          rotation = 0,
          gid = 171,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 568,
          y = 310,
          width = 102,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "castle_1f.cauldron"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
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
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 479,
          y = 126,
          width = 283,
          height = 74,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 189,
          width = 99,
          height = 91,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 342,
          y = 189,
          width = 137,
          height = 92,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 238,
          width = 102,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 90,
          y = 278,
          width = 70,
          height = 122,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 400,
          width = 400,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 940,
          y = 190,
          width = 143,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 276,
          width = 71,
          height = 124,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 400,
          width = 400,
          height = 81,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 568,
          y = 310,
          width = 102,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
