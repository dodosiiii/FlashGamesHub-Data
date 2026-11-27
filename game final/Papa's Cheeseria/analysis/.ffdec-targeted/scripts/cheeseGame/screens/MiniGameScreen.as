package cheeseGame.screens
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class MiniGameScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var miniGame:MiniGame;
      
      public var forceGame:String = "";
      
      public var whichGame:String = "none";
      
      public var possibleGames:Array = [MiniGame.TYPE_HALLWAY,MiniGame.TYPE_SKEEBALL,MiniGame.TYPE_CHILI,MiniGame.TYPE_PACHINKO,MiniGame.TYPE_GOKART,MiniGame.TYPE_MESS,MiniGame.TYPE_SHOT];
      
      public var prizeSets:Array = [0,1,2,3,4,5,6];
      
      public var wonPrizeSKU:String = null;
      
      public var wonPrizeAmount:Number = 0;
      
      public var wonPrizeIsClothing:Boolean = false;
      
      public var wonPrizeClothingMode:String = "";
      
      public var clickedPlay:Boolean = false;
      
      public var didPlayApplause:Boolean = false;
      
      public var minigameMusic:SoundChannel;
      
      public var minigameFiller:SoundChannel;
      
      public var musicVolume:Number = 0;
      
      public var musicVolumeSpeed:Number = 0.05;
      
      public var shouldPlayMusic:Boolean = false;
      
      public var mannequinColor:uint = 14540253;
      
      public function MiniGameScreen(param1:class_5, param2:String = "")
      {
         super();
         var _loc3_:MiniGameScreen = this;
         _loc3_.gameObj = param1;
         _loc3_.forceGame = param2;
         _loc3_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:MiniGameScreen = this;
         _loc2_.clip = new miniGameScreenMC();
         _loc2_.clip.x = 320;
         _loc2_.clip.y = 240;
         _loc2_.gameObj.var_155.addChild(_loc2_.clip);
         if(_loc2_.forceGame != "")
         {
            _loc2_.whichGame = _loc2_.forceGame;
         }
         else
         {
            _loc1_ = _loc2_.gameObj.var_128.getDay() % 7;
            _loc2_.whichGame = _loc2_.possibleGames[_loc1_];
         }
         _loc2_.clip.logo.gotoAndStop(_loc2_.whichGame);
         _loc2_.clip.hud.count.tickets_txt.text = String(_loc2_.gameObj.var_128.getTicketsTotal());
         _loc2_.clip.skip_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickSkip);
         _loc2_.clip.play_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickPlay);
         _loc2_.clip.hud.gotoAndPlay(2);
         _loc2_.clip.hud.title_txt.visible = false;
         _loc2_.updateStars();
         _loc2_.clip.gotoAndPlay("intro");
         _loc2_.clip.foodini.gotoAndPlay("intro");
         if(_loc2_.gameObj.var_128.getTicketsTotal() <= 0)
         {
            _loc2_.clip.logo.gotoAndStop("notickets");
            _loc2_.clip.gotoAndPlay("notickets");
            _loc2_.clip.foodini.gotoAndPlay("lose");
            _loc2_.clip.play_btn.visible = false;
         }
         _loc2_.gameObj.var_129.switchMusic("none");
         _loc2_.gameObj.var_129.playMusicClip("minigame_theme");
         _loc2_.minigameMusic = _loc2_.gameObj.var_129.playMusicClip("minigame_music",true,0);
         _loc2_.minigameFiller = _loc2_.gameObj.var_129.playMusicClip("minigame_fill",true);
         _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.updateScreen);
         if(_loc2_.gameObj.var_128.hasTrained("minigame") == false)
         {
            _loc2_.clip.trainingclip.visible = true;
            _loc2_.gameObj.var_128.setTrained("minigame");
         }
         else
         {
            _loc2_.clip.trainingclip.visible = false;
         }
      }
      
      public function cb() : void
      {
         var _loc1_:MiniGameScreen = this;
         if(_loc1_.clip.currentLabel == "waiting")
         {
            _loc1_.clickedPlay = true;
            _loc1_.clip.gotoAndPlay("hidetitle");
            _loc1_.clip.trainingclip.visible = false;
         }
      }
      
      public function clickPlay(param1:MouseEvent) : void
      {
         this.cb();
      }
      
      public function clickSkip(param1:MouseEvent) : void
      {
         var _loc2_:MiniGameScreen = this;
         if(_loc2_.clip.currentLabel == "waiting")
         {
            _loc2_.clickedPlay = false;
            _loc2_.clip.gotoAndPlay("hidetitle");
            _loc2_.clip.trainingclip.visible = false;
         }
      }
      
      public function startMiniGame() : void
      {
         var _loc1_:MiniGameScreen = this;
         _loc1_.wonPrizeSKU = null;
         _loc1_.wonPrizeAmount = 0;
         _loc1_.gameObj.var_128.useTicket(1);
         _loc1_.clip.hud.count.tickets_txt.text = String(_loc1_.gameObj.var_128.getTicketsTotal());
         var _loc2_:Number = _loc1_.possibleGames.indexOf(_loc1_.whichGame);
         _loc1_.gameObj.var_128.recordMinigamePlayed(_loc2_);
         if(_loc1_.whichGame == MiniGame.TYPE_GOKART)
         {
            _loc1_.miniGame = new MiniGameKart(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else if(_loc1_.whichGame == MiniGame.TYPE_HALLWAY)
         {
            _loc1_.miniGame = new MiniGameHallway(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else if(_loc1_.whichGame == MiniGame.TYPE_SHOT)
         {
            _loc1_.miniGame = new MiniGameHotshot(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else if(_loc1_.whichGame == MiniGame.TYPE_PACHINKO)
         {
            _loc1_.miniGame = new MiniGamePachinko(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else if(_loc1_.whichGame == MiniGame.TYPE_SKEEBALL)
         {
            _loc1_.miniGame = new MiniGameSkeeball(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else if(_loc1_.whichGame == MiniGame.TYPE_CHILI)
         {
            _loc1_.miniGame = new MiniGameChiliWorks(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else if(_loc1_.whichGame == MiniGame.TYPE_MESS)
         {
            _loc1_.miniGame = new MiniGameMess(_loc1_,_loc1_.clip.holder,_loc1_.whichGame);
         }
         else
         {
            _loc1_.miniGame = new MiniGameHallway(_loc1_,_loc1_.clip.holder,MiniGame.TYPE_HALLWAY);
         }
         _loc1_.shouldPlayMusic = true;
      }
      
      public function removeMiniGame() : void
      {
         var _loc1_:MiniGameScreen = this;
         if(_loc1_.miniGame != null)
         {
            _loc1_.miniGame.destroy();
            _loc1_.miniGame = null;
         }
         _loc1_.clip.hud.title_txt.visible = false;
      }
      
      public function createFurniThumbnail(param1:FurniData) : MovieClip
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:MovieClip = null;
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Rectangle = null;
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:MovieClip = null;
         if(param1.type == FurniData.TYPE_FLOORING)
         {
            _loc2_ = Number(String(param1.tag).split("floor")[1]);
            _loc20_ = new MovieClip();
            _loc3_ = new flooring_chunk();
            _loc3_.gotoAndStop(_loc2_);
            _loc4_ = new flooring_chunk();
            _loc4_.gotoAndStop(_loc2_);
            _loc4_.x = _loc3_.width;
            _loc20_.addChild(_loc3_);
            _loc20_.addChild(_loc4_);
            _loc20_.scaleX = 0.47;
            _loc20_.scaleY = 0.47;
         }
         else if(param1.type == FurniData.TYPE_WALLPAPER)
         {
            _loc5_ = Number(String(param1.tag).split("wall")[1]);
            _loc20_ = new MovieClip();
            _loc6_ = new wallpaper_holder();
            _loc6_.gotoAndStop(_loc5_);
            _loc7_ = new wallpaper_holder();
            _loc7_.gotoAndStop(_loc5_);
            _loc7_.x = _loc6_.width;
            _loc20_.addChild(_loc6_);
            _loc20_.addChild(_loc7_);
            _loc8_ = new MovieClip();
            _loc8_.graphics.beginFill(0,1);
            _loc8_.graphics.drawRect(0,0,_loc6_.width,245);
            _loc8_.graphics.endFill();
            _loc20_.addChild(_loc8_);
            _loc9_ = new MovieClip();
            _loc9_.graphics.beginFill(0,1);
            _loc9_.graphics.drawRect(0,0,_loc7_.width,245);
            _loc9_.graphics.endFill();
            _loc9_.x = _loc7_.x;
            _loc20_.addChild(_loc9_);
            _loc6_.mask = _loc8_;
            _loc7_.mask = _loc9_;
            _loc20_.scaleX = 0.43;
            _loc20_.scaleY = 0.43;
         }
         else
         {
            _loc10_ = getDefinitionByName(param1.tag) as Class;
            _loc11_ = new _loc10_();
            if(_loc11_.totalFrames > 1)
            {
               _loc11_.gotoAndStop(2);
            }
            _loc12_ = _loc11_.height;
            _loc13_ = _loc11_.height / _loc11_.width;
            _loc14_ = _loc11_.width / _loc11_.height;
            if(_loc11_.height > 100 || _loc11_.width > 100)
            {
               if(_loc11_.height > _loc11_.width)
               {
                  _loc11_.height = 100;
                  _loc11_.width = _loc11_.height * _loc14_;
               }
               else
               {
                  _loc11_.width = 100;
                  _loc11_.height = _loc11_.width * _loc13_;
               }
            }
            _loc15_ = (100 - _loc11_.width) / 2;
            _loc16_ = (100 - _loc11_.height) / 2;
            _loc17_ = _loc11_.getBounds(_loc11_);
            _loc18_ = _loc17_.y + _loc17_.height;
            _loc19_ = _loc18_ * (_loc11_.height / _loc12_);
            if(param1.type == FurniData.TYPE_FURNI)
            {
               _loc11_.x = _loc15_;
               _loc11_.y = 100 - _loc16_;
               _loc11_.y -= _loc19_;
            }
            else if(param1.type == FurniData.TYPE_POSTER)
            {
               _loc11_.x = _loc15_;
               _loc11_.y = _loc16_;
            }
            _loc20_ = _loc11_;
         }
         return _loc20_;
      }
      
      private function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
      }
      
      public function startShowingPrize() : void
      {
         var minigameIndex:Number = Number(NaN);
         var useTips:Number = Number(NaN);
         var dollars:Number = Number(NaN);
         var cents:Number = Number(NaN);
         var textCents:String = null;
         var textDollars:String = null;
         var clothing:ClothingItem = null;
         var furniData:FurniData = null;
         var ob:MiniGameScreen = this;
         var user:UserData = ob.gameObj.var_128;
         if(ob.wonPrizeSKU == "tips")
         {
            user.earnMinigameTips(ob.wonPrizeAmount);
         }
         else if(ob.wonPrizeSKU == "tickets")
         {
            user.earnMinigameTickets(ob.wonPrizeAmount);
         }
         else
         {
            minigameIndex = ob.possibleGames.indexOf(ob.whichGame);
            if(!ob.wonPrizeIsClothing)
            {
               user.earnMinigameFurniture(ob.wonPrizeSKU,minigameIndex);
            }
            else
            {
               if(ob.wonPrizeClothingMode == "gender")
               {
                  ob.wonPrizeSKU += "_" + ob.gameObj.workerData.gender;
               }
               user.earnMinigameClothing(ob.wonPrizeSKU,minigameIndex);
            }
         }
         if(ob.gameObj.var_133.isRarePrize(ob.wonPrizeSKU))
         {
            ob.clip.prizepanel.rarelabel.visible = true;
         }
         else
         {
            ob.clip.prizepanel.rarelabel.visible = false;
         }
         if(ob.wonPrizeSKU == "tips")
         {
            ob.clip.prizepanel.furnipanel.visible = false;
            ob.clip.prizepanel.ticketpanel.visible = false;
            ob.clip.prizepanel.tipspanel.visible = true;
            useTips = ob.wonPrizeAmount;
            dollars = Math.floor(useTips / 100);
            cents = useTips - dollars * 100;
            textCents = String(cents);
            if(textCents.length < 2)
            {
               textCents = "0" + textCents;
            }
            textDollars = String(class_13.method_110(dollars));
            ob.clip.prizepanel.tipspanel.tips_txt.text = "$" + textDollars + "." + textCents;
         }
         else if(ob.wonPrizeSKU == "tickets")
         {
            ob.clip.prizepanel.furnipanel.visible = false;
            ob.clip.prizepanel.ticketpanel.visible = true;
            ob.clip.prizepanel.tipspanel.visible = false;
            ob.clip.prizepanel.ticketpanel.tickets_txt.text = String(ob.wonPrizeAmount);
         }
         else if(ob.wonPrizeIsClothing)
         {
            ob.clip.prizepanel.furnipanel.visible = true;
            ob.clip.prizepanel.ticketpanel.visible = false;
            ob.clip.prizepanel.tipspanel.visible = false;
            clothing = ob.gameObj.var_135.getItemFromSKU(ob.wonPrizeSKU);
            ob.clip.prizepanel.furnipanel.title_txt.text = clothing.title;
            ob.clip.prizepanel.furnipanel.info_txt.text = "";
            ob.clip.prizepanel.furnipanel.effect_txt.text = "";
            ob.clip.prizepanel.furnipanel.own_txt.visible = false;
            ob.clip.prizepanel.furnipanel.own_label.visible = false;
            try
            {
               if(ob.clip.prizepanel.furnipanel.thumb.numChildren > 0)
               {
                  ob.clip.prizepanel.furnipanel.thumb.removeChildAt(0);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error removing thumb.");
            }
            ob.clip.prizepanel.furnipanel.thumb.addChild(ob.gameObj.var_135.generateClothingThumb(clothing.tag,ob.gameObj.workerData.gender,50,50,100,100));
         }
         else
         {
            ob.clip.prizepanel.furnipanel.visible = true;
            ob.clip.prizepanel.ticketpanel.visible = false;
            ob.clip.prizepanel.tipspanel.visible = false;
            furniData = ob.gameObj.var_133.getFurniFromTag(ob.wonPrizeSKU);
            ob.clip.prizepanel.furnipanel.title_txt.text = furniData.title;
            ob.clip.prizepanel.furnipanel.info_txt.text = "";
            ob.clip.prizepanel.furnipanel.effect_txt.text = "";
            ob.clip.prizepanel.furnipanel.own_txt.text = String(user.getFurniAmount(furniData.tag,true));
            ob.clip.prizepanel.furnipanel.own_txt.visible = true;
            ob.clip.prizepanel.furnipanel.own_label.visible = true;
            if(ob.gameObj.var_133.isRarePrize(ob.wonPrizeSKU))
            {
               ob.clip.prizepanel.furnipanel.own_txt.visible = false;
               ob.clip.prizepanel.furnipanel.own_label.visible = false;
            }
            try
            {
               if(ob.clip.prizepanel.furnipanel.thumb.numChildren > 0)
               {
                  ob.clip.prizepanel.furnipanel.thumb.removeChildAt(0);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error removing thumb.");
            }
            ob.clip.prizepanel.furnipanel.thumb.addChild(ob.createFurniThumbnail(furniData));
         }
         ob.updateStars();
      }
      
      public function destroy() : void
      {
         var _loc1_:MiniGameScreen = this;
         if(_loc1_.miniGame)
         {
            _loc1_.miniGame.destroy();
            _loc1_.miniGame = null;
         }
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.clip.skip_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickSkip);
         _loc1_.clip.play_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickPlay);
         if(_loc1_.minigameMusic)
         {
            _loc1_.minigameMusic.stop();
            _loc1_.minigameMusic = null;
         }
         if(_loc1_.minigameFiller)
         {
            _loc1_.minigameFiller.stop();
            _loc1_.minigameFiller = null;
         }
         _loc1_.gameObj.var_155.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function updateScreen(param1:Event = null) : void
      {
         var §~~unused§:*;
         var _loc7_:MiniGameScreen;
         var _loc2_:SoundTransform = null;
         var _loc3_:SoundTransform = null;
         var _loc4_:SoundTransform = null;
         var _loc5_:SoundTransform = null;
         var _loc6_:SoundTransform = null;
         if((_loc7_ = this).miniGame != null)
         {
            try
            {
               _loc7_.miniGame.updateScreen();
            }
            catch(err:Error)
            {
            }
         }
         if(_loc7_.gameObj.var_129.isMusicMute)
         {
            _loc2_ = new SoundTransform(0);
            if(_loc7_.minigameMusic)
            {
               _loc7_.minigameMusic.soundTransform = _loc2_;
            }
            if(_loc7_.minigameFiller)
            {
               _loc7_.minigameFiller.soundTransform = _loc2_;
            }
         }
         else if(_loc7_.shouldPlayMusic)
         {
            if(_loc7_.musicVolume < 1)
            {
               _loc7_.musicVolume += _loc7_.musicVolumeSpeed;
               _loc3_ = new SoundTransform(_loc7_.musicVolume);
               if(_loc7_.minigameMusic)
               {
                  _loc7_.minigameMusic.soundTransform = _loc3_;
               }
               _loc4_ = new SoundTransform(1 - _loc7_.musicVolume);
               if(_loc7_.minigameFiller)
               {
                  _loc7_.minigameFiller.soundTransform = _loc4_;
               }
            }
         }
         else if(_loc7_.musicVolume > 0)
         {
            _loc7_.musicVolume -= _loc7_.musicVolumeSpeed;
            _loc5_ = new SoundTransform(_loc7_.musicVolume);
            if(_loc7_.minigameMusic)
            {
               _loc7_.minigameMusic.soundTransform = _loc5_;
            }
            _loc6_ = new SoundTransform(1 - _loc7_.musicVolume);
            if(_loc7_.minigameFiller)
            {
               _loc7_.minigameFiller.soundTransform = _loc6_;
            }
         }
         if(_loc7_.clip.currentLabel == "waiting" && !_loc7_.didPlayApplause)
         {
            _loc7_.gameObj.var_129.playSound("applause.wav");
            _loc7_.didPlayApplause = true;
         }
         if(_loc7_.clip.currentLabel == "decideplay")
         {
            if(_loc7_.clickedPlay)
            {
               _loc7_.clip.gotoAndPlay("showgame");
               _loc7_.startMiniGame();
            }
            else
            {
               _loc7_.clip.gotoAndPlay("fadeout");
            }
         }
         else if(_loc7_.clip.currentLabel == "decideprize")
         {
            _loc7_.removeMiniGame();
            _loc7_.clip.hud.count.tickets_txt.text = String(_loc7_.gameObj.var_128.getTicketsTotal());
            if(_loc7_.wonPrizeSKU != null)
            {
               _loc7_.clip.gotoAndPlay("showprize");
               _loc7_.startShowingPrize();
            }
            else
            {
               if(_loc7_.gameObj.var_128.getTicketsTotal() > 0)
               {
                  _loc7_.clip.gotoAndPlay("showtitle");
                  _loc7_.clip.foodini.gotoAndPlay("intro");
               }
               else
               {
                  _loc7_.clip.gotoAndPlay("fadeout");
               }
               _loc7_.gameObj.var_128.saveData();
            }
         }
         else if(_loc7_.clip.currentLabel == "deciderepeat")
         {
            if(_loc7_.gameObj.var_128.getTicketsTotal() > 0)
            {
               _loc7_.clip.gotoAndPlay("showtitle");
               _loc7_.clip.foodini.gotoAndPlay("intro");
            }
            else
            {
               _loc7_.clip.gotoAndPlay("fadeout");
            }
         }
         else if(_loc7_.clip.currentLabel == "end")
         {
            _loc7_.gameObj.method_154();
         }
      }
      
      public function setTitle(param1:String) : void
      {
         var _loc2_:MiniGameScreen = this;
         _loc2_.clip.hud.title_txt.visible = true;
         _loc2_.clip.hud.title_txt.text = param1;
      }
      
      public function updateStars() : void
      {
         var _loc4_:Number = NaN;
         var _loc1_:MiniGameScreen = this;
         var _loc2_:UserData = _loc1_.gameObj.var_128;
         var _loc3_:Number = _loc1_.possibleGames.indexOf(_loc1_.whichGame);
         _loc4_ = Number(_loc2_.minigamePrizes[_loc3_]);
         if(_loc4_ > 42)
         {
            _loc4_ = 42;
         }
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         if(_loc4_ == 0)
         {
            _loc6_ = 0;
            _loc5_ = 0;
         }
         else
         {
            _loc6_ = Math.floor((_loc4_ - 1) / 14);
            class_7.method_1("Num Prizes: " + _loc4_ + ", Set = " + _loc6_);
            _loc5_ = _loc4_ - _loc6_ * 14;
            class_7.method_1("Stars to show: " + _loc5_);
         }
         if(_loc6_ > 2)
         {
            _loc6_ = 2;
            _loc5_ = 14;
         }
         if(_loc5_ > 14)
         {
            _loc5_ = 14;
         }
         _loc1_.clip.hud.stars.visible = true;
         var _loc7_:String = "bronze";
         if(_loc6_ == 1)
         {
            _loc7_ = "silver";
         }
         else if(_loc6_ == 2)
         {
            _loc7_ = "gold";
         }
         class_7.method_1("Earned " + _loc2_.minigamePrizes[_loc3_] + " prizes.  Show " + _loc5_ + " " + _loc7_ + " Stars.");
         var _loc8_:int = 0;
         while(_loc8_ < 14)
         {
            if(_loc8_ < _loc5_)
            {
               _loc1_.clip.hud.stars["star" + _loc8_].gotoAndStop(_loc7_);
            }
            else
            {
               _loc1_.clip.hud.stars["star" + _loc8_].gotoAndStop("unearned");
            }
            _loc8_++;
         }
         if(_loc6_ == 0 && _loc5_ == 14 || _loc6_ > 0)
         {
            _loc1_.clip.hud.stars.bonus0.gotoAndStop("bronze");
         }
         else
         {
            _loc1_.clip.hud.stars.bonus0.gotoAndStop("unearned");
         }
         if(_loc6_ == 1 && _loc5_ == 14 || _loc6_ > 1)
         {
            _loc1_.clip.hud.stars.bonus1.gotoAndStop("silver");
         }
         else
         {
            _loc1_.clip.hud.stars.bonus1.gotoAndStop("unearned");
         }
         if(_loc6_ == 2 && _loc5_ == 14 || _loc6_ > 2)
         {
            _loc1_.clip.hud.stars.bonus2.gotoAndStop("gold");
         }
         else
         {
            _loc1_.clip.hud.stars.bonus2.gotoAndStop("unearned");
         }
      }
      
      public function finishMiniGame(param1:String = null, param2:Number = 1, param3:Boolean = false, param4:String = "") : void
      {
         var _loc5_:MiniGameScreen = null;
         _loc5_ = this;
         _loc5_.wonPrizeSKU = param1;
         _loc5_.wonPrizeAmount = param2;
         _loc5_.wonPrizeIsClothing = param3;
         _loc5_.wonPrizeClothingMode = param4;
         _loc5_.gameObj.var_129.playSound("applause.wav");
         _loc5_.clip.gotoAndPlay("finishgame");
         _loc5_.shouldPlayMusic = false;
         if(_loc5_.gameObj.var_133.isRarePrize(param1))
         {
            _loc5_.gameObj.var_142.recordTagged("rareprize");
         }
      }
   }
}

