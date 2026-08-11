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
  nextlayerid = 9,
  nextobjectid = 30,
  properties = {
    ["border"] = "leaves",
    ["inside"] = true,
    ["light"] = true,
    ["music"] = "deltarune/home",
    ["name"] = "Kris's Room"
  },
  tilesets = {
    {
      name = "hometownobjects",
      firstgid = 1,
      filename = "../../../../../tilesets/hometownobjects.tsx",
      exportfilename = "../../../../../tilesets/hometownobjects.lua"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../../../assets/sprites/world/maps/hometown/torielhouse/kris_room.png",
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
      id = 6,
      name = "objects_room_night",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
          width = 640,
          height = 480,
          rotation = 0,
          gid = 78,
          visible = true,
          properties = {
            ["night"] = 1
          }
        }
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
          x = 80,
          y = 400,
          width = 210,
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
          x = 250,
          y = 440,
          width = 40,
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
          x = 40,
          y = 80,
          width = 40,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 40,
          width = 520,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 40,
          width = 40,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 370,
          y = 400,
          width = 190,
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
          x = 370,
          y = 440,
          width = 40,
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
      name = "objects_party",
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
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 190,
          y = 200,
          width = 82,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.torielhouse.kris_room.old_school_embarrassing_haircut}"
          }
        },
        {
          id = 9,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 378,
          y = 200,
          width = 82,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.torielhouse.kris_room.nothing_useful_drawer}"
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 160,
          width = 106,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["nighttext1"] = "{hometown.torielhouse.kris_room.quiet_night_outside}",
            ["solid"] = true,
            ["text1"] = "{hometown.torielhouse.kris_room.beautiful_day_outside}",
            ["text2"] = "{hometown.music_player.text}",
            ["text3"] = "{hometown.torielhouse.kris_room.felt_strange_feeling_judgement}"
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 196,
          width = 100,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "hometown.asriel_bed",
            ["solid"] = true
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 466,
          y = 200,
          width = 94,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "{hometown.torielhouse.kris_room.underneath_bed_old_cartridge_cat}",
            ["text2"] = "{hometown.torielhouse.kris_room.catti_catty_can_seen_faintly}"
          }
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 470,
          y = 390,
          width = 74,
          height = 60,
          rotation = 0,
          gid = 34,
          visible = true,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 466,
          y = 274,
          width = 92,
          height = 76,
          rotation = 0,
          gid = 35,
          visible = true,
          properties = {
            ["day"] = 1
          }
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 86,
          y = 400,
          width = 106,
          height = 64,
          rotation = 0,
          gid = 37,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 90,
          y = 366,
          width = 92,
          height = 34,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "{hometown.torielhouse.kris_room.computers_desktop_folder_called_epic}",
            ["text2"] = "{hometown.torielhouse.kris_room.poorly_drawn_design_game}",
            ["text3"] = "{hometown.torielhouse.kris_room.seems_last_boss_creature_giant}",
            ["text4"] = "{hometown.torielhouse.kris_room.doesnt_seem_like_game_ever}"
          }
        },
        {
          id = 17,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 486,
          y = 354,
          width = 58,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.torielhouse.kris_room.cage}"
          }
        },
        {
          id = 18,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 532,
          y = 322,
          width = 24,
          height = 28,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.torielhouse.kris_room.stained}"
          }
        },
        {
          id = 20,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 290,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "light/hometown/torielhouse/toriel_hallway",
            ["marker"] = "spawn"
          }
        },
        {
          id = 27,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 306,
          y = 219,
          width = 40,
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
      id = 7,
      name = "objects_night",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 470,
          y = 390,
          width = 74,
          height = 60,
          rotation = 0,
          gid = 33,
          visible = true,
          properties = {
            ["night"] = 1
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 86,
          y = 400,
          width = 106,
          height = 64,
          rotation = 0,
          gid = 79,
          visible = true,
          properties = {
            ["night"] = 1
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
          id = 19,
          name = "spawn",
          type = "",
          shape = "point",
          x = 330,
          y = 300,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "entry",
          type = "",
          shape = "point",
          x = 330,
          y = 440,
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
      id = 8,
      name = "controllers",
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
          id = 26,
          name = "hometowndaynight",
          type = "",
          shape = "point",
          x = 0,
          y = 0,
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
