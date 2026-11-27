package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.managers.CustomerManager;
   import cheeseGame.managers.SoundManager;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import package_2.*;
   import package_4.*;
   
   public class OrderScreen
   {
      
      public var clip:MovieClip;
      
      public var isActive:Boolean = false;
      
      public var gameObj:class_5;
      
      public var orderLineTargetX:Number = 105;
      
      public var orderLineTargetY:Number = 198;
      
      public var orderLineScale:Number = 0.6;
      
      public var leaveLineTargetX:Number = 152;
      
      public var leaveLineTargetY:Number = 186;
      
      public var leaveLineScale:Number = 0.6;
      
      public var waitLineTargetX:Number = 141;
      
      public var waitLineTargetY:Number = 131;
      
      public var waitLineScale:Number = 0.6;
      
      public var customerSpacing:Number = 85;
      
      public var offScreenX:Number = 675;
      
      public var firstCustomerStartX:Number = 600;
      
      public var forceCustomerDelay:Number = 900;
      
      public var timeEnteredStation:Number = 0;
      
      public var clicksToStation:Number = 0;
      
      public var clicksToForce:Number = 2;
      
      public var clickForceCustomerDelay:Number = 90;
      
      public var willForceCustomer:Boolean = false;
      
      public var clickForceCustomerTimer:Number = 0;
      
      public var signBarWidth:Number = 80;
      
      public var signFreshStartX:Number = -25;
      
      public var signFreshRange:Number = 54;
      
      public var readyToTrainCloser:Boolean = false;
      
      public var readyToTrainCritic:Boolean = false;
      
      public var furniItems:Vector.<FurnitureItem>;
      
      public var backdropBitmap:Bitmap;
      
      public var muted_boombox:Boolean = false;
      
      public var muted_jukebox:Boolean = false;
      
      public var muted_phonograph:Boolean = false;
      
      public var boomboxMC:MovieClip = null;
      
      public var jukeboxMC:MovieClip = null;
      
      public var phonographMC:MovieClip = null;
      
      public var isWaitingToEnd:Boolean = false;
      
      public var endingTimer:Number = 0;
      
      public var endingTimerMax:Number = 80;
      
      public var worker:Worker = null;
      
      public function OrderScreen(param1:class_5)
      {
         this.furniItems = new Vector.<FurnitureItem>();
         super();
         var _loc2_:OrderScreen = this;
         _loc2_.gameObj = param1;
         _loc2_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:OrderScreen = this;
         _loc1_.clip = new orderScreenMC();
         _loc1_.clip.opensign.gotoAndStop(1);
         _loc1_.clip.opensign.sign.gotoAndStop(1);
         _loc1_.clip.opensign.sign.opensign.bar.scaleX = 0;
         _loc1_.clip.opensign.sign.opensign.freshbar.mask = _loc1_.clip.opensign.sign.opensign.freshmask;
         _loc1_.clip.takeorder_bubble.clip.takeorder_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickTakeOrder);
         _loc1_.clip.takeorder_bubble.clip.takeorder_closer_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickTakeOrder);
         _loc1_.hideTakeOrderBubble();
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip,_loc1_.gameObj.workerData,20,173,0.6,false,true);
         _loc1_.gameObj.var_129.addEventListener("musicIsMuted",_loc1_.onMusicIsMuted);
         _loc1_.gameObj.var_129.addEventListener("musicIsNotMuted",_loc1_.onMusicIsNotMuted);
      }
      
      public function onMusicIsMuted(param1:Event) : void
      {
         var _loc2_:OrderScreen = this;
         var _loc3_:SoundManager = _loc2_.gameObj.var_129;
         var _loc4_:SoundTransform = new SoundTransform(0,0);
         if(_loc3_.track_jukebox)
         {
            _loc3_.track_jukebox.soundTransform = _loc4_;
         }
         if(_loc3_.track_boombox)
         {
            _loc3_.track_boombox.soundTransform = _loc4_;
         }
         if(_loc3_.track_phonograph)
         {
            _loc3_.track_phonograph.soundTransform = _loc4_;
         }
      }
      
      public function onMusicIsNotMuted(param1:Event) : void
      {
         var _loc2_:OrderScreen = this;
         var _loc3_:SoundManager = _loc2_.gameObj.var_129;
         var _loc4_:UserData = _loc2_.gameObj.var_128;
         var _loc5_:SoundTransform = new SoundTransform(1,0);
         if(_loc2_.isActive)
         {
            if(_loc4_.isFurniInLobby(_loc2_.gameObj.var_133.jukeboxTag) && !_loc2_.muted_jukebox)
            {
               if(_loc3_.track_jukebox)
               {
                  _loc3_.track_jukebox.soundTransform = _loc5_;
               }
            }
            if(_loc4_.isFurniInLobby(_loc2_.gameObj.var_133.boomboxTag) && !_loc2_.muted_boombox)
            {
               if(_loc3_.track_boombox)
               {
                  _loc3_.track_boombox.soundTransform = _loc5_;
               }
            }
            if(_loc4_.isFurniInLobby(_loc2_.gameObj.var_133.phonographTag) && !_loc2_.muted_phonograph)
            {
               if(_loc3_.track_phonograph)
               {
                  _loc3_.track_phonograph.soundTransform = _loc5_;
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:OrderScreen = this;
         _loc1_.gameObj.var_129.removeEventListener("musicIsMuted",_loc1_.onMusicIsMuted);
         _loc1_.gameObj.var_129.removeEventListener("musicIsNotMuted",_loc1_.onMusicIsNotMuted);
         _loc1_.clip.takeorder_bubble.clip.takeorder_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickTakeOrder);
         _loc1_.clip.takeorder_bubble.clip.takeorder_closer_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickTakeOrder);
         _loc1_.worker.destroy();
         _loc1_.worker = null;
         if(_loc1_.backdropBitmap != null)
         {
            _loc1_.backdropBitmap.bitmapData.dispose();
            try
            {
               _loc1_.clip.backdrop_holder.removeChild(_loc1_.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            _loc1_.backdropBitmap = null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.furniItems.length)
         {
            _loc1_.furniItems[_loc2_].destroy();
            _loc1_.furniItems[_loc2_] = null;
            _loc2_++;
         }
         _loc1_.furniItems = null;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.clip = null;
      }
      
      public function activateScreen() : void
      {
         var _loc1_:Customer = null;
         var _loc2_:OrderScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(!_loc2_.gameObj.var_138.contains(_loc2_.clip))
         {
            _loc2_.gameObj.var_138.addChild(_loc2_.clip);
         }
         _loc2_.gameObj.hud.clip.doorchime_alert.visible = false;
         _loc2_.gameObj.hud.clip.doorchime_alert.stop();
         if(_loc3_.hasRibbon())
         {
            _loc2_.clip.ribbon.visible = true;
         }
         else
         {
            _loc2_.clip.ribbon.visible = false;
         }
         if(_loc2_.clip.opensign.currentFrame == 1)
         {
            _loc2_.clip.opensign.gotoAndPlay(2);
         }
         _loc2_.hideTakeOrderBubble();
         var _loc4_:CustomerManager = _loc2_.gameObj.var_134;
         if(_loc4_.orderline.length > 0)
         {
            _loc1_ = _loc4_.orderline[0];
            if(!_loc1_.isWalking && _loc1_.currentLine == "orderline")
            {
               _loc2_.showTakeOrderBubble(_loc1_.isCloser);
            }
         }
         _loc2_.timeEnteredStation = _loc2_.gameObj.controls.gameplayTimer;
         _loc2_.isActive = true;
         _loc2_.worker.playAnimation("leanin");
         _loc4_.updateCustomersForBonuses();
         var _loc5_:Number = _loc2_.gameObj.controls.gameplayTimer / _loc2_.gameObj.var_211;
         var _loc6_:Number = _loc2_.gameObj.var_133.getSkyStartingFrame();
         if(_loc5_ > 0.98)
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_ + 6);
         }
         else if(_loc5_ > 0.8)
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_ + 5);
         }
         else if(_loc5_ > 0.65)
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_ + 4);
         }
         else if(_loc5_ > 0.5)
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_ + 3);
         }
         else if(_loc5_ > 0.35)
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_ + 2);
         }
         else if(_loc5_ > 0.2)
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_ + 1);
         }
         else
         {
            _loc2_.clip.outside.gotoAndStop(_loc6_);
         }
         if(Boolean(_loc2_.gameObj.var_128.currentDay >= 2 && _loc2_.gameObj.var_147.hangerTicket) && Boolean(_loc2_.gameObj.var_147.hangerTicket.ticketNumber == 2) && !_loc2_.gameObj.var_128.hasTrained("ticket"))
         {
            _loc2_.gameObj.hud.showContextTraining("ticket");
            _loc2_.gameObj.var_128.setTrained("ticket");
         }
         if(_loc2_.gameObj.var_134.outOfCustomers(true) && _loc2_.gameObj.var_147.outOfTickets())
         {
            class_7.method_1("End the Day!");
            _loc2_.gameObj.var_129.playMusicClip("endofday.wav");
            _loc2_.gameObj.hud.disableStationButtons();
            _loc2_.isWaitingToEnd = true;
            _loc2_.endingTimer = 0;
         }
         else
         {
            _loc2_.gameObj.var_129.switchMusic("order");
            _loc2_.playFurniMusic();
         }
      }
      
      public function deactivateScreen() : void
      {
         var _loc1_:OrderScreen = this;
         if(_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.removeChild(_loc1_.clip);
         }
         _loc1_.stopFurniMusic();
         _loc1_.isActive = false;
      }
      
      public function showTakeOrderBubble(param1:Boolean = false) : void
      {
         var _loc2_:OrderScreen = this;
         _loc2_.gameObj.method_104(1);
         _loc2_.clip.takeorder_bubble.visible = true;
         if(param1)
         {
            _loc2_.clip.takeorder_bubble.clip.takeorder_btn.visible = false;
            _loc2_.clip.takeorder_bubble.clip.takeorder_closer_btn.visible = true;
            _loc2_.clip.takeorder_bubble.clip.gotoAndStop("closer");
         }
         else
         {
            _loc2_.clip.takeorder_bubble.clip.takeorder_btn.visible = true;
            _loc2_.clip.takeorder_bubble.clip.takeorder_closer_btn.visible = false;
            _loc2_.clip.takeorder_bubble.clip.gotoAndStop("normal");
         }
      }
      
      public function hideTakeOrderBubble() : void
      {
         var _loc1_:OrderScreen = this;
         _loc1_.clip.takeorder_bubble.visible = false;
      }
      
      public function clickTakeOrder(param1:MouseEvent) : void
      {
         var _loc2_:OrderScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clicksToStation = 0;
         _loc2_.hideTakeOrderBubble();
         _loc2_.gameObj.method_104(2,26);
         if(_loc2_.gameObj.hud.whichContextTraining == "critic" || _loc2_.gameObj.hud.whichContextTraining == "closer")
         {
            _loc2_.gameObj.hud.removeContextTraining();
         }
         var _loc3_:Customer = _loc2_.gameObj.var_134.orderline[0];
         if(_loc3_ != null && _loc3_.isWaiter)
         {
            _loc2_.gameObj.hud.startTransition("diningTakeOrder");
         }
         else
         {
            _loc2_.gameObj.hud.startTransition("takeOrder");
         }
      }
      
      public function updateScreen() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:OrderScreen = this;
         if(_loc6_.isActive)
         {
            if(_loc6_.gameObj.controls.gameplayTimer - _loc6_.timeEnteredStation > _loc6_.forceCustomerDelay)
            {
               if(_loc6_.gameObj.var_134.orderline.length == 0 && _loc6_.gameObj.var_134.totalCustomers < _loc6_.gameObj.var_134.customerLineup.length)
               {
                  if(_loc6_.gameObj.var_128.currentDay > 1)
                  {
                     _loc6_.gameObj.var_134.spawnCustomer();
                  }
               }
            }
            _loc6_.clip.opensign.sign.opensign.bar.scaleX = Math.min(1,_loc6_.gameObj.controls.gameplayTimer / _loc6_.gameObj.var_211);
            _loc1_ = _loc6_.gameObj.var_134.customerLineup.length - _loc6_.gameObj.var_134.totalCustomers;
            _loc2_ = _loc6_.gameObj.var_134.spawnTiming;
            _loc3_ = _loc6_.gameObj.var_134.lastSpawnTime + _loc2_ - _loc6_.gameObj.controls.gameplayTimer;
            _loc1_--;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            _loc4_ = _loc6_.gameObj.controls.gameplayTimer + _loc3_ + _loc1_ * _loc2_;
            _loc5_ = Math.min(1,_loc4_ / _loc6_.gameObj.var_211);
            _loc6_.clip.opensign.sign.opensign.marker.x = _loc6_.clip.opensign.sign.opensign.bar.x + _loc5_ * _loc6_.signBarWidth;
            _loc6_.worker.animateModel();
         }
         if(_loc6_.willForceCustomer)
         {
            ++_loc6_.clickForceCustomerTimer;
            if(_loc6_.clickForceCustomerTimer >= _loc6_.clickForceCustomerDelay)
            {
               if(_loc6_.gameObj.var_134.orderline.length == 0 && _loc6_.gameObj.var_134.totalCustomers < _loc6_.gameObj.var_134.customerLineup.length)
               {
                  class_7.method_1(">> Force a customer!");
                  _loc6_.gameObj.var_134.spawnCustomer();
               }
               _loc6_.willForceCustomer = false;
            }
         }
         if(_loc6_.isWaitingToEnd)
         {
            ++_loc6_.endingTimer;
            if(_loc6_.endingTimer == _loc6_.endingTimerMax)
            {
               class_7.error("=============================================================== END OF DAY " + _loc6_.gameObj.var_128.currentDay);
               _loc6_.gameObj.var_205 = true;
               _loc6_.gameObj.hud.startTransition("ending");
               _loc6_.isWaitingToEnd = false;
            }
         }
      }
      
      public function registerClickForForcing() : void
      {
         var _loc1_:OrderScreen = this;
         var _loc2_:CustomerManager = _loc1_.gameObj.var_134;
         if(_loc1_.gameObj.var_128.currentDay > 1 && !_loc1_.willForceCustomer && _loc2_.orderline.length == 0 && _loc2_.waitline.length <= 2 && _loc2_.totalCustomers < _loc2_.customerLineup.length)
         {
            ++_loc1_.clicksToStation;
            class_7.method_1("Register Click for Forcing Customer (" + _loc1_.clicksToStation + ")");
            if(_loc1_.clicksToStation >= _loc1_.clicksToForce)
            {
               class_7.method_1(">> Will force a customer out!");
               _loc1_.clickForceCustomerTimer = 0;
               _loc1_.clicksToStation = 0;
               _loc1_.willForceCustomer = true;
            }
         }
      }
      
      public function initStationUpgrades() : void
      {
         var i:int;
         var data:FurniData = null;
         var x:Number = Number(NaN);
         var y:Number = Number(NaN);
         var screen:OrderScreen = this;
         var user:UserData = screen.gameObj.var_128;
         var f:int = 0;
         while(f < user.lobbyPlacement.length)
         {
            data = screen.gameObj.var_133.getFurniFromTag(user.lobbyPlacement[f][0]);
            x = Number(user.lobbyPlacement[f][1]);
            y = Number(user.lobbyPlacement[f][2]);
            screen.addFurni(data,false,x,y);
            f++;
         }
         if(screen.backdropBitmap != null)
         {
            screen.backdropBitmap.bitmapData.dispose();
            try
            {
               screen.clip.backdrop_holder.removeChild(screen.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            screen.backdropBitmap = null;
         }
         screen.backdropBitmap = screen.createLobbyBackdropBitmap();
         screen.clip.backdrop_holder.addChild(screen.backdropBitmap);
         i = 0;
         while(i < screen.furniItems.length)
         {
            if(screen.furniItems[i].data.tag == "poster_window" || screen.furniItems[i].data.tag == "poster_window2" || screen.furniItems[i].data.tag == "poster_window3" || screen.furniItems[i].data.tag == "poster_window4")
            {
               try
               {
                  screen.backdropBitmap.bitmapData.fillRect(new Rectangle(screen.furniItems[i].clip.x,screen.furniItems[i].clip.y,screen.furniItems[i].tileWidth * screen.furniItems[i].data.width,screen.furniItems[i].tileWidth * screen.furniItems[i].data.depth),0);
               }
               catch(err:Error)
               {
                  class_7.error("Error cutting out wall with smart window: " + err.message);
               }
            }
            i++;
         }
         screen.clip.opensign.sign.opensign.freshbar.x = screen.signFreshStartX + screen.gameObj.var_128.getLobbyFreshness() * screen.signFreshRange;
         screen.clip.opensign.sign.opensign.points_txt.text = String(Math.round(screen.gameObj.var_128.getLobbyPercent() * screen.gameObj.var_128.getLobbyMaxPoints()) + "/" + screen.gameObj.var_128.getLobbyMaxPoints());
      }
      
      public function addFurni(param1:FurniData, param2:Boolean, param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:OrderScreen = null;
         _loc5_ = this;
         var _loc6_:MovieClip = _loc5_.clip.wall_layer;
         if(param1.type == FurniData.TYPE_FURNI)
         {
            if(param4 == 0)
            {
               _loc6_ = _loc5_.clip.floor0_layer;
            }
            else if(param4 == 1)
            {
               _loc6_ = _loc5_.clip.floor1_layer;
            }
            else
            {
               _loc6_ = _loc5_.clip.floor2_layer;
            }
         }
         var _loc7_:FurnitureItem = new FurnitureItem(_loc5_.gameObj,_loc6_,param1,param3,param4,false,true);
         _loc5_.furniItems.push(_loc7_);
      }
      
      private function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc6_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:OrderScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Bitmap = null;
         var _loc5_:MovieClip = new lobbyBackdropMC();
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc5_.holder.wallparts["wall" + _loc1_].gotoAndStop(_loc3_.lobbyWallpaper);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            _loc5_.holder.floorparts["floor" + _loc1_].gotoAndStop(_loc3_.lobbyFlooring);
            _loc1_++;
         }
         _loc5_.holder.trim.transform.colorTransform = _loc2_.createColorTransform(_loc3_.lobbyTrim);
         _loc5_.holder.countertop.transform.colorTransform = _loc2_.createColorTransform(_loc3_.lobbyTop);
         _loc5_.holder.wallparts.mask = _loc5_.holder.wallmask;
         _loc5_.holder.floorparts.mask = _loc5_.holder.floormask;
         _loc6_ = new BitmapData(640,480,true,4294967295);
         _loc6_.draw(_loc5_,null,null,null,new Rectangle(0,0,640,480));
         _loc4_ = new Bitmap(_loc6_);
         _loc5_ = null;
         return _loc4_;
      }
      
      private function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
      }
      
      public function playFurniMusic(param1:String = "all") : void
      {
         var _loc2_:OrderScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:SoundManager = _loc2_.gameObj.var_129;
         var _loc5_:SoundTransform = new SoundTransform(1,0);
         if(_loc4_.isMusicMute)
         {
            _loc5_.volume = 0;
         }
         if((param1 == "all" || param1 == "jukebox" || param1 == _loc2_.gameObj.var_133.jukeboxTag) && _loc3_.isFurniInLobby(_loc2_.gameObj.var_133.jukeboxTag) && !_loc2_.muted_jukebox)
         {
            if(_loc4_.track_jukebox)
            {
               _loc4_.track_jukebox.soundTransform = _loc5_;
            }
         }
         if((param1 == "all" || param1 == "boombox" || param1 == _loc2_.gameObj.var_133.boomboxTag) && _loc3_.isFurniInLobby(_loc2_.gameObj.var_133.boomboxTag) && !_loc2_.muted_boombox)
         {
            if(_loc4_.track_boombox)
            {
               _loc4_.track_boombox.soundTransform = _loc5_;
            }
         }
         if((param1 == "all" || param1 == "phonograph" || param1 == _loc2_.gameObj.var_133.phonographTag) && _loc3_.isFurniInLobby(_loc2_.gameObj.var_133.phonographTag) && !_loc2_.muted_phonograph)
         {
            if(_loc4_.track_phonograph)
            {
               _loc4_.track_phonograph.soundTransform = _loc5_;
            }
         }
      }
      
      public function stopFurniMusic() : void
      {
         var _loc1_:OrderScreen = this;
         var _loc2_:SoundManager = _loc1_.gameObj.var_129;
         var _loc3_:SoundTransform = new SoundTransform(0,0);
         if(_loc2_.track_jukebox)
         {
            _loc2_.track_jukebox.soundTransform = _loc3_;
         }
         if(_loc2_.track_boombox)
         {
            _loc2_.track_boombox.soundTransform = _loc3_;
         }
         if(_loc2_.track_phonograph)
         {
            _loc2_.track_phonograph.soundTransform = _loc3_;
         }
      }
      
      public function toggleMusicMute(param1:String) : void
      {
         var _loc2_:OrderScreen = this;
         var _loc3_:SoundManager = _loc2_.gameObj.var_129;
         var _loc4_:SoundTransform = new SoundTransform(0,0);
         if(param1 == _loc2_.gameObj.var_133.jukeboxTag)
         {
            _loc2_.muted_jukebox = !_loc2_.muted_jukebox;
            if(_loc2_.muted_jukebox == false)
            {
               _loc2_.playFurniMusic("jukebox");
            }
            else if(_loc3_.track_jukebox)
            {
               _loc3_.track_jukebox.soundTransform = _loc4_;
            }
         }
         else if(param1 == _loc2_.gameObj.var_133.boomboxTag)
         {
            _loc2_.muted_boombox = !_loc2_.muted_boombox;
            if(_loc2_.muted_boombox == false)
            {
               _loc2_.playFurniMusic("boombox");
            }
            else if(_loc3_.track_boombox)
            {
               _loc3_.track_boombox.soundTransform = _loc4_;
            }
         }
         else if(param1 == _loc2_.gameObj.var_133.phonographTag)
         {
            _loc2_.muted_phonograph = !_loc2_.muted_phonograph;
            if(_loc2_.muted_phonograph == false)
            {
               _loc2_.playFurniMusic("phonograph");
            }
            else if(_loc3_.track_phonograph)
            {
               _loc3_.track_phonograph.soundTransform = _loc4_;
            }
         }
      }
   }
}

