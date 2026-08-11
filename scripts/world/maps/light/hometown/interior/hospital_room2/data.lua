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
  nextlayerid = 7,
  nextobjectid = 17,
  properties = {
    ["border"] = "leaves",
    ["inside"] = true,
    ["light"] = true,
    ["music"] = "hometown"
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../../../assets/sprites/world/maps/hometown/interior/hospitalroom2_berdly_sideb.png",
      id = 6,
      name = "roomalt",
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
      type = "imagelayer",
      image = "../../../../../../../assets/sprites/world/maps/hometown/interior/hospitalroom2.png",
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
          x = 240,
          y = 400,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 80,
          width = 360,
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
          y = 120,
          width = 40,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 400,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 400,
          width = 160,
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
          x = 200,
          y = 120,
          width = 40,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 180,
          width = 280,
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
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 326,
          width = 40,
          height = 74,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.text.it_s_a_regular_sink_1570ab3538}"
          }
        },
        {
          id = 9,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 326,
          width = 40,
          height = 74,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "{hometown.text.it_s_a_clone_of_the_other_sink_f458e060db}",
            ["text2"] = "{hometown.text.perhaps_there_was_originally_one_tall_sink_that__c14e4174cb}"
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 428,
          y = 220,
          width = 82,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "hometown.hospitalroom2bed",
            ["solid"] = true
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 244,
          y = 198,
          width = 54,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "{hometown.text.you_looked_inside_the_cupboard_9b93c9fd4d}",
            ["text2"] = "{hometown.text.a_very_small_obligatory_piano_is_hiding_inside_3fd294cb5a}"
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 180,
          width = 76,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.text.it_s_a_classic_1_to_10_pain_scale_wait_5_using_i_5c14efbe16}",
            ["text2"] = "{hometown.text.at_0_pain_wait_5_he_s_happy_wait_5_at_10_pain_wa_fb570cc0f3}"
          }
        },
        {
          id = 16,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 356,
          y = 220,
          width = 52,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "POST_SNOWGRAVE",
            ["solid"] = true,
            ["text"] = "{hometown.text.the_space_heater_is_running_f1d6f82188}"
          }
        },
        {
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["exit_delay"] = 0.3,
            ["exit_sound"] = "doorclose",
            ["facing"] = "down",
            ["map"] = "light/hometown/interior/hospital_hallway",
            ["marker"] = "entryroom2",
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
          id = 15,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 440,
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
