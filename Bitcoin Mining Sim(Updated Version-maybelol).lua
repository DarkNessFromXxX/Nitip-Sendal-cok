_G.KingpinEnabled = false
task.wait(0.1)
-- Inisialisasi variabel global agar fitur otomatis terset
_G.KingpinEnabled = true
_G.AutoAlg = false         -- Tambahkan jika belum terset
_G.AClaimStars = false     -- Tambahkan jika belum terset
_G.AOverclock = false      -- Tambahkan jika belum terset
_G.AClaimCrates = false    -- Tambahkan jika belum terset
_G.AClaimCrystals = false  -- Tambahkan jika belum terset
_G.AExchange = false       -- Tambahkan jika belum terset

-- (Awal script asli)
task.wait(0.1)
-- _G.KingpinEnabled sudah di-set secara global di atas

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNessFromXxX/Nitip-Sendal-cok/refs/heads/main/source'))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local function getHumanoid()
    return game:GetService("Players").LocalPlayer.Character.Humanoid
end
local function getHRP()
    return game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
end

local Window = Rayfield:CreateWindow({
   Name = "Crypto Kingpin",
   LoadingTitle = "Crypto Kingpin",
   LoadingSubtitle = "Bitcoin Miner ⛏️ [Beta]",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "CryptoKingpin"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", 
      RememberJoins = true 
   },
   KeySystem = false, 
   KeySettings = {
      Title = "Sirius Hub",
      Subtitle = "Key System",
      Note = "Join the discord (discord.gg/sirius)",
      FileName = "SiriusKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = "Hello"
   }
})

--///////////////////////////////////////////////////////////////////////
--//////////////////////////////  Scripts  //////////////////////////////
--///////////////////////////////////////////////////////////////////////

local RunService = game:GetService("RunService")
local Notifications = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").NewUi.Notifications
local CodeProx = game.Workspace.Codes:FindFirstChild("ProximityPrompt",true)
local CodesFolder = game.Workspace:FindFirstChild("Code")
local ShopsFolder = game:GetService("Workspace").Shops
local ShopsList = {}
for i,v in pairs(ShopsFolder:GetChildren()) do
    if not (v.Name == "HSV" or v.Name == "GenEX") then
        ShopsList[i] = v
    end
end

for _,v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "Codes" and v:IsA("Folder") then
        CodesFolder = v
    end
end

