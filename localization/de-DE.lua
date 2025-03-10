local L = LibStub("AceLocale-3.0"):NewLocale("BeStride", "deDE")
if not L then return end


L["GUI.Options.Open.GUI"] = "GUI öffnen"
L["GUI.BUTTON.SelectAll"] = "Alles auswählen"
L["GUI.BUTTON.ClearAll"] = "Alles abwählen"
L["GUI.BUTTON.Filter"] = "Filter"
L["GUI.BUTTON.Copy"] = "Kopieren"
L["GUI.BUTTON.Delete"] = "Löschen"
L["GUI.TAB.Mounts"] = "Reittiere"
L["GUI.TAB.MountOptions"] = "Reittieroptionen"
L["GUI.TAB.ClassOptions"] = "Klassenoptionen"
L["GUI.TAB.Keybinds"] = "Tastaturbelegungen"
L["GUI.TAB.Profiles"] = "Profile"
L["GUI.TAB.About"] = "Info"
L["GUI.TAB.Mounts.Ground"] = "Boden"
L["GUI.TAB.Mounts.Flying"] = "Luft"
L["GUI.TAB.Mounts.Repair"] = "Reparatur"
L["GUI.TAB.Mounts.Swimming"] = "Wasser"
L["GUI.TAB.Mounts.Passenger"] = "Passagier"
L["GUI.TAB.Mounts.Special"] = "Spezial"
L["GUI.About"] = "Version: " .. version .. "\n" .. "Autor: " .. author .. "\n" .. "Beschreibung: " .. "\n\n" .. "        " .. "BeStride ist eine Weiterentwicklung von YayMounts, das ursprünglich von Cyrae (Windrunner US) und Anzu (Kirin Tor US)" .. "\n" .. "        " .. "entwickelt wurde. Als Anaximander (Burning Legion US) später feststellte, dass das Projekt vernachlässigt wurde und mehrere" .. "\n" .. "        " .. "Fehler aufwies, die im Rahmen des Fehlerbehebungsprozesses behoben werden mussten, wurde das Addon modernisiert, um" .. "\n" .. "        " .. "den Code sauberer und modularer zu gestalten." .. "\n\n" .. "Ein besonderes Dankeschön geht an:" .. "\n\n" .. "        " .. "Mindlessgalaxy: Für die Unterstützung bei den Beta-Tests"
L["Bindings.Header"] = "BeStride"
L["Bindings.Regular"] = "Reittier beschwören"
L["Bindings.Ground"] = "Boden-Reittier erzwingen"
L["Bindings.Repair"] = "Reparatur-Reittier erzwingen"
L["Bindings.Passenger"] = "Passagier-Reittier erzwingen"
L["Zone.AzuremystIsle"] = "Azurmythosinsel"
L["Zone.BloodmystIsle"] = "Blutmythosinsel"
L["Zone.Deadmines"] = "Die Todesminen"
L["Zone.AQ"] = "Ahn'Qiraj"
L["Zone.Dalaran"] = "Dalaran"
L["Zone.Dalaran.SubZone.Underbelly"] = "Die Schattenseite"
L["Zone.Dalaran.SubZone.UnderbellyDescent"] = "Der Schattenabstieg"
L["Zone.Dalaran.SubZone.CircleofWills"] = "Kreis der Mächte"
L["Zone.Dalaran.SubZone.BlackMarket"] = "Der Schwarzmarkt"
L["Zone.Dalaran.SubZone.KrasusLanding"] = "Krasus' Landeplatz"
-- L["Zone.Dalaran.SubZone.KrasusLanding"] = ""
L["Zone.Icecrown"] = "Eiskrone"
L["Zone.Oculus"] = "Das Oculus"
L["Zone.StormPeaks"] = "Die Sturmgipfel"
L["Zone.SholazarBasin"] = "Sholazarbecken"
L["Zone.Wintergrasp"] = "Tausendwinter"
L["Zone.Vashjir"] = "Vashj'ir"
L["Zone.Vashjir.SubZone.KelptharForest"] = "Tang'tharwald"
L["Zone.Vashjir.SubZone.ShimmeringExpanse"] = "Schimmernde Weiten"
L["Zone.Vashjir.SubZone.AbyssalDepths"] = "Abyssische Tiefen"
L["Zone.Vashjir.SubZone.DamplightChamber"] = "Dunstlichtkammer"
L["Zone.Vashjir.SubZone.Nespirah"] = "Nespirah"
L["Zone.Vashjir.SubZone.LGhorek"] = "L'Ghorek"
L["Zone.VortexPinnacle"] = "Der Vortexgipfel"
L["Zone.Nagrand"] = "Nagrand"
L["Continent.Draenor"] = "Draenor"
-- L["Skills.Riding"] = ""
L["Settings.EnableNew"] = "Neu erlernte Reittiere automatisch aktivieren"
L["Settings.EmptyRandom"] = "Zufälliges nutzbares Reittier auswählen, wenn keine nutzbaren Reittiere ausgewählt sind"
L["Settings.RemountAfterDismount"] = "Sofort nach dem Absitzen wieder aufsitzen"
L["Settings.NoDismountWhileFlying"] = "Nicht beim Fliegen absteigen. Du musst landen oder (wenn in den Blizzard-Optionen aktiviert) einen Zauber wirken"
L["Settings.UseFlyingMount"] = "Luft-Reittiere auch in Gebieten verwenden, wo man nicht fliegen kann"
L["Settings.ForceFlyingMount"] = "Luft-Reittiere auch in Gebieten erzwingen, wo man nicht fliegen kann"
L["Settings.PrioritizePassenger"] = "Passagier-Reittiere priorisieren, wenn man in einer Gruppe ist"
L["Settings.NoSwimming"] = "Verwenden Sie niemals Unterwasserhalterungen"
L["Settings.FlyingBroom"] = "Immer einen fliegenden Besen anstelle eines normalen Reittiers verwenden"
L["Settings.Telaari"] = "Immer den Telaartalbuk oder Kriegswolf des Frostwolfklans in Nagrand verwenden"
L["Settings.G99Breakneck"] = "Benutze in Lorenhall das Auto 99-G-Genickbrecher"
L["Settings.ForceRobot"] = "Immer den Himmelsgolem oder Mechanischen Holzextraktor verwenden, wenn man Kräuterkunde gelernt hat"
L["Settings.Repair.Use"] = "Ein Reparatur-Reittier verwenden, wenn der Spieler eines hat und die Haltbarkeitsschwelle erreicht ist"
L["Settings.Repair.Force"] = "Ein Reparatur-Reittier erzwingen, wenn der Spieler eines hat"
L["Settings.Repair.Durability"] = "Gegenstand Niedrige Haltbarkeit %"
L["Settings.Repair.GlobalDurability"] = "Globale Niedrige Haltbarkeit %"
L["Settings.Repair.InventoryDurability"] = "Inventar Gegenstand Niedrige Haltbarkeit %"
L["Settings.Classes.DeathKnight"] = "Todesritter"
L["Settings.Classes.DemonHunter"] = "Dämonenjäger"
L["Settings.Classes.Druid"] = "Druide"
L["Settings.Classes.Evoker"] = "Rufer"
-- L["Settings.Classes.Hunter"] = ""
L["Settings.Classes.Mage"] = "Magier"
L["Settings.Classes.Monk"] = "Mönch"
L["Settings.Classes.Paladin"] = "Paladin"
L["Settings.Classes.Priest"] = "Priester"
L["Settings.Classes.Rogue"] = "Schurke"
L["Settings.Classes.Shaman"] = "Schamane"
-- L["Settings.Classes.Warlock"] = ""
-- L["Settings.Classes.Warrior"] = ""
L["Settings.Classes.DeathKnight.WraithWalk"] = "Todesritter: Gespensterwanderung"
L["Settings.Classes.DemonHunter.FelRush"] = "Dämonenjäger: Teufelsrausch verwenden"
L["Settings.Classes.DemonHunter.Glide"] = "Dämonenjäger: Gleiten verwenden"
L["Settings.Classes.Druid.FlightForm"] = "Druide: Fluggestalt verwenden"
L["Settings.Classes.Druid.TravelToTravel"] = "Druide: Im Kampf von der Reise- oder Wassergestalt direkt zu dieser Gestalt zurückverwandeln"
L["Settings.Classes.Druid.FlightFormPriority"] = "Druide: Vorrangig die Fluggestalt anstelle eines regulären Reittiers nutzen, selbst wenn man sich nicht bewegt"
L["Settings.Classes.Druid.MountedToFlightForm"] = "Druide: In die Fluggestalt verwandeln, während man sich auf einem Luft-Reittier fliegend fortbewegt"
-- L["Settings.Classes.Hunter.AspectOfTheCheetah"] = ""
L["Settings.Classes.Mage.SlowFall"] = "Magier: Langsamer Fall"
L["Settings.Classes.Mage.Blink"] = "Magier: Blinzeln"
L["Settings.Classes.Mage.BlinkPriority"] = "Magier: Vorrangig Blinzeln anstelle von Langsamer Fall nutzen (sogar wenn man fällt)"
L["Settings.Classes.Monk.Roll"] = "Mönch: Rollen"
L["Settings.Classes.Monk.ZenFlight"] = "Mönch: Zenflug verwenden, während man sich fortbewegt oder fällt"
L["Settings.Classes.Paladin.DivineSteed"] = "Paladin: Göttliches Ross"
L["Settings.Classes.Priest.Levitate"] = "Priester: Levitieren"
L["Settings.Classes.Rogue.Sprint"] = "Schurke: Sprinten"
L["Settings.Classes.Shaman.GhostWolf"] = "Schamane: Geisterwolf"
L["Settings.Classes.Evoker.Hover"] = "Rufer: Schweben"
L["Settings.Profiles.CreateNew"] = "Neues Profil erstellen:"
L["Settings.Profiles.Current"] = "Aktuelles Profil:"
L["Settings.Profiles.CopyFrom"] = "Einstellungen kopieren von:"
L["Settings.Profiles.Delete"] = "Profil löschen:"
L["Settings.Classes.Warlock.BurningRush"] = "Hexenmeister: Brennender Ansturm"
