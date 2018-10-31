if GetLocale() == "zhTW" then
	BeStride_Locale = {
		Options = {
			OpenGUI = "開啟設定"
		},
		GUI = {
			BUTTON = {
				SelectAll = "全部選擇",
				ClearAll = "清除全選",
				Filter = "過濾器",
				Copy = "複製",
				Delete = "刪除"
			},
			TAB = {
				Mounts = "坐騎",
				MountOptions = "坐騎選項",
				ClassOptions = "職業選項",
				Keybinds = "快捷鍵",
				Profile = "設定檔",
				About = "關於",
				Ground = "地面坐騎",
				Flying = "飛行座騎",
				Repair = "維修坐騎",
				Swimming = "游泳坐騎",
				Passenger = "多載坐騎",
				Special = "特殊坐騎"
			}
		},
		About = "版本: " .. version .. "\n" .. "作者: " .. author .. "\n" .. "描述: " .. "\n\n" .. "        " .. "BeStride 是由 YayMounts 改版而來原始作者為 Windrunner US 的 Cyrae 和 Kirin Tor US 的 Anzu" .. "\n" .. "        " .. "接下來, Burning Legion US 的 Anaximander 發現這個專案被原始作者放棄了, 並且有一些錯誤需要被修正" .. "\n" .. "        " .. "在解決錯誤的過程中, 此插件被現代化以讓程式碼更加的精簡與模組化." .. "\n\n" .. "特別感謝:" .. "\n\n" .. "        " .. "Mindlessgalaxy: 幫助 beta 版本的測試",
		Bindings = {
			Header = "BeStride",
			Regular = "騎乘按鈕",
			Ground = "強制地面坐騎按鈕",
			Repair = "強制維修坐騎按鈕",
			Passenger = "強制多載坐騎按鈕"
		},
		Zone = {
			Deadmines = {
				Name = "死亡礦坑"
			},
			AQ = {
				Name = "安其拉"
			},
			Dalaran = {
				Name = "達拉然",
				SubZone = {
					UnderBelly = {
						Name = "城底區"
					},
					UnderBellyDescent = {
						Name = "城底陷窟"
					},
					CircleOfWills = {
						Name = "意志之環"
					},
					BlackMarket = {
						Name = "黑市"
					}
				}
			},
			Icecrown = {
				Name = "寒冰皇冠"
			},
			Oculus = {
				Name = "奧核之眼"
			},
			StormPeaks = {
				Name = "風暴群山"
			},
			SholazarBasin = {
				Name = "休拉薩盆地"
			},
			Wintergrasp = {
				Name = "冬握湖"
			},
			Vashjir = {
				Name = "瓦許伊爾",
				SubZone = {
					KelptharForest = {
						Name = "凱波薩爾森林"
					},
					ShimmeringExpanse = {
						Name = "閃光瀚洋"
					},
					AbyssalDepths = {
						Name = "地獄深淵"
					},
					DamplightChamber = {
						Name = "霧光之間"
					},
					Nespirah = {
						Name = "奈斯畢拉"
					},
					LGhorek = {
						Name = "勒苟雷克"
					}
				}
			},
			VortexPinnacle = {
				Name = "漩渦尖塔"
			},
			Nagrand = {
				Name = "納葛蘭"
			}
		},
		Continent = {
			Draenor = {
				Name = "德拉諾"
			}
		},
		Settings = {
			EnableNew = "當學會新作其實自動啟用它們",
			EmptyRandom = "如果沒有可以使用的已選擇坐騎時隨機使用",
			RemountAfterDismount = "下馬後立刻重新上馬",
			NoDismountWhileFlying = "在飛行時不解除坐騎. 你必須要降落或者是施放一個法術 (假使在選項中啟用後)",
			UseFlyingMount = "在不可飛行的區域仍然使用飛行座騎",
			ForceFlyingMount = "在不可飛行的區域強制使用飛行座騎",
			PrioritizePassenger = "在隊伍時優先使用多載坐騎",
			FlyingBroom = "總是使用魔法掃帚代替普通坐騎",
			Telaari = "在納葛蘭時總是使用泰拉蕊塔巴克或是霜狼",
			Repair = {
				Use = "當到達耐久度閥值時且擁有時使用維修坐騎",
				Force = "當角色有維修坐騎時強制使用",
				Durability = "物品低耐久度 %",
				GlobalDurability = "全局低耐久度 %",
				IventoryDurability = "背包物品低耐久度 %"
			},
			Classes = {
				DeathKnight = {
					WraithWalk = "死亡騎士: 闇境靈行"
				},
				Druid = {
					FlightForm = "德魯伊: 使用飛行型態",
					TravelToTravel = "德魯伊: 在戰鬥時, 從旅行或水棲型態直接切換回那個型態",
					FlightFormPriority = "德魯伊: 即使未移動時也優先使用飛行型態",
					MountedToFlightForm = "德魯伊: 當在飛行座騎上且正在飛行時,變換為飛行型態"
				},
				DemonHunter = {
					FelRush = "惡魔獵人: 使用魔化衝刺",
					Glide = "惡魔獵人: 使用滑翔"
				},
				Mage = {
					SlowFall = "法師: 緩落",
					Blink = "法師: 閃現",
					BlinkPriority = "法師: 在緩落前優先使用閃現 (即使掉落時)"
				},
				Monk = {
					Roll = "武僧: 翻滾",
					ZenFlight = "武僧: 當移動或掉落時使用御風禪"
				},
				Paladin = {
					DivineSteed = "聖騎士: 神性戰馬"
				},
				Priest = {
					Levitate = "牧師: 漂浮術"
				},
				Rogue = {
					Sprint = "盜賊: 衝刺"
				},
				Shaman = {
					GhostWolf = "薩滿: 鬼魂之狼"
				}
			}
		}
	}
end