-- Meskipun variabel berikut dideklarasikan lokal, untuk konsistensi sebaiknya gunakan variabel global (_G)
local AutoAlg = _G.AutoAlg
local ABlacklist = false
local AClaimStars = _G.AClaimStars
local AOverclock = _G.AOverclock
local AClaimCrates = _G.AClaimCrates
local AClaimCrystals = _G.AClaimCrystals
local WhichAE = "Bitcoin"
local AExchange = _G.AExchange
local ExchangeRate = 4500
local cRate = game:GetService("Players").LocalPlayer.PlayerGui.NewUi.ExchangeUI.Values.Rate.Text
local ceRate = cRate:sub(8,#cRate - 5)
local CurERate = ""
local SpoofGp = false
--// Thanks guys :)
local u3 = { "K", "M", "B", "T", "Qd", "Qt", "Sx", "Sp", "Oc", "No", "De", "Ud", "Du", "Td", "Qu" };
local u4 = { "kW", "MW", "GW", "TW", "PW", "EW", "ZW", "YW", "SW", "DW" };
local function formatLargeNumber(p3, p4)
	p3 = tonumber(p3);
	if not p3 then
		return "0";
	end;
	local v64 = "";
	local v65 = "";
	if p3 < 0 then
		p3 = -p3;
		v65 = "-";
	end;
	local v66 = math.floor(math.log10(p3) / 3);
	local v67 = 10 ^ (v66 * 3);
	local v68 = u3[v66];
	if #u3 < v66 then
		v67 = 10 ^ (#u3 * 3);
		v64 = u3[#u3];
	elseif v68 then
		v64 = v68;
	end;
	if v64 ~= "" then
		local v69 = 10 ^ (1 and 0);
		p3 = math.floor(p3 * 10 * v69);
		p3 = (p3 - p3 % v67) / v67;
		p3 = p3 / 10 / 10 ^ (1 and 0);
		return v65 .. tostring(math.floor(p3 * 100 * v69 + 0.5) / (100 * v69)) .. v64;
	end;
	if p3 == 0 then
		return tostring(p3);
	end;
	if not (p3 < 0.6) then
		return v65 .. tostring(math.floor(p3 * 10) / 10);
	end;
	if p3 < 1E-07 then
		return 0;
	end;
	local v70 = string.format("%s%." .. math.ceil(math.log10(p3) * -1 + 1.25) .. "f", v65, p3);
	if string.sub(v70, string.len(v70), string.len(v70)) == "0" then
		v70 = string.sub(v70, 0, string.len(v70) - 1);
	end;
	return v65 .. v70;
end;

local init = coroutine.wrap(function()
    
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == 'UserOwnsGamePassAsync' or method == 'PlayerHasPass' or method == 'PlayerOwnsAsset' then
            print("Gamepass returned true...")
            if SpoofGp then return true else return old(self, ...) end
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
    
    
    while _G.KingpinEnabled and wait(0.5) do
        if not _G.KingpinEnabled then break end
        
        if WhichAE == "Bitcoin" then
            CurERate:Set("Current Exchange Rate: "..math.floor(game:GetService("ReplicatedStorage").BtcVal.Value * 100) / 100 .." per "..WhichAE,1)
            TotalE:Set("Total "..WhichAE..": "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value).." "..WhichAE,1)
            CurE:Set("Current Profit: "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value * game:GetService("ReplicatedStorage").BtcVal.Value).." Cash",1)
            local projProff = game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value * ExchangeRate
            if projProff < game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value * game:GetService("ReplicatedStorage").BtcVal.Value then
                projProff = game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value * game:GetService("ReplicatedStorage").BtcVal.Value
            end
            ProjE:Set("Projected Profit: "..formatLargeNumber(projProff).." sCash",1)
        else
            CurERate:Set("Current Exchange Rate: "..math.floor(game:GetService("ReplicatedStorage").SolVal.Value * 100) / 100 .." per "..WhichAE,1)
            TotalE:Set("Total "..WhichAE..": "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.Solaris.Value).." "..WhichAE,1)
            CurE:Set("Current Profit: "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.Solaris.Value * game:GetService("ReplicatedStorage").SolVal.Value).." sCash",1)
            local projProff = game:GetService("Players").LocalPlayer.leaderstats.Solaris.Value * ExchangeRate
            if projProff < game:GetService("Players").LocalPlayer.leaderstats.Solaris.Value * game:GetService("ReplicatedStorage").SolVal.Value then
                projProff = game:GetService("Players").LocalPlayer.leaderstats.Solaris.Value * game:GetService("ReplicatedStorage").SolVal.Value
            end
            ProjE:Set("Projected Profit: "..formatLargeNumber(projProff).." sCash",1)
        end
        
         
        if AExchange then
            if WhichAE == "Solaris" then
                for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.NewUi.ExchangeUI.TopBar.Sol.Activated)) do
                   v:Fire()
                end
                local rate = game:GetService("Players").LocalPlayer.PlayerGui.NewUi.ExchangeUI.Values.Rate.Text
                local eRate = rate:sub(8,#rate - 5)
                
                if tonumber(eRate) >= ExchangeRate then
                    game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(false)
                end
            elseif  WhichAE == "Bitcoin" then
                for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.NewUi.ExchangeUI.TopBar.Bit.Activated)) do
                   v:Fire()
                end
                local rate = game:GetService("Players").LocalPlayer.PlayerGui.NewUi.ExchangeUI.Values.Rate.Text
                local eRate = rate:sub(8,#rate - 5)
                
                if tonumber(eRate) >= ExchangeRate then
                    game:GetService("ReplicatedStorage").Events.ExchangeMoney:FireServer(true)
                end
            end
        end
        if AClaimCrystals then
            for _,v in pairs(game.Workspace.GemsSpawned:GetChildren()) do
                fireproximityprompt(v.Part.ProximityPrompt)
            end
        end
        if AClaimCrates then
            game:GetService("ReplicatedStorage").Events.ClmFrCrt:FireServer(false)
            game:GetService("ReplicatedStorage").Events.ClmFrCrt:FireServer(true)
        end
        if AClaimStars then
            game:GetService("ReplicatedStorage").Events.ClaimFreeBoostStar:FireServer()
        end
        if AOverclock then
            game:GetService("ReplicatedStorage").Events.ActivateOverclock:FireServer()
        end
        if AutoAlg then
            local Algs = PlayerGui.NewUi.UiButtons.SubButtonsContainer.SubButtonsMenu.Algorithms.AlgStore
            local rates = {}
            local ratesname = {}
            for i,v in pairs(Algs:GetChildren()) do
                if v.ClassName == "TextButton" then
                    rates[v.Name:sub(1,1)] = v.Rate.Text:sub(1, #v.Rate.Text - 1)
                    ratesname[v.Name:sub(1,1)] = v.Name:sub(2,#v.Name)
                end
            end

            local highestNumber = 0
            local newRate = 1
            for i, v in pairs(rates) do
                local number = tonumber(v)
                if number > highestNumber then
                    highestNumber = number
                    newRate = i
                end
            end

            game:GetService("ReplicatedStorage").Events.AlgoChang:FireServer(newRate)

            --// Check for Notifs

            if Notifications:FindFirstChild("NotifCell") then
                if not Notifications.NotifCell:FindFirstChild("MainButton") then return end
                if not Notifications.NotifCell.MainButton:FindFirstChild("MainText") then return end
                local descendant = Notifications.NotifCell
                if descendant.MainButton.MainText.Text == "Algorithms have changed" then
                    descendant.MainButton.MainText.Text = "Algorithms have changed. New best algorithm selected! ("..ratesname[newRate]..":"..highestNumber.."x)"
                    descendant.MainButton.SmallText.Text = "Closing in 10..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 9..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 8..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 7..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 6..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 5..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 4..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 3..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 2..."
                    task.wait(1)
                    descendant.MainButton.SmallText.Text = "Closing in 1..."
                    task.wait(1)

                    descendant:Destroy()
                end
            end
        end
        if not _G.KingpinEnabled then break end
    end
end)
--RunService.RenderStepped:Connect(function(step)
    
--end)


--///////////////////////////////////////////////////////////////////////
--///////////////////////////////  Tabs  ////////////////////////////////
--///////////////////////////////////////////////////////////////////////

local PlayerTab = Window:CreateTab("Player", 9766672602) -- Title, Image
local GameTab = Window:CreateTab("Game", 12689980465) -- Title, Image
local ShopTab = Window:CreateTab("Shops", 12689979456) -- Title, Image
local TeleportationTab = Window:CreateTab("Teleport", 12689978575) -- Title, Image

--///////////////////////////////////////////////////////////////////////
--//////////////////////////////  Player  ///////////////////////////////
--///////////////////////////////////////////////////////////////////////

local Section = PlayerTab:CreateSection("Player")
local antiAFK;
local VirtualUser=game:GetService("VirtualUser")
local AntiAFKToggle = PlayerTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFKToggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        if Value then
            antiAFK = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                Rayfield:Notify({
                    Title = "Anti AFK",
                    Content = "Anti AFK has blocked a kick attempt!",
                    Duration = 6.5,
                    Image = 4483362458
                })
            end)
        else
            antiAFK:Disconnect()
        end
    end,
})

