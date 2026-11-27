package package_1
{
   import cheeseGame.data.UserData;
   import cheeseGame.managers.ChallengeManager;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flipline.api.*;
   import package_2.*;
   import package_4.class_5;
   import package_5.class_16;
   
   public class class_9
   {
      
      public var gameObj:class_5;
      
      public var api:class_17;
      
      public var var_38:String = "1.0";
      
      private var var_241:String = "myleaderboard";
      
      private var kongregate:*;
      
      private var var_246:Loader;
      
      public var var_331:Boolean = false;
      
      public function class_9(param1:class_5)
      {
         super();
         this.gameObj = param1;
      }
      
      public function method_145() : void
      {
         var _loc4_:class_16 = null;
         var _loc5_:class_16 = null;
         var _loc6_:class_16 = null;
         var _loc7_:class_16 = null;
         var _loc8_:class_16 = null;
         var _loc9_:class_16 = null;
         var _loc10_:class_16 = null;
         var _loc11_:class_16 = null;
         var _loc12_:class_16 = null;
         var _loc1_:class_9 = this;
         _loc1_.api = new class_17(_loc1_.gameObj,_loc1_.gameObj.var_155,640,480);
         var _loc2_:class_16 = _loc1_.api.method_115("SplashScreen","cheeseGame.screens.SplashScreen",false,"",true,"bottom right",true,false,false,true);
         _loc2_.method_116("Play","clickStart",true,false,-1,true,"menuicon_greenarrow");
         _loc2_.method_231(true,"Flipline Studios. MIT");
         _loc2_.method_247(true,"v " + _loc1_.var_38);
         if(class_3.method_60())
         {
            if(class_1.method_73())
            {
               if(class_1.method_84())
               {
                  _loc2_.method_108(true,"top left",class_3.method_24("310101000112011201080054004300430115011501150042009801040101010801040101010600970042009501070105005901130112010500910111010701130110009500970057009900930105009700910104010101060103011100340113011201050091010500970096010101130105005701120101011201040097011100950110009700970106009101040107009901070034011301120105009100950093010501080093010100990106005701080093010800930111009501000097009701110097011001010093"),true,"large");
               }
               else
               {
                  _loc2_.method_108(true,"top left","",true,"large");
               }
            }
            if(class_1.method_93())
            {
               if(class_1.method_90())
               {
                  _loc2_.method_113(true,"top right",class_1.method_72(),"large");
               }
               else
               {
                  _loc2_.method_113(true,"top right","","large");
               }
            }
            if(class_1.method_65())
            {
               _loc2_.method_112("CREDITS","clickCredits");
            }
            if(class_1.method_69())
            {
               if(class_1.method_100() == "")
               {
                  _loc2_.method_182(class_1.method_81(),class_1.method_72());
               }
               else
               {
                  _loc2_.method_182(class_1.method_81(),class_1.method_100());
               }
            }
            if(class_1.method_68())
            {
               _loc2_.method_189(true);
               _loc2_.method_117("http://www.flipline.com/games/papashotdoggeria/index.html?utm_source=promo_panel&utm_medium=papashotdoggeria&utm_campaign=papascheeseria");
               _loc2_.method_117("http://www.flipline.com/games/papascupcakeria/index.html?utm_source=promo_panel&utm_medium=papascupcakeria&utm_campaign=papascheeseria");
               _loc2_.method_117("http://www.flipline.com/games/papaspastaria/index.html?utm_source=promo_panel&utm_medium=papaspastaria&utm_campaign=papascheeseria");
               _loc2_.method_117("http://www.flipline.com/games/papasdonuteria/index.html?utm_source=promo_panel&utm_medium=papasdonuteria&utm_campaign=papascheeseria");
               _loc2_.method_117("http://www.flipline.com/games/papalouie3/index.html?utm_source=promo_panel&utm_medium=papalouie3&utm_campaign=papascheeseria");
            }
            else
            {
               _loc2_.var_242 = true;
               _loc2_.var_179 = false;
            }
         }
         else
         {
            _loc2_.method_260(true,class_3.method_24("25901000112011201080054004300430115011501150042009801040101010801040101010600970042009501070105004301080093010800930111009501000097009701110097011001010093009101040101009500970106011100970110009700960101011000970095011200420100011201050104"));
            _loc2_.method_108(true,"top left",class_3.method_24("310101000112011201080054004300430115011501150042009801040101010801040101010600970042009501070105005901130112010500910111010701130110009500970057009900930105009700910104010101060103011100340113011201050091010500970096010101130105005701120101011201040097011100950110009700970106009101040107009901070034011301120105009100950093010501080093010100990106005701080093010800930111009501000097009701110097011001010093"),true,"large");
            _loc2_.method_124(true,"top right",class_3.method_24("3102010001120112010800540043004301150115011500420108009301080093010401070113010100970042009501070105005901130112010500910111010701130110009500970057009900930105009700910104010101060103011100340113011201050091010500970096010101130105005701120101011201040097011100950110009700970106009101040107009901070034011301120105009100950093010501080093010100990106005701080093010800930111009501000097009701110097011001010093"),true,"large");
            _loc2_.method_189();
            _loc2_.method_200(true,"http://www.facebook.com/flipline",true,"http://www.twitter.com/FliplineStudios");
            _loc2_.method_117("http://www.flipline.com/games/papashotdoggeria/index.html?utm_source=promo_panel&utm_medium=papashotdoggeria&utm_campaign=papascheeseria");
            _loc2_.method_117("http://www.flipline.com/games/papascupcakeria/index.html?utm_source=promo_panel&utm_medium=papascupcakeria&utm_campaign=papascheeseria");
            _loc2_.method_117("http://www.flipline.com/games/papaspastaria/index.html?utm_source=promo_panel&utm_medium=papaspastaria&utm_campaign=papascheeseria");
            _loc2_.method_117("http://www.flipline.com/games/papasdonuteria/index.html?utm_source=promo_panel&utm_medium=papasdonuteria&utm_campaign=papascheeseria");
            _loc2_.method_117("http://www.flipline.com/games/papalouie3/index.html?utm_source=promo_panel&utm_medium=papalouie3&utm_campaign=papascheeseria");
         }
         var _loc3_:class_16 = _loc1_.api.method_115("SlotSelect","cheeseGame.screens.SlotSelectScreen",true,"CHOOSE A SLOT",true,"top right",true);
         _loc3_.method_123("BACK","clickBack",true,"menuicon_redback");
         _loc4_ = _loc1_.api.method_115("CharacterEditor","cheeseGame.screens.CharacterEditorScreen",true,"CREATE YOUR CHEF",true,"top right",true,false,true);
         _loc4_.method_123("BACK","clickBack",true,"menuicon_redback");
         _loc4_.method_116("Continue","clickContinue",false,false,-1,false,"menuicon_greenarrow");
         _loc5_ = _loc1_.api.method_115("WaiterEditor","cheeseGame.screens.CharacterEditorScreen",true,"CREATE YOUR SERVER",true,"top right",true,false,true);
         _loc5_.method_123("BACK","clickBack",true,"menuicon_redback");
         _loc5_.method_116("Hire","clickContinue",false,false,130,false,"menuicon_greenarrow");
         _loc6_ = _loc1_.api.method_115("Cookbook","cheeseGame.screens.CookbookScreen",true,"COOKBOOK",true,"top right",true,false,true);
         _loc6_.method_116("Close Cookbook","clickContinue",false,false,-1,false,"menuicon_greenarrow");
         _loc7_ = _loc1_.api.method_115("EndOfDay","cheeseGame.screens.EndOfDayScreen",true,"TODAY\'S SERVICE",true,"top right",true);
         _loc7_.method_123("QUIT","clickQuit",true,"menuicon_quit");
         _loc7_.method_116("Continue","clickContinue",false,true,-1,false,"menuicon_greenarrow");
         if(class_3.method_60())
         {
            if(class_1.method_67())
            {
               if(class_1.method_98())
               {
                  _loc7_.method_108(true,"bottom left",class_1.method_76());
               }
               else
               {
                  _loc7_.method_108(true,"bottom left","");
               }
            }
            if(class_1.method_71())
            {
               if(class_1.method_79())
               {
                  _loc7_.method_113(true,"bottom right",class_1.method_72(),"small");
               }
               else
               {
                  _loc7_.method_113(true,"bottom right","","small");
               }
            }
            if(class_1.method_64())
            {
               _loc7_.method_112("Submit Score","clickSubmitScore",true);
            }
            if(_loc1_.method_126())
            {
               _loc7_.method_112("Save Backup","clickSaveBackup",true,-1,"menuicon_backup");
            }
         }
         else
         {
            _loc7_.method_108(true,"bottom left",class_1.method_76());
            _loc7_.method_124(true,"bottom right",class_1.method_86(),false,"small");
            if(class_1.method_66())
            {
               _loc7_.method_112("Submit Score","clickSubmitScore",true);
            }
            if(_loc1_.method_126())
            {
               _loc7_.method_112("Save Backup","clickSaveBackup",true,-1,"menuicon_backup");
            }
         }
         _loc8_ = _loc1_.api.method_115("StartDayPanel","cheeseGame.screens.StartDayPanel",false,"",true,"top right",true);
         _loc8_.method_123("QUIT","clickQuit",true,"menuicon_quit");
         _loc8_.method_112("View Parade","clickParade",true,130,"menuicon_parade");
         _loc8_.method_112("Visit Shop","clickShop",true,130,"menuicon_shop");
         _loc8_.method_112("Decorate Lobby","clickEditLobby",true,130,"menuicon_decorate");
         _loc8_.method_116("Continue","clickContinue",false,true,-1,true,"menuicon_greenarrow");
         if(class_3.method_60())
         {
            if(class_1.method_67())
            {
               if(class_1.method_98())
               {
                  _loc8_.method_108(true,"bottom left",class_1.method_76());
               }
               else
               {
                  _loc8_.method_108(true,"bottom left","");
               }
            }
            if(class_1.method_71())
            {
               if(class_1.method_79())
               {
                  _loc8_.method_113(true,"bottom right",class_1.method_72(),"small");
               }
               else
               {
                  _loc8_.method_113(true,"bottom right","","small");
               }
            }
         }
         else
         {
            _loc8_.method_124(true,"bottom right",class_1.method_86(),false,"small");
            _loc8_.method_108(true,"bottom left",class_1.method_76());
         }
         _loc9_ = _loc1_.api.method_115("ShopScreen","cheeseGame.screens.ShopScreen",false,"",false,"",false,false,false,false,true);
         _loc9_.method_116("Leave Shop","clickBackToGame",false,false,-1,false,"menuicon_greenarrow");
         _loc10_ = _loc1_.api.method_115("SplashCredits","cheeseGame.screens.MainMenuScreen",true,"CREDITS",true,"top right",true);
         _loc10_.method_116("Back","clickBackToSplash",false,false,-1,false,"menuicon_greenarrow");
         if(class_3.method_60())
         {
            if(class_1.method_67())
            {
               if(class_1.method_98())
               {
                  _loc10_.method_108(true,"bottom left",class_1.method_76());
               }
               else
               {
                  _loc10_.method_108(true,"bottom left","");
               }
            }
            if(class_1.method_71())
            {
               if(class_1.method_79())
               {
                  _loc10_.method_113(true,"bottom right",class_1.method_72(),"small");
               }
               else
               {
                  _loc10_.method_113(true,"bottom right","","small");
               }
            }
         }
         else
         {
            _loc10_.method_124(true,"bottom right",class_1.method_86(),false,"small");
            _loc10_.method_108(true,"bottom left",class_1.method_76());
         }
         _loc11_ = _loc1_.api.method_115("MainMenu","cheeseGame.screens.MainMenuScreen",true,"INFO",true,"top right",true);
         _loc11_.method_116("Back to Game","clickBackToGame",false,false,-1,false,"menuicon_greenarrow");
         _loc11_.method_112("INFO","clickInfo",false,-1,"menuicon_info");
         _loc11_.method_112("CUSTOMERS","clickCustomers",false,-1,"menuicon_customers");
         _loc11_.method_112("BADGES","clickMedals",false,-1,"menuicon_badges");
         _loc11_.method_112("HELP","clickHelp",false,-1,"menuicon_help");
         _loc11_.method_112("CREDITS","clickCredits",false,-1,"menuicon_credits");
         _loc11_.method_112("COOKBOOK","clickCookbook",false,-1,"menuicon_cookbook");
         _loc11_.method_123("QUIT","clickQuit",true,"menuicon_quit");
         if(class_3.method_60())
         {
            if(class_1.method_67())
            {
               if(class_1.method_98())
               {
                  _loc11_.method_108(true,"bottom left",class_1.method_76());
               }
               else
               {
                  _loc11_.method_108(true,"bottom left","");
               }
            }
            if(class_1.method_71())
            {
               if(class_1.method_79())
               {
                  _loc11_.method_113(true,"bottom right",class_1.method_72(),"small");
               }
               else
               {
                  _loc11_.method_113(true,"bottom right","","small");
               }
            }
         }
         else
         {
            _loc11_.method_124(true,"bottom right",class_1.method_86(),false,"small");
            _loc11_.method_108(true,"bottom left",class_1.method_76());
         }
         _loc12_ = _loc1_.api.method_115("LobbyHelp","cheeseGame.screens.MainMenuScreen",true,"LOBBY HELP",true,"top right",true);
         _loc12_.method_116("Back to Lobby","clickBackToGame",false,false,-1,false,"menuicon_greenarrow");
         if(class_3.method_60())
         {
            if(class_1.method_67())
            {
               if(class_1.method_98())
               {
                  _loc12_.method_108(true,"bottom left",class_1.method_76());
               }
               else
               {
                  _loc12_.method_108(true,"bottom left","");
               }
            }
            if(class_1.method_71())
            {
               if(class_1.method_79())
               {
                  _loc12_.method_113(true,"bottom right",class_1.method_72(),"small");
               }
               else
               {
                  _loc12_.method_113(true,"bottom right","","small");
               }
            }
         }
         else
         {
            _loc12_.method_108(true,"bottom left",class_1.method_76());
            _loc12_.method_124(true,"bottom right",class_1.method_86(),false,"small");
         }
         _loc1_.method_213();
      }
      
      public function method_126() : Boolean
      {
         if(class_3.method_87())
         {
            return false;
         }
         if(Boolean(class_3.method_60()) && class_1.method_75() == false)
         {
            return false;
         }
         return true;
      }
      
      public function method_155(param1:*) : void
      {
         var _loc2_:class_9 = this;
         _loc2_.api.method_155(param1);
      }
      
      public function submitScore(param1:Number, param2:String = "Anonymous", param3:Function = null, param4:Object = null) : void
      {
         var _loc5_:class_9 = this;
         if(!class_3.method_60())
         {
            if(class_1.method_66())
            {
               _loc5_.api.method_131(_loc5_.var_241,param3,true,true,true,param2,param1,param4);
            }
         }
         else if(class_1.method_64())
         {
            _loc5_.api.method_131(_loc5_.var_241,param3,true,true,true,param2,param1,param4);
         }
      }
      
      public function method_224(param1:Function = null) : void
      {
         var _loc2_:class_9 = this;
         if(!class_3.method_60())
         {
            if(class_1.method_66())
            {
               _loc2_.api.method_131(_loc2_.var_241,param1);
            }
         }
         else if(class_1.method_64())
         {
            _loc2_.api.method_131(_loc2_.var_241,param1);
         }
      }
      
      public function method_125() : void
      {
         var _loc1_:class_9 = this;
         try
         {
            if(!class_3.method_60())
            {
               if(class_1.method_66())
               {
                  _loc1_.api.method_135();
               }
            }
            else if(class_1.method_64())
            {
               _loc1_.api.method_135();
            }
         }
         catch(err:Error)
         {
         }
      }
      
      private function method_41() : LoaderInfo
      {
         return this.gameObj.root.loaderInfo;
      }
      
      public function method_156() : void
      {
         var _loc1_:class_9 = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:ChallengeManager = _loc1_.gameObj.var_142;
         if(Boolean(class_3.method_87()) && _loc1_.var_331 && Boolean(_loc1_.kongregate))
         {
            _loc1_.kongregate.stats.submit("highScore",_loc2_.getTotalPoints());
            _loc1_.kongregate.stats.submit("rank",_loc2_.getRank());
            _loc1_.kongregate.stats.submit("daysPlayed",_loc2_.getDay());
            _loc1_.kongregate.stats.submit("customersUnlocked",_loc2_.getStatCustomersUnlocked());
            _loc1_.kongregate.stats.submit("bronzeCustomers",_loc2_.getStatCustomersBronze());
            _loc1_.kongregate.stats.submit("silverCustomers",_loc2_.getStatCustomersSilver());
            _loc1_.kongregate.stats.submit("goldCustomers",_loc2_.getStatCustomersGold());
         }
      }
      
      public function method_213() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:class_9 = this;
         if(class_3.method_87())
         {
            class_7.info("On Kongregate, connect to API.");
            _loc3_.var_331 = true;
            _loc1_ = LoaderInfo(_loc3_.method_41()).parameters;
            _loc2_ = _loc1_.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
            Security.allowDomain(_loc2_);
            _loc3_.var_246 = new Loader();
            _loc3_.var_246.contentLoaderInfo.addEventListener(Event.COMPLETE,_loc3_.method_211);
            _loc3_.var_246.load(new URLRequest(_loc2_));
            _loc3_.gameObj.addChild(_loc3_.var_246);
         }
      }
      
      public function method_211(param1:Event) : void
      {
         var _loc2_:class_9 = this;
         class_7.info("Kongregate API Connected.");
         _loc2_.kongregate = param1.target.content;
         _loc2_.kongregate.services.connect();
      }
   }
}

