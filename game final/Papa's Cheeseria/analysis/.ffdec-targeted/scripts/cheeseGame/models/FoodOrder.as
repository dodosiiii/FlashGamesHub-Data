package cheeseGame.models
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.Matrix;
   import package_2.*;
   import package_4.class_5;
   
   public class FoodOrder
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var sandwich:Sandwich = null;
      
      public var fries:FryOrder = null;
      
      public var container:MovieClip;
      
      public var tweenSpeed:Number = 3;
      
      public var tweenLeaveSpeed:Number = 90;
      
      public var giveScale:Number = 0.54;
      
      public var giveTargetX:Number = 164;
      
      public var giveTargetY:Number = 332;
      
      public var giveDiningScale:Number = 0.54;
      
      public var giveDiningTargetX:Number = 236;
      
      public var giveDiningTargetY:Number = 296;
      
      public var fryScale:Number = 1;
      
      public var fryStartX:Number = -200;
      
      public var fryStartY:Number = 380;
      
      public var fryTargetX:Number = 336;
      
      public var fryLeaveTargetX:Number = 840;
      
      public var isOnFry:Boolean = false;
      
      public var isLeavingFry:Boolean = false;
      
      public var isTrashingFry:Boolean = false;
      
      public var isGivingOrder:Boolean = false;
      
      public var ticketHolderClip:MovieClip = null;
      
      public var ticketHolderStartX:Number = 335;
      
      public var ticketHolderTargetX:Number = 195;
      
      public var ticketHolderTargetY:Number = -69;
      
      public var ticketHolderSpeed:Number = 2;
      
      public var ticketHolderFinishX:Number = 195;
      
      public var ticketHolderFinishY:Number = -69;
      
      public var attachedTicket:Ticket;
      
      public var id:Number = 0;
      
      public var isDoneTopping:Boolean = false;
      
      public function FoodOrder(param1:class_5, param2:Sandwich)
      {
         super();
         this.gameObj = param1;
         this.sandwich = param2;
         this.setupFoodOrder();
      }
      
      public function setupFoodOrder() : void
      {
         var _loc1_:FoodOrder = this;
         _loc1_.clip = new platterMC();
         _loc1_.clip.mouseEnabled = false;
         _loc1_.clip.mouseChildren = false;
         _loc1_.sandwich.addToPlatter(_loc1_.clip);
         _loc1_.moveToFryScreen();
      }
      
      public function moveToFryScreen() : void
      {
         var _loc1_:FoodOrder = this;
         _loc1_.container = _loc1_.gameObj.var_131.clip.holder;
         _loc1_.isOnFry = true;
         _loc1_.clip.x = _loc1_.fryStartX;
         _loc1_.clip.y = _loc1_.fryStartY;
         _loc1_.clip.scaleX = _loc1_.fryScale;
         _loc1_.clip.scaleY = _loc1_.fryScale;
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.setupTweening();
         _loc1_.gameObj.var_129.playSound("trayslide.wav");
      }
      
      public function moveFromFryScreen() : void
      {
         var _loc1_:FoodOrder = this;
         _loc1_.isOnFry = false;
         _loc1_.isLeavingFry = true;
         _loc1_.isTrashingFry = false;
         _loc1_.setupTweening();
         _loc1_.gameObj.var_129.playSound("trayslide.wav");
      }
      
      public function moveToFryTrash() : void
      {
         var _loc1_:FoodOrder = this;
         _loc1_.isOnFry = false;
         _loc1_.isLeavingFry = true;
         _loc1_.isTrashingFry = true;
         _loc1_.setupTweening();
         _loc1_.gameObj.var_129.playSound("trayslide.wav");
      }
      
      public function moveToGiveOrder(param1:MovieClip) : void
      {
         var _loc2_:FoodOrder = this;
         class_7.info("Move Food to Give Order");
         _loc2_.container = param1;
         _loc2_.container.addChild(_loc2_.clip);
         _loc2_.clip.x = _loc2_.giveTargetX;
         _loc2_.clip.y = _loc2_.giveTargetY;
         _loc2_.clip.scaleX = _loc2_.giveScale;
         _loc2_.clip.scaleY = _loc2_.giveScale;
         _loc2_.ticketHolderClip.visible = false;
         if(_loc2_.fries)
         {
            _loc2_.fries.prepareForGiveOrder();
         }
         _loc2_.isGivingOrder = true;
         _loc2_.isLeavingFry = false;
      }
      
      public function moveToGiveDiningOrder(param1:MovieClip) : void
      {
         var _loc2_:FoodOrder = this;
         class_7.info("Move Food to Give Dining Order");
         _loc2_.container = param1;
         _loc2_.container.addChild(_loc2_.clip);
         _loc2_.clip.x = _loc2_.giveDiningTargetX;
         _loc2_.clip.y = _loc2_.giveDiningTargetY;
         _loc2_.clip.scaleX = _loc2_.giveDiningScale;
         _loc2_.clip.scaleY = _loc2_.giveDiningScale;
         _loc2_.isGivingOrder = true;
         _loc2_.isLeavingFry = false;
         _loc2_.ticketHolderClip.visible = false;
         if(_loc2_.fries)
         {
            _loc2_.fries.prepareForGiveOrder();
         }
      }
      
      public function setupTweening() : void
      {
         var _loc1_:FoodOrder = this;
         if(_loc1_.clip.hasEventListener(Event.ENTER_FRAME) == false)
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.tweenOrder);
         }
      }
      
      public function tweenOrder(param1:Event) : void
      {
         var _loc2_:Customer = null;
         var _loc3_:FoodOrder = this;
         if(_loc3_.clip != null)
         {
            if(_loc3_.isLeavingFry)
            {
               if(_loc3_.clip.x < _loc3_.fryLeaveTargetX)
               {
                  _loc3_.clip.x += _loc3_.tweenLeaveSpeed;
                  if(_loc3_.clip.x >= _loc3_.fryLeaveTargetX)
                  {
                     _loc3_.clip.x = _loc3_.fryLeaveTargetX;
                     _loc3_.clip.removeEventListener(Event.ENTER_FRAME,_loc3_.tweenOrder);
                     _loc3_.container.removeChild(_loc3_.clip);
                     _loc3_.isLeavingFry = false;
                     if(_loc3_.isTrashingFry)
                     {
                        class_7.info("(Trash)");
                        _loc3_.gameObj.var_131.removeFromLeavingOrders(_loc3_,true);
                        return;
                     }
                     _loc2_ = _loc3_.gameObj.var_134.getWaitingCustomer(_loc3_.attachedTicket.customerType);
                     if(_loc2_ != null && _loc2_.isWaiter)
                     {
                        _loc3_.gameObj.hud.startTransition("diningGiveOrder");
                     }
                     else
                     {
                        _loc3_.gameObj.hud.startTransition("giveOrder");
                     }
                     return;
                  }
               }
            }
            else if(_loc3_.isOnFry)
            {
               if(_loc3_.clip.x < _loc3_.fryTargetX)
               {
                  _loc3_.clip.x += (_loc3_.fryTargetX - _loc3_.clip.x) / _loc3_.tweenSpeed;
                  if(Math.abs(_loc3_.fryTargetX - _loc3_.clip.x) <= 1)
                  {
                     _loc3_.clip.x = _loc3_.fryTargetX;
                     _loc3_.clip.removeEventListener(Event.ENTER_FRAME,_loc3_.tweenOrder);
                  }
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:FoodOrder = this;
         class_7.method_1("DESTROY ORDER!");
         if(_loc1_.sandwich)
         {
            _loc1_.sandwich.destroy();
            _loc1_.sandwich = null;
         }
         if(_loc1_.fries)
         {
            _loc1_.fries.destroy();
            _loc1_.fries = null;
         }
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.tweenOrder);
         if(_loc1_.attachedTicket)
         {
            _loc1_.gameObj.var_147.removeTicket(_loc1_.attachedTicket);
            _loc1_.attachedTicket = null;
         }
         if(_loc1_.ticketHolderClip)
         {
            if(_loc1_.clip.contains(_loc1_.ticketHolderClip))
            {
               _loc1_.clip.removeChild(_loc1_.ticketHolderClip);
            }
            _loc1_.ticketHolderClip = null;
         }
         if(Boolean(_loc1_.container) && _loc1_.container.contains(_loc1_.clip))
         {
            _loc1_.container.removeChild(_loc1_.clip);
         }
         _loc1_.container = null;
         _loc1_.clip = null;
      }
      
      public function updateOrder() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:FoodOrder = this;
         if(_loc2_.ticketHolderClip != null)
         {
            if(_loc2_.ticketHolderClip.x != _loc2_.ticketHolderTargetX)
            {
               _loc1_ = _loc2_.ticketHolderTargetX - _loc2_.ticketHolderClip.x;
               _loc2_.ticketHolderClip.x += _loc1_ / _loc2_.ticketHolderSpeed;
               if(Math.abs(_loc1_) <= 1)
               {
                  _loc2_.ticketHolderClip.x = _loc2_.ticketHolderTargetX;
               }
            }
         }
         if(_loc2_.fries)
         {
            _loc2_.fries.updateFries();
         }
      }
      
      public function addFries(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:FoodOrder = null;
         _loc4_ = this;
         if(_loc4_.fries == null)
         {
            _loc4_.fries = new FryOrder(_loc4_.gameObj,_loc4_,param1,param2,param3);
            _loc4_.addTicketHolder();
            _loc4_.gameObj.method_104(21);
            if(!_loc4_.gameObj.var_128.hasTrained("saucefries") && _loc4_.gameObj.var_128.currentDay == 1 && !_loc4_.gameObj.training && _loc4_.gameObj.var_134.orderline.length == 0 && _loc4_.gameObj.var_134.waitline.length == 1)
            {
               _loc4_.gameObj.hud.showContextTraining("saucefries");
            }
         }
      }
      
      public function addTicketHolder() : void
      {
         var _loc1_:FoodOrder = this;
         if(_loc1_.ticketHolderClip == null)
         {
            class_7.method_1("Attach ticket holder!");
            _loc1_.ticketHolderClip = new ticketHolderMC();
            _loc1_.clip.addChild(_loc1_.ticketHolderClip);
            _loc1_.ticketHolderClip.x = _loc1_.ticketHolderStartX;
            _loc1_.ticketHolderClip.y = _loc1_.ticketHolderTargetY;
         }
      }
      
      public function attachTicket(param1:Ticket) : void
      {
         var _loc2_:FoodOrder = this;
         _loc2_.gameObj.hud.disableStationButtons();
         _loc2_.attachedTicket = param1;
      }
      
      public function getToppingNames(param1:Array) : Array
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:int = 0;
         var _loc4_:FoodOrder = this;
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < param1[_loc2_].length)
            {
               if(param1[_loc2_][_loc3_] != "")
               {
                  _loc6_.push(param1[_loc2_][_loc3_]);
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc4_.sandwich != null)
         {
            if(_loc6_.indexOf(_loc4_.sandwich.breadType) > -1 && _loc5_.indexOf(_loc4_.sandwich.breadType) == -1)
            {
               _loc5_.push(_loc4_.sandwich.breadType);
            }
            if(_loc6_.indexOf(_loc4_.sandwich.cheeseType1) > -1 && _loc5_.indexOf(_loc4_.sandwich.cheeseType1) == -1)
            {
               _loc5_.push(_loc4_.sandwich.cheeseType1);
            }
            if(_loc6_.indexOf(_loc4_.sandwich.cheeseType2) > -1 && _loc5_.indexOf(_loc4_.sandwich.cheeseType2) == -1)
            {
               _loc5_.push(_loc4_.sandwich.cheeseType2);
            }
            _loc2_ = 0;
            while(_loc2_ < _loc4_.sandwich.toppings.length)
            {
               if(_loc6_.indexOf(_loc4_.sandwich.toppings[_loc2_].type) > -1 && _loc5_.indexOf(_loc4_.sandwich.toppings[_loc2_].type) == -1)
               {
                  _loc5_.push(_loc4_.sandwich.toppings[_loc2_].type);
               }
               _loc2_++;
            }
         }
         if(_loc4_.fries != null)
         {
            if(_loc6_.indexOf(_loc4_.fries.fryType) > -1 && _loc5_.indexOf(_loc4_.fries.fryType) == -1)
            {
               _loc5_.push(_loc4_.fries.fryType);
            }
            if(_loc4_.fries.fryTopping != null)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_.fries.fryTopping.layerTypes.length)
               {
                  if(_loc6_.indexOf(_loc4_.fries.fryTopping.layerTypes[_loc2_]) > -1 && _loc5_.indexOf(_loc4_.fries.fryTopping.layerTypes[_loc2_]) == -1)
                  {
                     _loc5_.push(_loc4_.fries.fryTopping.layerTypes[_loc2_]);
                  }
                  _loc2_++;
               }
            }
         }
         class_7.method_1("Get valid toppings for plate: " + _loc5_.toString());
         return _loc5_;
      }
      
      public function stopPouring() : void
      {
         var _loc1_:FoodOrder = this;
         class_7.method_1("HEY STOP POURING");
         if(_loc1_.fries != null && _loc1_.fries.fryTopping != null && _loc1_.fries.fryTopping.isPouring)
         {
            _loc1_.fries.fryTopping.stopPouring();
         }
      }
      
      public function isPouring() : Boolean
      {
         var _loc1_:FoodOrder = this;
         var _loc2_:Boolean = false;
         if(_loc1_.fries != null && _loc1_.fries.fryTopping != null && _loc1_.fries.fryTopping.isPouring)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function drawToToppingBitmap(param1:MovieClip, param2:Matrix, param3:Number) : void
      {
      }
      
      public function drawSauceToBitmap(param1:MovieClip, param2:Number) : void
      {
      }
   }
}