local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        getHumanoid().WalkSpeed = Value
    end,
})

local RedeemCodes = PlayerTab:CreateButton({
    Name = "Redeem Codes",
    Callback = function()
        for _,v in pairs(CodesFolder:GetChildren()) do
            local code = v.SurfaceGui.SIGN.Text:sub(7,#v.SurfaceGui.SIGN.Text) or "Welp"
            if code == "Welp" then
                return
            else
                game:GetService("ReplicatedStorage").Events.CodeRedem:InvokeServer(code)
            end
        end
        Rayfield:Notify({
            Title = "Codes Redeemed",
            Content = "All Codes have been successfully redeemed!",
            Duration = 5,
            Image = 4483362458,
            Actions = { -- Notification Buttons
                Ignore = {
                    Name = "Ok",
                    Callback = function()
                        --// Cool
                    end
                },
            },
        })
    end,
})

local GamepassSpoof = PlayerTab:CreateToggle({
    Name = "Spoof Gamepasses",
    CurrentValue = false,
    Flag = "GamepassSpoof", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        SpoofGp = Value
    end,
})

--///////////////////////////////////////////////////////////////////////
--///////////////////////////////  Game  ////////////////////////////////
--///////////////////////////////////////////////////////////////////////
local Exchange = GameTab:CreateSection("Exchange")

local AutoExchange = GameTab:CreateToggle({
    Name = "Auto Exchange",
    CurrentValue = false,
    Flag = "AutoExchange", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        AExchange = Value
    end,
})

local AEDropdown = GameTab:CreateDropdown({
    Name = "Currency",
    Options = {"Bitcoin","Solaris"},
    CurrentOption = "Bitcoin",
    Flag = "AEDropdown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
        WhichAE = Option
    end,
})

local ExchangeRateSlider = GameTab:CreateSlider({
    Name = "Exchange Rate",
    Range = {4500, 10000},
    Increment = 100,
    Suffix = "(s)Cash",
    CurrentValue = 4500,
    Flag = "ExchangeRate", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        ExchangeRate = Value
    end,
})

CurERate = GameTab:CreateLabel("Current Exchange Rate: "..tonumber(ceRate).." per "..WhichAE)
TotalE = GameTab:CreateLabel("Total "..WhichAE..": "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value)..WhichAE)
CurE = GameTab:CreateLabel("Current Profit: "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value * game:GetService("ReplicatedStorage").BtcVal.Value).." (s)Cash")
ProjE = GameTab:CreateLabel("Projected Profit: "..formatLargeNumber(game:GetService("Players").LocalPlayer.leaderstats.BitCoins.Value * tonumber(ExchangeRate)).." (s)Cash")

