package cheeseGame.screens
{
   import cheeseGame.data.UserData;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class DiningGiveOrderScreen extends GiveOrderScreen
   {
      
      public var sittingModel:MovieClip = null;
      
      public var buddyModel:MovieClip = null;
      
      public function DiningGiveOrderScreen(param1:class_5)
      {
         super(param1);
      }
      
      override public function getCustomerReactionNumber(param1:String) : Number
      {
         return 1;
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:DiningGiveOrderScreen = this;
         _loc1_.clip = new giveOrderDiningMC();
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip.worker_holder,_loc1_.gameObj.var_151,209,64,1,false,true);
         _loc1_.clip.ticketmeter.bar.mask = _loc1_.clip.ticketmeter.masker;
         _loc1_.clip.ticketmeter.bar.scaleX = 0;
         _loc1_.clip.ticketmeter.ball1.gotoAndStop(1);
         _loc1_.clip.ticketmeter.ball2.gotoAndStop(1);
         _loc1_.clip.ticketmeter.ball3.gotoAndStop(1);
      }
      
      override public function activateScreen() : void
      {
         var _loc1_:DiningGiveOrderScreen = this;
         if(!_loc1_.gameObj.var_138.contains(_loc1_.clip))
         {
            _loc1_.gameObj.var_138.addChild(_loc1_.clip);
         }
         var _loc2_:FoodOrder = _loc1_.gameObj.var_131.currentOrder;
         _loc2_.moveToGiveDiningOrder(_loc1_.clip.customer_holder);
         _loc1_.currentCustomer = _loc1_.gameObj.var_134.getWaitingCustomer(_loc2_.attachedTicket.customerType);
         _loc1_.setupCustomerModel(_loc1_.gameObj.var_130.getCustomerClipName(currentCustomer.customerType));
         _loc1_.clip.customer_holder.addChild(_loc1_.sittingModel);
         _loc1_.sittingModel.x = 330;
         _loc1_.sittingModel.y = 110;
         _loc1_.sittingModel.gotoAndPlay("look");
         _loc1_.setupBuddy();
         if(_loc1_.currentCustomer.customerType % 2 == 0)
         {
            _loc1_.clip.coffee.visible = true;
            _loc1_.clip.coffee.gotoAndStop(_loc1_.currentCustomer.customerType % _loc1_.clip.coffee.totalFrames + 1);
         }
         else
         {
            _loc1_.clip.coffee.visible = false;
         }
         _loc1_.shouldAnimateMeter = false;
         _loc1_.shouldShowWorkerReaction = false;
         _loc1_.clip.tipjar.gotoAndStop(1);
         _loc1_.clip.tips.gotoAndStop(1);
         _loc1_.clip.starburst.gotoAndStop(1);
         _loc1_.adjustJarCoins();
         _loc1_.startPresentation();
         _loc1_.gameObj.var_129.switchMusic("none");
         _loc1_.drumrollSound = _loc1_.gameObj.var_129.playMusicClip("giveorder_drumroll.wav");
         _loc1_.isActive = true;
      }
      
      public function setupBuddy() : void
      {
         var _loc1_:String = null;
         var _loc2_:DiningGiveOrderScreen = this;
         var _loc3_:Number = _loc2_.currentCustomer.diningBuddy;
         if(_loc3_ > -1)
         {
            _loc1_ = _loc2_.gameObj.var_130.getCustomerClipName(_loc3_);
            _loc2_.setupCustomerModel(_loc1_,true);
            _loc2_.clip.customer2_holder.addChild(_loc2_.buddyModel);
            _loc2_.buddyModel.visible = true;
            _loc2_.buddyModel.scaleX = -1;
            _loc2_.buddyModel.x = 139;
            _loc2_.buddyModel.y = 140;
            _loc2_.buddyModel.gotoAndPlay("sitbuddy");
            if(_loc3_ % 2 == 0)
            {
               _loc2_.clip.coffeebuddy.visible = true;
               _loc2_.clip.coffeebuddy.gotoAndStop(_loc3_ % _loc2_.clip.coffeebuddy.totalFrames + 1);
            }
            else
            {
               _loc2_.clip.coffeebuddy.visible = false;
            }
         }
         else
         {
            if(_loc2_.buddyModel)
            {
               _loc2_.buddyModel.visible = false;
            }
            _loc2_.clip.coffeebuddy.visible = false;
         }
      }
      
      public function setupCustomerModel(param1:String, param2:Boolean = false) : void
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
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:Class = null;
         var _loc6_:DiningGiveOrderScreen = this;
         if(param2)
         {
            if(_loc6_.buddyModel != null)
            {
               _loc6_.destroyCustomerModel(_loc6_.buddyModel);
               if(_loc6_.clip.customer2_holder.contains(_loc6_.buddyModel))
               {
                  _loc6_.clip.customer2_holder.removeChild(_loc6_.buddyModel);
               }
               _loc6_.buddyModel = null;
            }
            _loc6_.buddyModel = new customerDiningMC();
            _loc3_ = _loc6_.buddyModel;
         }
         else
         {
            if(_loc6_.sittingModel != null)
            {
               _loc6_.destroyCustomerModel(_loc6_.sittingModel);
               if(_loc6_.clip.customer_holder.contains(_loc6_.sittingModel))
               {
                  _loc6_.clip.customer_holder.removeChild(_loc6_.sittingModel);
               }
               _loc6_.sittingModel = null;
            }
            _loc6_.sittingModel = new customerDiningMC();
            _loc3_ = _loc6_.sittingModel;
         }
         _loc8_ = getDefinitionByName("customer_" + param1 + "_body") as Class;
         _loc7_ = new _loc8_();
         _loc7_.name = "clip";
         _loc3_.body.addChild(_loc7_);
         _loc10_ = getDefinitionByName("customer_" + param1 + "_head") as Class;
         _loc9_ = new _loc10_();
         _loc9_.name = "clip";
         _loc3_.head.addChild(_loc9_);
         _loc11_ = _loc6_.gameObj.var_130.getCustomerPart(param1,"eyes",_loc6_.gameObj.var_128.getHolidayMonth());
         _loc11_.name = "clip";
         _loc3_.eyes.addChild(_loc11_);
         _loc12_ = _loc6_.gameObj.var_130.getCustomerPart(param1,"mouth",_loc6_.gameObj.var_128.getHolidayMonth());
         _loc12_.name = "clip";
         _loc3_.mouth.addChild(_loc12_);
         _loc14_ = getDefinitionByName("customer_" + param1 + "_neck") as Class;
         _loc13_ = new _loc14_();
         _loc13_.name = "clip";
         _loc3_.neck.addChild(_loc13_);
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         try
         {
            _loc4_ = getDefinitionByName("customer_" + param1 + "_hair") as Class;
            _loc15_ = new _loc4_();
            _loc15_.name = "clip";
            _loc3_.hair.addChild(_loc15_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc5_ = getDefinitionByName("customer_" + param1 + "_back_hair") as Class;
            _loc16_ = new _loc5_();
            _loc16_.name = "clip";
            _loc3_.back_hair.addChild(_loc16_);
         }
         catch(err:Error)
         {
         }
         _loc17_ = _loc6_.gameObj.var_130.getCustomerPart(param1,"foot",_loc6_.gameObj.var_128.getHolidayMonth());
         _loc17_.name = "clip";
         _loc3_.front_shoe.addChild(_loc17_);
         _loc18_ = _loc6_.gameObj.var_130.getCustomerPart(param1,"foot",_loc6_.gameObj.var_128.getHolidayMonth());
         _loc18_.name = "clip";
         _loc3_.back_shoe.addChild(_loc18_);
         _loc19_ = _loc6_.gameObj.var_130.getCustomerPart(param1,"hand",_loc6_.gameObj.var_128.getHolidayMonth());
         _loc19_.name = "clip";
         _loc3_.fronthand.addChild(_loc19_);
         _loc20_ = _loc6_.gameObj.var_130.getCustomerPart(param1,"hand2",_loc6_.gameObj.var_128.getHolidayMonth());
         _loc20_.name = "clip";
         _loc3_.backhand.addChild(_loc20_);
         _loc22_ = getDefinitionByName("customer_" + param1 + "_upperarm") as Class;
         _loc21_ = new _loc22_();
         _loc21_.name = "clip";
         _loc3_.front_upperarm.addChild(_loc21_);
         _loc23_ = new _loc22_();
         _loc23_.name = "clip";
         _loc3_.back_upperarm.addChild(_loc23_);
         _loc25_ = getDefinitionByName("customer_" + param1 + "_forearm") as Class;
         _loc24_ = new _loc25_();
         _loc24_.name = "clip";
         _loc3_.front_forearm.addChild(_loc24_);
         _loc26_ = new _loc25_();
         _loc26_.name = "clip";
         _loc3_.back_forearm.addChild(_loc26_);
         _loc27_ = _loc6_.gameObj.var_130.getCustomerHolidayOutfitMonth(_loc6_.gameObj.var_130.getCustomerIndex(param1));
         if(_loc27_ > 0 && _loc6_.gameObj.var_128.getMonth() == _loc27_)
         {
            _loc7_.gotoAndStop(2);
            _loc21_.gotoAndStop(2);
            _loc23_.gotoAndStop(2);
            _loc24_.gotoAndStop(2);
            _loc26_.gotoAndStop(2);
            _loc9_.gotoAndStop(2);
            _loc13_.gotoAndStop(2);
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
            _loc9_.gotoAndStop(1);
            _loc13_.gotoAndStop(1);
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
      
      public function destroyCustomerModel(param1:MovieClip) : void
      {
         var whichClip:MovieClip = param1;
         whichClip.stop();
         try
         {
            whichClip.body.removeChildAt(0);
            whichClip.head.removeChildAt(0);
            whichClip.eyes.removeChildAt(0);
            whichClip.mouth.removeChildAt(0);
            whichClip.neck.removeChildAt(0);
            whichClip.front_shoe.removeChildAt(0);
            whichClip.back_shoe.removeChildAt(0);
            whichClip.fronthand.removeChildAt(0);
            whichClip.backhand.removeChildAt(0);
            whichClip.front_upperarm.removeChildAt(0);
            whichClip.back_upperarm.removeChildAt(0);
            whichClip.front_forearm.removeChildAt(0);
            whichClip.back_forearm.removeChildAt(0);
         }
         catch(err:Error)
         {
            class_7.error("Error removing parts of customer");
         }
         try
         {
            whichClip.hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
         try
         {
            whichClip.back_hair.removeChildAt(0);
         }
         catch(err:Error)
         {
         }
      }
      
      override public function initStationUpgrades() : void
      {
         var _loc1_:DiningGiveOrderScreen = this;
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
         _loc1_.backdropBitmap = _loc1_.createLobbyBackdropBitmap();
         _loc1_.clip.backdrop_holder.addChild(_loc1_.backdropBitmap);
         _loc1_.backdropBitmap.x = -24;
         _loc1_.backdropBitmap.y = -40;
         _loc1_.clip.table1.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTop);
         _loc1_.clip.table2.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTop);
         _loc1_.clip.table3.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTop);
         _loc1_.clip.trim1.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTrim);
         _loc1_.clip.trim2.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTrim);
         _loc1_.clip.trim3.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTrim);
         _loc1_.clip.trim4.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTrim);
         _loc1_.worker.updateModelLook();
      }
      
      override public function showCustomerReaction() : void
      {
         var _loc1_:DiningGiveOrderScreen = this;
         _loc1_.sittingModel.gotoAndPlay("look" + _loc1_.customerReaction + "1");
         _loc1_.gameObj.var_142.recordTagged("diningroom");
         if(_loc1_.buddyModel)
         {
            if(_loc1_.customerReaction == "overjoyed" || _loc1_.customerReaction == "happy")
            {
               _loc1_.buddyModel.gotoAndPlay("buddyhappy");
            }
            else if(_loc1_.customerReaction == "decent" || _loc1_.customerReaction == "worried")
            {
               _loc1_.buddyModel.gotoAndPlay("buddyok");
            }
            else
            {
               _loc1_.buddyModel.gotoAndPlay("buddyangry");
            }
         }
      }
      
      override public function showWorkerReaction() : void
      {
         var _loc1_:DiningGiveOrderScreen = this;
         var _loc2_:String = _loc1_.customerReaction;
         if(_loc2_ == "overjoyed" || _loc2_ == "happy")
         {
            _loc1_.worker.playAnimation("score_happy");
         }
         else if(_loc2_ == "decent" || _loc2_ == "worried")
         {
            _loc1_.worker.playAnimation("score_ok");
         }
         else
         {
            _loc1_.worker.playAnimation("score_sad");
         }
      }
      
      override protected function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc6_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:DiningGiveOrderScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Bitmap = null;
         var _loc5_:MovieClip = new nowindowBackdropMC();
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
         _loc5_.holder.wallparts.mask = _loc5_.holder.wallmask;
         _loc5_.holder.floorparts.mask = _loc5_.holder.floormask;
         _loc6_ = new BitmapData(706,552,true,0);
         _loc6_.draw(_loc5_,null,null,null,new Rectangle(0,0,706,552));
         _loc4_ = new Bitmap(_loc6_);
         _loc5_ = null;
         return _loc4_;
      }
      
      override public function destroy() : void
      {
         var _loc1_:DiningGiveOrderScreen = this;
         if(_loc1_.sittingModel != null)
         {
            _loc1_.destroyCustomerModel(_loc1_.sittingModel);
            if(_loc1_.clip.customer_holder.contains(_loc1_.sittingModel))
            {
               _loc1_.clip.customer_holder.removeChild(_loc1_.sittingModel);
            }
            _loc1_.sittingModel = null;
         }
         if(_loc1_.buddyModel != null)
         {
            _loc1_.destroyCustomerModel(_loc1_.buddyModel);
            if(_loc1_.clip.customer2_holder.contains(_loc1_.buddyModel))
            {
               _loc1_.clip.customer2_holder.removeChild(_loc1_.buddyModel);
            }
            _loc1_.buddyModel = null;
         }
         super.destroy();
      }
      
      override public function getClothingBonus() : Number
      {
         var _loc1_:DiningGiveOrderScreen = this;
         var _loc2_:Number = _loc1_.gameObj.var_128.getHolidayClothingItemsWorn(true);
         class_7.method_1("(Server wearing " + _loc2_ + " holiday items.)");
         return _loc2_ * _loc1_.extraTipPerClothingItem;
      }
      
      override public function getWorkerClothingTags() : Array
      {
         var _loc1_:DiningGiveOrderScreen = this;
         return _loc1_.gameObj.var_151.getClothingTags();
      }
      
      override public function getOtherScreen() : GiveOrderScreen
      {
         var _loc1_:GiveOrderScreen = this;
         class_7.method_1("(with Main Give Order)");
         return _loc1_.gameObj.var_183;
      }
   }
}

