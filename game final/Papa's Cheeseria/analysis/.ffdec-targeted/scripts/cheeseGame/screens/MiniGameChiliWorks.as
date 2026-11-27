package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import package_2.*;
   import package_4.*;
   
   public class MiniGameChiliWorks extends MiniGame
   {
      
      public var whichDifficulty:Number = 1;
      
      public var isIntro:Boolean = true;
      
      public var introTimer:Number = 0;
      
      public var introTimerMax:Number = 15;
      
      public var isOutro:Boolean = false;
      
      public var outroTimer:Number = 0;
      
      public var outroTimerMax:Number = 55;
      
      public var gridStartX:Number = 192;
      
      public var gridStartY:Number = 96;
      
      public var tileWidth:Number = 64;
      
      public var numRows:Number = 5;
      
      public var numColumns:Number = 5;
      
      public var gridArray:Array = null;
      
      public var particles:Vector.<MovieClip> = null;
      
      public var emittersX:Array = [];
      
      public var emittersY:Array = [];
      
      public var emittersDir:Array = [];
      
      public var emittersDelay:Array = [];
      
      public var particleTimer:Number = 0;
      
      public var spigotY:Number = 0;
      
      public var endY:Number = 0;
      
      public var bowlX:Number = 0;
      
      public var timerStart:Number = 450;
      
      public var currentTimer:Number = 0;
      
      public var postCheckTimer:Number = 0;
      
      public var barMinX:Number = 159;
      
      public var barRange:Number = 321;
      
      public var didCheckPipes:Boolean = false;
      
      public var didReachEnd:Boolean = false;
      
      public var didFillBowl:Boolean = false;
      
      public var finishedFillingBowl:Boolean = false;
      
      public var wheelSpeed:Number = 0;
      
      public var didPlaySound:Boolean = false;
      
      public var loopSound:SoundChannel = null;
      
      public var loopVolume:Number = 0;
      
      public const TYPE_STRAIGHT:String = "straight";
      
      public const TYPE_CURVE:String = "curve";
      
      public const TYPE_ALL:String = "all";
      
      public const TYPE_TEE:String = "tee";
      
      public const TYPE_CAP:String = "cap";
      
      public var leveldata:Array = [[[null,null,null,null,null],[null,null,null,{
         "type":"curve",
         "rot":270
      },{
         "type":"curve",
         "rot":90,
         "locked":true
      }],[{
         "type":"straight",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":0
      },null,{
         "type":"straight",
         "rot":90,
         "locked":true
      },{
         "type":"straight",
         "rot":90
      }],[null,{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":270,
         "locked":true
      }],[null,null,null,null,null],[3],[2],[15]],[[{
         "type":"curve",
         "rot":0
      },null,null,null,null],[{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":0
      },null,{
         "type":"curve",
         "rot":0,
         "locked":true
      }],[{
         "type":"straight",
         "rot":0
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":90
      }],[{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      },null,null,null],[null,null,null,null,null],[1],[0],[10]],[[{
         "type":"straight",
         "rot":0
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":90
      },null],[null,{
         "type":"curve",
         "rot":270
      },{
         "type":"curve",
         "rot":180
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[null,null,{
         "type":"straight",
         "rot":0
      },null,{
         "type":"tee",
         "rot":270,
         "locked":true
      }],[null,null,{
         "type":"curve",
         "rot":0
      },{
         "type":"straight",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":270
      }],[null,null,null,null,null],[2],[0],[14]],[[{
         "type":"curve",
         "rot":90,
         "locked":true
      },null,null,null,null],[{
         "type":"curve",
         "rot":0
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"straight",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":0
      }],[null,{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":270
      }],[null,{
         "type":"curve",
         "rot":180
      },{
         "type":"tee",
         "rot":90,
         "locked":true
      },{
         "type":"curve",
         "rot":270
      },{
         "type":"straight",
         "rot":0,
         "locked":true
      }],[null,{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      },null,null],[3],[0],[15]],[[null,{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"cap",
         "rot":90
      },null],[null,{
         "type":"tee",
         "rot":180
      },{
         "type":"all",
         "rot":0,
         "locked":true
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":90,
         "locked":true
      }],[null,{
         "type":"cap",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      },null,{
         "type":"curve",
         "rot":0
      }],[{
         "type":"straight",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"curve",
         "rot":180
      }],[null,{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"curve",
         "rot":180
      }],[2],[3],[22]],[[null,{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":180
      },null,null],[null,{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":90,
         "locked":true
      }],[null,{
         "type":"tee",
         "rot":90
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"tee",
         "rot":0
      }],[null,{
         "type":"curve",
         "rot":270
      },{
         "type":"all",
         "rot":0
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":270
      }],[{
         "type":"straight",
         "rot":0
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[3],[4],[15]],[[null,null,null,{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[{
         "type":"curve",
         "rot":90,
         "locked":true
      },null,null,{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      }],[{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":0
      },null,{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[{
         "type":"straight",
         "rot":0
      },{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"curve",
         "rot":0
      },null,{
         "type":"straight",
         "rot":0
      }],[{
         "type":"curve",
         "rot":270
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      }],[1],[1],[15]],[[{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"cap",
         "rot":0
      },{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"tee",
         "rot":180
      }],[{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"curve",
         "rot":270
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      }],[{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"tee",
         "rot":180
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"tee",
         "rot":0
      }],[null,null,{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":180,
         "locked":true
      }],[null,null,null,null,null],[0],[1],[20]],[[{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":90,
         "locked":true
      },{
         "type":"curve",
         "rot":270
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      }],[{
         "type":"all",
         "rot":0
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"cap",
         "rot":90
      },{
         "type":"straight",
         "rot":0
      },null],[{
         "type":"tee",
         "rot":270,
         "locked":true
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"all",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[{
         "type":"straight",
         "rot":90
      },{
         "type":"cap",
         "rot":180
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"all",
         "rot":0
      },{
         "type":"tee",
         "rot":180
      }],[{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[0],[1],[20]],[[null,null,{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":180
      },{
         "type":"curve",
         "rot":0,
         "locked":true
      }],[null,{
         "type":"curve",
         "rot":0
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"tee",
         "rot":180
      }],[null,{
         "type":"straight",
         "rot":90,
         "locked":true
      },{
         "type":"curve",
         "rot":270
      },{
         "type":"tee",
         "rot":180
      },{
         "type":"curve",
         "rot":90
      }],[{
         "type":"cap",
         "rot":270
      },{
         "type":"all",
         "rot":0
      },{
         "type":"cap",
         "rot":270
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":180
      }],[{
         "type":"straight",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":180
      },null,{
         "type":"cap",
         "rot":180
      },{
         "type":"curve",
         "rot":180
      }],[0],[4],[22]],[[null,null,null,{
         "type":"cap",
         "rot":0
      },{
         "type":"curve",
         "rot":0
      }],[null,{
         "type":"cap",
         "rot":270
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"curve",
         "rot":270
      }],[{
         "type":"tee",
         "rot":180
      },{
         "type":"all",
         "rot":0,
         "locked":true
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"curve",
         "rot":270
      },{
         "type":"curve",
         "rot":90,
         "locked":true
      }],[{
         "type":"cap",
         "rot":270
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"all",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":270
      }],[null,{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"cap",
         "rot":180
      },null],[3],[2],[20]],[[{
         "type":"straight",
         "rot":0
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"cap",
         "rot":90
      }],[{
         "type":"curve",
         "rot":0,
         "locked":true
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"all",
         "rot":0
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":180,
         "locked":true
      }],[{
         "type":"tee",
         "rot":90
      },{
         "type":"cap",
         "rot":0
      },{
         "type":"cap",
         "rot":0
      },{
         "type":"cap",
         "rot":180
      },null],[{
         "type":"straight",
         "rot":90,
         "locked":true
      },{
         "type":"curve",
         "rot":180
      },{
         "type":"tee",
         "rot":180
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      }],[{
         "type":"curve",
         "rot":270
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"straight",
         "rot":90
      },{
         "type":"tee",
         "rot":180,
         "locked":true
      }],[4],[0],[25]],[[{
         "type":"tee",
         "rot":270
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"tee",
         "rot":180
      },{
         "type":"curve",
         "rot":90
      },null],[{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"cap",
         "rot":270
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"cap",
         "rot":90,
         "locked":true
      }],[{
         "type":"cap",
         "rot":270
      },{
         "type":"tee",
         "rot":0
      },{
         "type":"straight",
         "rot":0,
         "locked":true
      },{
         "type":"curve",
         "rot":90
      },null],[{
         "type":"tee",
         "rot":0
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"curve",
         "rot":180
      }],[{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"curve",
         "rot":180,
         "locked":true
      },{
         "type":"curve",
         "rot":270
      },{
         "type":"tee",
         "rot":0
      }],[4],[0],[24]],[[{
         "type":"curve",
         "rot":90
      },{
         "type":"tee",
         "rot":180
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"cap",
         "rot":0
      },null],[{
         "type":"all",
         "rot":0
      },{
         "type":"curve",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"curve",
         "rot":0
      }],[{
         "type":"curve",
         "rot":0
      },{
         "type":"tee",
         "rot":90
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"all",
         "rot":0
      },{
         "type":"all",
         "rot":0,
         "locked":true
      }],[{
         "type":"cap",
         "rot":180
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"cap",
         "rot":90
      },{
         "type":"tee",
         "rot":180
      },{
         "type":"curve",
         "rot":270
      }],[null,{
         "type":"curve",
         "rot":270,
         "locked":true
      },{
         "type":"straight",
         "rot":0
      },{
         "type":"tee",
         "rot":270
      },{
         "type":"cap",
         "rot":180
      }],[2],[1],[25]]];
      
      public function MiniGameChiliWorks(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:MiniGameChiliWorks = this;
         _loc1_.clip = new minigameChiliworksMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.screen.setTitle("Rico\'s Chiliworks");
         _loc1_.setupPrizes(_loc1_.type);
         _loc1_.screen.updateStars();
         _loc1_.reset();
         _loc1_.clip.spigot.wheel.addEventListener(MouseEvent.MOUSE_DOWN,this.clickWheel);
         _loc1_.clip.spigot.wheel.buttonMode = true;
         _loc1_.clip.spigot.wheel.useHandCursor = true;
         _loc1_.clip.bar.mask = _loc1_.clip.masker;
         if(_loc1_.whichDifficulty == 1)
         {
            _loc1_.clip.training.visible = true;
         }
         else
         {
            _loc1_.clip.training.visible = false;
         }
      }
      
      public function reset(param1:MouseEvent = null) : void
      {
         var _loc2_:MiniGameChiliWorks = this;
         _loc2_.decideDifficulty();
         _loc2_.setupPipes();
         _loc2_.setupParticles();
         _loc2_.isIntro = true;
         _loc2_.introTimer = 0;
         _loc2_.currentTimer = _loc2_.timerStart;
         _loc2_.didCheckPipes = false;
         _loc2_.particleTimer = 0;
         _loc2_.wheelSpeed = 0;
         _loc2_.didFillBowl = false;
         _loc2_.finishedFillingBowl = false;
         _loc2_.postCheckTimer = 0;
         _loc2_.didReachEnd = false;
         _loc2_.didPlaySound = false;
         _loc2_.clip.bar.x = _loc2_.barMinX + _loc2_.barRange;
      }
      
      public function decideDifficulty() : void
      {
         var _loc1_:MiniGameChiliWorks = this;
         var _loc2_:Number = _loc1_.getStartingLevel();
         if(_loc2_ < 14)
         {
            _loc1_.whichDifficulty = _loc2_ + 1;
         }
         else
         {
            _loc1_.whichDifficulty = 5 + Math.ceil(Math.random() * 9);
         }
      }
      
      override public function updateScreen() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:SoundTransform = null;
         var _loc4_:MiniGameChiliWorks = this;
         if(_loc4_.isIntro)
         {
            ++_loc4_.introTimer;
            if(_loc4_.introTimer >= _loc4_.introTimerMax)
            {
               _loc4_.isIntro = false;
            }
         }
         else if(!_loc4_.didCheckPipes)
         {
            --_loc4_.currentTimer;
            if(_loc4_.currentTimer == 0 && !_loc4_.didCheckPipes)
            {
               _loc4_.checkPipes();
            }
         }
         if(_loc4_.gridArray != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc4_.numRows)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc4_.numColumns)
               {
                  if(_loc4_.gridArray[_loc2_][_loc1_] is ChiliWorksPipe)
                  {
                     _loc4_.gridArray[_loc2_][_loc1_].updatePipe();
                  }
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         _loc4_.clip.timer_txt.text = this.getFormattedTimer();
         _loc4_.clip.bar.x = _loc4_.barMinX + _loc4_.currentTimer / _loc4_.timerStart * _loc4_.barRange;
         if(_loc4_.didCheckPipes)
         {
            _loc4_.updateParticles();
            ++_loc4_.postCheckTimer;
         }
         if(_loc4_.loopSound != null)
         {
            if(_loc4_.loopVolume < 0.5)
            {
               _loc4_.loopVolume += 0.02;
               if(_loc4_.loopVolume > 0.5)
               {
                  _loc4_.loopVolume = 0.5;
               }
            }
            if(_loc4_.screen.gameObj.var_129.isMute)
            {
               _loc4_.loopVolume = 0;
            }
            _loc3_ = new SoundTransform(_loc4_.loopVolume,0);
            _loc4_.loopSound.soundTransform = _loc3_;
         }
         if(_loc4_.isOutro)
         {
            ++_loc4_.outroTimer;
            if(_loc4_.outroTimer >= _loc4_.outroTimerMax)
            {
               _loc4_.isOutro = false;
               _loc4_.screen.finishMiniGame(_loc4_.skuToWin,_loc4_.amountToWin,_loc4_.skuIsClothing,_loc4_.skuClothingMode);
               if(_loc4_.loopSound)
               {
                  _loc4_.loopSound.stop();
                  _loc4_.loopSound = null;
                  _loc4_.screen.gameObj.var_129.playSound("chiliworks_finishpouring.wav",false,0.5);
               }
            }
         }
      }
      
      public function getFormattedTimer() : String
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:MiniGameChiliWorks = this;
         var _loc6_:* = "";
         if(_loc5_.currentTimer <= 0)
         {
            _loc6_ = "00:00";
         }
         else
         {
            _loc1_ = Math.floor(_loc5_.currentTimer / 30);
            _loc2_ = _loc5_.currentTimer - _loc1_ * 30;
            _loc3_ = _loc2_ / 30;
            _loc4_ = Math.floor(_loc3_ * 100);
            if(_loc1_ < 10)
            {
               _loc6_ = "0" + _loc1_;
            }
            else
            {
               _loc6_ = "" + _loc1_;
            }
            _loc6_ += ":";
            if(_loc4_ < 10)
            {
               _loc6_ += "0" + _loc4_;
            }
            else
            {
               _loc6_ += "" + _loc4_;
            }
         }
         return _loc6_;
      }
      
      public function clickWheel(param1:MouseEvent) : void
      {
         var _loc2_:MiniGameChiliWorks = this;
         if(!_loc2_.didCheckPipes)
         {
            _loc2_.checkPipes();
         }
      }
      
      public function checkPipes() : void
      {
         var _loc1_:MiniGameChiliWorks = this;
         class_7.method_1("CHECK PIPES");
         var _loc2_:Number = _loc1_.spigotY;
         var _loc3_:Number = _loc1_.numColumns - 1;
         var _loc4_:ChiliWorksPipe = _loc1_.gridArray[_loc2_][_loc3_];
         var _loc5_:Boolean = false;
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.checkPipe("right","",0);
         }
         if(_loc5_ == true && _loc1_.didReachEnd == true)
         {
            _loc1_.didFillBowl = true;
            _loc1_.emittersX.push(70);
            _loc1_.emittersY.push(70 + _loc1_.gridStartY + _loc1_.endY * _loc1_.tileWidth);
            _loc1_.emittersDir.push("up");
            _loc1_.emittersDelay.push(40);
            _loc1_.decidePrize();
         }
         else
         {
            _loc1_.didFillBowl = false;
            _loc1_.skuToWin = null;
            _loc1_.amountToWin = 0;
            _loc1_.skuIsClothing = false;
            _loc1_.skuClothingMode = "";
         }
         class_7.method_1("Success?: " + _loc5_ + ".  Did reach end?: " + this.didReachEnd);
         class_7.method_1("Number of emitters: " + _loc1_.emittersX.length);
         if(_loc1_.emittersX.length == 0)
         {
            class_7.method_1("(Closed system, immediately fail)");
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_decent.wav");
            _loc1_.didPlaySound = true;
            _loc1_.isOutro = true;
            _loc1_.outroTimer = 0;
         }
         _loc1_.wheelSpeed = 40;
         _loc1_.didCheckPipes = true;
         _loc1_.outroTimer = 0;
         _loc1_.screen.gameObj.var_129.playSound("chiliworks_startpouring.wav",false,0.5);
         _loc1_.loopSound = _loc1_.screen.gameObj.var_129.playSound("chiliworks_pourloop.wav",true,0);
      }
      
      public function getPipe(param1:Number, param2:Number) : ChiliWorksPipe
      {
         var _loc3_:MiniGameChiliWorks = this;
         var _loc4_:ChiliWorksPipe = null;
         if(param2 < _loc3_.gridArray.length && param2 >= 0 && param1 < _loc3_.gridArray[param2].length && param1 >= 0)
         {
            _loc4_ = _loc3_.gridArray[param2][param1];
         }
         return _loc4_;
      }
      
      override public function destroy() : void
      {
         var _loc1_:MiniGameChiliWorks = this;
         if(_loc1_.loopSound)
         {
            _loc1_.loopSound.stop();
            _loc1_.loopSound = null;
         }
         _loc1_.cleanupPipes();
         _loc1_.cleanupParticles();
         _loc1_.clip.spigot.wheel.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickWheel);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function setupParticles() : void
      {
         var _loc1_:MiniGameChiliWorks = this;
         _loc1_.cleanupParticles();
         if(_loc1_.particles == null)
         {
            _loc1_.particles = new Vector.<MovieClip>();
         }
         _loc1_.emittersX = [];
         _loc1_.emittersY = [];
         _loc1_.emittersDir = [];
         _loc1_.emittersDelay = [];
      }
      
      public function cleanupParticles() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MiniGameChiliWorks = this;
         if(_loc2_.particles != null && _loc2_.particles.length > 0)
         {
            _loc1_ = int(_loc2_.particles.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc2_.particles[_loc1_] != null)
               {
                  if(_loc2_.particles[_loc1_].parent)
                  {
                     _loc2_.particles[_loc1_].parent.removeChild(_loc2_.particles[_loc1_]);
                  }
                  _loc2_.particles[_loc1_] = null;
                  _loc2_.particles.splice(_loc1_,1);
               }
               _loc1_--;
            }
         }
         _loc2_.particles = null;
      }
      
      public function updateParticles() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Boolean = false;
         var _loc8_:Number = Number(NaN);
         var _loc9_:MovieClip = null;
         var _loc10_:MiniGameChiliWorks = this;
         if(_loc10_.wheelSpeed > 0)
         {
            _loc10_.wheelSpeed -= 2;
            _loc10_.clip.spigot.wheel.rotation += _loc10_.wheelSpeed;
            if(_loc10_.wheelSpeed <= 0)
            {
               _loc10_.wheelSpeed = 0;
            }
         }
         else if(_loc10_.wheelSpeed == 0)
         {
            ++_loc10_.particleTimer;
            if(_loc10_.finishedFillingBowl == false)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc10_.emittersX.length)
               {
                  if((_loc10_.emittersX.length == 1 && _loc10_.postCheckTimer % 3 == 0 || _loc10_.postCheckTimer % _loc10_.emittersX.length == _loc1_) && _loc10_.postCheckTimer >= _loc10_.emittersDelay[_loc1_])
                  {
                     _loc2_ = new chiliworks_chilibit();
                     _loc2_.gotoAndStop(Math.ceil(Math.random() * _loc2_.totalFrames));
                     _loc3_ = _loc10_.gridStartX + _loc10_.emittersX[_loc1_] * _loc10_.tileWidth;
                     _loc4_ = _loc10_.gridStartY + _loc10_.emittersY[_loc1_] * _loc10_.tileWidth;
                     _loc5_ = 0;
                     _loc6_ = 0;
                     _loc7_ = false;
                     if(!_loc10_.didPlaySound)
                     {
                        if(_loc10_.didFillBowl)
                        {
                           _loc10_.screen.gameObj.var_129.playMusicClip("customer_happy.wav");
                        }
                        else
                        {
                           _loc10_.screen.gameObj.var_129.playMusicClip("customer_decent.wav");
                        }
                        _loc10_.didPlaySound = true;
                        _loc10_.isOutro = true;
                        _loc10_.outroTimer = 0;
                     }
                     if(_loc10_.emittersX[_loc1_] > _loc10_.numColumns)
                     {
                        _loc3_ = Number(_loc10_.emittersX[_loc1_]);
                        _loc4_ = Number(_loc10_.emittersY[_loc1_]);
                        _loc7_ = true;
                     }
                     _loc8_ = 0.5 + Math.random() * 0.5;
                     if(_loc10_.emittersDir[_loc1_] == "down")
                     {
                        _loc4_ += _loc10_.tileWidth / 2;
                        _loc5_ = Math.random() * 2 - 1;
                        _loc6_ = 0 - Math.random() * 5;
                     }
                     else if(_loc10_.emittersDir[_loc1_] == "up")
                     {
                        _loc4_ -= _loc10_.tileWidth / 2;
                        _loc5_ = Math.random() * 2 - 1;
                        _loc6_ = 0 + Math.random() * 2;
                     }
                     else if(_loc10_.emittersDir[_loc1_] == "left")
                     {
                        _loc3_ -= _loc10_.tileWidth / 2;
                        _loc5_ = 3 + Math.random() * 3;
                        _loc6_ = 0 + Math.random() * 2;
                     }
                     else if(_loc10_.emittersDir[_loc1_] == "right")
                     {
                        _loc3_ += _loc10_.tileWidth / 2;
                        _loc5_ = 0 - 3 - Math.random() * 3;
                        _loc6_ = 0 + Math.random() * 2;
                     }
                     else if(_loc10_.emittersDir[_loc1_] == "oobright")
                     {
                        _loc3_ += _loc10_.tileWidth / 2;
                        _loc5_ = 0 - 7 - Math.random() * 4;
                        _loc6_ = 0;
                     }
                     if(_loc7_)
                     {
                        _loc5_ = 0;
                     }
                     _loc2_.x = _loc3_;
                     _loc2_.y = _loc4_;
                     _loc2_.speedX = _loc5_;
                     _loc2_.speedY = _loc6_;
                     _loc2_.scaleX = _loc8_;
                     _loc2_.scaleY = _loc8_;
                     _loc2_.isFinal = _loc7_;
                     if(_loc10_.emittersDir[_loc1_] == "right" || _loc10_.emittersDir[_loc1_] == "down")
                     {
                        _loc10_.clip.holder.addChildAt(_loc2_,0);
                     }
                     else
                     {
                        _loc10_.clip.holder.addChild(_loc2_);
                     }
                     _loc10_.particles.push(_loc2_);
                  }
                  _loc1_++;
               }
            }
            _loc1_ = int(_loc10_.particles.length - 1);
            while(_loc1_ >= 0)
            {
               _loc9_ = _loc10_.particles[_loc1_];
               _loc9_.speedY += 0.4;
               if(_loc9_.speedX > 0)
               {
                  _loc9_.speedX -= 0.08;
                  if(_loc9_.speedX < 0)
                  {
                     _loc9_.speedX = 0;
                  }
               }
               else if(_loc9_.speedX < 0)
               {
                  _loc9_.speedX += 0.08;
                  if(_loc9_.speedX > 0)
                  {
                     _loc9_.speedX = 0;
                  }
               }
               _loc9_.x += _loc9_.speedX;
               _loc9_.y += _loc9_.speedY;
               if(_loc10_.didFillBowl && _loc9_.isFinal === true && _loc9_.y > 417 && _loc10_.clip.bowl.fillup.currentFrame == 1)
               {
                  _loc10_.clip.bowl.fillup.gotoAndPlay(2);
               }
               if(_loc9_.y > 480)
               {
                  if(_loc9_.parent)
                  {
                     _loc9_.parent.removeChild(_loc9_);
                  }
                  _loc10_.particles.splice(_loc1_,1);
               }
               _loc1_--;
            }
            if(_loc10_.didFillBowl == true && _loc10_.finishedFillingBowl == false && _loc10_.clip.bowl.fillup.currentFrame == _loc10_.clip.bowl.fillup.totalFrames)
            {
               _loc10_.finishedFillingBowl = true;
               if(_loc10_.loopSound)
               {
                  _loc10_.loopSound.stop();
                  _loc10_.loopSound = null;
               }
               _loc10_.screen.gameObj.var_129.playSound("chiliworks_finishpouring.wav",false,0.5);
            }
         }
      }
      
      public function setupPipes() : void
      {
         var _loc9_:Number = NaN;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Boolean = false;
         var _loc7_:ChiliWorksPipe = null;
         var _loc8_:MiniGameChiliWorks = this;
         if(_loc8_.gridArray == null)
         {
            _loc8_.gridArray = [];
            _loc1_ = 0;
            while(_loc1_ < _loc8_.numRows)
            {
               _loc3_ = [];
               _loc2_ = 0;
               while(_loc2_ < _loc8_.numColumns)
               {
                  _loc3_.push(null);
                  _loc2_++;
               }
               _loc8_.gridArray.push(_loc3_);
               _loc1_++;
            }
         }
         _loc8_.cleanupPipes();
         _loc9_ = _loc8_.whichDifficulty;
         if(_loc9_ > _loc8_.leveldata.length)
         {
            _loc9_ = _loc8_.leveldata.length;
         }
         var _loc10_:Array = _loc8_.leveldata[_loc9_ - 1];
         _loc2_ = 0;
         while(_loc2_ < _loc8_.numRows)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc8_.numColumns)
            {
               if(_loc10_[_loc2_][_loc1_] != null)
               {
                  _loc4_ = String(_loc10_[_loc2_][_loc1_].type);
                  _loc5_ = Number(_loc10_[_loc2_][_loc1_].rot);
                  _loc6_ = false;
                  if(_loc10_[_loc2_][_loc1_].locked === true)
                  {
                     _loc6_ = true;
                  }
                  _loc7_ = new ChiliWorksPipe(_loc8_,_loc4_,_loc5_,_loc6_,_loc1_,_loc2_);
                  _loc8_.gridArray[_loc2_][_loc1_] = _loc7_;
               }
               _loc1_++;
            }
            _loc2_++;
         }
         _loc8_.spigotY = _loc10_[_loc8_.numRows][0];
         _loc8_.clip.spigot.y = _loc8_.gridStartY + _loc8_.spigotY * _loc8_.tileWidth;
         _loc8_.endY = _loc10_[_loc8_.numRows + 1][0];
         _loc8_.clip.endpiece.y = _loc8_.gridStartY + _loc8_.endY * _loc8_.tileWidth;
         _loc8_.clip.bowl.fillup.gotoAndStop(1);
         _loc8_.timerStart = _loc10_[_loc8_.numRows + 2][0] * 30;
      }
      
      public function cleanupPipes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MiniGameChiliWorks = this;
         if(_loc3_.gridArray != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.gridArray.length)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc3_.gridArray[_loc2_].length)
               {
                  if(_loc3_.gridArray[_loc2_][_loc1_] is ChiliWorksPipe && _loc3_.gridArray[_loc2_][_loc1_] != null)
                  {
                     _loc3_.gridArray[_loc2_][_loc1_].destroy();
                     _loc3_.gridArray[_loc2_][_loc1_] = null;
                  }
                  _loc1_++;
               }
               _loc2_++;
            }
         }
      }
   }
}

