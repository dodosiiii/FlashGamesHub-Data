package cheeseGame.models
{
   import cheeseGame.screens.MiniGameChiliWorks;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_2.*;
   
   public class ChiliWorksPipe
   {
      
      public const TYPE_STRAIGHT:String = "straight";
      
      public const TYPE_CURVE:String = "curve";
      
      public const TYPE_ALL:String = "all";
      
      public const TYPE_TEE:String = "tee";
      
      public const TYPE_CAP:String = "cap";
      
      public const FLOW_LEFT:String = "left";
      
      public const FLOW_RIGHT:String = "right";
      
      public const FLOW_UP:String = "up";
      
      public const FLOW_DOWN:String = "down";
      
      public var minigame:MiniGameChiliWorks;
      
      public var clip:MovieClip;
      
      public var type:String;
      
      public var flowDirections:Array;
      
      public var rotation:Number = 0;
      
      public var clipRotation:Number = 0;
      
      public var clipTargetRotation:Number = 0;
      
      public var isLocked:Boolean = false;
      
      public var gridX:Number = 0;
      
      public var gridY:Number = 0;
      
      public var didFlowThrough:Boolean = false;
      
      public var flowChainNumber:Number = -1;
      
      public var didClickLockedPipe:Boolean = false;
      
      public var lockedClickTimer:Number = 0;
      
      public var lockedClickTimerMax:Number = 20;
      
      public var lockedClickRotAmount:Number = 0;
      
      public var lockedClickRotAmountMax:Number = 3;
      
      public function ChiliWorksPipe(param1:MiniGameChiliWorks, param2:String, param3:Number, param4:Boolean, param5:Number, param6:Number)
      {
         this.flowDirections = [];
         super();
         this.minigame = param1;
         this.type = param2;
         this.rotation = param3;
         this.clipRotation = param3;
         this.clipTargetRotation = param3;
         this.isLocked = param4;
         this.gridX = param5;
         this.gridY = param6;
         this.setupPipe();
      }
      
      public function setupPipe() : void
      {
         var _loc1_:ChiliWorksPipe = this;
         _loc1_.clip = new chiliPipeMC();
         if(_loc1_.type == _loc1_.TYPE_STRAIGHT)
         {
            _loc1_.clip.gotoAndStop(1);
         }
         else if(_loc1_.type == _loc1_.TYPE_CURVE)
         {
            _loc1_.clip.gotoAndStop(2);
         }
         else if(_loc1_.type == _loc1_.TYPE_ALL)
         {
            _loc1_.clip.gotoAndStop(3);
         }
         else if(_loc1_.type == _loc1_.TYPE_TEE)
         {
            _loc1_.clip.gotoAndStop(4);
         }
         else if(_loc1_.type == _loc1_.TYPE_CAP)
         {
            _loc1_.clip.gotoAndStop(5);
         }
         if(_loc1_.isLocked)
         {
            _loc1_.clip.gotoAndStop(_loc1_.clip.currentFrame + 5);
         }
         _loc1_.clip.mouseEnabled = true;
         _loc1_.clip.mouseChildren = false;
         _loc1_.clip.buttonMode = true;
         _loc1_.clip.useHandCursor = true;
         _loc1_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickPipe);
         _loc1_.clip.x = _loc1_.minigame.gridStartX + _loc1_.gridX * _loc1_.minigame.tileWidth;
         _loc1_.clip.y = _loc1_.minigame.gridStartY + _loc1_.gridY * _loc1_.minigame.tileWidth;
         _loc1_.clip.rotation = _loc1_.clipTargetRotation;
         _loc1_.minigame.clip.holder.addChild(_loc1_.clip);
         _loc1_.updateFlow();
         _loc1_.setupCaps();
      }
      
      public function setupCaps() : void
      {
         var _loc1_:ChiliWorksPipe = this;
         if(_loc1_.type == _loc1_.TYPE_STRAIGHT)
         {
            _loc1_.clip.cap2.visible = false;
            _loc1_.clip.cap4.visible = false;
         }
         else if(_loc1_.type == _loc1_.TYPE_CURVE)
         {
            _loc1_.clip.cap3.visible = false;
            _loc1_.clip.cap4.visible = false;
         }
         else if(_loc1_.type == _loc1_.TYPE_TEE)
         {
            _loc1_.clip.cap4.visible = false;
         }
         else if(_loc1_.type == _loc1_.TYPE_CAP)
         {
            _loc1_.clip.cap1.visible = false;
            _loc1_.clip.cap3.visible = false;
            _loc1_.clip.cap4.visible = false;
         }
         _loc1_.updateCaps();
      }
      
      public function updateCaps() : void
      {
         var _loc1_:ChiliWorksPipe = this;
         var _loc2_:Number = 1;
         var _loc3_:Number = 2;
         if(_loc1_.gridY % 2 == _loc1_.gridX % 2 && _loc1_.type != _loc1_.TYPE_CAP)
         {
            _loc2_ = 3;
            _loc3_ = 4;
            if(_loc1_.isLocked)
            {
               _loc2_ = 5;
               _loc3_ = 6;
            }
         }
         if(_loc1_.rotation == 0)
         {
            _loc1_.clip.cap1.gotoAndStop(_loc2_);
            _loc1_.clip.cap2.gotoAndStop(_loc2_);
            _loc1_.clip.cap3.gotoAndStop(_loc3_);
            _loc1_.clip.cap4.gotoAndStop(_loc3_);
         }
         else if(_loc1_.rotation == 90)
         {
            _loc1_.clip.cap4.gotoAndStop(_loc2_);
            _loc1_.clip.cap1.gotoAndStop(_loc2_);
            _loc1_.clip.cap2.gotoAndStop(_loc3_);
            _loc1_.clip.cap3.gotoAndStop(_loc3_);
         }
         else if(_loc1_.rotation == 180)
         {
            _loc1_.clip.cap3.gotoAndStop(_loc2_);
            _loc1_.clip.cap4.gotoAndStop(_loc2_);
            _loc1_.clip.cap1.gotoAndStop(_loc3_);
            _loc1_.clip.cap2.gotoAndStop(_loc3_);
         }
         else if(_loc1_.rotation == 270)
         {
            _loc1_.clip.cap2.gotoAndStop(_loc2_);
            _loc1_.clip.cap3.gotoAndStop(_loc2_);
            _loc1_.clip.cap4.gotoAndStop(_loc3_);
            _loc1_.clip.cap1.gotoAndStop(_loc3_);
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:ChiliWorksPipe = this;
         if(_loc1_.clip)
         {
            _loc1_.clip.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickPipe);
            if(_loc1_.clip.parent)
            {
               _loc1_.clip.parent.removeChild(_loc1_.clip);
            }
            _loc1_.clip = null;
         }
      }
      
      public function clickPipe(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:ChiliWorksPipe = this;
         if(Boolean(_loc3_.minigame) && _loc3_.minigame.didCheckPipes == false)
         {
            if(_loc3_.isLocked)
            {
               _loc3_.didClickLockedPipe = true;
               _loc3_.lockedClickRotAmount = _loc3_.lockedClickRotAmountMax;
               _loc3_.lockedClickTimer = 0;
               _loc3_.minigame.screen.gameObj.var_129.playSound("chiliworks_lockedpipe.wav");
            }
            else
            {
               _loc3_.clipTargetRotation += 90;
               _loc3_.rotation += 90;
               if(_loc3_.rotation >= 360)
               {
                  _loc3_.rotation -= 360;
               }
               if(_loc3_.rotation < 0)
               {
                  _loc3_.rotation += 360;
               }
               _loc3_.updateFlow();
               _loc3_.updateCaps();
               _loc2_ = Math.ceil(Math.random() * 4);
               _loc3_.minigame.screen.gameObj.var_129.playSound("chiliworks_pipe" + _loc2_ + ".wav");
            }
         }
      }
      
      public function updatePipe() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:ChiliWorksPipe = this;
         if(_loc5_.flowChainNumber > -1 && _loc5_.minigame.didCheckPipes && _loc5_.minigame.postCheckTimer > _loc5_.flowChainNumber * 2)
         {
            _loc1_ = _loc5_.minigame.postCheckTimer + _loc5_.flowChainNumber * 2;
            _loc2_ = Math.sin(_loc1_) * 2 + _loc5_.clipRotation;
            _loc5_.clip.rotation = _loc2_;
         }
         else if(_loc5_.minigame.didCheckPipes && _loc5_.clipRotation != _loc5_.clipTargetRotation)
         {
            _loc5_.clipRotation = _loc5_.clipTargetRotation;
            _loc5_.clip.rotation = _loc5_.clipRotation;
         }
         else if(_loc5_.clipRotation != _loc5_.clipTargetRotation)
         {
            _loc3_ = _loc5_.clipTargetRotation - _loc5_.clipRotation;
            _loc5_.clipRotation += _loc3_ / 2;
            if(Math.abs(_loc5_.clipTargetRotation - _loc5_.clipRotation) <= 1)
            {
               _loc5_.clipRotation = _loc5_.clipTargetRotation;
            }
            _loc5_.clip.rotation = _loc5_.clipRotation;
         }
         if(_loc5_.didClickLockedPipe)
         {
            _loc4_ = Math.sin(_loc5_.lockedClickTimer) * _loc5_.lockedClickRotAmount + _loc5_.clipRotation;
            _loc5_.clip.rotation = _loc4_;
            ++_loc5_.lockedClickTimer;
            _loc5_.lockedClickRotAmount -= 0.2;
            if(_loc5_.lockedClickRotAmount <= 0)
            {
               _loc5_.lockedClickRotAmount = 0;
               _loc5_.clip.rotation = _loc5_.clipRotation;
               _loc5_.didClickLockedPipe = false;
               _loc5_.lockedClickTimer = 0;
            }
         }
      }
      
      public function updateFlow() : void
      {
         var _loc1_:* = 0;
         var _loc2_:ChiliWorksPipe = this;
         if(_loc2_.flowDirections.length > 0)
         {
            _loc1_ = int(_loc2_.flowDirections.length - 1);
            while(_loc1_ >= 0)
            {
               _loc2_.flowDirections.splice(_loc1_,1);
               _loc1_--;
            }
         }
         if(_loc2_.type == _loc2_.TYPE_STRAIGHT)
         {
            if(_loc2_.rotation == 0 || _loc2_.rotation == 180)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_LEFT,_loc2_.FLOW_RIGHT);
            }
            else
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_UP,_loc2_.FLOW_DOWN);
            }
         }
         else if(_loc2_.type == _loc2_.TYPE_CURVE)
         {
            if(_loc2_.rotation == 0)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_DOWN,_loc2_.FLOW_RIGHT);
            }
            else if(_loc2_.rotation == 90)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_DOWN,_loc2_.FLOW_LEFT);
            }
            else if(_loc2_.rotation == 180)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_UP,_loc2_.FLOW_LEFT);
            }
            else
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_UP,_loc2_.FLOW_RIGHT);
            }
         }
         else if(_loc2_.type == _loc2_.TYPE_ALL)
         {
            _loc2_.flowDirections.push(_loc2_.FLOW_UP,_loc2_.FLOW_DOWN,_loc2_.FLOW_LEFT,_loc2_.FLOW_RIGHT);
         }
         else if(_loc2_.type == _loc2_.TYPE_TEE)
         {
            if(_loc2_.rotation == 0)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_LEFT,_loc2_.FLOW_RIGHT,_loc2_.FLOW_DOWN);
            }
            else if(_loc2_.rotation == 90)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_UP,_loc2_.FLOW_DOWN,_loc2_.FLOW_LEFT);
            }
            else if(_loc2_.rotation == 180)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_LEFT,_loc2_.FLOW_RIGHT,_loc2_.FLOW_UP);
            }
            else
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_UP,_loc2_.FLOW_DOWN,_loc2_.FLOW_RIGHT);
            }
         }
         else if(_loc2_.type == _loc2_.TYPE_CAP)
         {
            if(_loc2_.rotation == 0)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_DOWN);
            }
            else if(_loc2_.rotation == 90)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_LEFT);
            }
            else if(_loc2_.rotation == 180)
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_UP);
            }
            else
            {
               _loc2_.flowDirections.push(_loc2_.FLOW_RIGHT);
            }
         }
      }
      
      public function flagForEmitter(param1:String, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:ChiliWorksPipe = null;
         _loc5_ = this;
         _loc5_.minigame.emittersX.push(param2);
         _loc5_.minigame.emittersY.push(param3);
         _loc5_.minigame.emittersDir.push(param1);
         _loc5_.minigame.emittersDelay.push(param4);
      }
      
      public function checkPipe(param1:String, param2:String = "", param3:Number = 0) : Boolean
      {
         var _loc11_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:ChiliWorksPipe = null;
         var _loc8_:Boolean = false;
         var _loc9_:ChiliWorksPipe = this;
         var _loc10_:Boolean = true;
         _loc11_ = _loc9_.flowDirections.indexOf(param1);
         if(_loc11_ == -1)
         {
            _loc10_ = false;
            class_7.method_1(param2 + "Problem with the flow in piece " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- Coming into pipe from side = " + param1 + ". Can\'t receive flow in this direction!  (Only " + _loc9_.flowDirections.toString() + ")");
            _loc9_.flagForEmitter(param1,this.gridX,this.gridY,param3 * 2);
         }
         else
         {
            class_7.method_1(param2 + "OK, " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- Can receive flow from side " + param1 + ".... see where it goes:");
            if(_loc9_.didFlowThrough)
            {
               class_7.method_1(param2 + " -- " + this.gridX + ", " + this.gridY + " -- already flowed through, stop checking here.");
            }
            else
            {
               _loc9_.didFlowThrough = true;
               _loc9_.flowChainNumber = param3;
               _loc5_ = [];
               _loc4_ = 0;
               while(_loc4_ < _loc9_.flowDirections.length)
               {
                  if(_loc9_.flowDirections[_loc4_] != param1)
                  {
                     _loc5_.push(_loc9_.flowDirections[_loc4_]);
                  }
                  _loc4_++;
               }
               if(_loc5_.length > 0)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     _loc6_ = _loc5_[_loc4_];
                     _loc8_ = true;
                     if(_loc6_ == _loc9_.FLOW_UP)
                     {
                        _loc7_ = _loc9_.minigame.getPipe(_loc9_.gridX,_loc9_.gridY - 1);
                        if(_loc7_ == null)
                        {
                           _loc8_ = false;
                           class_7.method_1(param2 + " OUT OF BOUNDS, " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- Nothing is up.");
                           _loc9_.flagForEmitter(_loc9_.FLOW_DOWN,_loc9_.gridX,_loc9_.gridY - 1,param3 * 2);
                        }
                        else
                        {
                           _loc8_ = _loc7_.checkPipe(_loc9_.FLOW_DOWN,param2 + "--> " + this.gridX + "," + this.gridY + " ",param3 + 1);
                        }
                     }
                     else if(_loc6_ == _loc9_.FLOW_RIGHT)
                     {
                        _loc7_ = _loc9_.minigame.getPipe(_loc9_.gridX + 1,_loc9_.gridY);
                        if(_loc7_ == null)
                        {
                           _loc8_ = false;
                           class_7.method_1(param2 + " OUT OF BOUNDS, " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- Nothing is right.");
                           _loc9_.flagForEmitter(_loc9_.FLOW_LEFT,_loc9_.gridX + 1,_loc9_.gridY,param3 * 2);
                        }
                        else
                        {
                           _loc8_ = _loc7_.checkPipe(_loc9_.FLOW_LEFT,param2 + "--> " + this.gridX + "," + this.gridY + " ",param3 + 1);
                        }
                     }
                     else if(_loc6_ == _loc9_.FLOW_DOWN)
                     {
                        _loc7_ = _loc9_.minigame.getPipe(_loc9_.gridX,_loc9_.gridY + 1);
                        if(_loc7_ == null)
                        {
                           _loc8_ = false;
                           class_7.method_1(param2 + " OUT OF BOUNDS, " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- Nothing is below.");
                           _loc9_.flagForEmitter(_loc9_.FLOW_UP,_loc9_.gridX,_loc9_.gridY + 1,param3 * 2);
                        }
                        else
                        {
                           _loc8_ = _loc7_.checkPipe(_loc9_.FLOW_UP,param2 + "--> " + this.gridX + "," + this.gridY + " ",param3 + 1);
                        }
                     }
                     else if(_loc6_ == _loc9_.FLOW_LEFT)
                     {
                        if(_loc9_.gridX == 0)
                        {
                           if(_loc9_.minigame.endY == _loc9_.gridY)
                           {
                              _loc8_ = true;
                              _loc9_.minigame.didReachEnd = true;
                           }
                           else
                           {
                              _loc8_ = false;
                              class_7.method_1(param2 + " OUT OF BOUNDS, " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- At the left, but the pipe isn\'t next to me.");
                              _loc9_.flagForEmitter("oobright",_loc9_.gridX - 1,_loc9_.gridY,param3 * 2);
                           }
                        }
                        else
                        {
                           _loc7_ = _loc9_.minigame.getPipe(_loc9_.gridX - 1,_loc9_.gridY);
                           if(_loc7_ == null)
                           {
                              _loc8_ = false;
                              class_7.method_1(param2 + " OUT OF BOUNDS, " + this.gridX + ", " + this.gridY + " -- " + _loc9_.type + " -- Nothing is left.");
                              _loc9_.flagForEmitter(_loc9_.FLOW_RIGHT,_loc9_.gridX - 1,_loc9_.gridY,param3 * 2);
                           }
                           else
                           {
                              _loc8_ = _loc7_.checkPipe(_loc9_.FLOW_RIGHT,param2 + "--> " + this.gridX + "," + this.gridY + " ",param3 + 1);
                           }
                        }
                     }
                     if(_loc8_ == false)
                     {
                        _loc10_ = false;
                     }
                     _loc4_++;
                  }
               }
            }
         }
         return _loc10_;
      }
   }
}

