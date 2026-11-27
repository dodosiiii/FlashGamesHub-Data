package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.*;
   
   public class ParadeScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var didStart:Boolean = false;
      
      public var lastTime:Number = 0;
      
      public var goldCustomerIDs:Array;
      
      public var silverCustomerIDs:Array;
      
      public var bronzeCustomerIDs:Array;
      
      public var noneCustomerIDs:Array;
      
      public var goldSetsShown:Number = 0;
      
      public var silverSetsShown:Number = 0;
      
      public var bronzeSetsShown:Number = 0;
      
      public var foodiniCustomerID:Number = -1;
      
      public var closerCustomerIDs:Array;
      
      public var floatCustomerIDs_papalouie:Array;
      
      public var floatCustomerIDs_pizzeria:Array;
      
      public var floatCustomerIDs_burgeria:Array;
      
      public var floatCustomerIDs_tacomia:Array;
      
      public var floatCustomerIDs_freezeria:Array;
      
      public var floatCustomerIDs_pancakeria:Array;
      
      public var floatCustomerIDs_wingeria:Array;
      
      public var floatCustomerIDs_romano:Array;
      
      public var floatCustomerIDs_hotdoggeria:Array;
      
      public var floatCustomerIDs_cupcakeria:Array;
      
      public var floatCustomerIDs_pastaria:Array;
      
      public var floatCustomerIDs_donuteria:Array;
      
      public var floatCustomerIDs_cheeseria:Array;
      
      public var whichOrder:Number = -1;
      
      public var paradeOrder:Array;
      
      public var walkSpeed:Number = 2;
      
      public var carSpeed:Number = 3;
      
      public var movingParts:Array;
      
      public var movingPartsType:Array;
      
      public var startX:Number = -20;
      
      public var carStartY:Number = 321;
      
      public var customerStartY:Number = 240;
      
      public var customerScale:Number = 0.21;
      
      public var fromButton:Boolean = false;
      
      public var workers:Vector.<Worker>;
      
      public function ParadeScreen(param1:class_5, param2:Boolean)
      {
         this.goldCustomerIDs = [];
         this.silverCustomerIDs = [];
         this.bronzeCustomerIDs = [];
         this.noneCustomerIDs = [];
         this.closerCustomerIDs = [];
         this.floatCustomerIDs_papalouie = [];
         this.floatCustomerIDs_pizzeria = [];
         this.floatCustomerIDs_burgeria = [];
         this.floatCustomerIDs_tacomia = [];
         this.floatCustomerIDs_freezeria = [];
         this.floatCustomerIDs_pancakeria = [];
         this.floatCustomerIDs_wingeria = [];
         this.floatCustomerIDs_romano = [];
         this.floatCustomerIDs_hotdoggeria = [];
         this.floatCustomerIDs_cupcakeria = [];
         this.floatCustomerIDs_pastaria = [];
         this.floatCustomerIDs_donuteria = [];
         this.floatCustomerIDs_cheeseria = [];
         this.paradeOrder = ["foodini","closer","pizzeria","gold","burgeria","silver","tacomia","bronze","freezeria","romano","pancakeria","wingeria","hotdoggeria","cupcakeria","pastaria","donuteria","cheeseria","papalouie"];
         this.movingParts = [];
         this.movingPartsType = [];
         super();
         var _loc3_:ParadeScreen = this;
         _loc3_.gameObj = param1;
         _loc3_.fromButton = param2;
         _loc3_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:ParadeScreen = this;
         _loc1_.clip = new paradeScreenMC();
         _loc1_.gameObj.var_155.addChild(_loc1_.clip);
         var _loc2_:Number = _loc1_.gameObj.var_128.getHolidayMonth();
         class_7.method_1("Month?: " + _loc2_);
         if(_loc2_ == 0)
         {
            _loc2_ = 13;
         }
         var _loc3_:Number = _loc2_ * 2 - 1;
         _loc1_.clip.bg.gotoAndStop(_loc3_);
         _loc1_.clip.bg.cacheAsBitmap = true;
         _loc1_.clip.bg.mouseEnabled = false;
         _loc1_.clip.bg.mouseChildren = false;
         _loc1_.clip.fg.gotoAndStop(_loc3_);
         _loc1_.clip.fg.cacheAsBitmap = true;
         _loc1_.clip.fg.mouseEnabled = false;
         _loc1_.clip.fg.mouseChildren = false;
         _loc1_.workers = new Vector.<Worker>();
         _loc1_.setupCustomerGroups();
         _loc1_.releaseNextGroup();
         _loc1_.didStart = true;
         _loc1_.clip.backtogame_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBackToGame);
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         if(_loc1_.paradeOrder.indexOf("papalouie") > -1)
         {
            _loc1_.clip.message.visible = false;
         }
         else
         {
            _loc1_.clip.message.visible = true;
         }
         _loc1_.gameObj.var_129.switchMusic("title");
         if(_loc1_.fromButton == false)
         {
            _loc1_.gameObj.var_128.didShowParade = true;
         }
      }
      
      public function clickBackToGame(param1:MouseEvent) : void
      {
         var _loc2_:ParadeScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.fader.gotoAndPlay("fadeout");
         _loc2_.clip.backtogame_btn.visible = false;
      }
      
      public function updateScreen(param1:Event = null) : void
      {
         var _loc2_:* = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:ParadeScreen = this;
         if(_loc4_.didStart)
         {
            _loc2_ = int(_loc4_.movingParts.length - 1);
            while(_loc2_ >= 0)
            {
               _loc3_ = _loc4_.movingParts[_loc2_];
               if(_loc4_.movingPartsType[_loc2_] == "car" || _loc4_.movingPartsType[_loc2_] == "carmain")
               {
                  _loc3_.x += _loc4_.carSpeed;
               }
               else
               {
                  _loc3_.x += _loc4_.walkSpeed;
               }
               if((_loc4_.movingPartsType[_loc2_] == "car" || _loc4_.movingPartsType[_loc2_] == "carmain") && _loc3_.x - _loc3_.width > 660)
               {
                  try
                  {
                     _loc4_.clearCustomer(_loc3_.customer0);
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     _loc4_.clearCustomer(_loc3_.customer1);
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     _loc4_.clearCustomer(_loc3_.customer2);
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     _loc4_.clearCustomer(_loc3_.customer3);
                  }
                  catch(err:Error)
                  {
                  }
                  _loc4_.clip.holder.removeChild(_loc3_);
                  _loc4_.movingParts.splice(_loc2_,1);
                  _loc4_.movingPartsType.splice(_loc2_,1);
                  if(_loc4_.whichOrder == _loc4_.paradeOrder.length)
                  {
                     _loc4_.clip.fader.gotoAndPlay("fadeout");
                  }
               }
               else if((_loc4_.movingPartsType[_loc2_] == "customer" || _loc4_.movingPartsType[_loc2_] == "customermain") && _loc3_.x - _loc3_.width / 2 > 660)
               {
                  _loc4_.clearCustomer(_loc3_);
                  _loc4_.clip.holder.removeChild(_loc3_);
                  _loc4_.movingParts.splice(_loc2_,1);
                  _loc4_.movingPartsType.splice(_loc2_,1);
               }
               else if(_loc4_.movingPartsType[_loc2_] == "customermain" && _loc3_.x > 500)
               {
                  _loc4_.releaseNextGroup();
                  _loc4_.movingPartsType[_loc2_] = "customer";
               }
               else if(_loc4_.movingPartsType[_loc2_] == "customermain" && _loc4_.whichOrder == 0 && _loc3_.x > 320)
               {
                  _loc4_.releaseNextGroup();
                  _loc4_.movingPartsType[_loc2_] = "customer";
               }
               else if(_loc4_.movingPartsType[_loc2_] == "carmain" && _loc3_.x - _loc3_.width / 2 > 500)
               {
                  _loc4_.releaseNextGroup();
                  _loc4_.movingPartsType[_loc2_] = "car";
               }
               _loc2_--;
            }
            if(_loc4_.clip.fader.currentFrame == _loc4_.clip.fader.totalFrames)
            {
               _loc4_.didStart = false;
               if(_loc4_.fromButton)
               {
                  _loc4_.gameObj.method_122();
               }
               else
               {
                  _loc4_.gameObj.method_129();
               }
               _loc4_.gameObj.method_278();
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:ParadeScreen = this;
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.clip.backtogame_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickBackToGame);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.workers.length)
         {
            _loc1_.workers[_loc2_].destroy();
            _loc1_.workers[_loc2_] = null;
            _loc2_++;
         }
         _loc1_.workers = null;
         _loc1_.gameObj.var_155.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function releaseNextGroup() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Boolean = false;
         var _loc7_:Worker = null;
         var _loc8_:Worker = null;
         var _loc9_:Class = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Array = null;
         var _loc12_:Boolean = false;
         var _loc13_:Number = Number(NaN);
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:MovieClip = null;
         var _loc17_:Number = Number(NaN);
         var _loc18_:Number = Number(NaN);
         var _loc19_:Array = null;
         var _loc20_:MovieClip = null;
         var _loc21_:Number = Number(NaN);
         var _loc22_:Number = Number(NaN);
         var _loc23_:ParadeScreen = this;
         if(!(_loc23_.paradeOrder[_loc23_.whichOrder] == "gold" && _loc23_.goldSetsShown < _loc23_.goldCustomerIDs.length))
         {
            if(!(_loc23_.paradeOrder[_loc23_.whichOrder] == "silver" && _loc23_.silverSetsShown < _loc23_.silverCustomerIDs.length))
            {
               if(!(_loc23_.paradeOrder[_loc23_.whichOrder] == "bronze" && _loc23_.bronzeSetsShown < _loc23_.bronzeCustomerIDs.length))
               {
                  ++_loc23_.whichOrder;
               }
            }
         }
         if(_loc23_.whichOrder < _loc23_.paradeOrder.length)
         {
            _loc2_ = _loc23_.paradeOrder[_loc23_.whichOrder];
            if(_loc2_ == "foodini")
            {
               _loc3_ = new customerParadeMC();
               _loc23_.buildCustomer(_loc23_.foodiniCustomerID,_loc3_);
               _loc3_.scaleX = _loc23_.customerScale * -1;
               _loc3_.scaleY = _loc23_.customerScale;
               _loc3_.x = _loc23_.startX;
               _loc3_.y = _loc23_.customerStartY;
               _loc3_.gotoAndPlay("walkbaton");
               _loc23_.clip.holder.addChild(_loc3_);
               _loc23_.movingParts.push(_loc3_);
               _loc23_.movingPartsType.push("customermain");
            }
            else if(_loc2_ == "cheeseria")
            {
               _loc4_ = getDefinitionByName("parade_car_" + _loc2_) as Class;
               _loc5_ = new _loc4_() as MovieClip;
               _loc6_ = false;
               _loc7_ = new Worker(_loc23_.gameObj,_loc5_.customer0,_loc23_.gameObj.workerData,0,0,1);
               _loc7_.playAnimation("stand");
               _loc23_.workers.push(_loc7_);
               if(_loc23_.gameObj.var_128.didCreateWaiter)
               {
                  _loc8_ = new Worker(_loc23_.gameObj,_loc5_.customer1,_loc23_.gameObj.var_151,0,0,1);
                  _loc8_.playAnimation("stand");
                  _loc23_.workers.push(_loc8_);
               }
               _loc5_.x = _loc23_.startX;
               _loc5_.y = _loc23_.carStartY;
               _loc23_.clip.holder.addChild(_loc5_);
               _loc23_.movingParts.push(_loc5_);
               _loc23_.movingPartsType.push("carmain");
            }
            else if(_loc2_ == "papalouie" || _loc2_ == "pizzeria" || _loc2_ == "burgeria" || _loc2_ == "tacomia" || _loc2_ == "freezeria" || _loc2_ == "pancakeria" || _loc2_ == "romano" || _loc2_ == "wingeria" || _loc2_ == "hotdoggeria" || _loc2_ == "cupcakeria" || _loc2_ == "pastaria" || _loc2_ == "donuteria")
            {
               _loc9_ = getDefinitionByName("parade_car_" + _loc2_) as Class;
               _loc10_ = new _loc9_() as MovieClip;
               _loc11_ = _loc23_["floatCustomerIDs_" + _loc2_];
               _loc12_ = false;
               _loc1_ = 0;
               while(_loc1_ < _loc11_.length)
               {
                  _loc23_.buildCustomer(_loc11_[_loc1_],_loc10_["customer" + _loc1_]);
                  if(_loc2_ == "papalouie")
                  {
                     _loc10_["customer" + _loc1_].gotoAndPlay("standwave0");
                  }
                  else if(_loc2_ == "pizzeria")
                  {
                     _loc10_["customer" + _loc1_].gotoAndPlay("stand");
                  }
                  else if(Math.random() > 0.6 && (_loc1_ == 0 || _loc1_ >= 1 && _loc12_))
                  {
                     _loc10_["customer" + _loc1_].gotoAndPlay("stand");
                  }
                  else
                  {
                     _loc13_ = Math.round(Math.random() * 3);
                     _loc10_["customer" + _loc1_].gotoAndPlay("standwave" + _loc13_);
                     _loc12_ = true;
                  }
                  _loc1_++;
               }
               _loc10_.x = _loc23_.startX;
               _loc10_.y = _loc23_.carStartY;
               _loc23_.clip.holder.addChild(_loc10_);
               _loc23_.movingParts.push(_loc10_);
               _loc23_.movingPartsType.push("carmain");
            }
            else if(_loc2_ == "gold" || _loc2_ == "bronze" || _loc2_ == "silver")
            {
               _loc14_ = _loc23_[_loc2_ + "CustomerIDs"];
               _loc15_ = [];
               if(_loc2_ == "gold")
               {
                  _loc15_ = _loc14_[_loc23_.goldSetsShown];
               }
               else if(_loc2_ == "silver")
               {
                  _loc15_ = _loc14_[_loc23_.silverSetsShown];
               }
               else if(_loc2_ == "bronze")
               {
                  _loc15_ = _loc14_[_loc23_.bronzeSetsShown];
               }
               _loc1_ = 0;
               while(_loc1_ < _loc15_.length)
               {
                  _loc16_ = new customerParadeMC();
                  _loc23_.buildCustomer(_loc15_[_loc1_],_loc16_);
                  _loc16_.scaleX = _loc23_.customerScale * -1;
                  _loc16_.scaleY = _loc23_.customerScale;
                  _loc16_.x = _loc23_.startX;
                  _loc16_.y = _loc23_.customerStartY;
                  _loc17_ = Math.random();
                  _loc18_ = Math.random();
                  if(_loc1_ == 0 && (_loc2_ == "bronze" || _loc2_ == "silver" || _loc2_ == "gold"))
                  {
                     _loc16_.gotoAndPlay("walkbanner");
                     _loc16_.flag.inside.gotoAndStop(_loc2_);
                  }
                  else if(_loc17_ > 0.7)
                  {
                     if(_loc18_ > 0.8)
                     {
                        _loc16_.gotoAndPlay("walkwave2");
                     }
                     else if(_loc18_ > 0.4)
                     {
                        _loc16_.gotoAndPlay("walkwave2_2");
                     }
                     else
                     {
                        _loc16_.gotoAndPlay("walkwave2_3");
                     }
                  }
                  else if(_loc17_ > 0.4)
                  {
                     if(_loc18_ > 0.8)
                     {
                        _loc16_.gotoAndPlay("walkwave");
                     }
                     else if(_loc18_ > 0.5)
                     {
                        _loc16_.gotoAndPlay("walkwave_2");
                     }
                     else
                     {
                        _loc16_.gotoAndPlay("walkwave_3");
                     }
                  }
                  else if(_loc18_ > 0.7)
                  {
                     _loc16_.gotoAndPlay("walk");
                  }
                  else if(_loc18_ > 0.4)
                  {
                     _loc16_.gotoAndPlay("walk_2");
                  }
                  else
                  {
                     _loc16_.gotoAndPlay("walk_3");
                  }
                  if(_loc1_ > 0)
                  {
                     if(_loc1_ % 2 == 0)
                     {
                        _loc16_.y += 20;
                        _loc23_.clip.holder.addChild(_loc16_);
                     }
                     else
                     {
                        _loc16_.y -= 20;
                        _loc23_.clip.holder.addChildAt(_loc16_,0);
                     }
                     _loc16_.y += Math.round(Math.random() * 12) - 6;
                     _loc16_.x -= 20 + (20 * _loc1_ + Math.floor(Math.random() * 10));
                  }
                  else
                  {
                     _loc23_.clip.holder.addChild(_loc16_);
                  }
                  _loc23_.movingParts.push(_loc16_);
                  if(_loc1_ == _loc15_.length - 1)
                  {
                     _loc23_.movingPartsType.push("customermain");
                  }
                  else
                  {
                     _loc23_.movingPartsType.push("customer");
                  }
                  _loc1_++;
               }
               if(_loc2_ == "gold")
               {
                  ++_loc23_.goldSetsShown;
               }
               else if(_loc2_ == "silver")
               {
                  ++_loc23_.silverSetsShown;
               }
               else if(_loc2_ == "bronze")
               {
                  ++_loc23_.bronzeSetsShown;
               }
            }
            else
            {
               _loc19_ = _loc23_[_loc2_ + "CustomerIDs"];
               _loc1_ = 0;
               while(_loc1_ < _loc19_.length)
               {
                  _loc20_ = new customerParadeMC();
                  _loc23_.buildCustomer(_loc19_[_loc1_],_loc20_);
                  _loc20_.scaleX = _loc23_.customerScale * -1;
                  _loc20_.scaleY = _loc23_.customerScale;
                  _loc20_.x = _loc23_.startX;
                  _loc20_.y = _loc23_.customerStartY;
                  _loc21_ = Math.random();
                  _loc22_ = Math.random();
                  if(_loc1_ == 0 && (_loc2_ == "bronze" || _loc2_ == "silver" || _loc2_ == "gold"))
                  {
                     _loc20_.gotoAndPlay("walkbanner");
                     _loc20_.flag.inside.gotoAndStop(_loc2_);
                  }
                  else if(_loc21_ > 0.7)
                  {
                     if(_loc22_ > 0.8)
                     {
                        _loc20_.gotoAndPlay("walkwave2");
                     }
                     else if(_loc22_ > 0.4)
                     {
                        _loc20_.gotoAndPlay("walkwave2_2");
                     }
                     else
                     {
                        _loc20_.gotoAndPlay("walkwave2_3");
                     }
                  }
                  else if(_loc21_ > 0.4)
                  {
                     if(_loc22_ > 0.8)
                     {
                        _loc20_.gotoAndPlay("walkwave");
                     }
                     else if(_loc22_ > 0.5)
                     {
                        _loc20_.gotoAndPlay("walkwave_2");
                     }
                     else
                     {
                        _loc20_.gotoAndPlay("walkwave_3");
                     }
                  }
                  else if(_loc22_ > 0.7)
                  {
                     _loc20_.gotoAndPlay("walk");
                  }
                  else if(_loc22_ > 0.4)
                  {
                     _loc20_.gotoAndPlay("walk_2");
                  }
                  else
                  {
                     _loc20_.gotoAndPlay("walk_3");
                  }
                  if(_loc1_ > 0)
                  {
                     if(_loc1_ % 2 == 0)
                     {
                        _loc20_.y += 20;
                        _loc23_.clip.holder.addChild(_loc20_);
                     }
                     else
                     {
                        _loc20_.y -= 20;
                        _loc23_.clip.holder.addChildAt(_loc20_,0);
                     }
                     _loc20_.y += Math.round(Math.random() * 12) - 6;
                     _loc20_.x -= 20 + (20 * _loc1_ + Math.floor(Math.random() * 10));
                  }
                  else
                  {
                     _loc23_.clip.holder.addChild(_loc20_);
                  }
                  _loc23_.movingParts.push(_loc20_);
                  if(_loc1_ == _loc19_.length - 1)
                  {
                     _loc23_.movingPartsType.push("customermain");
                  }
                  else
                  {
                     _loc23_.movingPartsType.push("customer");
                  }
                  _loc1_++;
               }
            }
         }
      }
      
      public function setupCustomerGroups() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:String = null;
         var _loc3_:ParadeScreen = this;
         _loc3_.foodiniCustomerID = _loc3_.getCustomerIndex("Foodini");
         _loc3_.closerCustomerIDs = _loc3_.getMultipleCustomerIndex(["Jojo","Rhonda","Hank","Quinn","Chester","Radlynn","Xolo"]);
         _loc3_.floatCustomerIDs_papalouie = _loc3_.getMultipleCustomerIndex(["PapaLouie"]);
         _loc3_.floatCustomerIDs_burgeria = _loc3_.getMultipleCustomerIndex(["Marty","Rita"]);
         _loc3_.floatCustomerIDs_pizzeria = _loc3_.getMultipleCustomerIndex(["Roy"]);
         _loc3_.floatCustomerIDs_tacomia = _loc3_.getMultipleCustomerIndex(["Mitch","Maggie"]);
         _loc3_.floatCustomerIDs_freezeria = _loc3_.getMultipleCustomerIndex(["Penny","Alberto"]);
         _loc3_.floatCustomerIDs_pancakeria = _loc3_.getMultipleCustomerIndex(["Cooper","Prudence"]);
         _loc3_.floatCustomerIDs_romano = _loc3_.getMultipleCustomerIndex(["Bruna Romano","Gino Romano","Little Edoardo","Carlo Romano"]);
         _loc3_.floatCustomerIDs_wingeria = _loc3_.getMultipleCustomerIndex(["Chuck","Mandi"]);
         _loc3_.floatCustomerIDs_hotdoggeria = _loc3_.getMultipleCustomerIndex(["Peggy","Taylor"]);
         _loc3_.floatCustomerIDs_cupcakeria = _loc3_.getMultipleCustomerIndex(["James","Willow"]);
         _loc3_.floatCustomerIDs_pastaria = _loc3_.getMultipleCustomerIndex(["Doan","Utah"]);
         _loc3_.floatCustomerIDs_donuteria = _loc3_.getMultipleCustomerIndex(["Scooter","Tony"]);
         _loc3_.noneCustomerIDs = _loc3_.getCustomerIndexWithAward(0);
         _loc3_.bronzeCustomerIDs = _loc3_.getCustomerIndexWithAward(1);
         _loc3_.silverCustomerIDs = _loc3_.getCustomerIndexWithAward(2);
         _loc3_.goldCustomerIDs = _loc3_.getCustomerIndexWithAward(3);
         if(_loc3_.goldCustomerIDs.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("gold"),1);
         }
         if(_loc3_.silverCustomerIDs.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("silver"),1);
         }
         if(_loc3_.bronzeCustomerIDs.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("bronze"),1);
         }
         _loc1_ = _loc3_.closerCustomerIDs.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.closerCustomerIDs[_loc1_]) == false)
            {
               _loc3_.closerCustomerIDs.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.closerCustomerIDs.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("closer"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_burgeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_burgeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_burgeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_burgeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("burgeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_pizzeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_pizzeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_pizzeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_pizzeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("pizzeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_tacomia.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_tacomia[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_tacomia.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_tacomia.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("tacomia"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_freezeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_freezeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_freezeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_freezeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("freezeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_pancakeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_pancakeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_pancakeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_pancakeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("pancakeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_romano.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_romano[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_romano.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_romano.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("romano"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_papalouie.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_papalouie[_loc1_],true) == false)
            {
               _loc3_.floatCustomerIDs_papalouie.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_papalouie.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("papalouie"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_wingeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_wingeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_wingeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_wingeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("wingeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_hotdoggeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_hotdoggeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_hotdoggeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_hotdoggeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("hotdoggeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_cupcakeria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_cupcakeria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_cupcakeria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_cupcakeria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("cupcakeria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_pastaria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_pastaria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_pastaria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_pastaria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("pastaria"),1);
         }
         _loc1_ = _loc3_.floatCustomerIDs_donuteria.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_.hasServedCustomer(_loc3_.floatCustomerIDs_donuteria[_loc1_]) == false)
            {
               _loc3_.floatCustomerIDs_donuteria.splice(_loc1_,1);
            }
            _loc1_--;
         }
         if(_loc3_.floatCustomerIDs_donuteria.length == 0)
         {
            _loc3_.paradeOrder.splice(_loc3_.paradeOrder.indexOf("donuteria"),1);
         }
         var _loc4_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.paradeOrder.length)
         {
            _loc2_ = _loc3_.paradeOrder[_loc1_];
            if(_loc2_ == "pizzeria" || _loc2_ == "burgeria" || _loc2_ == "tacomia" || _loc2_ == "freezeria" || _loc2_ == "wingeria" || _loc2_ == "hotdoggeria" || _loc2_ == "pancakeria" || _loc2_ == "cupcakeria" || _loc2_ == "romano" || _loc2_ == "pastaria" || _loc2_ == "donuteria")
            {
               _loc4_++;
            }
            _loc1_++;
         }
         _loc3_.gameObj.var_128.seenFloatsInParade = _loc4_;
      }
      
      public function getCustomerIndexWithAward(param1:Number) : Array
      {
         var _loc5_:Array = null;
         var _loc2_:ParadeScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:CustomerData = _loc2_.gameObj.var_130;
         _loc5_ = [];
         _loc5_.push([]);
         var _loc6_:int = 1;
         while(_loc6_ < _loc4_.getCustomerTotal())
         {
            if(_loc3_.getCustomerSeal(_loc6_) == param1 && !_loc2_.alreadyInGroup(_loc6_))
            {
               if(_loc5_[_loc5_.length - 1].length < 7)
               {
                  _loc5_[_loc5_.length - 1].push(_loc6_);
               }
               else
               {
                  _loc5_.push([_loc6_]);
               }
            }
            _loc6_++;
         }
         if(_loc5_.length == 1 && _loc5_[0].length == 0)
         {
            _loc5_ = [];
         }
         class_7.method_1("Award Level " + param1 + ": " + _loc5_.length + " sets.");
         return _loc5_;
      }
      
      public function hasServedCustomer(param1:Number, param2:Boolean = false) : Boolean
      {
         var _loc3_:ParadeScreen = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:Boolean = true;
         if(param2 && _loc4_.customersUnlocked[param1] == 1)
         {
            _loc5_ = true;
         }
         else if(_loc4_.getCustomerTotalOrders(param1) == 0)
         {
            _loc5_ = false;
         }
         else
         {
            _loc5_ = true;
         }
         return _loc5_;
      }
      
      public function alreadyInGroup(param1:Number) : Boolean
      {
         var _loc2_:ParadeScreen = this;
         var _loc3_:Boolean = false;
         if(_loc2_.foodiniCustomerID == param1)
         {
            _loc3_ = true;
         }
         if(_loc2_.closerCustomerIDs.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_burgeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_freezeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_pancakeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_papalouie.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_pizzeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_tacomia.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_romano.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_wingeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_hotdoggeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_cupcakeria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_pastaria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         if(_loc2_.floatCustomerIDs_donuteria.indexOf(param1) > -1)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function getCustomerIndex(param1:String) : Number
      {
         var _loc2_:ParadeScreen = this;
         return _loc2_.gameObj.var_130.getCustomerIndex(param1);
      }
      
      public function getMultipleCustomerIndex(param1:Array) : Array
      {
         var _loc2_:ParadeScreen = this;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.push(_loc2_.getCustomerIndex(param1[_loc4_]));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getCustomerClipName(param1:Number) : String
      {
         var _loc2_:ParadeScreen = this;
         return _loc2_.gameObj.var_130.getCustomerClipName(param1);
      }
      
      public function buildCustomer(param1:Number, param2:MovieClip) : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:Class = null;
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         var _loc14_:Class = null;
         var _loc17_:MovieClip = null;
         var _loc18_:MovieClip = null;
         var _loc19_:MovieClip = null;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:Class = null;
         var _loc23_:MovieClip = null;
         var _loc24_:MovieClip = null;
         var _loc25_:Class = null;
         var _loc26_:MovieClip = null;
         var _loc27_:Number = NaN;
         var _loc3_:Class = null;
         var _loc4_:Class = null;
         var _loc5_:ParadeScreen = this;
         var _loc6_:String = _loc5_.getCustomerClipName(param1);
         _loc8_ = getDefinitionByName("customer_" + _loc6_ + "_body") as Class;
         _loc7_ = new _loc8_();
         _loc7_.name = "clip";
         param2.body.addChild(_loc7_);
         _loc10_ = getDefinitionByName("customer_" + _loc6_ + "_head") as Class;
         _loc9_ = new _loc10_();
         _loc9_.name = "clip";
         param2.head.addChild(_loc9_);
         _loc11_ = _loc5_.gameObj.var_130.getCustomerPart(_loc6_,"eyes",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc11_.name = "clip";
         param2.eyes.addChild(_loc11_);
         _loc12_ = _loc5_.gameObj.var_130.getCustomerPart(_loc6_,"mouth",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc12_.name = "clip";
         param2.mouth.addChild(_loc12_);
         _loc14_ = getDefinitionByName("customer_" + _loc6_ + "_neck") as Class;
         _loc13_ = new _loc14_();
         _loc13_.name = "clip";
         param2.neck.addChild(_loc13_);
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         try
         {
            _loc3_ = getDefinitionByName("customer_" + _loc6_ + "_hair") as Class;
            _loc15_ = new _loc3_();
            _loc15_.name = "clip";
            param2.hair.addChild(_loc15_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc4_ = getDefinitionByName("customer_" + _loc6_ + "_back_hair") as Class;
            _loc16_ = new _loc4_();
            _loc16_.name = "clip";
            param2.back_hair.addChild(_loc16_);
         }
         catch(err:Error)
         {
         }
         _loc17_ = _loc5_.gameObj.var_130.getCustomerPart(_loc6_,"foot",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc17_.name = "clip";
         param2.front_shoe.addChild(_loc17_);
         _loc18_ = _loc5_.gameObj.var_130.getCustomerPart(_loc6_,"foot",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc18_.name = "clip";
         param2.back_shoe.addChild(_loc18_);
         _loc19_ = _loc5_.gameObj.var_130.getCustomerPart(_loc6_,"hand",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc19_.name = "clip";
         param2.fronthand.addChild(_loc19_);
         _loc20_ = _loc5_.gameObj.var_130.getCustomerPart(_loc6_,"hand2",_loc5_.gameObj.var_128.getHolidayMonth());
         _loc20_.name = "clip";
         param2.backhand.addChild(_loc20_);
         _loc22_ = getDefinitionByName("customer_" + _loc6_ + "_upperarm") as Class;
         _loc21_ = new _loc22_();
         _loc21_.name = "clip";
         param2.front_upperarm.addChild(_loc21_);
         _loc23_ = new _loc22_();
         _loc23_.name = "clip";
         param2.back_upperarm.addChild(_loc23_);
         _loc25_ = getDefinitionByName("customer_" + _loc6_ + "_forearm") as Class;
         _loc24_ = new _loc25_();
         _loc24_.name = "clip";
         param2.front_forearm.addChild(_loc24_);
         _loc26_ = new _loc25_();
         _loc26_.name = "clip";
         param2.back_forearm.addChild(_loc26_);
         _loc27_ = _loc5_.gameObj.var_130.getCustomerHolidayOutfitMonth(param1);
         if(_loc27_ > 0 && _loc5_.gameObj.var_128.getMonth() == _loc27_)
         {
            _loc7_.gotoAndStop(2);
            _loc21_.gotoAndStop(2);
            _loc23_.gotoAndStop(2);
            _loc24_.gotoAndStop(2);
            _loc26_.gotoAndStop(2);
            _loc13_.gotoAndStop(2);
            _loc9_.gotoAndStop(2);
            if(_loc15_)
            {
               _loc15_.gotoAndStop(2);
            }
            if(_loc16_)
            {
               _loc16_.gotoAndStop(2);
            }
         }
         else
         {
            _loc7_.gotoAndStop(1);
            _loc21_.gotoAndStop(1);
            _loc23_.gotoAndStop(1);
            _loc24_.gotoAndStop(1);
            _loc26_.gotoAndStop(1);
            _loc13_.gotoAndStop(1);
            _loc9_.gotoAndStop(1);
            if(_loc15_)
            {
               _loc15_.gotoAndStop(1);
            }
            if(_loc16_)
            {
               _loc16_.gotoAndStop(1);
            }
         }
      }
      
      public function clearCustomer(param1:MovieClip) : void
      {
         try
         {
            param1.stop();
            param1.head.removeChildAt(0);
            param1.eyes.removeChildAt(0);
            param1.mouth.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.body.removeChildAt(0);
            param1.neck.removeChildAt(0);
            param1.front_shoe.removeChildAt(0);
            param1.back_shoe.removeChildAt(0);
            param1.fronthand.removeChildAt(0);
            param1.backhand.removeChildAt(0);
            param1.front_upperarm.removeChildAt(0);
            param1.back_upperarm.removeChildAt(0);
            param1.front_forearm.removeChildAt(0);
            param1.back_forearm.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            param1.back_hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
      }
   }
}