local Section = GameTab:CreateSection("Automation")

local AlgorithmToggle = GameTab:CreateToggle({
    Name = "Auto Algorithm",
    CurrentValue = false,
    Flag = "AlgorithmToggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        AutoAlg = Value
    end,
})

local AutoClaimStars = GameTab:CreateToggle({
    Name = "Auto Claim Stars",
    CurrentValue = false,
    Flag = "AutoClaimStars", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        AClaimStars = Value
    end,
})

local AutoClaimCrates = GameTab:CreateToggle({
    Name = "Auto Claim Crates",
    CurrentValue = false,
    Flag = "AutoClaimCrates", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        AClaimCrates = Value
    end,
})

local AutoCollectCrystals = GameTab:CreateToggle({
    Name = "Auto Collect Crystals",
    CurrentValue = false,
    Flag = "AutoCollectCrystals", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        AClaimCrystals = Value
    end,
})

local AutoOverclock = GameTab:CreateToggle({
    Name = "Auto Overclock",
    CurrentValue = false,
    Flag = "AutoOverclock", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        AOverclock = Value
    end,
})

--///////////////////////////////////////////////////////////////////////
--/////////////////////////////  Teleport  //////////////////////////////
--///////////////////////////////////////////////////////////////////////

local SpawnArea = TeleportationTab:CreateSection("Spawn Area")

