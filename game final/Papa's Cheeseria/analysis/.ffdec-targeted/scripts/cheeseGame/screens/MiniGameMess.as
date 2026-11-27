package cheeseGame.screens
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import package_2.*;
   import package_4.*;
   
   public class MiniGameMess extends MiniGame
   {
      
      public var whichDifficulty:Number = 1;
      
      public var allowedMisses:Number = 3;
      
      public var currentMisses:Number = 0;
      
      public var isIntro:Boolean = true;
      
      public var introTimer:Number = 0;
      
      public var introTimerMax:Number = 30;
      
      public var isOutro:Boolean = false;
      
      public var outroTimer:Number = 0;
      
      public var outroTimerMax:Number = 40;
      
      public var tileWidth:Number = 45;
      
      public var sheetWidth:Number = 37;
      
      public var sheetHeight:Number = 2;
      
      public var totalPossibleObjects:Number = 74;
      
      public var numObjects:Number = 6;
      
      public var maxObjects:Number = 6;
      
      public var whichObjects:Array = [];
      
      public var foundObjects:Array = [];
      
      public var maxTime:Number = 600;
      
      public var currTime:Number = 600;
      
      public var isRunning:Boolean = false;
      
      public var tileSheet:BitmapData;
      
      public var tileColors:BitmapData;
      
      public var imageColors:BitmapData;
      
      public var colorthumbs:Vector.<BitmapData>;
      
      public var thumbs:Vector.<BitmapData>;
      
      public var thumbBitmaps:Vector.<Bitmap>;
      
      public var foundAllObjects:Boolean = false;
      
      public function MiniGameMess(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:MiniGameMess = this;
         _loc1_.clip = new minigameMessMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.screen.setTitle("Mitch\'s Mess");
         _loc1_.setupPrizes(_loc1_.type);
         _loc1_.screen.updateStars();
         _loc1_.thumbs = new Vector.<BitmapData>();
         _loc1_.thumbBitmaps = new Vector.<Bitmap>();
         _loc1_.colorthumbs = new Vector.<BitmapData>();
         _loc1_.tileSheet = new mess_thumbimage(0,0);
         _loc1_.tileColors = new mess_thumbcolor(0,0);
         _loc1_.imageColors = new mess_maincolor(0,0);
         _loc1_.reset();
         _loc1_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickScreen);
         if(_loc1_.whichDifficulty == 1)
         {
            _loc1_.clip.trainer.visible = true;
         }
         else
         {
            _loc1_.clip.trainer.visible = false;
         }
      }
      
      public function reset(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:BitmapData = null;
         var _loc8_:Bitmap = null;
         var _loc9_:BitmapData = null;
         var _loc10_:MiniGameMess = this;
         _loc10_.decideDifficulty();
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            if(_loc2_ <= _loc10_.allowedMisses)
            {
               _loc10_.clip["strike_" + _loc2_].visible = true;
               _loc10_.clip["strike_" + _loc2_].gotoAndStop(1);
            }
            else
            {
               _loc10_.clip["strike_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         _loc10_.currentMisses = 0;
         _loc10_.currTime = _loc10_.maxTime;
         _loc10_.whichObjects = [];
         _loc10_.foundObjects = [];
         _loc2_ = 0;
         while(_loc2_ < _loc10_.numObjects)
         {
            _loc3_ = Math.floor(Math.random() * _loc10_.totalPossibleObjects);
            while(_loc10_.whichObjects.indexOf(_loc3_) > -1)
            {
               _loc3_ = Math.floor(Math.random() * _loc10_.totalPossibleObjects);
            }
            _loc10_.whichObjects.push(_loc3_);
            _loc10_.foundObjects.push(false);
            _loc2_++;
         }
         if(_loc10_.whichDifficulty == 1)
         {
            _loc10_.whichObjects = [40,64,42];
         }
         trace("Objects: " + _loc10_.whichObjects.toString());
         _loc10_.clearThumbs();
         _loc2_ = 1;
         while(_loc2_ <= _loc10_.maxObjects)
         {
            _loc10_.clip["thumb" + _loc2_].visible = false;
            _loc10_.clip["check" + _loc2_].visible = false;
            _loc10_.clip["check" + _loc2_].gotoAndStop(1);
            if(_loc2_ <= _loc10_.numObjects)
            {
               _loc10_.clip["thumb" + _loc2_].visible = true;
               _loc4_ = Number(_loc10_.whichObjects[_loc2_ - 1]);
               _loc5_ = Math.floor(_loc4_ / _loc10_.sheetWidth);
               _loc6_ = _loc4_ - _loc5_ * _loc10_.sheetWidth;
               trace("Obj = " + _loc4_ + ". Y = " + _loc5_ + ", X = " + _loc6_);
               _loc7_ = new BitmapData(_loc10_.tileWidth,_loc10_.tileWidth,false,0);
               _loc7_.copyPixels(_loc10_.tileSheet,new Rectangle(_loc6_ * _loc10_.tileWidth,_loc5_ * _loc10_.tileWidth,_loc10_.tileWidth,_loc10_.tileWidth),new Point(0,0));
               _loc8_ = new Bitmap(_loc7_);
               _loc10_.clip["thumb" + _loc2_].addChild(_loc8_);
               _loc9_ = new BitmapData(_loc10_.tileWidth,_loc10_.tileWidth,false,0);
               _loc9_.copyPixels(_loc10_.tileColors,new Rectangle(_loc6_ * _loc10_.tileWidth,_loc5_ * _loc10_.tileWidth,_loc10_.tileWidth,_loc10_.tileWidth),new Point(0,0));
               _loc10_.thumbBitmaps.push(_loc8_);
               _loc10_.thumbs.push(_loc7_);
               _loc10_.colorthumbs.push(_loc9_);
            }
            _loc2_++;
         }
         _loc10_.formatTime(this.maxTime);
         _loc10_.isIntro = true;
         _loc10_.introTimer = 0;
      }
      
      public function clearThumbs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MiniGameMess = this;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.colorthumbs.length)
         {
            _loc2_.colorthumbs[_loc1_].dispose();
            _loc2_.thumbs[_loc1_].dispose();
            _loc2_.thumbBitmaps[_loc1_].parent.removeChild(_loc2_.thumbBitmaps[_loc1_]);
            _loc2_.colorthumbs[_loc1_] = null;
            _loc2_.thumbs[_loc1_] = null;
            _loc2_.thumbBitmaps[_loc1_] = null;
            _loc1_++;
         }
         _loc2_.colorthumbs = null;
         _loc2_.thumbs = null;
         _loc2_.thumbBitmaps = null;
         _loc2_.colorthumbs = new Vector.<BitmapData>();
         _loc2_.thumbs = new Vector.<BitmapData>();
         _loc2_.thumbBitmaps = new Vector.<Bitmap>();
      }
      
      public function decideDifficulty() : void
      {
         var _loc1_:MiniGameMess = this;
         var _loc2_:Number = _loc1_.getStartingLevel();
         if(_loc2_ < 14)
         {
            _loc1_.whichDifficulty = _loc2_ + 1;
         }
         else
         {
            _loc1_.whichDifficulty = 14;
         }
         if(_loc1_.whichDifficulty == 1)
         {
            _loc1_.numObjects = 3;
            _loc1_.maxTime = 600;
         }
         else if(_loc1_.whichDifficulty == 2)
         {
            _loc1_.numObjects = 3;
            _loc1_.maxTime = 540;
         }
         else if(_loc1_.whichDifficulty == 3)
         {
            _loc1_.numObjects = 4;
            _loc1_.maxTime = 540;
         }
         else if(_loc1_.whichDifficulty == 4)
         {
            _loc1_.numObjects = 4;
            _loc1_.maxTime = 480;
         }
         else if(_loc1_.whichDifficulty == 6)
         {
            _loc1_.numObjects = 5;
            _loc1_.maxTime = 540;
         }
         else if(_loc1_.whichDifficulty == 7)
         {
            _loc1_.numObjects = 5;
            _loc1_.maxTime = 480;
         }
         else
         {
            _loc1_.numObjects = 6;
            _loc1_.maxTime = 600;
         }
      }
      
      public function checkSuccess() : void
      {
         var _loc1_:MiniGameMess = this;
         if(_loc1_.foundAllObjects)
         {
            _loc1_.decidePrize();
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_happy.wav");
         }
         else
         {
            _loc1_.skuToWin = null;
            _loc1_.amountToWin = 0;
            _loc1_.skuIsClothing = false;
            _loc1_.skuClothingMode = "";
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_decent.wav");
         }
      }
      
      override public function updateScreen() : void
      {
         var _loc1_:MiniGameMess = this;
         if(_loc1_.isIntro)
         {
            ++_loc1_.introTimer;
            if(_loc1_.introTimer >= _loc1_.introTimerMax)
            {
               _loc1_.isIntro = false;
               _loc1_.startSearch();
            }
         }
         if(_loc1_.isRunning)
         {
            --_loc1_.currTime;
            _loc1_.formatTime(_loc1_.currTime);
            if(_loc1_.currTime == 0)
            {
               _loc1_.endGame();
            }
         }
         if(_loc1_.isOutro)
         {
            ++_loc1_.outroTimer;
            if(_loc1_.outroTimer >= _loc1_.outroTimerMax)
            {
               _loc1_.isOutro = false;
               _loc1_.screen.finishMiniGame(_loc1_.skuToWin,_loc1_.amountToWin,_loc1_.skuIsClothing,_loc1_.skuClothingMode);
            }
         }
      }
      
      public function endGame() : void
      {
         var _loc1_:MiniGameMess = this;
         _loc1_.isRunning = false;
         _loc1_.isIntro = false;
         _loc1_.isOutro = true;
         _loc1_.checkSuccess();
         _loc1_.outroTimer = 0;
      }
      
      public function startSearch() : void
      {
         var _loc1_:MiniGameMess = this;
         _loc1_.isRunning = true;
      }
      
      public function formatTime(param1:Number) : void
      {
         var _loc2_:MiniGameMess = this;
         var _loc3_:Number = Math.floor(param1 / 30);
         var _loc4_:Number = Math.floor((param1 - _loc3_ * 30) / 30 * 100);
         if(_loc3_ < 10)
         {
            _loc2_.clip.time_txt.text = "0" + _loc3_;
         }
         else
         {
            _loc2_.clip.time_txt.text = _loc3_;
         }
         if(_loc4_ < 10)
         {
            _loc2_.clip.cents_txt.text = ":0" + _loc4_;
         }
         else
         {
            _loc2_.clip.cents_txt.text = ":" + _loc4_;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:MiniGameMess = this;
         _loc1_.clearThumbs();
         if(_loc1_.tileSheet)
         {
            _loc1_.tileSheet.dispose();
            _loc1_.tileSheet = null;
         }
         if(_loc1_.tileColors)
         {
            _loc1_.tileColors.dispose();
            _loc1_.tileColors = null;
         }
         if(_loc1_.imageColors)
         {
            _loc1_.imageColors.dispose();
            _loc1_.imageColors = null;
         }
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.clip.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickScreen);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function clickScreen(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:MiniGameMess = this;
         if(_loc10_.isRunning)
         {
            _loc2_ = _loc10_.clip.mouseX;
            _loc3_ = _loc10_.clip.mouseY;
            _loc4_ = _loc10_.imageColors.getPixel(_loc2_,_loc3_);
            _loc5_ = false;
            _loc6_ = 0;
            while(_loc6_ < _loc10_.colorthumbs.length)
            {
               if(_loc10_.foundObjects[_loc6_] == false)
               {
                  if(_loc4_ == _loc10_.colorthumbs[_loc6_].getPixel(2,2))
                  {
                     trace("MATCH!");
                     _loc10_.foundObjects[_loc6_] = true;
                     _loc10_.clip["check" + (_loc6_ + 1)].visible = true;
                     _loc10_.clip["check" + (_loc6_ + 1)].gotoAndPlay(2);
                     _loc5_ = true;
                     _loc10_.screen.gameObj.var_129.playSound("getstar.wav");
                     break;
                  }
               }
               _loc6_++;
            }
            if(!_loc5_)
            {
               ++_loc10_.currentMisses;
               _loc10_.screen.gameObj.var_129.playSound("boing.wav");
               _loc9_ = 1;
               while(_loc9_ <= 3)
               {
                  if(_loc9_ <= _loc10_.currentMisses)
                  {
                     _loc10_.clip["strike_" + _loc9_].gotoAndStop(2);
                  }
                  else
                  {
                     _loc10_.clip["strike_" + _loc9_].gotoAndStop(1);
                  }
                  _loc9_++;
               }
               if(_loc10_.currentMisses >= 3)
               {
                  _loc10_.endGame();
               }
            }
            _loc7_ = true;
            _loc8_ = 0;
            while(_loc8_ < _loc10_.foundObjects.length)
            {
               if(_loc10_.foundObjects[_loc8_] === false)
               {
                  _loc7_ = false;
                  break;
               }
               _loc8_++;
            }
            if(_loc7_)
            {
               _loc10_.foundAllObjects = true;
               _loc10_.endGame();
            }
         }
      }
   }
}

