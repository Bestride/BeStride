if GetLocale() == "koKR" then
	BeStride_Locale = {
		Options = {
			OpenGUI = "설정창 열기"
		},
		GUI = {
			BUTTON = {
				SelectAll = "모두 선택",
				ClearAll = "모두 해제",
				Filter = "필터",
				Copy = "복사",
				Delete = "삭제"
			},
			TAB = {
				Mounts = "탈것 목록",
				MountOptions = "탈것 설정",
				ClassOptions = "직업 설정",
				Keybinds = "단축키",
				Profile = "프로필",
				About = "정보",
				Ground = "지상",
				Flying = "비행",
				Repair = "수리",
				Swimming = "수영",
				Passenger = "다인승",
				Special = "특별"
			}
		},
		About = "버전: " .. version .. "\n" .. "제작자: " .. author .. "\n" .. "디스코드: https://discord.gg/6bZf5PF" .. "\n" .. "설명: " .. "\n\n" .. "        " .. "BeStride 애드온은 북미섭의 Anzu-키린토, Cyrae-윈드러너가 만든 YayMounts 애드온에서 시작되었습니다." .. "\n" .. "        " .. "이후, 북미섭의 Anaximander-불타는군단이 방치된 것을 발견하고 버그를 고쳤습니다." .. "\n" .. "        " .. "버그를 고치는 과정에서, 코드를 정리하고 모듈을 추가하면서 현대화되었습니다." .. "\n\n" .. "특별 감사:" .. "\n\n" .. "        " .. "Mindlessgalaxy: 베타 테스팅을 도와주셨습니다.",
		Bindings = {
			Header = "베스트라이드",
			Regular = "탈것 탑승",
			Ground = "지상 탈것 강제 탑승",
			Repair = "수리 탈것 강제 탑승",
			Passenger = "다인승 탈것 강제 탑승"
		},
		Zone = {
			AzuremystIsle = {
				Name = "하늘안개 섬"
			},
			BloodmystIsle = {
				Name = "핏빛안개 섬"
			},
			Deadmines = {
				Name = "죽음의 폐광"
			},
			AQ = {
				Name = "안퀴라즈"
			},
			Dalaran = {
				Name = "달라란",
				SubZone = {
					Underbelly = {
						Name = "마법의 뒤안길"
					},
					UnderbellyDescent = {
						Name = "마법의 뒤안길 지하"
					},
					CircleofWills = {
						Name = "의지의 투기장"
					},
					BlackMarket = {
						Name = "암시장"
					},
					KrasusLanding = {
						Name = ""
					}
				}
			},
			Icecrown = {
				Name = "얼음왕관"
			},
			Oculus = {
				Name = "마력의 눈"
			},
			StormPeaks = {
				Name = "폭풍우 봉우리"
			},
			SholazarBasin = {
				Name = "숄라자르 분지"
			},
			Wintergrasp = {
				Name = "겨울손아귀"
			},
			Vashjir = {
				Name = "바쉬르",
				SubZone = {
					KelptharForest = {
						Name = "켈프타르 숲"
					},
					ShimmeringExpanse = {
						Name = "흐린빛 벌판"
					},
					AbyssalDepths = {
						Name = "심연의 나락"
					},
					DamplightChamber = {
						Name = "안개빛 방"
					},
					Nespirah = {
						Name = "네스피라"
					},
					LGhorek = {
						Name = "고레크"
					}
				}
			},
			VortexPinnacle = {
				Name = "소용돌이 누각"
			},
			Nagrand = {
				Name = "나그란드"
			}
		},
		Continent = {
			Draenor = {
				Name = "드레노어",
			},
		},
		Skills = {
			Riding = {
				Name = "탈것 타기"
			}
		},
		Settings = {
			EnableNew = "새로 배운 탈것을 자동으로 활성화",
			EmptyRandom = "체크된게 없을 때, 임의의 랜덤탈것 탑승",
			RemountAfterDismount = "탈것 해제 후 즉시 재탑승",
			NoDismountWhileFlying = "비행중 탈것 해제 잠금(낙사방지). 체크시 땅에 착지하거나 스킬을 사용해야 합니다.",
			UseFlyingMount = "비행 불가능 지역에서 비행 탈것 탑승 위주.",
			ForceFlyingMount = "비행 불가능 지역에서 비행 탈것 탑승 강제.",
			PrioritizePassenger = "파티일 때 다인승 탈것 우선",
			NoSwimming = "수영중일 때 수중 탈것을 사용하지 않습니다.",
			FlyingBroom = "일반 탈것 대신 비행 빗자루를 탑승(할로윈 축제)",
			Telaari = "나그란드에서 텔라아리 탈부크나 서리늑대 전투늑대를 항상 사용합니다.",
			ForceRobot = "약초채집을 배운 경우 항상 하늘골렘이나 기계화 목재 추출기를 탑승합니다.",
			Repair = {
				Use = "소유중 + 내구도 문제가 있을 때, 수리탈것을 탑승합니다.",
				Force = "소유중일 때, 수리탈것 탑승을 강제합니다.",
				Durability = "내구도 알림 기준(%) - 착용템",
				GlobalDurability = "내구도 알림 기준(%) - 전체",
				InventoryDurability = "내구도 알림 기준(%) - 가방"
			},
			Classes = {
				DeathKnight = {
					WraithWalk = "죽음의 기사: 죽음의 진군"
				},
				DemonHunter = {
					FelRush = "악마사냥꾼: 지옥 돌진",
					Glide = "악마사냥꾼: 활공"
				},
				Druid = {
					FlightForm = "드루이드: 비행폼 변신",
					TravelToTravel = "드루이드: 전투 중일 때, 이동폼이나 수영폼으로 바꿉니다.",
					FlightFormPriority = "드루이드: 움직이지 않을때, 비행폼을 우선합니다.",
					MountedToFlightForm = "드루이드: 탈것 타고있을 때, 비행폼으로 바꿉니다."
				},
				Hunter = {
					AspectOfTheCheetah = "사냥꾼: 치타의 상",
				},
				Mage = {
					SlowFall = "마법사: 저속낙하",
					Blink = "마법사: 점멸",
					BlinkPriority = "마법사: 저속낙하를 쓰기전에 점멸을 우선합니다.(낙하중이라도)"
				},
				Monk = {
					Roll = "수도사: 구르기",
					ZenFlight = "수도사: 이동중이거나 낙하중일 때 참선 비행을 사용합니다."
				},
				Paladin = {
					DivineSteed = "성기사: 천상의 군마"
				},
				Priest = {
					Levitate = "사제: 공중 부양"
				},
				Rogue = {
					Sprint = "도적: 전력 질주"
				},
				Shaman = {
					GhostWolf = "주술사: 늑대 정령"
				}
			},
			Profiles = {
				CreateNew = "새 프로필 만들기:",
				Current = "현재 프로필:",
				CopyFrom = "프로필 복사:",
				Delete = "프로필 삭제:"
			}
		}
	}
end