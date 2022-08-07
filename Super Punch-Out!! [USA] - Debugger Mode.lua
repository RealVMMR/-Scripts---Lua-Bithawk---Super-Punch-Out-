---------------------------------------------------------------------------
--  Super Punch-Out!!! Debugger Mode | USA Version.
--  Version: 1.0 
--  Author: VMMR (VictorMR)

-- NOTES: 
-- Face And Stomach:
	     -- Colors:
	     -- • Green = Defense - ON
	     -- • Red = Defense - OFF
	     -- • Blue = Counterattack / Counterattack Point
	     -- • Orange = Dodge
	 -- "!" Symbol: Moment where the Fighter will be instantly knocked Down.
-- Keys:
   -- • W: ON Debug 
   -- • E: OFF Debug
---------------------------------------------------------------------------

local INPUT_KEYNAMES = {  -- BizHawk
    
    A=false, Add=false, Alt=false, Apps=false, Attn=false, B=false, Back=false, BrowserBack=false, BrowserFavorites=false,
    BrowserForward=false, BrowserHome=false, BrowserRefresh=false, BrowserSearch=false, BrowserStop=false, C=false,
    Cancel=false, Capital=false, CapsLock=false, Clear=false, Control=false, ControlKey=false, Crsel=false, D=false, D0=false,
    D1=false, D2=false, D3=false, D4=false, D5=false, D6=false, D7=false, D8=false, D9=false, Decimal=false, Delete=false,
    Divide=false, Down=false, E=false, End=false, Enter=false, EraseEof=false, Escape=false, Execute=false, Exsel=false,
    F=false, F1=false, F10=false, F11=false, F12=false, F13=false, F14=false, F15=false, F16=false, F17=false, F18=false,
    F19=false, F2=false, F20=false, F21=false, F22=false, F23=false, F24=false, F3=false, F4=false, F5=false, F6=false,
    F7=false, F8=false, F9=false, FinalMode=false, G=false, H=false, HanguelMode=false, HangulMode=false, HanjaMode=false,
    Help=false, Home=false, I=false, IMEAccept=false, IMEAceept=false, IMEConvert=false, IMEModeChange=false,
    IMENonconvert=false, Insert=false, J=false, JunjaMode=false, K=false, KanaMode=false, KanjiMode=false, KeyCode=false,
    L=false, LaunchApplication1=false, LaunchApplication2=false, LaunchMail=false, LButton=false, LControlKey=false,
    Left=false, LineFeed=false, LMenu=false, LShiftKey=false, LWin=false, M=false, MButton=false, MediaNextTrack=false,
    MediaPlayPause=false, MediaPreviousTrack=false, MediaStop=false, Menu=false, Modifiers=false, Multiply=false, N=false,
    Next=false, NoName=false, None=false, NumLock=false, NumPad0=false, NumPad1=false, NumPad2=false, NumPad3=false,
    NumPad4=false, NumPad5=false, NumPad6=false, NumPad7=false, NumPad8=false, NumPad9=false, O=false, Oem1=false,
    Oem102=false, Oem2=false, Oem3=false, Oem4=false, Oem5=false, Oem6=false, Oem7=false, Oem8=false, OemBackslash=false,
    OemClear=false, OemCloseBrackets=false, Oemcomma=false, OemMinus=false, OemOpenBrackets=false, OemPeriod=false,
    OemPipe=false, Oemplus=false, OemQuestion=false, OemQuotes=false, OemSemicolon=false, Oemtilde=false, P=false,
    ProcessKey=false, Q=false, R=false, RButton=false, RControlKey=false, Return=false, Right=false, RMenu=false, RShiftKey=false,
    RWin=false, S=false, Scroll=false, Select=false, SelectMedia=false, Separator=false, Shift=false, ShiftKey=false,
    Sleep=false, Snapshot=false, Space=false, Subtract=false, T=false, Tab=false, U=false, Up=false, V=false, VolumeDown=false,
    VolumeMute=false, VolumeUp=false, W=false, X=false, XButton1=false, XButton2=false, Y=false, Z=false, Zoom=false
}
--Round Value Function: 
function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

