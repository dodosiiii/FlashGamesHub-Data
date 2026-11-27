package cheeseGame.screens
{
   import cheeseGame.data.CustomerData;
   import cheeseGame.data.UserData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import package_2.*;
   import package_4.class_5;
   
   public class StartDayPanel
   {
      
      public var gameObj:class_5;
      
      public var container:MovieClip;
      
      public var clip:MovieClip;
      
      public var var_197:Boolean = false;
      
      public var var_253:Boolean = false;
      
      public var var_354:Number = 10;
      
      public var var_266:Number = 21;
      
      public var action:String = "continue";
      
      public var var_291:Boolean = true;
      
      public var trainingClip:MovieClip;
      
      public var var_296:String = "none";
      
      public var editor:CharacterEditorScreen;
      
      public var paradetip:MovieClip = null;
      
      public var newstar:MovieClip = null;
      
      public var paradestar:MovieClip = null;
      
      public var didSetupOutroButton:Boolean = false;
      
      public var outroButton:SimpleButton = null;
      
      public var var_256:String = "Papa Louie";
      
      public var var_294:Boolean = false;
      
      public function StartDayPanel(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         var _loc4_:StartDayPanel = null;
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.container = param2;
         if(param3 != null && param3.hasOwnProperty("showAd"))
         {
            _loc4_.var_197 = param3.showAd;
         }
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         trace("Setup Start Day Panel");
         var _loc1_:StartDayPanel = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         _loc1_.clip = new startDayPanelMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.container.addEventListener("clickShop",_loc1_.clickShop);
         _loc1_.container.addEventListener("clickEditLobby",_loc1_.clickEditLobby);
         _loc1_.container.addEventListener("clickContinue",_loc1_.clickContinue);
         _loc1_.container.addEventListener("clickParade",_loc1_.clickParade);
         _loc1_.container.addEventListener("clickQuit",_loc1_.clickQuit);
         _loc1_.container.addEventListener("clickCookbook",_loc1_.clickCookbook);
         _loc1_.gameObj.var_132.api.addEventListener("clickCookbook",_loc1_.clickCookbook);
         _loc1_.clip.gokart_btn.visible = false;
         _loc1_.clip.skeeball_btn.visible = false;
         _loc1_.clip.shot_btn.visible = false;
         _loc1_.clip.hallway_btn.visible = false;
         _loc1_.clip.pachinko_btn.visible = false;
         _loc1_.clip.chili_btn.visible = false;
         _loc1_.clip.mess_btn.visible = false;
         if(_loc2_.furniInventory.length <= 2)
         {
            _loc1_.var_291 = false;
         }
         _loc1_.clip.play();
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,this.updateScreen);
         _loc1_.paradetip = _loc1_.clip.paradetip;
         _loc1_.paradestar = _loc1_.clip.paradestar;
         _loc1_.newstar = _loc1_.clip.furnistar;
         _loc1_.paradestar.stop();
         _loc1_.paradestar.visible = false;
         _loc1_.paradetip.visible = false;
         _loc1_.newstar.stop();
         _loc1_.newstar.visible = false;
         _loc1_.editor = new CharacterEditorScreen(_loc1_.gameObj,_loc1_.clip.backdrop_holder);
         _loc1_.clip.outro_btn.visible = false;
      }
      
      public function adjustMenuIcons() : void
      {
         var _loc1_:StartDayPanel = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         if(_loc1_.var_294 == false)
         {
            if(_loc1_.method_208() > _loc2_.seenFloatsInParade)
            {
               class_7.method_1("SHOW NEW FOR PARADE");
               _loc1_.gameObj.var_132.api.setButtonIcon("all","View Parade","menuicon_new");
            }
            if(_loc2_.hasNewFurni)
            {
               class_7.method_1("SHOW NEW FOR DECORATE");
               _loc1_.gameObj.var_132.api.setButtonIcon("all","Decorate Lobby","menuicon_new");
            }
            _loc1_.var_294 = true;
         }
      }
      
      public function method_208() : Number
      {
         var _loc1_:StartDayPanel = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:CustomerData = _loc1_.gameObj.var_130;
         var _loc4_:Number = 0;
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Marty")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Rita")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Mitch")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Maggie")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Penny")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Alberto")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Cooper")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Prudence")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Chuck")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Mandi")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Taylor")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Peggy")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("James")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Willow")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Carlo Romano")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Gino Romano")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Bruna Romano")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Little Edoardo")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Roy")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Doan")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Utah")) > 0)
         {
            _loc4_++;
         }
         if(_loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Tony")) > 0 || _loc2_.getCustomerTotalOrders(_loc3_.getCustomerIndex("Scooter")) > 0)
         {
            _loc4_++;
         }
         class_7.method_1("Floats in parade: " + _loc4_);
         return _loc4_;
      }
      
      public function clickContinue(param1:Event) : void
      {
         var _loc2_:StartDayPanel = this;
         _loc2_.action = "continue";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.gameObj.var_129.switchMusic("none");
      }
      
      public function clickQuit(param1:Event) : void
      {
         var _loc2_:StartDayPanel = this;
         _loc2_.action = "quit";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.var_197 = false;
      }
      
      public function clickShop(param1:Event) : void
      {
         var _loc2_:StartDayPanel = this;
         _loc2_.action = "shop";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.var_197 = false;
      }
      
      public function clickParade(param1:Event) : void
      {
         var _loc2_:StartDayPanel = this;
         _loc2_.action = "parade";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.var_197 = false;
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
      }
      
      public function method_283(param1:MouseEvent) : void
      {
         var _loc2_:StartDayPanel = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_")[0];
         _loc2_.var_296 = _loc3_;
         _loc2_.action = "minigame";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.var_197 = false;
      }
      
      public function clickEditLobby(param1:Event) : void
      {
         var _loc2_:StartDayPanel = this;
         _loc2_.action = "lobbyeditor";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.var_197 = false;
         _loc2_.gameObj.var_128.setTrained("decorate");
         _loc2_.gameObj.var_128.hasNewFurni = false;
         if(_loc2_.trainingClip)
         {
            _loc2_.gameObj.removeChild(_loc2_.trainingClip);
            _loc2_.trainingClip = null;
         }
      }
      
      public function clickCookbook(param1:Event) : void
      {
         var _loc2_:StartDayPanel = this;
         _loc2_.action = "cookbook";
         _loc2_.clip.gotoAndPlay("hide");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.gameObj.var_129.playSound("trayslide.wav");
         _loc2_.paradetip.gotoAndStop(1);
         _loc2_.newstar.visible = false;
         _loc2_.paradestar.visible = false;
         _loc2_.gameObj.var_132.api.disableButtons();
         _loc2_.gameObj.var_132.api.method_114("StartDayPanel");
         _loc2_.var_197 = false;
         if(_loc2_.trainingClip)
         {
            _loc2_.gameObj.removeChild(_loc2_.trainingClip);
            _loc2_.trainingClip = null;
         }
      }
      
      public function method_266(param1:Event = null, param2:Boolean = false) : void
      {
         var _loc3_:StartDayPanel = this;
         class_7.method_1("Ad Finished");
         _loc3_.clip.gotoAndPlay(_loc3_.var_266 + 1);
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:StartDayPanel = this;
         var _loc4_:class_14 = _loc3_.gameObj.var_132.api.var_153;
         if(!_loc3_.didSetupOutroButton)
         {
            _loc3_.setupOutroButton();
         }
         _loc3_.adjustMenuIcons();
         if(_loc3_.clip.currentFrame == _loc3_.var_354 - 1)
         {
            _loc2_ = ["Continue ►","Visit Shop","View Parade"];
            if(_loc3_.var_291)
            {
               _loc2_.push("Decorate Lobby");
            }
            _loc3_.gameObj.var_132.api.enableButtons("StartDayPanel",_loc2_);
         }
         else if(_loc3_.clip.currentFrame == _loc3_.var_266)
         {
            _loc3_.clip.gotoAndPlay(_loc3_.var_266 + 1);
         }
         else if(_loc3_.clip.currentFrame == _loc3_.clip.totalFrames)
         {
            _loc3_.clip.removeEventListener(Event.ENTER_FRAME,this.updateScreen);
            _loc3_.gameObj.var_129.restoreSoundAfterAd();
            if(_loc3_.action == "continue")
            {
               _loc3_.gameObj.var_134.setupLineup();
               if(_loc3_.gameObj.var_134.showNewCustomer && _loc3_.gameObj.var_134.showNewCustomerNum == _loc3_.gameObj.var_130.getCustomerIndex(_loc3_.var_256))
               {
                  class_7.method_1("Show that Outro Screen!");
                  _loc3_.gameObj.method_144();
               }
               else
               {
                  _loc3_.gameObj.method_129();
               }
               _loc3_.gameObj.method_119();
            }
            else if(_loc3_.action == "shop")
            {
               _loc3_.gameObj.method_204();
               _loc3_.gameObj.method_119();
            }
            else if(_loc3_.action == "lobbyeditor")
            {
               _loc3_.gameObj.method_228();
               _loc3_.gameObj.method_119();
            }
            else if(_loc3_.action == "minigame")
            {
               _loc3_.gameObj.method_181(_loc3_.var_296);
               _loc3_.gameObj.method_119();
            }
            else if(_loc3_.action == "cookbook")
            {
               _loc3_.gameObj.method_219();
               _loc3_.gameObj.method_119();
            }
            else if(_loc3_.action == "parade")
            {
               _loc3_.gameObj.method_176(true);
               _loc3_.gameObj.method_119();
            }
            else if(_loc3_.action == "quit")
            {
               _loc3_.gameObj.quitToTitle();
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:StartDayPanel = this;
         _loc1_.setupOutroButton(false);
         if(_loc1_.paradetip != null)
         {
            _loc1_.paradetip.parent.removeChild(_loc1_.paradetip);
            _loc1_.paradetip = null;
         }
         if(_loc1_.newstar != null)
         {
            _loc1_.newstar.parent.removeChild(_loc1_.newstar);
            _loc1_.newstar = null;
         }
         _loc1_.editor.destroy();
         _loc1_.editor = null;
         if(_loc1_.trainingClip)
         {
            _loc1_.gameObj.removeChild(_loc1_.trainingClip);
            _loc1_.trainingClip = null;
         }
         _loc1_.container.removeEventListener("clickShop",_loc1_.clickShop);
         _loc1_.container.removeEventListener("clickEditLobby",_loc1_.clickEditLobby);
         _loc1_.container.removeEventListener("clickContinue",_loc1_.clickContinue);
         _loc1_.container.removeEventListener("clickParade",_loc1_.clickParade);
         _loc1_.container.removeEventListener("clickQuit",_loc1_.clickQuit);
         _loc1_.container.removeEventListener("clickCookbook",_loc1_.clickCookbook);
         _loc1_.gameObj.var_132.api.removeEventListener("clickCookbook",_loc1_.clickCookbook);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function setupOutroButton(param1:Boolean = true) : void
      {
         var firstDay:Number = Number(NaN);
         var init:Boolean = param1;
         var screen:StartDayPanel = this;
         if(!screen.didSetupOutroButton)
         {
            try
            {
               if(init)
               {
                  screen.outroButton = screen.clip.outro_btn;
                  screen.outroButton.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickRewatchOutro);
                  screen.gameObj.var_132.api.method_194(screen.outroButton,"StartDayPanel");
                  firstDay = screen.gameObj.var_128.getCustomerFirstDay(screen.gameObj.var_130.getCustomerIndex(screen.var_256));
                  if(screen.gameObj.var_134.showNewCustomer && screen.gameObj.var_134.showNewCustomerNum == screen.gameObj.var_130.getCustomerIndex(screen.var_256))
                  {
                     screen.outroButton.visible = false;
                  }
                  else if(firstDay > 0 && firstDay <= screen.gameObj.var_128.getDay())
                  {
                     screen.outroButton.visible = true;
                  }
                  else
                  {
                     screen.outroButton.visible = false;
                  }
               }
               else
               {
                  screen.outroButton.removeEventListener(MouseEvent.MOUSE_DOWN,screen.clickRewatchOutro);
                  if(screen.outroButton.parent)
                  {
                     screen.outroButton.parent.removeChild(screen.outroButton);
                  }
                  screen.outroButton = null;
               }
            }
            catch(err:Error)
            {
               class_7.error("Error setting up Outro button: " + err.message);
            }
         }
         screen.didSetupOutroButton = true;
      }
      
      public function clickRewatchOutro(param1:MouseEvent = null) : void
      {
         var _loc2_:StartDayPanel = this;
         if(_loc2_.paradestar != null)
         {
            _loc2_.paradestar.visible = false;
         }
         if(_loc2_.newstar != null)
         {
            _loc2_.newstar.visible = false;
         }
         _loc2_.gameObj.method_144(true,_loc2_.method_272);
      }
      
      public function method_272() : void
      {
         var _loc1_:StartDayPanel = this;
         try
         {
            if(_loc1_.editor)
            {
               _loc1_.editor.clip.fader.gotoAndPlay("fadein");
            }
         }
         catch(err:Error)
         {
         }
      }
   }
}

