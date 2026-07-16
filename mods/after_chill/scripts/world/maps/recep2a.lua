return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 15,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 12,
  nextobjectid = 32,
  properties = {
    ["music"] = "hallway"
  },
  tilesets = {
    {
      name = "Receptionist",
      firstgid = 1,
      filename = "../tilesets/Receptionist.tsx",
      exportfilename = "../tilesets/Receptionist..lua"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../assets/sprites/tilesets/indoors recep bg_1.png",
      id = 2,
      name = "bg",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = -68,
      offsety = -82,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 100, 101, 120 },
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 15,
      id = 1,
      name = "Tile Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 175, 175, 209 },
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 320, 321, 317, 321, 321, 321, 317, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 320, 321, 321, 321, 321, 321, 321, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 320, 321, 317, 321, 321, 321, 317, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 320, 321, 321, 321, 321, 321, 321, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 320, 321, 317, 321, 321, 321, 317, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 320, 321, 321, 321, 321, 321, 321, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 320, 321, 321, 321, 321, 321, 321, 321, 322, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 263, 264, 264, 264, 264, 264, 264, 264, 264, 264, 32, 32, 32, 33, 0,
        0, 0, 0, 0, 0, 282, 283, 283, 283, 283, 283, 283, 283, 283, 283, 51, 51, 51, 52, 0,
        0, 0, 0, 0, 0, 282, 283, 283, 283, 283, 283, 283, 283, 283, 283, 51, 51, 51, 52, 0,
        0, 0, 0, 0, 0, 282, 283, 283, 283, 283, 283, 283, 283, 283, 283, 51, 51, 51, 284, 0,
        0, 0, 0, 0, 0, 301, 302, 302, 282, 283, 283, 283, 284, 302, 302, 302, 302, 302, 71, 0,
        0, 0, 0, 0, 0, 339, 340, 340, 282, 283, 283, 283, 284, 340, 340, 226, 226, 226, 109, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 282, 283, 283, 283, 284, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 282, 283, 283, 283, 284, 0, 0, 0, 0, 0, 0, 0
      }
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
          x = 200,
          y = 240,
          width = 440,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 440,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 480,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 440,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 440,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 280,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 642,
          y = 239.667,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760.615,
          y = 284,
          width = 40,
          height = 155,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 642.25,
          y = 441.5,
          width = 160,
          height = 40,
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
          id = 9,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 595,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "recep2",
            ["marker"] = "entranceB"
          }
        },
        {
          id = 10,
          name = "chest",
          type = "",
          shape = "point",
          x = 723,
          y = 359,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "honey_drop"
          }
        },
        {
          id = 24,
          name = "forcefield",
          type = "",
          shape = "rectangle",
          x = 643,
          y = 279,
          width = 38,
          height = 159,
          rotation = 0,
          visible = true,
          properties = {
            ["cond"] = "not (Game:getFlag(\"heart_solved\", 0) >= 1)"
          }
        },
        {
          id = 25,
          name = "heartbutton",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 339.5,
          width = 37,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["button_id"] = 1
          }
        },
        {
          id = 26,
          name = "heartbutton",
          type = "",
          shape = "rectangle",
          x = 420,
          y = 339.5,
          width = 37,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["button_id"] = 2
          }
        },
        {
          id = 27,
          name = "heartbutton",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 339.5,
          width = 40,
          height = 40.5,
          rotation = 0,
          visible = true,
          properties = {
            ["button_id"] = 3
          }
        },
        {
          id = 28,
          name = "heartscreen",
          type = "",
          shape = "rectangle",
          x = 351.66,
          y = 136,
          width = 30,
          height = 10,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "hideparty",
          type = "",
          shape = "rectangle",
          x = 237,
          y = 280,
          width = 363,
          height = 158,
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
      name = "objects_party",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "controllers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
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
          id = 8,
          name = "entranceA",
          type = "",
          shape = "point",
          x = 422,
          y = 543,
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