--local SwapHead_Address = mainmemory.readbyte(0x000991)
     local Room_Value = mainmemory.readbyte(0x000C00)
     local Debug_on = 1
	 local value_t = 133
	 local fight_x = mainmemory.readbyte(0x000912)
     local image_op_timer = 0 
     local player_rage_draw_timer = 0 
	 local player_rounds_draw_timer = 0
     local boxer_rounds_draw_timer = 0 
	 
while true do 
--VARIABLES IN LOOP:
local boxer_rounds = mainmemory.readbyte(0x00099D)
local down_check = mainmemory.readbyte(0x000BC0)
local boxer_stamina = mainmemory.readbyte(0x00099F)
local boxer_recover = mainmemory.readbyte(0x009DF)
local boxer_id_address = mainmemory.readbyte(0x000600)

local player_stamina = mainmemory.readbyte(0x00089F)
local player_super_bar = mainmemory.readbyte(0x000B54)
local player_rage = mainmemory.readbyte(0x000B65)
local player_rage_activated = mainmemory.readbyte(0x000B63)
local player_rounds = mainmemory.readbyte(0x00089D)

local boxer_defense = {
[0] = mainmemory.readbyte(0x000967), --One Punch Active (80)
[1] = mainmemory.readbyte(0x000968), --Face - Right
[2] = mainmemory.readbyte(0x000969), --Face - Left
[3] = mainmemory.readbyte(0x00096A), --Stomach - Right
[4] = mainmemory.readbyte(0x00096B), --Stomach - Left 
}

local boxer_id = {
[0] = "Gabby Jay",
[1] = "Bear Hugger" ,	
[2] = "Piston Hurricane" ,
[3] = "Bald Bull" ,

[4] = "Bob Charlie", 
[5] = "Dragon Chan" ,
[6] = "Masked Muscle" ,
[7] = "Mr. Sandman", 

[8] = "Aran Ryan" ,
[9] = "Heike Kagero" ,
[10] = "Mad Clown" ,
[11] = "Super Macho Man" ,

[12] = "Narcis Prince" ,
[13] = "Hoy Quarlow" ,
[14] = "Rick Bruiser" ,
[15] = "Nick Bruiser" ,
}

local player_defense = {
[1] = mainmemory.readbyte(0x000868), --Face - Left 
[2] = mainmemory.readbyte(0x000869), --Face - Right 
[3] = mainmemory.readbyte(0x00086A), --Stomach - Left 
[4] = mainmemory.readbyte(0x00086B), --Stomach - Right 
}

local boxer_critic_c = mainmemory.readbyte(0x00092A)

local milisec = mainmemory.readbyte(0x000B26)
local milisec_2 = mainmemory.readbyte(0x000B27)
local sec = mainmemory.read_u8(0x000B28)
local sec_2 = mainmemory.readbyte(0x000B29)
local minute = mainmemory.readbyte(0x000B2A)

local User_input = INPUT_KEYNAMES
local next_page = input.get()

    --Key Check
	User_input.W = next_page.W
	User_input.E = next_page.E

    --Key Check²
      if next_page.W then
	      Debug_on = 1 
	  else if next_page.E then 
	      Debug_on = 0
	  end 
      end 
	  
if mainmemory.readbyte(0x000C00) == 06 and Debug_on == 1 then --Room = Fighter And Debug_On Check 
	 
	 --BACKGROUND Top Screen 
		gui.drawRectangle(120, -4,227,44, "", "black")
		gui.drawRectangle(0, -4,121,44, "", "black")
		
	 --Timer And Fighter Name:
      gui.pixelText(170,215,"TIMER:0"..minute..":"..sec_2..sec..":"..milisec_2..milisec,"white","black",0)
	  gui.pixelText(0,215,"Fighter:".. boxer_id[boxer_id_address],"white","black",0)
	  
