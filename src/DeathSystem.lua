---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Bergi.
--- DateTime: 08.03.2021 21:07
---
do
    local InitGlobalsOrigin = InitGlobals
    function InitGlobals()
        InitGlobalsOrigin()
        TimerStart(CreateTimer(), 1, false, function()
            InitDeathEvent()
            DestroyTimer(GetExpiredTimer())
        end)
    end
end
function InitDeathEvent()
    local this = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(this, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(this, function()
        local u = GetTriggerUnit() --тот кто умер
        local killer = GetKillingUnit()
        local xu, yu = GetUnitXY(u)

        if IsUnitEnemy(u, GetOwningPlayer(killer)) then
            if HERO[GetPlayerId(GetOwningPlayer(killer))].UnitHero then
                --print("Есть герой")

                if killer then
                    --print(GetUnitName(killer),GetUnitName(u))
                    local exp = BlzGetUnitMaxHP(u) / 10
                    --AddExp(GetUnitData(killer), exp)
                    EffectFromUnit2Unit(nil,"Firebrand Shot Yellow", GetUnitData(killer).UnitHero, u,"add gold")
                end
            else
                --print("нет героя")
            end



            if GetUnitTypeId(u) == FourCC("n005") then
                --грибочек

                normal_sound("MP3\\RO\\Spore\\Death", xu, yu, 50)
                TimerStart(CreateTimer(), 15, false, function()
                    local x, y = GetRandomReal(GetRectMinX(gg_rct_Bound03), GetRectMaxX(gg_rct_Bound03)), GetRandomReal(GetRectMinY(gg_rct_Bound03), GetRectMaxY(gg_rct_Bound03))
                    --print(x,y)
                    local new = CreateUnit(Player(10), FourCC("n005"), x, y, 0)
                    SporeAddMoveEvent(new)
                end)

                --CreateItemPrefabPool(GetUnitData(killer), xu, yu, "Spore Card", "Spore", "Spore Hat","Mycelium")
            end
        end
    end)
end