package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.screens.FryScreen;
   import flash.display.*;
   import flash.events.Event;
   import flash.filters.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class FryTopping
   {
      
      public var gameObj:class_5;
      
      public var fryOrder:FryOrder;
      
      public var toppingHolder:MovieClip;
      
      public var isDoneTopping:Boolean = false;
      
      public var currentTopping:String = "none";
      
      public var currentToppingData:ToppingItem;
      
      public var distributionAreas:Number = 8;
      
      public var distributionWidth:Number = 50;
      
      public var distributionStartingX:Number = -50;
      
      public var bunBoundsLeft:Number = 123;
      
      public var bunBoundsRight:Number = 354;
      
      public var bunBoundsMargin:Number = 25;
      
      public var coords:Array;
      
      public var rateTimer:Number = 0;
      
      public var isPouring:Boolean = false;
      
      public var lastCurveDir:Number = -1;
      
      public var squirtWaveRange:Number = 2;
      
      public var squirtWaveAngle:Number = 0;
      
      public var squirtWaveSpeed:Number = 0.3;
      
      public var gravity:Number = 1;
      
      public var nudgeRotation:Number = 2;
      
      public var layerTypes:Array;
      
      public var layerNodeTallies:Array;
      
      public var layerNodeDistributions:Array;
      
      public var drizzleIntersections:Number = 0;
      
      public var sauceNodeDistributions:Array;
      
      public var sauceNodeTally:Number = 0;
      
      public var fallingBlobs:MovieClip;
      
      public var fallingBlobsHolder:MovieClip;
      
      public var fallingBlobLayerType:String = "none";
      
      public var fallingBackgroundBlobs:MovieClip;
      
      public var fallingBackgroundBlobsHolder:MovieClip;
      
      public var tally:Number = 0;
      
      public var originPoint:Point;
      
      public var whichColor:Number = 0;
      
      public var whichColorDir:Number = 1;
      
      public var startBlobDiff:Number = -80;
      
      public var startSauceDiff:Number = -85;
      
      public var bakedBlobs:MovieClip;
      
      public var bakedBMP:BitmapData;
      
      public var finalBMP:BitmapData;
      
      public var finalBitmap:Bitmap;
      
      public var progressBMP:BitmapData;
      
      public var progressBitmap:Bitmap;
      
      public var progressMC:MovieClip;
      
      public var bitmapOffsetX:Number = -98;
      
      public var bitmapOffsetY:Number = -62;
      
      public var bitmapWidth:Number = 182;
      
      public var bitmapHeight:Number = 130;
      
      public var looseBMP:BitmapData;
      
      public var looseBitmap:Bitmap;
      
      public var looseWidth:Number = 220;
      
      public var looseHeight:Number = 205;
      
      public var looseOffsetX:Number = 114;
      
      public var looseOffsetY:Number = 85;
      
      public var heightBitmap:BitmapData = null;
      
      public var heightOffsetMax:Number = 20;
      
      public var heightmapOffsetX:Number = 0;
      
      public var heightmapOffsetY:Number = 0;
      
      public function FryTopping(param1:class_5, param2:FryOrder)
      {
         this.coords = [];
         this.layerTypes = [];
         this.layerNodeTallies = [];
         this.layerNodeDistributions = [];
         this.sauceNodeDistributions = [];
         this.originPoint = new Point(0,0);
         super();
         this.gameObj = param1;
         this.fryOrder = param2;
         class_7.method_1("Creating Fries Topping Object");
         this.setupFryTopping();
      }
      
      public function setupFryTopping() : void
      {
         var _loc1_:FryTopping = this;
         _loc1_.toppingHolder = new MovieClip();
         _loc1_.fryOrder.clip.addChild(_loc1_.toppingHolder);
         _loc1_.toppingHolder.x = 0;
         _loc1_.toppingHolder.y = 0;
         _loc1_.setupPouringSystem();
         _loc1_.setupHeightMap();
      }
      
      public function drawLooseTopping(param1:MovieClip, param2:Matrix) : void
      {
         var _loc3_:FryTopping = this;
         param2.tx += _loc3_.looseOffsetX;
         param2.ty += _loc3_.looseOffsetY;
         _loc3_.looseBMP.draw(param1,param2);
      }
      
      public function drawLooseSauce(param1:MovieClip) : void
      {
         var _loc2_:FryTopping = this;
         var _loc3_:Matrix = new Matrix();
         _loc3_.tx = param1.x + _loc2_.looseOffsetX;
         _loc3_.ty = param1.y + _loc2_.looseOffsetY;
         _loc2_.looseBMP.draw(param1,_loc3_,null,null,null,true);
         param1.graphics.clear();
      }
      
      public function clearLooseToppings() : void
      {
         var _loc1_:FryTopping = this;
         if(_loc1_.looseBitmap != null)
         {
            if(_loc1_.looseBitmap.parent)
            {
               _loc1_.looseBitmap.parent.removeChild(_loc1_.looseBitmap);
            }
            _loc1_.looseBitmap.bitmapData = null;
            _loc1_.looseBitmap = null;
         }
         if(_loc1_.looseBMP != null)
         {
            _loc1_.looseBMP.dispose();
            _loc1_.looseBMP = null;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:FryTopping = this;
         trace("DESTROY TOPPING");
         _loc1_.clearLooseToppings();
         if(_loc1_.progressBitmap)
         {
            if(_loc1_.progressBitmap.parent)
            {
               _loc1_.progressBitmap.parent.removeChild(_loc1_.progressBitmap);
            }
            _loc1_.progressBitmap.bitmapData = null;
            _loc1_.progressBitmap = null;
         }
         if(_loc1_.progressBMP)
         {
            _loc1_.progressBMP.dispose();
            _loc1_.progressBMP = null;
         }
         if(_loc1_.finalBitmap)
         {
            if(_loc1_.finalBitmap.parent)
            {
               _loc1_.finalBitmap.parent.removeChild(_loc1_.finalBitmap);
            }
            _loc1_.finalBitmap.bitmapData = null;
            _loc1_.finalBitmap = null;
         }
         if(_loc1_.finalBMP)
         {
            _loc1_.finalBMP.dispose();
            _loc1_.finalBMP = null;
         }
         if(_loc1_.progressMC)
         {
            if(_loc1_.progressMC.parent)
            {
               _loc1_.progressMC.parent.removeChild(_loc1_.progressMC);
            }
            _loc1_.progressMC = null;
         }
         if(_loc1_.bakedBlobs)
         {
            if(_loc1_.bakedBlobs.parent)
            {
               _loc1_.bakedBlobs.parent.removeChild(_loc1_.bakedBlobs);
            }
            _loc1_.bakedBlobs = null;
         }
         if(_loc1_.fallingBlobs)
         {
            if(_loc1_.fallingBlobs.parent)
            {
               _loc1_.fallingBlobs.parent.removeChild(_loc1_.fallingBlobs);
            }
            _loc1_.fallingBlobs = null;
         }
         if(_loc1_.fallingBackgroundBlobs)
         {
            if(_loc1_.fallingBackgroundBlobs.parent)
            {
               _loc1_.fallingBackgroundBlobs.parent.removeChild(_loc1_.fallingBackgroundBlobs);
            }
            _loc1_.fallingBackgroundBlobs = null;
         }
         if(_loc1_.fallingBlobsHolder.parent)
         {
            _loc1_.fallingBlobsHolder.parent.removeChild(_loc1_.fallingBlobsHolder);
         }
         _loc1_.fallingBlobsHolder = null;
         if(_loc1_.fallingBackgroundBlobsHolder.parent)
         {
            _loc1_.fallingBackgroundBlobsHolder.parent.removeChild(_loc1_.fallingBackgroundBlobsHolder);
         }
         _loc1_.fallingBackgroundBlobsHolder = null;
         if(_loc1_.toppingHolder.parent)
         {
            _loc1_.toppingHolder.parent.removeChild(_loc1_.toppingHolder);
         }
         _loc1_.toppingHolder = null;
         _loc1_.fryOrder = null;
         _loc1_.currentToppingData = null;
         _loc1_.gameObj = null;
      }
      
      public function finishPouring() : void
      {
         var _loc1_:FryTopping = this;
         _loc1_.toppingHolder.mouseEnabled = false;
         _loc1_.toppingHolder.mouseChildren = false;
         _loc1_.fryOrder.clip.mouseEnabled = false;
         _loc1_.fryOrder.clip.mouseChildren = false;
         _loc1_.isDoneTopping = true;
      }
      
      public function setupPouringSystem() : void
      {
         var _loc1_:FryTopping = this;
         _loc1_.bakedBlobs = new MovieClip();
         _loc1_.fallingBlobs = new MovieClip();
         _loc1_.fallingBlobsHolder = new MovieClip();
         _loc1_.fallingBlobsHolder.addChild(_loc1_.fallingBlobs);
         _loc1_.fryOrder.clip.addChild(_loc1_.fallingBlobsHolder);
         _loc1_.fallingBlobsHolder.x = _loc1_.toppingHolder.x;
         _loc1_.fallingBlobsHolder.y = _loc1_.toppingHolder.y;
         _loc1_.fallingBlobs.mouseEnabled = false;
         _loc1_.fallingBlobsHolder.mouseEnabled = false;
         _loc1_.fallingBackgroundBlobs = new MovieClip();
         _loc1_.fallingBackgroundBlobsHolder = new MovieClip();
         _loc1_.fallingBackgroundBlobsHolder.addChild(_loc1_.fallingBackgroundBlobs);
         _loc1_.fryOrder.clip.addChildAt(_loc1_.fallingBackgroundBlobsHolder,0);
         _loc1_.fallingBackgroundBlobsHolder.x = _loc1_.toppingHolder.x;
         _loc1_.fallingBackgroundBlobsHolder.y = _loc1_.toppingHolder.y;
         _loc1_.fallingBackgroundBlobs.mouseEnabled = false;
         _loc1_.fallingBackgroundBlobsHolder.mouseEnabled = false;
         var _loc2_:ColorTransform = new ColorTransform(0.9,0.9,0.9,1,30,30,30,0);
         _loc1_.fallingBackgroundBlobs.transform.colorTransform = _loc2_;
         _loc1_.toppingHolder.addChild(_loc1_.bakedBlobs);
         _loc1_.fryOrder.clip.mouseEnabled = false;
         _loc1_.fryOrder.clip.mouseChildren = false;
         _loc1_.toppingHolder.mouseEnabled = false;
         _loc1_.bakedBMP = new BitmapData(_loc1_.bitmapWidth,_loc1_.bitmapHeight,true,0);
         _loc1_.finalBMP = new BitmapData(_loc1_.bakedBMP.width,_loc1_.bakedBMP.height,true,0);
         _loc1_.finalBitmap = new Bitmap(_loc1_.finalBMP,"auto",true);
         _loc1_.bakedBlobs.addChild(_loc1_.finalBitmap);
         _loc1_.progressBMP = new BitmapData(_loc1_.bakedBMP.width,_loc1_.bakedBMP.height,true,0);
         _loc1_.progressBitmap = new Bitmap(_loc1_.progressBMP,"auto",true);
         _loc1_.progressMC = new MovieClip();
         _loc1_.progressMC.addChild(_loc1_.progressBitmap);
         _loc1_.progressMC.mouseEnabled = false;
         _loc1_.progressMC.mouseChildren = false;
         _loc1_.bakedBlobs.addChild(_loc1_.progressMC);
         _loc1_.bakedBlobs.x = 0 + _loc1_.bitmapOffsetX;
         _loc1_.bakedBlobs.y = 0 + _loc1_.bitmapOffsetY;
         _loc1_.sauceNodeDistributions = [0,0,0,0,0,0,0,0];
         _loc1_.sauceNodeTally = 0;
         _loc1_.looseBMP = new BitmapData(_loc1_.looseWidth,_loc1_.looseHeight,true,0);
         _loc1_.looseBitmap = new Bitmap(_loc1_.looseBMP,"auto",true);
         _loc1_.looseBitmap.x = 0 - (_loc1_.looseOffsetX - _loc1_.fryOrder.placeX);
         _loc1_.looseBitmap.y = 0 - (_loc1_.looseOffsetY - _loc1_.fryOrder.placeY);
         _loc1_.fryOrder.foodOrder.clip.addChildAt(_loc1_.looseBitmap,0);
      }
      
      public function startPouring() : void
      {
         var _loc1_:ToppingShaker = null;
         var _loc2_:ToppingSpoon = null;
         var _loc3_:FryTopping = this;
         var _loc4_:FryScreen = _loc3_.gameObj.var_131;
         var _loc5_:Number = _loc3_.gameObj.mouseX;
         var _loc6_:Number = _loc3_.gameObj.mouseY;
         if(!_loc4_.isSelectingBottle && !_loc3_.isDoneTopping && (_loc3_.coords.length == 0 && _loc4_.selectedTopping != "none" || _loc3_.coords.length > 0 && _loc4_.selectedTopping == _loc3_.currentTopping))
         {
            _loc3_.currentTopping = _loc4_.selectedTopping;
            _loc3_.getToppingData(true);
            _loc3_.isPouring = true;
            _loc3_.rateTimer = 0;
            _loc3_.squirtWaveAngle = 0;
            _loc1_ = _loc4_.getSauceBottle(_loc3_.currentTopping);
            if(_loc1_ != null)
            {
               _loc1_.startPouring();
            }
            _loc2_ = _loc4_.getSpoon(_loc3_.currentTopping);
            if(_loc2_ != null)
            {
               _loc2_.startPouring();
            }
            _loc3_.fallingBlobs.filters = _loc3_.createFilters(_loc3_.currentTopping);
            _loc3_.fallingBackgroundBlobs.filters = _loc3_.createFilters(_loc3_.currentTopping);
            if(_loc3_.gameObj.method_111(22) && _loc3_.currentTopping == FoodData.FRYTOPPING_CHEDDAR)
            {
               _loc3_.gameObj.method_104(22);
            }
            else if(_loc3_.gameObj.hud.whichContextTraining == "saucefries" && _loc3_.currentTopping == FoodData.SAUCE_KETCHUP)
            {
               _loc3_.gameObj.var_128.setTrained("saucefries");
               _loc3_.gameObj.hud.removeContextTraining();
            }
            else if(_loc3_.gameObj.hud.whichContextTraining == "baconfries" && _loc3_.currentTopping == FoodData.FRYTOPPING_BACON)
            {
               _loc3_.gameObj.var_128.setTrained("baconfries");
               _loc3_.gameObj.hud.removeContextTraining();
            }
         }
      }
      
      public function checkForStartPouring() : void
      {
         var _loc1_:FryTopping = this;
         var _loc2_:FryScreen = _loc1_.gameObj.var_131;
         if(_loc2_.shouldStartPouring && !_loc1_.isPouring && !_loc2_.isSelectingBottle && !_loc2_.isSelectingBin && !_loc1_.isDoneTopping && (_loc1_.coords.length == 0 && _loc2_.selectedTopping != "none" || _loc1_.coords.length > 0 && _loc2_.selectedTopping == _loc1_.currentTopping))
         {
            _loc1_.startPouring();
            _loc2_.shouldStartPouring = false;
         }
      }
      
      public function stopPouring(param1:Boolean = false) : void
      {
         var _loc2_:ToppingSpoon = null;
         var _loc3_:ToppingShaker = null;
         var _loc4_:FryTopping = this;
         if(!_loc4_.gameObj.var_131.isSelectingBottle && !_loc4_.gameObj.var_131.isSelectingBin && !_loc4_.isDoneTopping && _loc4_.isPouring)
         {
            _loc4_.isPouring = false;
            if(_loc4_.coords.length > 0)
            {
               _loc4_.coords[_loc4_.coords.length - 1].end = true;
            }
            _loc2_ = _loc4_.gameObj.var_131.getSpoon(_loc4_.currentTopping);
            if(_loc2_ != null)
            {
               _loc2_.stopPouring();
            }
            _loc3_ = _loc4_.gameObj.var_131.getSauceBottle(_loc4_.currentTopping);
            if(_loc3_ != null)
            {
               _loc3_.stopPouring();
            }
         }
         if(param1)
         {
            _loc4_.gameObj.var_131.shouldDeselect = true;
         }
         _loc4_.gameObj.var_131.stopPouringSound();
         if(_loc4_.currentTopping == FoodData.FRYTOPPING_CHEDDAR)
         {
            _loc4_.gameObj.method_104(23);
         }
         else if(_loc4_.currentTopping == FoodData.SAUCE_KETCHUP && !_loc4_.gameObj.var_128.hasTrained("baconfries") && _loc4_.gameObj.var_128.currentDay == 1 && !_loc4_.gameObj.training && _loc4_.gameObj.var_134.orderline.length == 0 && _loc4_.gameObj.var_134.waitline.length == 1)
         {
            _loc4_.gameObj.hud.showContextTraining("baconfries");
         }
      }
      
      public function saveNodeDistribution(param1:Number, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:FryTopping = this;
         var _loc7_:Number = param2;
         var _loc8_:Number = param3;
         param2 += _loc6_.getNodeOffsetX();
         param3 += _loc6_.getNodeOffsetY();
         var _loc9_:Number = 0;
         if(param2 < 0 && param3 < -2)
         {
            _loc9_ = 0;
         }
         else if(param2 >= 0 && param3 < -2)
         {
            _loc9_ = 1;
         }
         else if(param2 >= 0 && param3 >= -2)
         {
            _loc9_ = 2;
         }
         else if(param2 < 0 && param3 >= -2)
         {
            _loc9_ = 3;
         }
         if(_loc6_.isInsideFries(_loc7_,_loc8_,false) == false)
         {
            _loc9_ += 4;
         }
         _loc6_.layerNodeDistributions[param1][_loc9_] += 1;
         _loc6_.layerNodeTallies[param1] += 1;
         if(_loc6_.coords.length <= 1)
         {
            class_7.method_1("Last Layer Distro: " + _loc6_.layerNodeDistributions[_loc6_.layerNodeDistributions.length - 1].toString());
         }
      }
      
      public function toppingIsSauce(param1:String = null) : Boolean
      {
         var _loc2_:FryTopping = this;
         var _loc3_:ToppingItem = _loc2_.getToppingData();
         if(_loc3_ == null)
         {
            return false;
         }
         return _loc3_.isSauce;
      }
      
      public function toppingCanInbetween(param1:String = null) : Boolean
      {
         var _loc2_:FryTopping = this;
         var _loc3_:ToppingItem = _loc2_.getToppingData();
         if(_loc3_ == null)
         {
            return false;
         }
         return _loc3_.inbetweens;
      }
      
      public function getToppingData(param1:Boolean = false) : ToppingItem
      {
         var _loc2_:FryTopping = this;
         var _loc3_:ToppingItem = null;
         if(_loc2_.currentToppingData != null && (!param1 || param1 && _loc2_.currentToppingData.type == _loc2_.currentTopping))
         {
            _loc3_ = _loc2_.currentToppingData;
         }
         else if(_loc2_.currentTopping != "" && _loc2_.currentTopping != "none")
         {
            _loc2_.currentToppingData = _loc2_.gameObj.toppingData.getToppingItemData(_loc2_.currentTopping);
            _loc3_ = _loc2_.currentToppingData;
         }
         else
         {
            _loc3_ = new ToppingItem("","",0,50,50,50,50,50,50);
         }
         return _loc3_;
      }
      
      public function addBlob(param1:Number = -1, param2:Number = -1, param3:Number = -1) : void
      {
         var _loc24_:FryTopping = null;
         var _loc34_:Number = NaN;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Class = null;
         var _loc16_:MovieClip = null;
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Number = Number(NaN);
         var _loc20_:Number = Number(NaN);
         var _loc21_:Number = Number(NaN);
         var _loc22_:Object = null;
         var _loc23_:ToppingItem = null;
         _loc24_ = this;
         var _loc25_:Number = _loc24_.gameObj.mouseX;
         var _loc26_:Number = _loc24_.fryOrder.clip.mouseX;
         var _loc27_:Number = _loc24_.fryOrder.clip.mouseY;
         var _loc28_:Number = _loc26_;
         var _loc29_:Number = _loc27_;
         var _loc30_:Number = 0;
         var _loc31_:ToppingShaker = _loc24_.gameObj.var_131.getSauceBottle(_loc24_.currentTopping);
         var _loc32_:ToppingSpoon = _loc24_.gameObj.var_131.getSpoon(_loc24_.currentTopping);
         _loc28_ += Math.sin(_loc24_.squirtWaveAngle) * _loc24_.squirtWaveRange;
         if(param1 > -1)
         {
            _loc28_ = param1;
         }
         if(param2 > -1)
         {
            _loc29_ = param2;
         }
         if(param3 > -1)
         {
            _loc30_ = param3;
         }
         _loc26_ = _loc28_;
         _loc27_ = _loc29_;
         if(_loc24_.toppingIsSauce())
         {
            _loc29_ += _loc24_.startSauceDiff;
         }
         else
         {
            _loc29_ += _loc24_.startBlobDiff;
         }
         var _loc33_:* = !_loc24_.isInsideFries(_loc26_,_loc27_,false);
         _loc34_ = _loc24_.getHeightMapOffset(_loc26_,_loc27_);
         if(_loc34_ >= _loc24_.heightOffsetMax * 0.7)
         {
            _loc33_ = true;
         }
         _loc27_ += _loc34_;
         if(param1 == -1)
         {
            _loc24_.adjustFallingLayer();
         }
         if(_loc24_.toppingIsSauce() && param1 == -1 && param2 == -1)
         {
            if(_loc24_.coords.length > 0 && _loc24_.toppingCanInbetween())
            {
               _loc4_ = Number(_loc24_.coords[_loc24_.coords.length - 1].x);
               _loc5_ = Number(_loc24_.coords[_loc24_.coords.length - 1].y);
               _loc6_ = Number(_loc24_.coords[_loc24_.coords.length - 1].speed);
               if(_loc24_.coords[_loc24_.coords.length - 1].end !== true)
               {
                  _loc7_ = _loc28_ - _loc4_;
                  _loc8_ = _loc29_ - _loc5_;
                  _loc9_ = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
                  _loc10_ = Math.floor(_loc9_ / 10);
                  if(_loc10_ > 0)
                  {
                     _loc11_ = 1;
                     while(_loc11_ < _loc10_)
                     {
                        _loc12_ = _loc4_ + _loc11_ * (_loc7_ / _loc10_);
                        _loc13_ = _loc5_ + _loc11_ * (_loc8_ / _loc10_);
                        if(_loc24_.toppingIsSauce())
                        {
                           _loc13_ -= _loc24_.startSauceDiff;
                        }
                        else
                        {
                           _loc13_ -= _loc24_.startBlobDiff;
                        }
                        _loc14_ = _loc6_ - _loc11_ * (_loc6_ / _loc10_);
                        _loc24_.addBlob(_loc12_,_loc13_,_loc14_);
                        _loc11_++;
                     }
                  }
               }
            }
         }
         if(_loc24_.gameObj.var_131.toppingRemaining > 0)
         {
            if(_loc24_.isWithinFryArea(_loc26_,_loc27_))
            {
               _loc15_ = getDefinitionByName(_loc24_.getToppingData().pieceName) as Class;
               _loc16_ = new _loc15_();
               _loc17_ = _loc24_.getToppingData().rotationMin;
               _loc18_ = _loc24_.getToppingData().rotationMax;
               _loc19_ = _loc18_ - _loc17_;
               _loc20_ = Math.random() * _loc19_ + _loc17_;
               _loc21_ = _loc24_.gameObj.var_131.toppingRemaining / _loc24_.gameObj.var_131.toppingCapacity;
               _loc16_.rotation = _loc20_;
               _loc16_.gotoAndStop(Math.ceil(Math.random() * _loc16_.totalFrames));
               _loc22_ = {
                  "x":_loc28_,
                  "y":_loc29_,
                  "targetx":_loc26_,
                  "targety":_loc27_,
                  "speed":_loc30_,
                  "clip":_loc16_,
                  "usecoll":-1,
                  "percentdeep":_loc21_,
                  "isOutside":_loc33_,
                  "offset":_loc34_
               };
               _loc24_.coords.push(_loc22_);
               if(param1 > -1)
               {
                  _loc22_.wasForced = true;
               }
               if(!_loc24_.toppingIsSauce() || _loc24_.currentTopping == FoodData.FRYSAUCE_POUTINE && _loc24_.gameObj.var_131.toppingRemaining % 2 == 0)
               {
                  _loc24_.fallingBlobs.addChild(_loc22_.clip);
               }
               --_loc24_.gameObj.var_131.toppingRemaining;
               if(_loc31_)
               {
                  _loc31_.setIcon("none");
               }
               if(_loc32_)
               {
                  _loc32_.setIcon("none");
               }
               _loc23_ = _loc24_.getToppingData();
               if(_loc24_.gameObj.var_131.isPlayingPouringSound() == false)
               {
                  if(_loc23_.isSauce || _loc23_.type == FoodData.FRYSAUCE_SOURCREAM)
                  {
                     _loc24_.gameObj.var_131.playPouringSound("squeeze_bottle.wav");
                  }
                  else if(_loc23_.type == FoodData.FRYTOPPING_CHIVES || _loc23_.type == FoodData.FRYTOPPING_ROSEMARY || _loc23_.type == FoodData.FRYTOPPING_SEASONING)
                  {
                     _loc24_.gameObj.var_131.playPouringSound("pour_shaker.wav");
                  }
                  else
                  {
                     _loc24_.gameObj.var_131.playPouringSound("pour_solid.wav");
                  }
               }
            }
            else
            {
               if(_loc31_ != null || _loc32_ != null)
               {
                  if(_loc31_ != null)
                  {
                     _loc31_.setIcon("up");
                  }
                  if(_loc32_ != null)
                  {
                     _loc32_.setIcon("up");
                  }
                  if(_loc24_.coords.length > 0)
                  {
                     _loc24_.coords[_loc24_.coords.length - 1].end = true;
                  }
               }
               _loc24_.gameObj.var_131.stopPouringSound();
            }
         }
         if(param1 == -1 && _loc24_.gameObj.var_131.toppingRemaining <= 0)
         {
            _loc24_.gameObj.var_131.toppingRemaining = 0;
            _loc24_.stopPouring(true);
         }
      }
      
      private function degToRads(param1:Number) : Number
      {
         return param1 * Math.PI / 180;
      }
      
      public function adjustFallingLayer() : void
      {
         var _loc1_:FryTopping = this;
         _loc1_.fallingBlobLayerType = _loc1_.currentTopping;
      }
      
      public function screenUpdate(param1:Event = null) : void
      {
         var totalNodesDone:Number;
         var surface:Number;
         var speedmax:Number;
         var i:Number = Number(NaN);
         var useDropRate:Number = Number(NaN);
         var shouldDrop:Boolean = false;
         var mx:Matrix = null;
         var whichLayer:Number = Number(NaN);
         var useColor:uint = 0;
         var sauceLayer:Number = Number(NaN);
         var sa:Number = Number(NaN);
         var sauceMX:Matrix = null;
         var p:Number = Number(NaN);
         var e:Event = param1;
         var ob:FryTopping = this;
         ob.lastCurveDir = -1;
         ob.whichColor = 0;
         ob.checkForStartPouring();
         if(ob.isPouring)
         {
            if(ob.toppingIsSauce())
            {
               ob.squirtWaveAngle += ob.squirtWaveSpeed;
            }
            else
            {
               ob.squirtWaveAngle += ob.squirtWaveSpeed;
            }
            useDropRate = ob.getToppingData().dropRate;
            if(ob.gameObj.training)
            {
               useDropRate *= 2;
            }
            if(ob.rateTimer % useDropRate == 0)
            {
               if(ob.gameObj.var_131.toppingRemaining > 0)
               {
                  ob.addBlob();
               }
            }
            ++ob.rateTimer;
         }
         totalNodesDone = 0;
         surface = 0;
         speedmax = ob.getToppingData().maxSpeed;
         ob.fallingBlobs.graphics.clear();
         ob.fallingBackgroundBlobs.graphics.clear();
         i = 0;
         while(i < ob.coords.length)
         {
            shouldDrop = false;
            if(ob.toppingIsSauce() && ob.coords[i].done === true)
            {
               totalNodesDone++;
            }
            else if(ob.coords[i].y >= ob.coords[i].targety)
            {
               ob.coords[i].y = ob.coords[i].targety;
               ob.coords[i].clip.x = ob.coords[i].x;
               ob.coords[i].clip.y = ob.coords[i].y;
               mx = new Matrix();
               mx.rotate(ob.degToRads(ob.coords[i].clip.rotation));
               mx.tx = ob.coords[i].x;
               mx.ty = ob.coords[i].y;
               whichLayer = -1;
               if(ob.layerTypes.length > 0)
               {
                  if(ob.layerTypes[ob.layerTypes.length - 1] == ob.currentTopping)
                  {
                     whichLayer = ob.layerTypes.length - 1;
                  }
               }
               if(whichLayer == -1)
               {
                  ob.layerTypes.push(ob.currentTopping);
                  ob.layerNodeTallies.push(0);
                  ob.layerNodeDistributions.push([0,0,0,0,0,0,0,0]);
                  whichLayer = ob.layerTypes.length - 1;
               }
               if(ob.toppingIsSauce())
               {
                  ob.coords[i].done = true;
                  ob.saveNodeDistribution(whichLayer,ob.coords[i].x,ob.coords[i].y,true,false);
               }
               else
               {
                  ob.coords[i].clip.visible = true;
                  if(ob.coords[i].isOutside == false)
                  {
                     ob.drawIntoBitmap(ob.coords[i].clip,mx);
                  }
                  else
                  {
                     ob.drawLooseTopping(ob.coords[i].clip,mx);
                  }
                  if(ob.fallingBlobs.contains(ob.coords[i].clip))
                  {
                     ob.fallingBlobs.removeChild(ob.coords[i].clip);
                  }
                  else if(ob.fallingBackgroundBlobs.contains(ob.coords[i].clip))
                  {
                     ob.fallingBackgroundBlobs.removeChild(ob.coords[i].clip);
                  }
                  ob.saveNodeDistribution(whichLayer,ob.coords[i].x,ob.coords[i].y,false,false);
                  ob.coords[i].clip = null;
                  ob.redrawMainBitmap();
                  ob.coords.splice(i,1);
                  i--;
               }
            }
            else
            {
               ob.coords[i].clip.x = ob.coords[i].x;
               ob.coords[i].clip.y = ob.coords[i].y;
               if(Boolean(!ob.toppingIsSauce()) && Boolean(ob.coords[i].isOutside) && ob.coords[i].y > ob.coords[i].targety - ob.coords[i].offset)
               {
                  if(ob.isInsideFries(ob.coords[i].x,ob.coords[i].y,false))
                  {
                     ob.coords[i].clip.visible = false;
                  }
               }
               shouldDrop = true;
            }
            if(shouldDrop)
            {
               if(ob.coords[i].y < ob.coords[i].targety)
               {
                  if(ob.coords[i].speed < speedmax)
                  {
                     ob.coords[i].speed = Math.min(ob.coords[i].speed + ob.gravity,speedmax);
                  }
                  if(ob.coords[i].y + ob.coords[i].speed < ob.coords[i].targety)
                  {
                     ob.coords[i].y += ob.coords[i].speed;
                  }
                  else
                  {
                     ob.coords[i].y = ob.coords[i].targety;
                  }
               }
            }
            if(ob.toppingIsSauce())
            {
               try
               {
                  if(ob.coords.length > i + 1)
                  {
                     if(Boolean(ob.coords[i + 1].isOutside) && (ob.coords[i + 1].done === true || ob.coords[i + 1].y > ob.coords[i + 1].targety - ob.coords[i + 1].offset))
                     {
                        if(ob.coords[i].isOutside == false)
                        {
                           if(ob.coords[i].end !== true)
                           {
                              ob.coords[i].end = true;
                           }
                        }
                     }
                  }
                  if(i > 0)
                  {
                     if(Boolean(ob.coords[i - 1].isOutside) && (ob.coords[i - 1].done === true || ob.coords[i - 1].y > ob.coords[i - 1].targety - ob.coords[i - 1].offset))
                     {
                        if(ob.coords[i].isOutside == false)
                        {
                           if(ob.coords[i - 1].end !== true)
                           {
                              ob.coords[i - 1].end = true;
                           }
                        }
                     }
                  }
               }
               catch(err:Error)
               {
                  class_7.method_1("Error with line cutting.");
               }
               ob.lastCurveDir *= -1;
               useColor = ob.changeSauceColor(ob.currentTopping);
               if(i > 0 && ob.coords[i - 1].end !== true)
               {
                  ob.drawSauceLine(ob.currentTopping,ob.coords[i].x,ob.coords[i].y,ob.coords[i - 1].x,ob.coords[i - 1].y,ob.coords[i].done,ob.fallingBlobs,ob.fallingBackgroundBlobs,ob.coords[i],ob.coords[i - 1],useColor);
               }
            }
            i++;
         }
         if(ob.toppingIsSauce() && totalNodesDone > 0 && totalNodesDone == ob.coords.length)
         {
            sauceLayer = -1;
            if(ob.layerTypes.length > 0)
            {
               if(ob.layerTypes[ob.layerTypes.length - 1] == ob.currentTopping)
               {
                  sauceLayer = ob.layerTypes.length - 1;
               }
            }
            if(sauceLayer == -1)
            {
               ob.finalBMP.draw(ob.progressMC,null,null,null,null,true);
               ob.progressBMP.fillRect(ob.progressBMP.rect,0);
               ob.progressMC.filters = ob.createFilters(ob.currentTopping);
               ob.layerTypes.push(ob.currentTopping);
               ob.layerNodeTallies.push(0);
               ob.layerNodeDistributions.push([0,0,0,0,0,0,0,0]);
               whichLayer = ob.layerTypes.length - 1;
               sauceLayer = ob.layerTypes.length - 1;
            }
            ob.layerNodeTallies[sauceLayer] += ob.sauceNodeTally;
            sa = 0;
            while(sa < ob.sauceNodeDistributions.length)
            {
               ob.layerNodeDistributions[sauceLayer][sa] += ob.sauceNodeDistributions[sa];
               sa++;
            }
            class_7.method_1("SAUCE DISTRO: " + ob.layerNodeDistributions[sauceLayer].toString());
            ob.sauceNodeTally = 0;
            ob.sauceNodeDistributions = [0,0,0,0,0,0,0,0];
            sauceMX = new Matrix();
            sauceMX.tx = 0 - ob.bitmapOffsetX;
            sauceMX.ty = 0 - ob.bitmapOffsetY;
            ob.progressBMP.draw(ob.fallingBlobs,sauceMX,null,null,null,true);
            ob.fallingBlobs.graphics.clear();
            ob.drawLooseSauce(ob.fallingBackgroundBlobs);
            ob.fallingBackgroundBlobs.graphics.clear();
            ob.redrawMainBitmap();
            p = ob.coords.length - 1;
            while(p >= 0)
            {
               if(ob.coords[p].clip.parent)
               {
                  ob.coords[p].clip.parent.removeChild(ob.coords[p].clip);
               }
               ob.coords[p].clip = null;
               ob.coords.splice(p,1);
               p--;
            }
         }
      }
      
      public function drawIntoBitmap(param1:MovieClip, param2:Matrix) : void
      {
         var _loc3_:FryTopping = this;
         param2.tx += _loc3_.getBitmapDrawOffsetX();
         param2.ty += _loc3_.getBitmapDrawOffsetY();
         _loc3_.progressBMP.draw(param1,param2);
      }
      
      public function redrawMainBitmap() : void
      {
         var _loc1_:FryTopping = this;
         _loc1_.bakedBMP.copyPixels(_loc1_.finalBMP,_loc1_.finalBMP.rect,_loc1_.originPoint,null,null,true);
         _loc1_.bakedBMP.copyPixels(_loc1_.progressBMP,_loc1_.progressBMP.rect,_loc1_.originPoint,null,null,true);
      }
      
      public function createFilters(param1:String, param2:Boolean = false) : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:GlowFilter = null;
         var _loc5_:FryTopping = this;
         var _loc6_:Array = [];
         var _loc7_:Number = 1.2;
         if(param2)
         {
            _loc7_ = 1.05;
         }
         if(_loc5_.toppingIsSauce(param1))
         {
            if(_loc5_.toppingIsSauce(param1))
            {
               _loc7_ = 2;
               _loc3_ = _loc5_.getToppingData().sauceGlowColor;
               _loc4_ = new GlowFilter(_loc3_,1,_loc7_,_loc7_,0.8,1,true);
               _loc6_ = [_loc4_];
            }
         }
         return _loc6_;
      }
      
      public function getSauceThicknessArray(param1:String, param2:*) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:FryTopping = this;
         if(param2 === true)
         {
            _loc3_ = _loc4_.getToppingData().sauceThicknessDone;
         }
         else
         {
            _loc3_ = _loc4_.getToppingData().sauceThicknessFall;
         }
         return _loc3_;
      }
      
      public function drawSauceLine(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:*, param7:MovieClip, param8:MovieClip, param9:Object, param10:Object, param11:uint) : void
      {
         var _loc18_:Number = NaN;
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:FryTopping = this;
         var _loc15_:Number = param2 - param4;
         var _loc16_:Number = param3 - param5;
         var _loc17_:Number = Math.sqrt(_loc15_ * _loc15_ + _loc16_ * _loc16_);
         _loc18_ = Math.atan2(_loc16_,_loc15_);
         var _loc19_:Number = _loc18_ + Math.PI / 2;
         if(this.lastCurveDir == 1)
         {
            _loc19_ += Math.PI;
         }
         var _loc20_:Number = param4 + _loc15_ / 2;
         var _loc21_:Number = param5 + _loc16_ / 2;
         _loc12_ = _loc20_ + Math.cos(_loc19_) * (_loc17_ / 5);
         _loc13_ = _loc21_ + Math.sin(_loc19_) * (_loc17_ / 5);
         var _loc22_:String = "normal";
         var _loc23_:MovieClip = param7;
         if(param6 === true && Boolean(param9.isOutside))
         {
            _loc23_ = param8;
            _loc22_ = "background";
         }
         else if(Boolean(param9.isOutside) && param9.y > param9.targety - param9.offset)
         {
            _loc23_ = param8;
            _loc22_ = "background";
         }
         var _loc24_:Array = _loc14_.getSauceThicknessArray(param1,param6);
         var _loc25_:Number = 1;
         if(_loc17_ < 5)
         {
            _loc25_ = Number(_loc24_[5]);
         }
         else if(_loc17_ < 10)
         {
            _loc25_ = Number(_loc24_[4]);
         }
         else if(_loc17_ < 15)
         {
            _loc25_ = Number(_loc24_[3]);
         }
         else if(_loc17_ < 20)
         {
            _loc25_ = Number(_loc24_[2]);
         }
         else if(_loc17_ < 25)
         {
            _loc25_ = Number(_loc24_[1]);
         }
         else
         {
            _loc25_ = Number(_loc24_[0]);
         }
         _loc23_.graphics.lineStyle(_loc25_,param11,1);
         _loc23_.graphics.moveTo(param2,param3);
         if(Boolean(param6) && Math.abs(_loc15_) > 3)
         {
            _loc23_.graphics.curveTo(_loc12_,_loc13_,param4,param5);
         }
         else
         {
            _loc23_.graphics.lineTo(param4,param5);
         }
         _loc23_.graphics.lineStyle(1,16777215,0.3);
         _loc23_.graphics.moveTo(param2,param3 - _loc25_ / 2);
         if(Boolean(param6) && Math.abs(_loc15_) > 3)
         {
            _loc23_.graphics.curveTo(_loc12_,_loc13_,param4,param5 - _loc25_ / 2);
         }
         else
         {
            _loc23_.graphics.lineTo(param4,param5 - _loc25_ / 2);
         }
      }
      
      public function changeSauceColor(param1:String) : uint
      {
         var _loc2_:FryTopping = this;
         var _loc3_:Array = _loc2_.getToppingData().sauceColors;
         var _loc4_:uint = uint(_loc3_[_loc2_.whichColor]);
         _loc2_.whichColor += _loc2_.whichColorDir;
         if(_loc2_.whichColorDir == -1 && _loc2_.whichColor < 0)
         {
            _loc2_.whichColor = 1;
            _loc2_.whichColorDir = 1;
         }
         else if(_loc2_.whichColorDir == 1 && _loc2_.whichColor >= _loc3_.length)
         {
            _loc2_.whichColor = _loc3_.length - 2;
            _loc2_.whichColorDir = -1;
         }
         return _loc4_;
      }
      
      public function setupHeightMap() : void
      {
         var _loc4_:Matrix = null;
         var _loc1_:FryTopping = this;
         var _loc2_:MovieClip = class_12.method_103(_loc1_.fryOrder.fryType + "_heightmap",false,false);
         var _loc3_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc4_ = new Matrix();
         _loc4_.tx = 0 - _loc3_.x;
         _loc4_.ty = 0 - _loc3_.y;
         _loc1_.heightBitmap = new BitmapData(Math.ceil(_loc3_.width * 1),Math.ceil(_loc3_.height * 1),true,0);
         _loc1_.heightBitmap.draw(_loc2_,_loc4_,null,null,null,true);
         _loc1_.heightmapOffsetX = 0 - _loc3_.x;
         _loc1_.heightmapOffsetY = 0 - _loc3_.y;
         _loc2_ = null;
         _loc3_ = null;
         _loc4_ = null;
      }
      
      public function getHeightMapOffset(param1:Number, param2:Number) : Number
      {
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:FryTopping = this;
         var _loc4_:Number = 0;
         param1 += _loc3_.heightmapOffsetX;
         param2 += _loc3_.heightmapOffsetY;
         _loc5_ = _loc3_.heightBitmap.getPixel32(param1,param2);
         var _loc6_:String = _loc5_.toString(16);
         var _loc7_:uint = uint(_loc5_ >>> 24);
         _loc8_ = uint(_loc5_ >>> 16 & 0xFF);
         var _loc9_:Number = _loc8_ / 255;
         if(_loc7_ < 255)
         {
            _loc9_ = 1;
         }
         return Number(_loc9_ * _loc3_.heightOffsetMax);
      }
      
      public function isInsideFries(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = false) : Boolean
      {
         var _loc7_:uint = 0;
         var _loc5_:FryTopping = this;
         var _loc6_:Boolean = false;
         param1 += _loc5_.heightmapOffsetX;
         param2 += _loc5_.heightmapOffsetY;
         _loc7_ = _loc5_.heightBitmap.getPixel32(param1,param2);
         if(_loc7_ == 0)
         {
            _loc6_ = false;
         }
         else if(_loc7_ == 4294901760 && param3 == false)
         {
            _loc6_ = false;
         }
         else
         {
            _loc6_ = true;
         }
         return _loc6_;
      }
      
      public function isWithinFryArea(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:FryTopping = this;
         if(param1 > _loc3_.fryOrder.fryClip.x + _loc3_.bitmapOffsetX && param1 < _loc3_.fryOrder.fryClip.x + _loc3_.bitmapOffsetX + _loc3_.bitmapWidth && param2 > _loc3_.fryOrder.fryClip.y + _loc3_.bitmapOffsetY && param2 < _loc3_.fryOrder.fryClip.y + _loc3_.bitmapOffsetY + _loc3_.bitmapHeight)
         {
            return true;
         }
         class_7.method_1("NOT WITHIN FRY AREA: X/Y: " + param1 + ", " + param2 + ". Bounds = " + (_loc3_.fryOrder.fryClip.x + _loc3_.bitmapOffsetX) + " -> " + (_loc3_.fryOrder.fryClip.x + _loc3_.bitmapOffsetX + _loc3_.bitmapWidth) + " X.   " + (_loc3_.fryOrder.fryClip.y + _loc3_.bitmapOffsetX) + " -> " + (_loc3_.fryOrder.fryClip.y + _loc3_.bitmapOffsetY + _loc3_.bitmapHeight) + " Y.");
         return false;
      }
      
      public function getNodeOffsetX() : Number
      {
         return 0;
      }
      
      public function getNodeOffsetY() : Number
      {
         return 0;
      }
      
      public function getBitmapDrawOffsetX() : Number
      {
         var _loc1_:FryTopping = this;
         return 0 - _loc1_.bitmapOffsetX;
      }
      
      public function getBitmapDrawOffsetY() : Number
      {
         var _loc1_:FryTopping = this;
         return 0 - _loc1_.bitmapOffsetY;
      }
      
      public function moveForGiveOrder(param1:MovieClip) : void
      {
         var _loc2_:FryTopping = this;
         if(_loc2_.progressMC)
         {
         }
      }
   }
}

