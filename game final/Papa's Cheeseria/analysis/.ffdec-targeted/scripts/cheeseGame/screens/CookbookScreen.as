package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import package_2.*;
   import package_4.class_5;
   
   public class CookbookScreen
   {
      
      public var gameObj:class_5;
      
      public var container:MovieClip = null;
      
      public var params:Object = null;
      
      public var inMenu:Boolean = false;
      
      private var cookbookIndex:Number = -1;
      
      private var cookbookScrollStart:Number = 125;
      
      private var cookbookScrollRange:Number = 191;
      
      private var cookbookScrollDir:Number = 0;
      
      private var cookbookMode:String = "recipe";
      
      private var cookbookSortMode:String = "abc";
      
      private var cookbookLinks:Vector.<MovieClip> = null;
      
      private var cookbookScrollAreaStart:Number = 91;
      
      private var cookbookScrollAreaHeight:Number = 260;
      
      private var cookbookPage:CookbookPage = null;
      
      private var lastCookbookPage:CookbookPage = null;
      
      public var clip:MovieClip;
      
      public var isClosing:Boolean = false;
      
      public var anyChanges:Boolean = false;
      
      public var lastClickedValue:* = null;
      
      public var trainingClip:MovieClip = null;
      
      public var whichContextTraining:String = "none";
      
      public function CookbookScreen(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         var _loc4_:CookbookScreen = null;
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.container = param2;
         _loc4_.params = param3;
         if(param3 != null)
         {
            class_7.method_1("Cookbook in Menu");
            if(param3.hasOwnProperty("inMenu"))
            {
               _loc4_.inMenu = param3.inMenu;
            }
         }
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var i:int = 0;
         var screen:CookbookScreen = this;
         screen.clip = new cookbookScreenMC();
         screen.container.addChild(screen.clip);
         screen.clip.addEventListener(Event.ENTER_FRAME,screen.updateScreen);
         screen.cookbookLinks = new Vector.<MovieClip>();
         screen.populateCookbookLinks(true,true);
         screen.clip.up_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookArrow);
         screen.clip.down_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookArrow);
         screen.clip.drag_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookDragger);
         screen.clip.drag_btn.addEventListener(MouseEvent.ROLL_OVER,screen.rolloverCookbookDragger);
         screen.clip.drag_btn.addEventListener(MouseEvent.ROLL_OUT,screen.rolloutCookbookDragger);
         screen.clip.drag_btn.buttonMode = true;
         screen.clip.drag_btn.useHandCursor = true;
         screen.clip.drag_btn.gotoAndStop(1);
         screen.clip.recipe_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookRecipes);
         screen.clip.ingredient_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookIngredients);
         screen.clip.recipe_btn.gotoAndStop(2);
         screen.clip.ingredient_btn.gotoAndStop(1);
         screen.clip.sort_abc.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookSortMode);
         screen.clip.sort_new.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookSortMode);
         screen.clip.sort_holiday.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickCookbookSortMode);
         screen.clip.sort_abc.gotoAndStop(1);
         screen.clip.sort_new.gotoAndStop(2);
         screen.clip.sort_holiday.gotoAndStop(2);
         screen.clip.pageturn.gotoAndStop(1);
         screen.clip.pageturnmask.gotoAndStop(1);
         screen.clip.flipholder.mask = screen.clip.pageturnmask;
         try
         {
            if(screen.gameObj.var_128.currentSpecial > -1)
            {
               screen.showCookbookSpecial(screen.gameObj.var_128.currentSpecial);
            }
            else
            {
               screen.showCookbookSpecial(-1);
            }
         }
         catch(err:Error)
         {
            class_7.error("Error showing the initial special: " + err.message);
         }
         screen.container.addEventListener("clickContinue",screen.clickContinue);
         if(screen.inMenu)
         {
            screen.clip.fader.stop();
            screen.clip.fader.visible = false;
            screen.clip.options.visible = false;
         }
         else
         {
            screen.gameObj.var_129.switchMusic("order");
            if(screen.gameObj.var_128.hasBonus("specialsign"))
            {
               screen.clip.options.visible = true;
               screen.clip.options.yes_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickShowSignYes);
               screen.clip.options.no_btn.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickShowSignNo);
               if(screen.gameObj.var_128.showSpecialSign === 1)
               {
                  screen.clip.options.yes_btn.gotoAndStop(1);
                  screen.clip.options.no_btn.gotoAndStop(2);
               }
               else
               {
                  screen.clip.options.yes_btn.gotoAndStop(2);
                  screen.clip.options.no_btn.gotoAndStop(1);
               }
            }
            else
            {
               screen.clip.options.visible = false;
            }
         }
         if(!screen.inMenu && screen.gameObj.var_128.hasTrained("listspecial") == false && screen.gameObj.var_128.currentSpecial == -1 && screen.gameObj.var_128.hasAnySpecials() == true)
         {
            screen.showContextTraining("listspecial");
         }
      }
      
      public function clickShowSignYes(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_128.showSpecialSign = 1;
         _loc2_.clip.options.yes_btn.gotoAndStop(1);
         _loc2_.clip.options.no_btn.gotoAndStop(2);
         _loc2_.anyChanges = true;
      }
      
      public function clickShowSignNo(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_128.showSpecialSign = 0;
         _loc2_.clip.options.yes_btn.gotoAndStop(2);
         _loc2_.clip.options.no_btn.gotoAndStop(1);
         _loc2_.anyChanges = true;
      }
      
      public function destroy() : void
      {
         var _loc1_:CookbookScreen = this;
         class_7.method_1("(Destroy Cookbook)");
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.removeContextTraining();
         _loc1_.removeCookbookLinks();
         _loc1_.cookbookLinks = null;
         _loc1_.clip.options.yes_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickShowSignYes);
         _loc1_.clip.options.no_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickShowSignNo);
         _loc1_.clip.up_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookArrow);
         _loc1_.clip.down_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookArrow);
         _loc1_.clip.drag_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookDragger);
         _loc1_.clip.drag_btn.removeEventListener(MouseEvent.ROLL_OVER,_loc1_.rolloverCookbookDragger);
         _loc1_.clip.drag_btn.removeEventListener(MouseEvent.ROLL_OUT,_loc1_.rolloutCookbookDragger);
         _loc1_.clip.recipe_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookRecipes);
         _loc1_.clip.ingredient_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookIngredients);
         _loc1_.clip.sort_abc.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookSortMode);
         _loc1_.clip.sort_new.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookSortMode);
         _loc1_.clip.sort_holiday.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickCookbookSortMode);
         if(_loc1_.cookbookPage)
         {
            _loc1_.cookbookPage.destroy();
            _loc1_.cookbookPage = null;
         }
         if(_loc1_.lastCookbookPage)
         {
            _loc1_.lastCookbookPage.destroy();
            _loc1_.lastCookbookPage = null;
         }
         _loc1_.container.removeEventListener("clickContinue",_loc1_.clickContinue);
         if(_loc1_.clip)
         {
            if(_loc1_.clip.parent)
            {
               _loc1_.clip.parent.removeChild(_loc1_.clip);
            }
         }
         _loc1_.container = null;
         _loc1_.clip = null;
      }
      
      public function clickCookbookSortMode(param1:MouseEvent, param2:String = null) : void
      {
         var _loc3_:CookbookScreen = this;
         _loc3_.gameObj.var_129.playSound("buttonclick.wav");
         if(param2 != null)
         {
            _loc3_.cookbookSortMode = param2;
         }
         else if(param1.currentTarget == _loc3_.clip.sort_abc)
         {
            _loc3_.cookbookSortMode = "abc";
         }
         else if(param1.currentTarget == _loc3_.clip.sort_new)
         {
            _loc3_.cookbookSortMode = "new";
         }
         else if(param1.currentTarget == _loc3_.clip.sort_holiday)
         {
            _loc3_.cookbookSortMode = "holiday";
         }
         _loc3_.clip.sort_abc.gotoAndStop(2);
         _loc3_.clip.sort_new.gotoAndStop(2);
         _loc3_.clip.sort_holiday.gotoAndStop(2);
         _loc3_.clip["sort_" + _loc3_.cookbookSortMode].gotoAndStop(1);
         _loc3_.populateCookbookLinks(true);
      }
      
      public function clickCookbookRecipes(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc2_.cookbookMode != "recipe")
         {
            _loc2_.cookbookMode = "recipe";
            _loc2_.populateCookbookLinks(true);
            _loc2_.clip.recipe_btn.gotoAndStop(2);
            _loc2_.clip.ingredient_btn.gotoAndStop(1);
         }
      }
      
      public function clickCookbookIngredients(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc2_.cookbookMode != "ingredient")
         {
            _loc2_.cookbookMode = "ingredient";
            _loc2_.populateCookbookLinks(true);
            _loc2_.clip.recipe_btn.gotoAndStop(1);
            _loc2_.clip.ingredient_btn.gotoAndStop(2);
         }
         if(_loc2_.whichContextTraining == "bonusspecial")
         {
            _loc2_.removeContextTraining();
         }
      }
      
      public function clickCookbookArrow(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         var _loc3_:String = param1.currentTarget.name;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc3_ == "up_btn")
         {
            _loc2_.cookbookScrollDir = -1;
         }
         else if(_loc3_ == "down_btn")
         {
            _loc2_.cookbookScrollDir = 1;
         }
         _loc2_.clip.scrollarea.addEventListener(Event.ENTER_FRAME,_loc2_.holdCookbookArrow);
         _loc2_.gameObj.stage.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseCookbookArrow);
      }
      
      public function releaseCookbookArrow(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.cookbookScrollDir = 0;
         _loc2_.clip.scrollarea.removeEventListener(Event.ENTER_FRAME,_loc2_.holdCookbookArrow);
         _loc2_.gameObj.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseCookbookArrow);
      }
      
      public function holdCookbookArrow(param1:Event) : void
      {
         var _loc2_:CookbookScreen = this;
         var _loc3_:Number = Number(_loc2_.cookbookScrollAreaStart);
         var _loc4_:Number = _loc3_ - (_loc2_.clip.scrollarea.height - _loc2_.cookbookScrollAreaHeight);
         if(_loc2_.cookbookScrollDir == 1)
         {
            _loc2_.clip.scrollarea.y -= 8;
         }
         else if(_loc2_.cookbookScrollDir == -1)
         {
            _loc2_.clip.scrollarea.y += 8;
         }
         if(_loc2_.clip.scrollarea.y < _loc4_)
         {
            _loc2_.clip.scrollarea.y = _loc4_;
            _loc2_.cookbookScrollDir = 0;
         }
         else if(_loc2_.clip.scrollarea.y > _loc3_)
         {
            _loc2_.clip.scrollarea.y = _loc3_;
            _loc2_.cookbookScrollDir = 0;
         }
         var _loc5_:Number = Math.abs((_loc2_.clip.scrollarea.y - _loc3_) / (_loc4_ - _loc3_));
         _loc2_.clip.drag_btn.y = _loc2_.cookbookScrollStart + _loc5_ * _loc2_.cookbookScrollRange;
      }
      
      public function showCookbookSpecial(param1:Number) : void
      {
         var _loc2_:CookbookScreen = this;
         if(_loc2_.lastCookbookPage)
         {
            _loc2_.lastCookbookPage.destroy();
            _loc2_.lastCookbookPage = null;
         }
         if(_loc2_.cookbookPage)
         {
            _loc2_.lastCookbookPage = _loc2_.cookbookPage;
            _loc2_.lastCookbookPage.setContainer(_loc2_.clip.flipholder);
         }
         if(_loc2_.cookbookPage != null)
         {
            _loc2_.clip.pageturn.gotoAndPlay(2);
            _loc2_.clip.pageturnmask.gotoAndPlay(2);
         }
         _loc2_.cookbookPage = new CookbookPage(_loc2_.gameObj,_loc2_,_loc2_.clip.pageholder,param1);
      }
      
      public function showCookbookIngredient(param1:String) : void
      {
         var _loc2_:CookbookScreen = this;
         if(_loc2_.lastCookbookPage)
         {
            _loc2_.lastCookbookPage.destroy();
            _loc2_.lastCookbookPage = null;
         }
         if(_loc2_.cookbookPage)
         {
            _loc2_.lastCookbookPage = _loc2_.cookbookPage;
            _loc2_.lastCookbookPage.setContainer(_loc2_.clip.flipholder);
         }
         _loc2_.clip.pageturn.gotoAndPlay(2);
         _loc2_.clip.pageturnmask.gotoAndPlay(2);
         _loc2_.cookbookPage = new CookbookPage(_loc2_.gameObj,_loc2_,_loc2_.clip.pageholder,-1,param1);
      }
      
      public function rolloverCookbookDragger(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.clip.drag_btn.gotoAndStop(2);
      }
      
      public function rolloutCookbookDragger(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.clip.drag_btn.gotoAndStop(1);
      }
      
      public function clickCookbookDragger(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.drag_btn.startDrag(false,new Rectangle(_loc2_.clip.drag_btn.x,_loc2_.cookbookScrollStart,0,_loc2_.cookbookScrollRange));
         _loc2_.clip.drag_btn.addEventListener(Event.ENTER_FRAME,_loc2_.dragCookbookDragger);
         _loc2_.gameObj.stage.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseCookbookDragger);
      }
      
      public function dragCookbookDragger(param1:Event) : void
      {
         var _loc2_:CookbookScreen = this;
         var _loc3_:Number = (_loc2_.clip.drag_btn.y - _loc2_.cookbookScrollStart) / _loc2_.cookbookScrollRange;
         _loc2_.clip.scrollarea.y = Math.round(_loc2_.cookbookScrollAreaStart - (_loc2_.clip.scrollarea.height - _loc2_.cookbookScrollAreaHeight) * _loc3_);
      }
      
      public function releaseCookbookDragger(param1:MouseEvent) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseCookbookDragger);
         _loc2_.clip.drag_btn.removeEventListener(Event.ENTER_FRAME,_loc2_.dragCookbookDragger);
         _loc2_.clip.drag_btn.stopDrag();
      }
      
      public function populateCookbookLinks(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:SpecialItem = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:MovieClip = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:CookbookScreen = this;
         var _loc16_:GameData = _loc15_.gameObj.var_133;
         var _loc17_:UserData = _loc15_.gameObj.var_128;
         var _loc18_:Number = 0;
         var _loc19_:Number = 0;
         var _loc20_:Number = 0;
         _loc15_.removeCookbookLinks();
         if(_loc15_.cookbookMode == "recipe")
         {
            _loc4_ = _loc16_.getSpecials(_loc15_.cookbookSortMode);
            _loc19_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc3_];
               _loc6_ = _loc5_.index;
               _loc7_ = new menu_cookbook_link();
               _loc7_.bg.gotoAndStop(_loc3_ % 2 + 1);
               if(_loc17_.hasSpecial(_loc6_))
               {
                  _loc7_.name_txt.text = _loc5_.title;
                  if(_loc17_.isSpecialViewed(_loc6_))
                  {
                     _loc7_.newlabel.visible = false;
                  }
                  else
                  {
                     _loc7_.newlabel.visible = true;
                     _loc7_.name_txt.textColor = 11101455;
                  }
                  if(_loc17_.getSpecialStars(_loc6_) >= _loc17_.starsToMasterSpecial)
                  {
                     _loc7_.bullet.gotoAndStop(2);
                  }
                  else
                  {
                     _loc7_.bullet.gotoAndStop(1);
                  }
                  if(_loc17_.currentSpecial == _loc6_)
                  {
                     _loc7_.checkmark.visible = true;
                     _loc7_.newlabel.visible = false;
                     _loc7_.name_txt.textColor = 2008576;
                     _loc20_ = _loc3_ * _loc7_.height;
                  }
                  else
                  {
                     _loc7_.checkmark.visible = false;
                  }
                  _loc7_.holiday.stop();
                  _loc7_.holiday.visible = false;
                  _loc7_.buttonMode = true;
                  _loc7_.useHandCursor = true;
                  _loc7_.mouseEnabled = true;
                  _loc7_.specialIndex = _loc6_;
                  _loc7_.addEventListener(MouseEvent.MOUSE_DOWN,_loc15_.clickCookbookLink);
                  _loc7_.x = 0;
                  _loc7_.y = _loc3_ * _loc7_.height;
                  _loc15_.clip.scrollarea.addChild(_loc7_);
                  _loc7_.btn.visible = true;
                  _loc18_++;
               }
               else
               {
                  _loc7_.name_txt.text = "???";
                  _loc7_.checkmark.visible = false;
                  _loc7_.newlabel.visible = false;
                  _loc7_.bullet.gotoAndStop(1);
                  _loc7_.holiday.stop();
                  _loc7_.holiday.visible = false;
                  _loc7_.btn.visible = false;
                  _loc7_.x = 0;
                  _loc7_.y = _loc3_ * _loc7_.height;
                  _loc15_.clip.scrollarea.addChild(_loc7_);
               }
               _loc15_.cookbookLinks.push(_loc7_);
               _loc3_++;
            }
            _loc4_ = null;
         }
         else if(_loc15_.cookbookMode == "ingredient")
         {
            _loc8_ = _loc16_.getIngredients(_loc15_.cookbookSortMode);
            _loc19_ = _loc8_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc8_.length)
            {
               _loc9_ = _loc8_[_loc3_];
               _loc10_ = new menu_cookbook_link();
               _loc10_.bg.gotoAndStop(_loc3_ % 2 + 1);
               if(_loc17_.hasTopping(_loc9_.tag))
               {
                  _loc10_.name_txt.text = _loc9_.title;
                  _loc10_.newlabel.visible = false;
                  _loc10_.bullet.gotoAndStop(1);
                  _loc10_.checkmark.visible = false;
                  _loc11_ = Number(FoodData.getHolidayForItem(_loc9_.tag));
                  if(_loc11_ > 0 && _loc11_ < 13)
                  {
                     _loc10_.holiday.gotoAndStop(_loc11_);
                  }
                  else
                  {
                     _loc10_.holiday.stop();
                     _loc10_.holiday.visible = false;
                  }
                  _loc10_.buttonMode = true;
                  _loc10_.useHandCursor = true;
                  _loc10_.mouseEnabled = true;
                  _loc10_.tag = _loc9_.tag;
                  _loc10_.addEventListener(MouseEvent.MOUSE_DOWN,_loc15_.clickCookbookLink);
                  _loc10_.x = 0;
                  _loc10_.y = _loc3_ * _loc10_.height;
                  _loc15_.clip.scrollarea.addChild(_loc10_);
                  _loc10_.btn.visible = true;
                  _loc18_++;
               }
               else
               {
                  _loc10_.name_txt.text = "???";
                  _loc10_.checkmark.visible = false;
                  _loc10_.newlabel.visible = false;
                  _loc10_.bullet.gotoAndStop(1);
                  _loc10_.holiday.stop();
                  _loc10_.holiday.visible = false;
                  _loc10_.btn.visible = false;
                  _loc10_.x = 0;
                  _loc10_.y = _loc3_ * _loc10_.height;
                  _loc15_.clip.scrollarea.addChild(_loc10_);
               }
               _loc15_.cookbookLinks.push(_loc10_);
               _loc3_++;
            }
            _loc8_ = null;
         }
         _loc15_.clip.tally_txt.text = _loc18_ + "/" + _loc19_;
         _loc15_.clip.percent_txt.text = Math.floor(_loc18_ / _loc19_ * 100) + "%";
         if(param1)
         {
            _loc15_.clip.scrollarea.y = _loc15_.cookbookScrollAreaStart;
            _loc15_.clip.drag_btn.y = _loc15_.cookbookScrollStart;
         }
         if(param2 && _loc15_.cookbookMode == "recipe" && _loc17_.currentSpecial > -1)
         {
            if(_loc20_ > _loc15_.cookbookScrollAreaHeight - 40)
            {
               _loc12_ = Number(_loc15_.cookbookScrollAreaStart);
               _loc13_ = _loc12_ - (_loc15_.clip.scrollarea.height - _loc15_.cookbookScrollAreaHeight);
               _loc15_.clip.scrollarea.y = _loc15_.cookbookScrollAreaStart - _loc20_ + 80;
               if(_loc15_.clip.scrollarea.y < _loc13_)
               {
                  _loc15_.clip.scrollarea.y = _loc13_;
               }
               else if(_loc15_.clip.scrollarea.y > _loc12_)
               {
                  _loc15_.clip.scrollarea.y = _loc12_;
               }
               _loc14_ = Math.abs((_loc15_.clip.scrollarea.y - _loc12_) / (_loc13_ - _loc12_));
               _loc15_.clip.drag_btn.y = _loc15_.cookbookScrollStart + _loc14_ * _loc15_.cookbookScrollRange;
            }
         }
      }
      
      public function removeCookbookLinks() : void
      {
         var _loc1_:* = 0;
         var _loc2_:CookbookScreen = this;
         if(_loc2_.cookbookLinks != null && _loc2_.cookbookLinks.length > 0)
         {
            _loc1_ = int(_loc2_.cookbookLinks.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc2_.cookbookLinks[_loc1_].parent)
               {
                  _loc2_.cookbookLinks[_loc1_].parent.removeChild(_loc2_.cookbookLinks[_loc1_]);
                  _loc2_.cookbookLinks[_loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickCookbookLink);
                  _loc2_.cookbookLinks[_loc1_] = null;
                  _loc2_.cookbookLinks.splice(_loc1_,1);
               }
               _loc1_--;
            }
         }
      }
      
      public function clickCookbookLink(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:String = null;
         var _loc4_:CookbookScreen = this;
         if(_loc4_.cookbookMode == "recipe")
         {
            _loc2_ = Number(MovieClip(param1.currentTarget).specialIndex);
            class_7.method_1("Click link for " + _loc2_);
            if(_loc4_.lastClickedValue != _loc2_)
            {
               _loc4_.showCookbookSpecial(_loc2_);
               if(_loc4_.gameObj.var_128.isSpecialViewed(_loc2_) == false)
               {
                  _loc4_.gameObj.var_128.setSpecialViewed(_loc2_);
                  MovieClip(param1.currentTarget).newlabel.visible = false;
                  MovieClip(param1.currentTarget).name_txt.textColor = 6710886;
                  _loc4_.anyChanges = true;
               }
               _loc4_.lastClickedValue = _loc2_;
               _loc4_.gameObj.var_129.playSound("dropticket.wav");
               if(_loc4_.whichContextTraining == "listspecial")
               {
                  _loc4_.gameObj.var_128.setTrained("listspecial");
                  _loc4_.removeContextTraining();
               }
               if(!_loc4_.inMenu && _loc4_.gameObj.var_128.hasTrained("setspecial") == false)
               {
                  _loc4_.showContextTraining("setspecial");
               }
            }
         }
         else if(_loc4_.cookbookMode == "ingredient")
         {
            _loc3_ = MovieClip(param1.currentTarget).tag;
            class_7.method_1("Click link for " + _loc3_);
            if(_loc4_.lastClickedValue != _loc3_)
            {
               _loc4_.showCookbookIngredient(_loc3_);
               _loc4_.lastClickedValue = _loc3_;
               _loc4_.gameObj.var_129.playSound("dropticket.wav");
            }
         }
         if(_loc4_.whichContextTraining == "bonusspecial")
         {
            _loc4_.removeContextTraining();
         }
      }
      
      public function clickContinue(param1:Event) : void
      {
         var _loc2_:CookbookScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.fader.gotoAndPlay("quickfadeout");
         _loc2_.isClosing = true;
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:CookbookScreen = this;
         if(_loc2_.isClosing)
         {
            if(_loc2_.clip.fader.currentFrame == _loc2_.clip.fader.totalFrames)
            {
               if(this.anyChanges == true)
               {
                  class_7.info("SAVE SPECIAL DATA");
                  _loc2_.gameObj.var_128.saveSpecialData();
               }
               _loc2_.gameObj.method_122();
               _loc2_.gameObj.method_225();
            }
         }
      }
      
      public function showContextTraining(param1:String) : void
      {
         var _loc2_:CookbookScreen = this;
         if(!_loc2_.trainingClip)
         {
            _loc2_.trainingClip = new trainingMC();
            _loc2_.clip.addChild(_loc2_.trainingClip);
            _loc2_.trainingClip.mouseEnabled = false;
            _loc2_.trainingClip.mouseChildren = false;
         }
         _loc2_.whichContextTraining = param1;
         _loc2_.trainingClip.gotoAndStop(param1);
      }
      
      public function removeContextTraining() : void
      {
         var _loc1_:CookbookScreen = this;
         if(_loc1_.trainingClip)
         {
            _loc1_.clip.removeChild(_loc1_.trainingClip);
            _loc1_.trainingClip = null;
         }
         _loc1_.whichContextTraining = "none";
      }
   }
}

