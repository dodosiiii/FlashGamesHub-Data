package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.screens.CookbookScreen;
   import flash.display.*;
   import flash.events.*;
   import package_2.*;
   import package_4.class_5;
   
   public class CookbookPage
   {
      
      public var gameObj:class_5;
      
      public var screen:CookbookScreen;
      
      public var container:MovieClip;
      
      public var specialIndex:Number = -1;
      
      public var ingredientTag:String = null;
      
      public var isSpecial:Boolean = false;
      
      public var clip:MovieClip;
      
      public var logoClip:MovieClip = null;
      
      public var logoBitmap:Bitmap = null;
      
      public var logoBMP:BitmapData = null;
      
      public var panelHolder:MovieClip = null;
      
      public var panelParts:Vector.<MovieClip> = null;
      
      public var orderData:CustomerOrder = null;
      
      public function CookbookPage(param1:class_5, param2:CookbookScreen, param3:MovieClip, param4:Number = -1, param5:String = null)
      {
         super();
         this.gameObj = param1;
         this.screen = param2;
         if(param5 != null)
         {
            this.isSpecial = false;
            this.ingredientTag = param5;
            this.setupIngredientPage(param3);
         }
         else
         {
            this.isSpecial = true;
            this.specialIndex = param4;
            this.setupSpecialPage(param3);
         }
      }
      
      public function setContainer(param1:MovieClip) : void
      {
         var _loc2_:CookbookPage = this;
         if(_loc2_.clip != null && param1 != null && param1.contains(_loc2_.clip) == false)
         {
            param1.addChild(_loc2_.clip);
         }
      }
      
      public function setupSpecialPage(param1:MovieClip) : void
      {
         var _loc2_:SpecialItem = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:CookbookPage = this;
         var _loc7_:UserData = _loc6_.gameObj.var_128;
         var _loc8_:GameData = _loc6_.gameObj.var_133;
         if(_loc6_.specialIndex == -1)
         {
            if(_loc7_.hasAnySpecials())
            {
               _loc6_.clip = new menu_cookbook_recipe_blankpage();
            }
            else
            {
               _loc6_.clip = new menu_cookbook_recipe_nopage();
            }
         }
         else
         {
            _loc6_.clip = new menu_cookbook_recipe_page();
            _loc2_ = _loc8_.getSpecial(this.specialIndex);
            if(_loc2_ != null)
            {
               _loc6_.clip.title_txt.text = _loc2_.title;
               _loc6_.clip.bonus_txt.text = _loc2_.getBonusString();
               _loc6_.clip.from_txt.text = _loc7_.getSpecialCustomerName(this.specialIndex);
               _loc6_.clip.served_txt.text = _loc7_.getSpecialsServed(this.specialIndex);
               _loc3_ = _loc7_.getSpecialStars(this.specialIndex);
               _loc4_ = 1;
               while(_loc4_ <= 5)
               {
                  if(_loc3_ >= _loc4_)
                  {
                     _loc6_.clip["star" + _loc4_].visible = true;
                  }
                  else
                  {
                     _loc6_.clip["star" + _loc4_].visible = false;
                  }
                  _loc4_++;
               }
               _loc6_.logoBMP = _loc8_.getSpecialLogo(this.specialIndex);
               _loc6_.logoBitmap = new Bitmap(_loc6_.logoBMP);
               _loc6_.logoBitmap.x = 21;
               _loc6_.logoBitmap.y = 94;
               _loc6_.clip.addChild(_loc6_.logoBitmap);
               _loc6_.orderData = new CustomerOrder();
               _loc6_.orderData.setBread(_loc2_.ingredients[0]);
               _loc6_.orderData.setCheese(_loc2_.ingredients[1]);
               _loc6_.orderData.setCookType(FoodData.COOK_MEDIUM);
               _loc5_ = 2;
               while(_loc5_ < _loc2_.ingredients.length)
               {
                  _loc6_.orderData.addToppings(_loc2_.ingredients[_loc5_]);
                  _loc5_++;
               }
               _loc6_.createOrderPanels();
               if(_loc7_.currentSpecial == this.specialIndex)
               {
                  _loc6_.clip.special_btn.gotoAndStop(1);
               }
               else if(this.screen == null || this.screen.inMenu)
               {
                  _loc6_.clip.special_btn.stop();
                  _loc6_.clip.special_btn.visible = false;
               }
               else
               {
                  _loc6_.clip.special_btn.gotoAndStop(2);
                  _loc6_.clip.special_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc6_.clickSetSpecial);
               }
            }
            else
            {
               class_7.error("ERROR: Bad special: " + this.specialIndex);
               _loc6_.clip.visible = false;
            }
         }
         param1.addChild(_loc6_.clip);
      }
      
      public function createOrderPanels() : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:CookbookPage = this;
         _loc3_.panelHolder = new MovieClip();
         _loc3_.panelParts = new Vector.<MovieClip>();
         _loc4_ = new ticket_panel_bread();
         _loc4_.gotoAndStop(_loc3_.orderData.bread);
         _loc4_.x = -31;
         _loc4_.y = 211;
         _loc3_.panelParts.push(_loc4_);
         _loc3_.panelHolder.addChild(_loc4_);
         _loc5_ = new ticket_panel_cheese();
         _loc5_.gotoAndStop(_loc3_.orderData.cheese);
         _loc5_.x = 40;
         _loc5_.y = 211;
         _loc3_.panelParts.push(_loc5_);
         _loc3_.panelHolder.addChild(_loc5_);
         _loc6_ = new ticket_panel_cook();
         _loc6_.gotoAndStop(_loc3_.orderData.cookType);
         _loc6_.x = 2;
         _loc6_.y = 232;
         _loc3_.panelParts.push(_loc6_);
         _loc3_.panelHolder.addChild(_loc6_);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.orderData.toppings.length)
         {
            _loc2_ = null;
            if(FoodData.isSliceTopping(_loc3_.orderData.toppings[_loc1_]))
            {
               _loc2_ = new ticket_panel_slicetopping();
            }
            else if(FoodData.isSauce(_loc3_.orderData.toppings[_loc1_]))
            {
               _loc2_ = new ticket_panel_sauce();
            }
            else
            {
               _loc2_ = new ticket_panel_clump();
            }
            _loc2_.gotoAndStop(_loc3_.orderData.toppings[_loc1_]);
            _loc2_.x = 0;
            _loc2_.y = 172 - 32 * _loc1_;
            _loc3_.panelParts.push(_loc2_);
            _loc3_.panelHolder.addChild(_loc2_);
            _loc1_++;
         }
         _loc3_.clip.addChild(_loc3_.panelHolder);
         _loc3_.panelHolder.x = 267;
         _loc3_.panelHolder.y = 30;
         _loc3_.panelHolder.cacheAsBitmap = true;
      }
      
      public function setupIngredientPage(param1:MovieClip) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:CookbookPage = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         _loc2_.clip = new menu_cookbook_ingredient_page();
         _loc4_ = _loc3_.toppingIndexes.indexOf(_loc2_.ingredientTag);
         if(_loc4_ > -1)
         {
            _loc2_.clip.title_txt.text = _loc3_.toppingNames[_loc4_];
         }
         else
         {
            _loc2_.clip.title_txt.text = "???";
         }
         _loc5_ = Number(FoodData.getHolidayForItem(_loc2_.ingredientTag));
         if(_loc5_ == 0 || _loc5_ == 13)
         {
            _loc2_.clip.holiday.stop();
            _loc2_.clip.holiday.visible = false;
         }
         else
         {
            _loc2_.clip.holiday.gotoAndStop(_loc5_);
         }
         _loc2_.logoClip = new newtopping_topping();
         _loc2_.logoClip.gotoAndStop(_loc2_.ingredientTag);
         _loc2_.logoClip.scaleX = 0.6;
         _loc2_.logoClip.scaleY = 0.6;
         _loc2_.logoClip.x = 168;
         _loc2_.logoClip.y = 120;
         _loc2_.clip.addChild(_loc2_.logoClip);
         _loc2_.logoClip.cacheAsBitmap = true;
         _loc2_.logoClip.mouseEnabled = false;
         _loc2_.logoClip.mouseChildren = false;
         var _loc6_:String = "???";
         if(FoodData.isBread(_loc2_.ingredientTag))
         {
            _loc6_ = "Bread";
         }
         else if(FoodData.isCheese(_loc2_.ingredientTag))
         {
            _loc6_ = "Cheese";
         }
         else if(FoodData.getFries().indexOf(_loc2_.ingredientTag) > -1)
         {
            _loc6_ = "Fries";
         }
         else if(FoodData.isSauce(_loc2_.ingredientTag))
         {
            _loc6_ = "Sauce";
         }
         else if(Boolean(FoodData.isFryTopping(_loc2_.ingredientTag)) && !FoodData.isTopping(_loc2_.ingredientTag))
         {
            _loc6_ = "Fry Topping";
         }
         else
         {
            _loc6_ = "Topping";
         }
         _loc2_.clip.type_txt.htmlText = "<font color=\"#676767\">Type: </font>";
         _loc2_.clip.type_txt.htmlText += "<font color=\"#BD5D5D\">" + _loc6_ + "</font>";
         param1.addChild(_loc2_.clip);
      }
      
      public function clickSetSpecial(param1:MouseEvent) : void
      {
         var _loc2_:CookbookPage = this;
         _loc2_.gameObj.var_129.playSound("waiter_bell.wav");
         _loc2_.gameObj.var_128.currentSpecial = _loc2_.specialIndex;
         if(_loc2_.screen)
         {
            _loc2_.screen.anyChanges = true;
         }
         _loc2_.clip.special_btn.gotoAndStop(1);
         _loc2_.clip.special_btn.mouseEnabled = false;
         _loc2_.clip.special_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickSetSpecial);
         if(_loc2_.screen)
         {
            _loc2_.screen.populateCookbookLinks(false);
            if(_loc2_.screen.whichContextTraining == "setspecial")
            {
               _loc2_.gameObj.var_128.setTrained("setspecial");
               _loc2_.screen.removeContextTraining();
            }
            if(!_loc2_.screen.inMenu && _loc2_.gameObj.var_128.hasTrained("bonusspecial") == false)
            {
               _loc2_.screen.showContextTraining("bonusspecial");
               _loc2_.gameObj.var_128.setTrained("bonusspecial");
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CookbookPage = this;
         if(_loc2_.isSpecial)
         {
            if(_loc2_.logoBitmap)
            {
               if(_loc2_.logoBitmap.parent)
               {
                  _loc2_.logoBitmap.parent.removeChild(_loc2_.logoBitmap);
               }
               _loc2_.logoBitmap.bitmapData = null;
               _loc2_.logoBitmap = null;
            }
            if(_loc2_.logoBMP)
            {
               _loc2_.logoBMP.dispose();
               _loc2_.logoBMP = null;
            }
            if(Boolean(_loc2_.panelParts) && _loc2_.panelParts.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc2_.panelParts.length)
               {
                  if(_loc2_.panelParts[_loc1_].parent)
                  {
                     _loc2_.panelParts[_loc1_].parent.removeChild(_loc2_.panelParts[_loc1_]);
                  }
                  _loc2_.panelParts[_loc1_] = null;
                  _loc1_++;
               }
            }
            _loc2_.panelParts = null;
            if(Boolean(_loc2_.panelHolder) && Boolean(_loc2_.panelHolder.parent))
            {
               _loc2_.panelHolder.parent.removeChild(_loc2_.panelHolder);
            }
            _loc2_.panelHolder = null;
            _loc2_.orderData = null;
            if(_loc2_.clip.special_btn)
            {
               _loc2_.clip.special_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickSetSpecial);
            }
         }
         else if(_loc2_.logoClip)
         {
            if(_loc2_.logoClip.parent)
            {
               _loc2_.logoClip.parent.removeChild(_loc2_.logoClip);
            }
            _loc2_.logoClip = null;
         }
         if(Boolean(_loc2_.clip) && Boolean(_loc2_.clip.parent))
         {
            _loc2_.clip.parent.removeChild(_loc2_.clip);
         }
         _loc2_.clip = null;
      }
   }
}