--FIGHTERS - DRAW TEXTs:  
	  --Stamina Fighter And Recover Check: 
	  if down_check == 0 or player_stamina == 0 then 
	         gui.pixelText(120,(0*1)-1,"Stamina:".. boxer_stamina,"red","black",0)
	      else if down_check > 0 then 
	    	 --gui.pixelText(120,(0*1)-1,"Recover:".. mainmemory.readbyte(0x0009DF),"red","black",0)
	    	 if boxer_recover > 80 then 
	    	 gui.pixelText(120,(0*1)-1,"Recover:Defeat","red","black",0)
	    	 else 
	    	 gui.pixelText(120,(0*1)-1,"Recover:".. boxer_recover,"red","black",0)
	    	 end 
	      end 
	  end 
	    
		--Attack Timer: 
		    gui.pixelText(120,(8*1)-1,"Atk.Timer:".. mainmemory.readbyte(0x000912),"red","black",0) 
		--Face Fighter - Status Check:
		    gui.pixelText(210,2,"Face:","red","black",1)
		--Stomach Fighter - Status Check:
		    gui.pixelText(198,12,"Stomach:","red","black",1)
		--Fuzzy Value:		
            gui.pixelText(120,(8*2),"Fuzzy:".. round(mainmemory.readbyte(0x00092B)/1.76),"red","black",0)
		--Defense Check: 				
            gui.pixelText(120,(8*3),"Def.Check:".. mainmemory.readbyte(0x000932),"red","black",0)	
        --Rounds Fighters:
		    gui.pixelText(120,(8*4),"Rounds:","red","black",0)	 

        --Draw Cube - Rounds Fighters: 
        if boxer_rounds == 0 then 
		             gui.drawRectangle(162       ,(8*4)+1,6,6, "darkred", "red")
		             gui.drawRectangle(162+(10*1),(8*4)+1,6,6, "darkred", "red")
		             gui.drawRectangle(162+(10*2),(8*4)+1,6,6, "darkred", "red")
	         else if boxer_rounds == 1 then 
		             gui.drawRectangle(162,(8*4)+1,6,6, "darkgreen", "lightgreen")
		             gui.drawRectangle(162+(10*1),(8*4)+1,6,6, "darkred", "red")
		             gui.drawRectangle(162+(10*2),(8*4)+1,6,6, "darkred", "red")
	         else if boxer_rounds == 2 then 
		             gui.drawRectangle(162,       (8*4)+1,6,6, "darkgreen", "lightgreen")
		             gui.drawRectangle(162+(10*1),(8*4)+1,6,6, "darkgreen", "lightgreen")
		             gui.drawRectangle(162+(10*2),(8*4)+1,6,6, "darkred",          "red")
	         else if boxer_rounds == 3 then 
		         boxer_rounds_draw_timer = boxer_rounds_draw_timer + 1 
		     	     if boxer_rounds_draw_timer < 10 then 
		                gui.drawRectangle(162,       (8*4)+1,6,6, "darkgoldenrod", "gold")
		                gui.drawRectangle(162+(10*1),(8*4)+1,6,6, "darkgoldenrod", "gold")
		                gui.drawRectangle(162+(10*2),(8*4)+1,6,6, "darkgoldenrod", "gold")
			        end 
			
			          if boxer_rounds_draw_timer > 20 then 
			          boxer_rounds_draw_timer = 0
		  	          end 
                     end 
                  end 
              end 
		 end 
		
        --BLOCK AND DEFENSE OFF CHECK : =========================================================================================
		          if boxer_defense[1] == 160 then 
		          gui.drawRectangle(231, 2, 6, 6, "green", "green")
		          else if boxer_defense[1] == 161 or boxer_defense[1] == 0 or boxer_defense[3] == 162 then 
		          	 gui.drawRectangle(231, 2, 6, 6, "red", "red")
                  end 
		          end
		          
		          if boxer_defense[2] == 160 then 
		          gui.drawRectangle(241, 2, 6, 6, "green", "green")
		          else if boxer_defense[2] == 161 or boxer_defense[2] == 0 or boxer_defense[3] == 162 then 
		              gui.drawRectangle(241, 2, 6, 6, "red", "red")
		          end 
		          end 
		          
		          --gui.drawRectangle(241, 2, 6, 6, "blue", "blue")		
		          if boxer_defense[3] == 161 or boxer_defense[3] == 0 or boxer_defense[3] == 162 then 
		          gui.drawRectangle(231, 12, 6, 6, "red", "red")
		          else if boxer_defense[3] == 160 then  
		          gui.drawRectangle(231, 12, 6, 6, "green", "green")	
		          end 
		          end 
	              
		          if boxer_defense[4] == 161 or boxer_defense[4] == 0 or boxer_defense[3] == 162 then 
		          gui.drawRectangle(241, 12, 6, 6, "red", "red")
		          else if boxer_defense[4] == 160 then 
		          gui.drawRectangle(241, 12, 6, 6, "green", "green")
		          end 
		          end 
				  
		-- DODGE LEFT/RIGHT =========================================================================================
		          if boxer_defense[1] and boxer_defense[2] and boxer_defense[3] and boxer_defense[4] == 132 or
				     boxer_defense[1] and boxer_defense[2] and boxer_defense[3] and boxer_defense[4] == 130 or 
				     boxer_defense[1] and boxer_defense[2] and boxer_defense[3] and boxer_defense[4] == 164 
				  then 
		             gui.drawRectangle(231, 2, 6, 6, "orange", "orange")	
		             gui.drawRectangle(241, 2, 6, 6, "orange", "orange")	
		             gui.drawRectangle(231, 12, 6, 6, "orange", "orange")	
		             gui.drawRectangle(241, 12, 6, 6, "orange", "orange")	
		          end 
		
		-- GUARD-OFF  =========================================================================================
	              if mainmemory.readbyte(0x00092A) == 129 then --Rosto - Direito
		          	gui.drawRectangle(241, 2, 6, 6, "blue", "blue")	
		          end 
		          
	              if mainmemory.readbyte(0x00092A) == 130 then --Rosto - Esquerdo 
		          	gui.drawRectangle(231, 2, 6, 6, "blue", "blue")	
		          end 
		          
	              if mainmemory.readbyte(0x00092A) == 135 then --Estomago - Direito 
		          	gui.drawRectangle(241, 12, 6, 6, "blue", "blue")	
		          end 
		          
	              if mainmemory.readbyte(0x00092A) == 136 then --Estomago - Esquerdo 
		          	gui.drawRectangle(231, 12, 6, 6, "blue", "blue")	
		          end 
	    -- =========================================================================================
		
