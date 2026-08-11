return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 23,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 34,
  properties = {
    ["border"] = "leaves",
    ["inside"] = true,
    ["light"] = true,
    ["music"] = "deltarune/muscle"
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
      image = "../../../../../../../assets/sprites/world/maps/hometown/interior/sans_store.png",
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
          x = 520,
          y = 400,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 20,
          y = 400,
          width = 500,
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
          x = 20,
          y = 40,
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
          x = 20,
          y = 0,
          width = 820,
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
          x = 640,
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
          x = 680,
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
          x = 800,
          y = 40,
          width = 40,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 60,
          y = 160,
          width = 20,
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
          x = 222,
          y = 160,
          width = 578,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 102,
          y = 284,
          width = 330,
          height = 78,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_sans",
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
          id = 32,
          name = "npc",
          type = "",
          shape = "point",
          x = 543,
          y = 164,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "sans",
            ["cutscene"] = "hometown.sans"
          }
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 94,
          y = 370,
          width = 344,
          height = 150,
          rotation = 0,
          gid = 20,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 654,
          y = 382,
          width = 52,
          height = 56,
          rotation = 0,
          gid = 19,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 718,
          y = 388,
          width = 58,
          height = 166,
          rotation = 0,
          gid = 17,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 670,
          y = 160,
          width = 28,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "hometown.sansplin"
          }
        },
        {
          id = 16,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 160,
          width = 142,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.text.various_frozen_bagels_and_treats_781b7bd0bf}"
          }
        },
        {
          id = 17,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 322,
          width = 58,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.text.ice_e_s_pizza_pin_ups_mangazine_fc38c83bd9}",
            ["text2"] = "{hometown.text.hot_and_fresh_chease_wait_5_pepperonie_wait_5_ju_74a9d265e2}"
          }
        },
        {
          id = 18,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 178,
          y = 322,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.text.there_re_some_car_magazines_on_the_racks_9a7cd452c4}",
            ["text2"] = "{hometown.text.it_might_be_fun_to_look_at_them_ade6ea9fc5}",
            ["text3"] = "{hometown.text.but_there_s_other_people_around_73719bb0f7}"
          }
        },
        {
          id = 19,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 246,
          y = 322,
          width = 60,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.text.it_s_a_zine_for_jockington_fans_seems_popular_3039158dc6}"
          }
        },
        {
          id = 20,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 322,
          width = 104,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.text.it_s_a_bunch_of_cards_and_heart_shaped_chocolate_b5d36d7398}",
            ["text2"] = "{hometown.text.get_well_soon_i_m_glad_your_bike_crashed_a61a24a1a2}"
          }
        },
        {
          id = 22,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 658,
          y = 336,
          width = 42,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "{hometown.text.it_s_a_trash_can_4b208a8154}"
          }
        },
        {
          id = 23,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 718,
          y = 328,
          width = 58,
          height = 58,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "{hometown.text.you_can_t_reach_the_top_wait_5_rendering_it_impo_9756129751}",
            ["text2"] = "{hometown.text.you_ll_never_be_able_to_buy_something_in_this_st_d19e1c9965}"
          }
        },
        {
          id = 24,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 712,
          y = 200,
          width = 80,
          height = 18,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.text.it_s_a_rack_of_candy_wait_5_jerky_wait_5_and_var_89fc2493ee}"
          }
        },
        {
          id = 25,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 200,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.text.loose_eggs_1_d8a7efaee0}",
            ["text2"] = "{hometown.text.it_s_too_much_responsibility_for_an_egg_380c8020c0}"
          }
        },
        {
          id = 26,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 324,
          y = 200,
          width = 58,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "{hometown.text.it_looks_like_a_normal_basket_of_fruit_wait_5_bu_b9b759fb74}",
            ["text2"] = "{hometown.text.wait_5_it_s_incredibly_deep_and_holds_all_sorts__ed00310da9}"
          }
        },
        {
          id = 27,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 422,
          y = 200,
          width = 58,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.text.grapes_wait_5_melons_wait_5_oranges_wait_5_and_t_5849572366}"
          }
        },
        {
          id = 28,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 200,
          width = 36,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "{hometown.text.it_looks_like_a_normal_palm_tree_wait_5_but_it_s_97ac8b475b}"
          }
        },
        {
          id = 29,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "light/hometown/town_mid",
            ["marker"] = "entrysans"
          }
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 476,
          y = 206,
          width = 228,
          height = 98,
          rotation = 0,
          gid = 66,
          visible = true,
          properties = {}
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
          id = 30,
          name = "spawn",
          type = "",
          shape = "point",
          x = 600,
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
