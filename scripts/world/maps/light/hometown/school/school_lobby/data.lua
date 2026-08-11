return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 47,
  height = 21,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 47,
  properties = {
    ["border"] = "leaves",
    ["light"] = true,
    ["music"] = "deltarune/mus_school"
  },
  tilesets = {
    {
      name = "school",
      firstgid = 1,
      filename = "../../../../../tilesets/school.tsx"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../../../assets/sprites/world/maps/hometown/school/school_lobby.png",
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
      id = 4,
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
          shape = "polygon",
          x = 80,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -40 },
            { x = 40, y = -40 }
          },
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "polygon",
          x = 120,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = -40 },
            { x = 40, y = -40 }
          },
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 400,
          width = 40,
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
          x = 278,
          y = 400,
          width = 522,
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
          x = 760,
          y = 80,
          width = 40,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 80,
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
          x = 840,
          y = 0,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 0,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 80,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 80,
          width = 40,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 400,
          width = 560,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1718,
          y = 400,
          width = 42,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1760,
          y = 400,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 520,
          width = 680,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 560,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 640,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 680,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 680,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 640,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 560,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 520,
          width = 720,
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
      id = 5,
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
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 400,
          width = 78,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["exit_delay"] = 1,
            ["exit_sound"] = "doorclose",
            ["facing"] = "down",
            ["map"] = "light/hometown/school/kris_class",
            ["marker"] = "spawn",
            ["sound"] = "dooropen"
          }
        },
        {
          id = 23,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1640,
          y = 400,
          width = 78,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["exit_delay"] = 1,
            ["exit_sound"] = "doorclose",
            ["facing"] = "down",
            ["map"] = "light/hometown/school/toriel_class",
            ["marker"] = "spawn",
            ["sound"] = "dooropen"
          }
        },
        {
          id = 24,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 820,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "light/hometown/town_school",
            ["marker"] = "entryschool"
          }
        },
        {
          id = 25,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 880,
          y = -40,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "up",
            ["map"] = "light/hometown/school/school_door",
            ["marker"] = "entry"
          }
        },
        {
          id = 30,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1208,
          y = 360,
          width = 114,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.school.school_lobby.like_breathing_moving_fast_without}",
            ["text2"] = "{hometown.school.school_lobby.usually_legs}",
            ["text3"] = "{hometown.school.school_lobby.join_cross_country_team_jockington}"
          }
        },
        {
          id = 31,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1112,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.ran_water_fountain_lukewarm}"
          }
        },
        {
          id = 32,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 592,
          y = 360,
          width = 114,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.school.school_lobby.ready_sadie_hawkmans_dance}",
            ["text2"] = "{hometown.school.school_lobby.dance_all_chaperones_wear_giant}",
            ["text3"] = "{hometown.school.school_lobby.screech_any_students_make_contact}"
          }
        },
        {
          id = 33,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1400,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked}"
          }
        },
        {
          id = 35,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1440,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked}"
          }
        },
        {
          id = 36,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked}"
          }
        },
        {
          id = 37,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1560,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_empty}"
          }
        },
        {
          id = 38,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 1520,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.used_brothers_locker}"
          }
        },
        {
          id = 39,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked_2}"
          }
        },
        {
          id = 41,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked_2}"
          }
        },
        {
          id = 42,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked_2}"
          }
        },
        {
          id = 43,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_locked_2}"
          }
        },
        {
          id = 44,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.school.school_lobby.locker_covered_jockington_memorabilia}"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 26,
          name = "entrykris",
          type = "",
          shape = "point",
          x = 240,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "spawn",
          type = "",
          shape = "point",
          x = 940,
          y = 800,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "entrytoriel",
          type = "",
          shape = "point",
          x = 1680,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "entrydark",
          type = "",
          shape = "point",
          x = 940,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../../../../../assets/sprites/world/maps/hometown/school/school_lobby_sunset.png",
      id = 8,
      name = "sunset",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {
        ["cond"] = "Game:getFlag(\"hometown_time\", \"day\") == \"sunset\""
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
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
          id = 46,
          name = "schoolsunset",
          type = "",
          shape = "point",
          x = 6,
          y = -6,
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
