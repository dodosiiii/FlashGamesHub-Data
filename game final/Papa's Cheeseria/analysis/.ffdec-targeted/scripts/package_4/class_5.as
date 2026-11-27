package package_4
{
   import cheeseGame.data.*;
   import cheeseGame.events.*;
   import cheeseGame.managers.*;
   import cheeseGame.screens.*;
   import flash.display.*;
   import flash.events.Event;
   import package_1.*;
   import package_2.*;
   
   public dynamic class class_5 extends MovieClip
   {
      
      public var var_138:MovieClip;
      
      public var var_155:MovieClip;
      
      public var var_128:UserData;
      
      public var var_130:CustomerData;
      
      public var var_133:GameData;
      
      public var var_135:ClothingData;
      
      public var workerData:WorkerData;
      
      public var var_151:WorkerData;
      
      public var toppingData:ToppingData;
      
      public var var_145:OrderScreen;
      
      public var var_131:FryScreen;
      
      public var var_136:GrillScreen;
      
      public var var_139:BuildScreen;
      
      public var var_187:TakeOrderScreen;
      
      public var var_183:GiveOrderScreen;
      
      public var var_199:DiningTakeOrderScreen;
      
      public var var_195:DiningGiveOrderScreen;
      
      public var var_194:StartDayScreen;
      
      public var var_193:FinishDayScreen;
      
      public var var_216:UnlockScreen;
      
      public var var_234:PrizePopup;
      
      public var var_228:SpecialPopup;
      
      public var var_231:HireWaiterScreen;
      
      public var var_229:ParadeScreen;
      
      public var var_388:CharacterEditorScreen;
      
      public var var_213:MiniGameScreen;
      
      public var var_176:LobbyEditorScreen;
      
      public var var_227:IntroScreen;
      
      public var var_225:OutroScreen;
      
      public var var_134:CustomerManager;
      
      public var var_147:TicketManager;
      
      public var var_142:ChallengeManager;
      
      public var loadingScreen:class_2;
      
      public var var_250:class_11;
      
      public var var_237:class_6;
      
      public var var_244:class_8;
      
      public var var_328:class_10;
      
      public var var_367:Array = [SplashScreen,SlotSelectScreen,EndOfDayScreen,StartDayPanel,ShopScreen,MainMenuScreen,CharacterEditorScreen];
      
      public var hud:GameHUD;
      
      public var controls:GameControls;
      
      public var var_129:SoundManager;
      
      public var var_132:class_9;
      
      public var var_169:Boolean = false;
      
      public var var_205:Boolean = false;
      
      public var var_211:Number = 10800;
      
      public var var_390:Number = 640;
      
      public var var_389:Number = 480;
      
      public var training:Boolean = false;
      
      public var var_200:Number = 1;
      
      public var var_305:Number = 26;
      
      public var var_391:Boolean = false;
      
      public var var_318:Boolean = false;
      
      private var var_270:Boolean = false;
      
      public function class_5()
      {
         super();
      }
      
      public function method_209(param1:Event = null) : void
      {
         var _loc2_:class_5 = this;
         _loc2_.method_275();
         _loc2_.var_138 = new MovieClip();
         _loc2_.var_138.mouseEnabled = false;
         _loc2_.addChild(_loc2_.var_138);
         _loc2_.var_155 = new MovieClip();
         _loc2_.var_155.mouseEnabled = false;
         _loc2_.addChild(_loc2_.var_155);
         var _loc3_:MovieClip = new border_overlay();
         _loc2_.addChild(_loc3_);
         _loc2_.var_130 = new CustomerData(_loc2_);
         _loc2_.var_133 = new GameData(_loc2_);
         _loc2_.var_128 = new UserData(_loc2_);
         _loc2_.var_135 = new ClothingData(_loc2_);
         _loc2_.workerData = new WorkerData();
         _loc2_.var_151 = new WorkerData();
         _loc2_.toppingData = new ToppingData(_loc2_);
         _loc2_.var_142 = new ChallengeManager(_loc2_);
         _loc2_.var_132 = new class_9(_loc2_);
         _loc2_.var_132.method_145();
         _loc2_.var_133.setPrizes();
         trace("Papa\'s Cheeseria Flipline Studios.");
         trace("Game Version: " + _loc2_.var_132.var_38 + "");
         trace("- Loaded.");
         trace("----------------------------------------------------------------");
         _loc2_.method_241();
      }
      
      public function method_275() : void
      {
         var loaderInfo:LoaderInfo = null;
         var sentLevel:String = null;
         var numberLevel:Number = Number(NaN);
         var mod:class_5 = this;
         class_7.method_240(mod.method_259);
         class_7.method_143(class_7.const_9);
         try
         {
            loaderInfo = mod.root.loaderInfo;
            if(loaderInfo.loader != null)
            {
               loaderInfo = loaderInfo.loader.loaderInfo;
            }
            if(loaderInfo.parameters.hasOwnProperty("traceall"))
            {
               class_7.method_143(class_7.ALL);
            }
            else if(loaderInfo.parameters.hasOwnProperty("tracelevel"))
            {
               sentLevel = String(loaderInfo.parameters.tracelevel);
               numberLevel = 0;
               if(sentLevel == "all")
               {
                  numberLevel = Number(class_7.ALL);
               }
               else if(sentLevel == "debug")
               {
                  numberLevel = Number(class_7.const_11);
               }
               else if(sentLevel == "error")
               {
                  numberLevel = Number(class_7.const_7);
               }
               else if(sentLevel == "warn")
               {
                  numberLevel = Number(class_7.const_10);
               }
               else if(sentLevel == "none" || sentLevel == "off")
               {
                  numberLevel = Number(class_7.const_19);
               }
               else
               {
                  numberLevel = Number(sentLevel);
               }
               class_7.method_143(numberLevel);
            }
            if(loaderInfo.parameters.hasOwnProperty("flipxi"))
            {
               if(loaderInfo.parameters.flipxi == "true")
               {
                  class_7.method_276();
               }
            }
         }
         catch(err:Error)
         {
            class_7.error("Error checking parameters for trace override.");
         }
      }
      
      public function method_259() : String
      {
         var mod:class_5 = this;
         var returnVal:String = "";
         try
         {
            if(mod.controls)
            {
               returnVal = mod.controls.gameplayTimer + "   ";
            }
            else
            {
               returnVal = "???   ";
            }
         }
         catch(err:Error)
         {
            returnVal = "err   ";
         }
         return returnVal;
      }
      
      public function method_241() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.stage != null)
         {
            _loc1_.stage.stageFocusRect = false;
         }
         _loc1_.var_129 = new SoundManager(_loc1_);
         _loc1_.var_132.method_155(_loc1_.var_129);
         if(class_3.method_70())
         {
            if(class_3.method_60())
            {
               if(class_1.method_80())
               {
                  _loc1_.method_262();
               }
               else if(class_1.method_91())
               {
                  _loc1_.method_152();
               }
               else
               {
                  _loc1_.var_132.api.method_106("SplashScreen");
               }
            }
            else
            {
               _loc1_.method_152();
            }
         }
         else
         {
            _loc1_.method_236();
         }
      }
      
      public function method_236() : void
      {
         var _loc1_:class_5 = this;
         if(!_loc1_.var_328)
         {
            _loc1_.var_328 = new class_10(_loc1_);
         }
      }
      
      public function method_253() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_250 = new class_11(_loc1_);
      }
      
      public function method_217() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_250)
         {
            _loc1_.var_250.destroy();
            _loc1_.var_250 = null;
         }
      }
      
      public function method_262() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_237 = new class_6(_loc1_);
      }
      
      public function method_222() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_237)
         {
            _loc1_.var_237.destroy();
            _loc1_.var_237 = null;
         }
      }
      
      public function method_152() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_244 = new class_8(_loc1_);
      }
      
      public function method_251() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_244)
         {
            _loc1_.var_244.destroy();
            _loc1_.var_244 = null;
         }
      }
      
      public function method_141() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_132.api.method_105("EndOfDay");
         _loc1_.method_149();
         _loc1_.var_169 = false;
         _loc1_.var_270 = false;
         _loc1_.var_132.api.method_106("SplashScreen");
      }
      
      public function method_153() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_194)
         {
            _loc1_.var_194.destroy();
            _loc1_.var_194 = null;
         }
         if(!_loc1_.var_194)
         {
            _loc1_.var_194 = new StartDayScreen(_loc1_);
         }
      }
      
      public function method_242() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_194)
         {
            _loc1_.var_194.destroy();
            _loc1_.var_194 = null;
         }
         if(_loc1_.controls)
         {
            _loc1_.controls.resetKeyFocus();
         }
      }
      
      public function method_230() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_193)
         {
            _loc1_.var_193.destroy();
            _loc1_.var_193 = null;
         }
         if(!_loc1_.var_193)
         {
            _loc1_.var_193 = new FinishDayScreen(_loc1_);
         }
      }
      
      public function method_212() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_193)
         {
            _loc1_.var_193.destroy();
            _loc1_.var_193 = null;
         }
      }
      
      public function method_122() : void
      {
         var _loc1_:class_5 = this;
         var _loc2_:Object = new Object();
         _loc2_.showAd = false;
         if(_loc1_.var_128.playedALevel)
         {
            _loc2_.showAd = true;
         }
         _loc1_.var_132.api.method_106("StartDayPanel",_loc2_);
      }
      
      public function method_119() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_132.api.method_105("StartDayPanel");
      }
      
      public function method_204() : void
      {
         var _loc1_:class_5 = this;
         class_7.method_1("Show Shop Screen!");
         _loc1_.var_132.api.method_106("ShopScreen");
      }
      
      public function method_191() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_132.api.method_105("ShopScreen");
      }
      
      public function method_196(param1:Number = -1, param2:Boolean = false) : void
      {
         var _loc4_:Object = null;
         var _loc3_:class_5 = this;
         _loc4_ = new Object();
         _loc4_.selectedSlot = param1;
         _loc4_.firsttime = true;
         _loc4_.firstwaiter = param2;
         if(param2)
         {
            _loc3_.var_132.api.method_106("WaiterEditor",_loc4_);
         }
         else
         {
            _loc3_.var_132.api.method_106("CharacterEditor",_loc4_);
         }
      }
      
      public function method_167() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_132.api.method_105("WaiterEditor");
         _loc1_.var_132.api.method_105("CharacterEditor");
      }
      
      public function method_228() : void
      {
         var _loc1_:class_5 = this;
         if(!_loc1_.var_176)
         {
            _loc1_.var_176 = new LobbyEditorScreen(_loc1_);
         }
      }
      
      public function method_206() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_176)
         {
            _loc1_.var_176.destroy();
            _loc1_.var_176 = null;
         }
      }
      
      public function method_219() : void
      {
         var _loc1_:class_5 = this;
         class_7.method_1("-- Show Cookbook");
         _loc1_.var_132.api.method_106("Cookbook");
      }
      
      public function method_225() : void
      {
         var _loc1_:class_5 = this;
         class_7.method_1("-- Remove Cookbook");
         _loc1_.var_132.api.method_105("Cookbook");
      }
      
      public function method_280(param1:String = null) : void
      {
         var _loc2_:class_5 = this;
         _loc2_.var_318 = true;
         _loc2_.var_270 = _loc2_.var_169;
         _loc2_.var_169 = true;
         if(param1 == "help")
         {
            _loc2_.var_132.api.method_106("LobbyHelp",{"useSection":String(param1)});
         }
         else if(param1 == "cookbook")
         {
            _loc2_.var_132.api.method_106("Cookbook",{"useSection":String(param1)});
         }
         else
         {
            _loc2_.var_132.api.method_106("MainMenu");
         }
      }
      
      public function method_149(param1:Boolean = false) : void
      {
         var _loc2_:class_5 = this;
         _loc2_.var_318 = false;
         _loc2_.var_169 = _loc2_.var_270;
         _loc2_.var_132.api.method_105("SplashCredits");
         _loc2_.var_132.api.method_105("MainMenu");
         _loc2_.var_132.api.method_105("LobbyHelp");
         _loc2_.var_132.api.method_105("Cookbook");
         if(param1)
         {
            try
            {
               _loc2_.hud.closedMenu();
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function method_129(param1:Boolean = false) : void
      {
         var _loc2_:class_5 = this;
         if(!_loc2_.var_216)
         {
            _loc2_.var_216 = new UnlockScreen(_loc2_,param1);
         }
      }
      
      public function method_183() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_216)
         {
            _loc1_.var_216.destroy();
            _loc1_.var_216 = null;
         }
      }
      
      public function showNewHireScreen() : void
      {
         var _loc1_:class_5 = this;
         if(!_loc1_.var_231)
         {
            _loc1_.var_231 = new HireWaiterScreen(_loc1_,_loc1_.var_155);
         }
      }
      
      public function method_268() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_231)
         {
            _loc1_.var_231.destroy();
            _loc1_.var_231 = null;
         }
      }
      
      public function method_252(param1:String) : void
      {
         var _loc2_:class_5 = this;
         if(!_loc2_.var_234)
         {
            _loc2_.var_234 = new PrizePopup(_loc2_,_loc2_.var_155,param1);
         }
      }
      
      public function method_254() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_234)
         {
            _loc1_.var_234.destroy();
            _loc1_.var_234 = null;
         }
      }
      
      public function method_184(param1:Boolean = true) : void
      {
         var _loc2_:class_5 = this;
         if(!_loc2_.var_228)
         {
            _loc2_.var_228 = new SpecialPopup(_loc2_,_loc2_.var_155,param1);
         }
      }
      
      public function method_215() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_228)
         {
            _loc1_.var_228.destroy();
            _loc1_.var_228 = null;
         }
      }
      
      public function method_176(param1:Boolean = false) : void
      {
         var _loc2_:class_5 = this;
         if(!_loc2_.var_229)
         {
            _loc2_.var_229 = new ParadeScreen(_loc2_,param1);
         }
      }
      
      public function method_278() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_229)
         {
            _loc1_.var_229.destroy();
            _loc1_.var_229 = null;
         }
      }
      
      public function method_181(param1:String = "") : void
      {
         var _loc2_:class_5 = this;
         if(!_loc2_.var_213)
         {
            _loc2_.method_137();
            _loc2_.var_132.api.method_105("EndOfDay");
            _loc2_.var_213 = new MiniGameScreen(_loc2_,param1);
         }
      }
      
      public function method_270() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_213)
         {
            _loc1_.var_213.destroy();
            _loc1_.var_213 = null;
         }
      }
      
      public function method_162() : void
      {
         var _loc1_:class_5 = this;
         if(!_loc1_.var_227)
         {
            _loc1_.var_227 = new IntroScreen(_loc1_);
         }
      }
      
      public function method_271() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_227)
         {
            _loc1_.var_227.destroy();
            _loc1_.var_227 = null;
         }
      }
      
      public function method_144(param1:Boolean = false, param2:Function = null) : void
      {
         var _loc3_:class_5 = this;
         if(!_loc3_.var_225)
         {
            _loc3_.var_225 = new OutroScreen(_loc3_,param1,param2);
         }
      }
      
      public function method_216() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.var_225)
         {
            _loc1_.var_225.destroy();
            _loc1_.var_225 = null;
         }
      }
      
      public function method_154() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_132.api.method_105("EndOfDay");
         _loc1_.method_270();
         if(_loc1_.var_128.currentDay == 1)
         {
            _loc1_.training = true;
            _loc1_.var_200 = 1;
         }
         else
         {
            _loc1_.training = false;
         }
         _loc1_.controls = new GameControls(_loc1_);
         _loc1_.var_134 = new CustomerManager(_loc1_);
         _loc1_.var_147 = new TicketManager(_loc1_);
         _loc1_.hud = new GameHUD(_loc1_);
         _loc1_.var_145 = new OrderScreen(_loc1_);
         _loc1_.var_131 = new FryScreen(_loc1_);
         _loc1_.var_136 = new GrillScreen(_loc1_);
         _loc1_.var_139 = new BuildScreen(_loc1_);
         _loc1_.var_187 = new TakeOrderScreen(_loc1_);
         _loc1_.var_183 = new GiveOrderScreen(_loc1_);
         _loc1_.var_195 = new DiningGiveOrderScreen(_loc1_);
         _loc1_.var_199 = new DiningTakeOrderScreen(_loc1_);
         _loc1_.var_130.generateCustomerBitmap();
         if(_loc1_.var_128.currentDay > 1)
         {
            _loc1_.method_122();
         }
         else
         {
            _loc1_.var_134.setupLineup();
            _loc1_.method_153();
         }
      }
      
      public function method_137() : void
      {
         var _loc1_:class_5 = this;
         if(_loc1_.hud)
         {
            _loc1_.controls.destroy();
            _loc1_.var_134.destroy();
            _loc1_.var_147.destroy();
            _loc1_.hud.destroy();
            _loc1_.var_145.destroy();
            _loc1_.var_131.destroy();
            _loc1_.var_136.destroy();
            _loc1_.var_139.destroy();
            _loc1_.var_187.destroy();
            _loc1_.var_183.destroy();
            _loc1_.var_195.destroy();
            _loc1_.var_199.destroy();
            _loc1_.controls = null;
            _loc1_.var_134 = null;
            _loc1_.var_147 = null;
            _loc1_.hud = null;
            _loc1_.var_145 = null;
            _loc1_.var_131 = null;
            _loc1_.var_136 = null;
            _loc1_.var_139 = null;
            _loc1_.var_187 = null;
            _loc1_.var_183 = null;
            _loc1_.var_195 = null;
            _loc1_.var_199 = null;
         }
      }
      
      public function method_239() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.var_205 = false;
         _loc1_.var_129.restoreSoundAfterAd();
         _loc1_.controls.setupGameCycle();
         _loc1_.var_131.initStationUpgrades();
         _loc1_.var_136.initStationUpgrades();
         _loc1_.var_139.initStationUpgrades();
         _loc1_.var_145.initStationUpgrades();
         _loc1_.var_183.initStationUpgrades();
         _loc1_.var_195.initStationUpgrades();
         _loc1_.var_199.initStationUpgrades();
         _loc1_.var_187.initStationUpgrades();
         _loc1_.hud.startHUD();
         _loc1_.var_134.startSpawningCustomers();
      }
      
      public function method_277() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.method_137();
         _loc1_.var_132.api.method_106("EndOfDay");
      }
      
      public function quitToTitle() : void
      {
         var _loc1_:class_5 = this;
         _loc1_.method_191();
         _loc1_.method_119();
         _loc1_.method_149();
         _loc1_.method_137();
         _loc1_.method_141();
      }
      
      public function method_111(... rest) : Boolean
      {
         var _loc2_:class_5 = this;
         if(_loc2_.training && rest.indexOf(_loc2_.var_200) > -1)
         {
            return true;
         }
         return false;
      }
      
      public function method_104(... rest) : void
      {
         var _loc2_:class_5 = this;
         if(_loc2_.training && rest.indexOf(_loc2_.var_200) > -1)
         {
            _loc2_.method_257();
         }
      }
      
      public function method_257() : void
      {
         var _loc1_:class_5 = this;
         ++_loc1_.var_200;
         try
         {
            _loc1_.hud.trainingClip.nextFrame();
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc1_.hud.showTrainingWarning("hidden");
         }
         catch(err:Error)
         {
         }
         if(_loc1_.var_200 > _loc1_.var_305)
         {
            class_7.info("Training Complete!");
            _loc1_.training = false;
            try
            {
               _loc1_.hud.removeSkipButtons();
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function method_203() : void
      {
         var _loc1_:class_5 = this;
         class_7.method_1("SKIP TRAINING");
         _loc1_.training = false;
         _loc1_.hud.removeContextTraining();
         _loc1_.var_128.setTrained("curlyfries");
         _loc1_.var_128.setTrained("baconfries");
         _loc1_.var_128.setTrained("saucefries");
      }
   }
}