--PLAYER - DRAW TEXTS:
        gui.pixelText(0,(0*1)-1,"Stamina:".. player_stamina,"cyan","black",0) 
		
	--Super (Bar) - Check: 
		if player_super_bar < 27 then 
                     gui.pixelText(0,(8*1)-1,"Super:".. player_super_bar,"cyan","black",0) 
            else if player_super_bar == 27 then 
                     gui.pixelText(0,(8*1)-1,"Super:MAX","cyan","black",0) 
            end 
        end 
	--Rage Check: 
		gui.pixelText(0,(8*2)-1,"Rage Status:".. player_rage,"cyan","black",0) 
		
	--Rage Level Text Check: 
		if player_rage_activated == 0 then 
		   if player_rage < 16 then 
              gui.pixelText(0,(8*3)-1,"Level:1","snow","black",1) 		
		      else if player_rage > 15 and player_rage < 24 then 
                 gui.pixelText(0,(8*3)-1,"Level:2","snow","black",1) 	
		         else if player_rage > 23 and player_rage < 32 then 
                    gui.pixelText(0,(8*3)-1,"Level:3","snow","black",1) 	
		            else if player_rage > 31 and player_rage < 40 then 
                       gui.pixelText(0,(8*3)-1,"Level:4","snow","black",1) 	 
		               else if player_rage > 39 and player_rage < 48 then 
                          gui.pixelText(0,(8*3)-1,"Level:5","snow","black",1) 			
		                  else if player_rage > 47 and player_rage < 56 then 
                             gui.pixelText(0,(8*3)-1,"Level:6","snow","black",1) 			
		                                                                end 
                                                                     end 
                                                                  end 		
		                                                       end 
		   												    end 
		  end 
        end 
		
		--LEVEL MAX! - Rage Player:
		if player_rage > 64 then 
		   player_rage_draw_timer = player_rage_draw_timer + 1 
		      if player_rage_draw_timer < 15 then 
		         gui.pixelText(0,(8*3)-1,"Level:MAX!","gold","black",1) 	   
		      else if player_rage_draw_timer == 30 then 
		      player_rage_draw_timer = 0 
		      end 
		      end 
	    end 
			  
		--Rounds Players: 
	    gui.pixelText(0,(8*3)+8,"Rounds:","cyan","black",0) 	 
		
		--Rounds Player Cube Draw: 
        if player_rounds == 0 then 
		             gui.drawRectangle(42       ,(8*4)+1,6,6, "darkred", "red")
		             gui.drawRectangle(42+(10*1),(8*4)+1,6,6, "darkred", "red")
		             gui.drawRectangle(42+(10*2),(8*4)+1,6,6, "darkred", "red")
	         else if player_rounds == 1 then 
		             gui.drawRectangle(42,(8*4)+1,6,6, "darkgreen", "lightgreen")
		             gui.drawRectangle(42+(10*1),(8*4)+1,6,6, "darkred", "red")
		             gui.drawRectangle(42+(10*2),(8*4)+1,6,6, "darkred", "red")
	         else if player_rounds == 2 then 
		             gui.drawRectangle(42,       (8*4)+1,6,6, "darkgreen", "lightgreen")
		             gui.drawRectangle(42+(10*1),(8*4)+1,6,6, "darkgreen", "lightgreen")
		             gui.drawRectangle(42+(10*2),(8*4)+1,6,6, "darkred",          "red")
	         else if player_rounds == 3 then 
		         player_rounds_draw_timer = player_rounds_draw_timer + 1 
		     	     if boxer_rounds_draw_timer < 10 then 
		                gui.drawRectangle(42,       (8*4)+1,6,6, "darkgoldenrod", "gold")
		                gui.drawRectangle(42+(10*1),(8*4)+1,6,6, "darkgoldenrod", "gold")
		                gui.drawRectangle(42+(10*2),(8*4)+1,6,6, "darkgoldenrod", "gold")
			        end 
			
			          if player_rounds_draw_timer > 20 then 
			          player_rounds_draw_timer = 0
			          end 
                   end 
                end 
            end 
		end 
		
	if boxer_defense[0] == 128 then 
		image_op_timer = image_op_timer + 1 
		if image_op_timer > -1 and image_op_timer  < 2 then 
		gui.drawRectangle(250, 2, 3, 10, "aliceblue", "aliceblue")
		gui.drawRectangle(251, 4, 1, 10, "aliceblue", "aliceblue")
		gui.drawRectangle(250, 16, 3, 2, "aliceblue", "aliceblue")
		else if image_op_timer  > 1 then 
		
		end 
		end 
		
		if image_op_timer  > 3 then
		image_op_timer = 0 		
		end 
    else 
	    image_op_timer = 2
	end 

end 

emu.frameadvance();
end 

