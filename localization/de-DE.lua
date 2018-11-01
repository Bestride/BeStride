if GetLocale() == "deDE" then
	BeStride_Locale = {
		Options = {
			OpenGUI = "GUI öffnen"
		},
		GUI = {
			BUTTON = {
				SelectAll = "Alles auswählen",
				ClearAll = "Alles abwählen",
				Filter = "Filter",
				Copy = "Kopieren",
				Delete = "Löschen"
			},
			TAB = {
				Mounts = "Reittiere",
				MountOptions = "Reittieroptionen",
				ClassOptions = "Klassenoptionen",
				Keybinds = "Tastaturbelegungen",
				Profile = "Profile",
				About = "Info",
				Ground = "Boden",
				Flying = "Luft",
				Repair = "Reparatur",
				Swimming = "Wasser",
				Passenger = "Passagier",
				Special = "Spezial"
			}
		},
		About = "Version: " .. version .. "\n" .. "Autor: " .. author .. "\n" .. "Beschreibung: " .. "\n\n" .. "        " .. "BeStride ist eine Weiterentwicklung von YayMounts, das ursprünglich von Cyrae (Windrunner US) und Anzu (Kirin Tor US)" .. "\n" .. "        " .. "entwickelt wurde. Als Anaximander (Burning Legion US) später feststellte, dass das Projekt vernachlässigt wurde und mehrere" .. "\n" .. "        " .. "Fehler aufwies, die im Rahmen des Fehlerbehebungsprozesses behoben werden mussten, wurde das Addon modernisiert, um" .. "\n" .. "        " .. "den Code sauberer und modularer zu gestalten." .. "\n\n" .. "Ein besonderes Dankeschön geht an:" .. "\n\n" .. "        " .. "Mindlessgalaxy: Für die Unterstützung bei den Beta-Tests",
		Bindings = {
			Header = "BeStride",
			Regular = "Reittier beschwören",
			Ground = "Boden-Reittier erzwingen",
			Repair = "Reparatur-Reittier erzwingen",
			Passenger = "Passagier-Reittier erzwingen"
		},
		Zone = {
			AzuremystIsle = {
				Name = "Azurmythosinsel"
			},
			BloodmystIsle = {
				Name = "Blutmythosinsel"
			},
			Deadmines = {
				Name = "Die Todesminen"
			},
			AQ = {
				Name = "Ahn'Qiraj"
			},
			Dalaran = {
				Name = "Dalaran",
				SubZone = {
					UnderBelly = {
						Name = "Die Schattenseite"
					},
					UnderBellyDescent = {
						Name = "Der Schattenabstieg"
					},
					CircleOfWills = {
						Name = "Kreis der Mächte"
					},
					BlackMarket = {
						Name = "Der Schwarzmarkt"
					}
				}
			},
			Icecrown = {
				Name = "Eiskrone"
			},
			Oculus = {
				Name = "Das Oculus"
			},
			StormPeaks = {
				Name = "Die Sturmgipfel"
			},
			SholazarBasin = {
				Name = "Sholazarbecken"
			},
			Wintergrasp = {
				Name = "Tausendwinter"
			},
			Vashjir = {
				Name = "Vashj'ir",
				SubZone = {
					KelptharForest = {
						Name = "Tang'tharwald"
					},
					ShimmeringExpanse = {
						Name = "Schimmernde Weiten"
					},
					AbyssalDepths = {
						Name = "Abyssische Tiefen"
					},
					DamplightChamber = {
						Name = "Dunstlichtkammer"
					},
					Nespirah = {
						Name = "Nespirah"
					},
					LGhorek = {
						Name = "L'Ghorek"
					}
				}
			},
			VortexPinnacle = {
				Name = "Der Vortexgipfel"
			},
			Nagrand = {
				Name = "Nagrand"
			}
		},
		Continent = {
			Draenor = {
				Name = "Draenor"
			}
		},
		Settings = {
			EnableNew = "Neu erlernte Reittiere automatisch aktivieren",
			EmptyRandom = "Zufälliges nutzbares Reittier auswählen, wenn keine nutzbaren Reittiere ausgewählt sind",
			RemountAfterDismount = "Sofort nach dem Absitzen wieder aufsitzen",
			NoDismountWhileFlying = "Nicht beim Fliegen absteigen. Du musst landen oder (wenn in den Blizzard-Optionen aktiviert) einen Zauber wirken",
			UseFlyingMount = "Luft-Reittiere auch in Gebieten verwenden, wo man nicht fliegen kann",
			ForceFlyingMount = "Luft-Reittiere auch in Gebieten erzwingen, wo man nicht fliegen kann",
			PrioritizePassenger = "Passagier-Reittiere priorisieren, wenn man in einer Gruppe ist",
			FlyingBroom = "Immer einen fliegenden Besen anstelle eines normalen Reittiers verwenden",
			Telaari = "Immer den Telaartalbuk oder Kriegswolf des Frostwolfklans in Nagrand verwenden",
			Repair = {
				Use = "Ein Reparatur-Reittier verwenden, wenn der Spieler eines hat und die Haltbarkeitsschwelle erreicht ist",
				Force = "Ein Reparatur-Reittier erzwingen, wenn der Spieler eines hat",
				Durability = "Gegenstand Niedrige Haltbarkeit %",
				GlobalDurability = "Globale Niedrige Haltbarkeit %",
				InventoryDurability = "Inventar Gegenstand Niedrige Haltbarkeit %"
			},
			Classes = {
				DeathKnight = {
					WraithWalk = "Todesritter: Gespensterwanderung"
				},
				Druid = {
					FlightForm = "Druide: Fluggestalt verwenden",
					TravelToTravel = "Druide: Im Kampf von der Reise- oder Wassergestalt direkt zu dieser Gestalt zurückverwandeln",
					FlightFormPriority = "Druide: Vorrangig die Fluggestalt anstelle eines regulären Reittiers nutzen, selbst wenn man sich nicht bewegt",
					MountedToFlightForm = "Druide: In die Fluggestalt verwandeln, während man sich auf einem Luft-Reittier fliegend fortbewegt"
				},
				DemonHunter = {
					FelRush = "Dämonenjäger: Teufelsrausch verwenden",
					Glide = "Dämonenjäger: Gleiten verwenden"
				},
				Mage = {
					SlowFall = "Magier: Langsamer Fall",
					Blink = "Magier: Blinzeln",
					BlinkPriority = "Magier: Vorrangig Blinzeln anstelle von Langsamer Fall nutzen (sogar wenn man fällt)"
				},
				Monk = {
					Roll = "Mönch: Rollen",
					ZenFlight = "Mönch: Zenflug verwenden, während man sich fortbewegt oder fällt"
				},
				Paladin = {
					DivineSteed = "Paladin: Göttliches Ross"
				},
				Priest = {
					Levitate = "Priester: Levitieren"
				},
				Rogue = {
					Sprint = "Schurke: Sprinten"
				},
				Shaman = {
					GhostWolf = "Schamane: Geisterwolf"
				}
			},
			Profiles = {
				CreateNew = "Neues Profil erstellen:",
				Current = "Aktuelles Profil:",
				CopyFrom = "Einstellungen kopieren von:",
				Delete = "Profil löschen:"
			}
		}
	}
end