local PlotTP = TeleportationTab:CreateButton({
    Name = "Teleport Home",
    Callback = function()
        local plot = game.Workspace:FindFirstChild("Plot_"..Player.PlotNum.Value)
        getHRP().CFrame = plot.Sign.Part.CFrame
    end,
})
local spawnLocations = {
    ["Shop"]=Vector3.new(163.194, 6.86647, 91.418 ),
    ["Plot Shop"]=Vector3.new(-91.0254, 6.86678, 91.7581 ),
    ["Level 4 Generators"]=Vector3.new(-204.339, 6.86688, -386.451 ),
    ["DanT Shop Inc."]=Vector3.new(-1.06147, 6.86684, -697.361 ),
    ["Flux Cards Inc."]=Vector3.new(96.6758, 6.86681, -699.803 ),
    ["Miner Toolz"]=Vector3.new(-32.0513, 6.86683, -891.005 ),
    ["Tables & More"]=Vector3.new(97.6989, 6.86678, -892.704 ),
    ["HSV"]=Vector3.new(36.6701, 6.8668, -1072.3 ),
    ["Chypset"]=Vector3.new(-251, 6.86688, -1132 ),
    ["Train Platform"]=Vector3.new(-172.918, -21.5105, 147.29 )
}

local postTrainLocations = {
    ["Train Platform"]=Vector3.new( -146.848, -0.9504, 14018.1 ),
    ["Solaris Electronics"]=Vector3.new( -29.3074, 26.9868, 13781.4 ),
    ["GenEX"]=Vector3.new(-75.7544, 26.9868, 13762.3),
    ["OptiX"]=Vector3.new(-231.471, 26.9864, 13804.3),
    ["Solaris Generators"]=Vector3.new(-213.766, 26.9869, 13883.4),
    ["Prism Works"]=Vector3.new(56.6452, 26.7655, 13913.8),
    ["Xeno"]=Vector3.new(27.3198, 26.7655, 13945.8),
    ["Hive Tech"]=Vector3.new(-171.274, 27.7916, 13682.9),
    ["Artic"]=Vector3.new(-120.805, 26.0781, 13682.5)
}

local SpawnTeleport = TeleportationTab:CreateDropdown({
    Name = "Spawn Area Teleportations",
    Options = {"Shop","Plot Shop","Level 4 Generators","DanT Shop Inc.", "Flux Cards Inc.", "Miner Toolz", "Tables & More", "HSV", "Chypset", "Train Platform"},
    CurrentOption = "Select Zone",
    Flag = "SpawnTeleport", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
        for i,v in pairs(spawnLocations) do
            if i == Option then
                getHRP().CFrame = CFrame.new(spawnLocations[i])
            end
        end
    end,
})

local PostTrain = TeleportationTab:CreateSection("Post Train")

local TrainTeleport = TeleportationTab:CreateDropdown({
    Name = "Post Train Teleportations (Level 200+)",
    Options = {"Train Platform","Solaris Electronics","GenEX","OptiX","Solaris Generators","Prism Works","Xeno","Hive Tech", "Artic"},
    CurrentOption = "Select Zone",
    Flag = "TrainTeleport", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
        for i,v in pairs(postTrainLocations) do
            if i == Option then
                getHRP().CFrame = CFrame.new(postTrainLocations[i])
            end
        end
    end,
})

--///////////////////////////////////////////////////////////////////////
--///////////////////////////////  Shops  ///////////////////////////////
--///////////////////////////////////////////////////////////////////////

local ShopSection = ShopTab:CreateSection("Shops")

local function FormatShops()
    local NewShopList = {}
    for i,v in pairs(ShopsList) do
        NewShopList[i] = tostring(v.Name)
    end
    return NewShopList
end

local ShopsDropdown = ShopTab:CreateDropdown({
    Name = "Open Shop",
    Options = FormatShops(),
    CurrentOption = "Select Shop",
    Flag = "ShopsDropdown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
        local s = ShopsFolder:FindFirstChild(Option)
        local oldPos = s.Trigger.ShopTrig.CFrame
        task.wait()
        s.Trigger.ShopTrig.CFrame = getHRP().CFrame
        task.wait(0.2)
        for i,v in pairs(getconnections(PlayerGui.NewUi.ShopAlert.Button.MouseButton1Down)) do
           v:Fire()
        end
        task.wait(0.2)
        s.Trigger.ShopTrig.CFrame = oldPos
    end,
})

init()