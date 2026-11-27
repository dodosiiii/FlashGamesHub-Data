package cheeseGame.screens
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class ShopScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var whichSet:Number = 1;
      
      public var panelsPerSet:Number = 6;
      
      public var workingArray:Array;
      
      public var shouldShowNext:Boolean = false;
      
      public var shouldShowPrev:Boolean = false;
      
      public var purchasedToday:Array;
      
      public var lastPurchaseTag:String = "none";
      
      public var mode:String = "upgrades";
      
      public var filterThemeMonth:Number = -1;
      
      public var filterShowType:String = "all";
      
      public var filterShowTypes:Array;
      
      public var filterShowTypeLabels:Array;
      
      public var dropdownClip:MovieClip;
      
      public var dropdownClipType:String = "none";
      
      public var isShowingDropdown:Boolean = false;
      
      public var dropdownParts:Array;
      
      public var mannequinColor:uint = 14540253;
      
      public var tipsPanel:MovieClip = null;
      
      public var colorPalette:MovieClip = null;
      
      public var colorSwatches:Vector.<MovieClip>;
      
      public var colorPaletteData:Array;
      
      public var colorPalettePanel:Number = 0;
      
      public var tintGroupsSelectedTag:Array;
      
      public function ShopScreen(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         var _loc4_:ShopScreen = null;
         this.workingArray = [];
         this.purchasedToday = [];
         this.filterShowTypes = ["all","owned","notowned",ClothingItem.TYPE_SHIRT,ClothingItem.TYPE_JACKET,ClothingItem.TYPE_SHOES,ClothingItem.TYPE_PANTS,ClothingItem.TYPE_HAT,ClothingItem.TYPE_ACC_ARMS,ClothingItem.TYPE_ACC_BELT,ClothingItem.TYPE_ACC_BODY,ClothingItem.TYPE_ACC_FACE];
         this.filterShowTypeLabels = ["All","Already Owned","Not Owned","Shirts","Jackets","Shoes","Pants","Hats","Arm Extras","Belts","Accessories","Glasses"];
         this.dropdownParts = [];
         this.colorPaletteData = [];
         this.tintGroupsSelectedTag = [];
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.container = param2;
         if(_loc4_.gameObj.var_128.hasVisitedUpgradeShop == false)
         {
            _loc4_.gameObj.var_128.hasVisitedUpgradeShop = true;
         }
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:ShopScreen = this;
         class_7.method_1("Setup Shop Screen!");
         _loc1_.clip = new shopScreenMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.tipsPanel = _loc1_.clip.tipspanel;
         _loc1_.gameObj.addChild(_loc1_.tipsPanel);
         _loc1_.tipsPanel.tips_txt.text = _loc1_.gameObj.var_128.getTipsTotal(true);
         _loc1_.clip.noitems.visible = false;
         _loc1_.clip.next_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickNext);
         _loc1_.clip.prev_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickPrevious);
         _loc1_.clip.upgrades_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.furniture_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.poster_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.wallfloor_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.clothing_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         var _loc2_:int = 1;
         while(_loc2_ <= 6)
         {
            _loc1_.clip.panels["panel" + _loc2_].purchase_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickPurchase);
            _loc1_.clip.panels["panel" + _loc2_].confirm.yes_btn.addEventListener(MouseEvent.CLICK,_loc1_.confirmPurchase);
            _loc1_.clip.panels["panel" + _loc2_].confirm.no_btn.addEventListener(MouseEvent.CLICK,_loc1_.cancelPurchase);
            _loc1_.clip.panels["panel" + _loc2_].pickswatch.color_btn.addEventListener(MouseEvent.CLICK,_loc1_.clickChooseColor);
            _loc1_.clip.panels["panel" + _loc2_].pickswatch.owned.mouseEnabled = false;
            _loc1_.clip.panels["panel" + _loc2_].pickswatch.owned.mouseChildren = false;
            _loc2_++;
         }
         _loc1_.clip.next_btn.visible = false;
         _loc1_.clip.prev_btn.visible = false;
         _loc1_.clip.page_txt.text = "";
         _loc1_.container.addEventListener("clickBackToGame",_loc1_.clickBackToGame);
         _loc1_.container.addEventListener("clickQuit",_loc1_.clickQuit);
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.gameObj.var_129.switchMusic("bake");
         _loc1_.clip.show_dropdown.btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickOpenShowDropdown);
         _loc1_.clip.theme_dropdown.btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickOpenThemeDropdown);
         _loc1_.selectMode("upgrades",true);
      }
      
      public function clickChangeMode(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         var _loc3_:Array = String(param1.currentTarget.name).split("_");
         var _loc4_:String = _loc3_[0];
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc2_.mode != _loc4_)
         {
            _loc2_.selectMode(_loc4_);
         }
      }
      
      public function selectMode(param1:String, param2:Boolean = false, param3:Boolean = true) : void
      {
         var _loc5_:ShopScreen = null;
         var _loc4_:int = 0;
         _loc5_ = this;
         _loc5_.mode = param1;
         _loc5_.clip.tabbg.gotoAndStop(_loc5_.mode);
         _loc5_.clip.noitems.gotoAndStop(1);
         _loc5_.clip.noitems.visible = false;
         if(param3)
         {
            _loc5_.filterShowType = "all";
            if(param1 == "wallfloor")
            {
               _loc5_.filterShowType = "notowned";
            }
         }
         _loc5_.workingArray = _loc5_.gameObj.var_133.getStoreTags(_loc5_.mode,_loc5_.filterShowType,_loc5_.filterThemeMonth);
         _loc5_.purchasedToday = [];
         if(_loc5_.workingArray.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.workingArray.length)
            {
               _loc5_.purchasedToday.push(0);
               _loc4_++;
            }
         }
         if(param2 && _loc5_.mode == "upgrades" && _loc5_.workingArray.length == 0)
         {
            _loc5_.selectMode("furniture",true);
            return;
         }
         class_7.method_1("MODE: " + _loc5_.mode);
         class_7.method_1("Working Array: " + _loc5_.workingArray);
         _loc5_.removeColorPalette();
         _loc5_.whichSet = 1;
         if(!param2)
         {
            _loc5_.clip.panels.gotoAndPlay("nextset");
            _loc5_.clip.next_btn.visible = false;
            _loc5_.clip.prev_btn.visible = false;
         }
         else
         {
            _loc5_.populatePanels();
            _loc5_.clip.panels.gotoAndPlay(1);
            _loc5_.clip.next_btn.visible = false;
            _loc5_.clip.prev_btn.visible = false;
         }
         _loc5_.updateDropdowns();
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:ShopScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(_loc2_.clip.panels.currentFrame == 6 || _loc2_.clip.panels.currentFrame == 17)
         {
            _loc2_.clip.panels.stop();
            if(_loc2_.shouldShowNext)
            {
               _loc2_.clip.next_btn.visible = true;
            }
            else
            {
               _loc2_.clip.next_btn.visible = false;
            }
            if(_loc2_.shouldShowPrev)
            {
               _loc2_.clip.prev_btn.visible = true;
            }
            else
            {
               _loc2_.clip.prev_btn.visible = false;
            }
         }
         else
         {
            _loc2_.clip.next_btn.visible = false;
            _loc2_.clip.prev_btn.visible = false;
         }
         if(_loc2_.clip.panels.currentFrame == 11)
         {
            _loc2_.populatePanels();
            _loc2_.clip.panels.gotoAndPlay(1);
         }
         else if(_loc2_.clip.panels.currentFrame == 22)
         {
            _loc2_.populatePanels();
            _loc2_.clip.panels.gotoAndPlay(12);
         }
      }
      
      public function populatePanels(param1:Boolean = false) : void
      {
         var i:int;
         var totalPages:Number;
         var index:Number = Number(NaN);
         var mypanel:MovieClip = null;
         var whichTag:String = null;
         var alreadyPurchased:Number = Number(NaN);
         var furniData:FurniData = null;
         var upgrade:Upgrade = null;
         var upgradeThumb:MovieClip = null;
         var tintClothing:ClothingItem = null;
         var clothing:ClothingItem = null;
         var justPurchased:Boolean = param1;
         var screen:ShopScreen = this;
         var data:UserData = screen.gameObj.var_128;
         var gamedata:GameData = screen.gameObj.var_133;
         var offset:Number = screen.panelsPerSet * (screen.whichSet - 1);
         screen.removeColorPalette();
         i = 0;
         while(i < screen.panelsPerSet)
         {
            index = i + offset;
            mypanel = screen.clip.panels["panel" + (i + 1)];
            if(justPurchased == false)
            {
               screen.tintGroupsSelectedTag[i] = null;
            }
            if(index < screen.workingArray.length)
            {
               whichTag = screen.workingArray[index];
               alreadyPurchased = Number(screen.purchasedToday[index]);
               if(screen.mode == "furniture" || screen.mode == "poster" || screen.mode == "wallfloor")
               {
                  furniData = gamedata.getFurniFromTag(whichTag);
                  mypanel.visible = true;
                  mypanel.title_txt.text = "  " + furniData.title;
                  mypanel.info_txt.text = "";
                  mypanel.infopanel.visible = false;
                  mypanel.pointpanel.visible = true;
                  mypanel.pointpanel.effect_txt.text = furniData.effect + " Bonus";
                  mypanel.pointpanel.points_txt.text = furniData.getMaxPoints() + " Points";
                  mypanel.pointpanel.theme.gotoAndStop(furniData.theme);
                  mypanel.own_txt.text = String(data.getFurniAmount(whichTag,true));
                  mypanel.own_txt.visible = true;
                  mypanel.own_label.visible = true;
                  if(data.getFurniAmount(whichTag,true) == 0)
                  {
                     mypanel.purchasedbg.visible = false;
                  }
                  else
                  {
                     mypanel.purchasedbg.visible = true;
                  }
                  mypanel.price_txt.text = class_13.method_127(furniData.price);
                  if(furniData.price <= data.getTipsTotal())
                  {
                     mypanel.purchase_btn.visible = true;
                     mypanel.needmoretips_btn.visible = false;
                  }
                  else
                  {
                     mypanel.purchase_btn.visible = false;
                     mypanel.needmoretips_btn.visible = true;
                  }
                  try
                  {
                     if(mypanel.thumb.numChildren > 0)
                     {
                        mypanel.thumb.removeChildAt(0);
                     }
                  }
                  catch(err:Error)
                  {
                     class_7.error("Error removing thumb.");
                  }
                  mypanel.thumb.addChild(screen.createFurniThumbnail(furniData));
                  if(screen.lastPurchaseTag == furniData.tag)
                  {
                     mypanel.fireworks.gotoAndPlay(2);
                     screen.lastPurchaseTag = "none";
                  }
                  if(data.getFurniAmount(whichTag,true) > 0 && (furniData.type == FurniData.TYPE_WALLPAPER || furniData.type == FurniData.TYPE_FLOORING))
                  {
                     mypanel.purchase_btn.visible = false;
                     mypanel.needmoretips_btn.visible = false;
                  }
                  mypanel.confirm.visible = false;
                  mypanel.cover.visible = false;
                  mypanel.alreadyown.visible = false;
                  if(screen.mode == "wallfloor" && Boolean(alreadyPurchased))
                  {
                     mypanel.cover.visible = true;
                  }
                  mypanel.pickswatch.visible = false;
               }
               else if(screen.mode == "upgrades")
               {
                  upgrade = gamedata.getUpgradeFromTag(whichTag);
                  mypanel.visible = true;
                  mypanel.title_txt.text = upgrade.title;
                  mypanel.info_txt.text = "";
                  mypanel.pointpanel.visible = false;
                  mypanel.infopanel.visible = true;
                  mypanel.infopanel.info_txt.text = upgrade.description;
                  if(whichTag != "napkin")
                  {
                     mypanel.own_txt.visible = false;
                     mypanel.own_label.visible = false;
                     mypanel.purchasedbg.visible = false;
                  }
                  mypanel.price_txt.text = class_13.method_127(upgrade.price);
                  if(whichTag != "vatguide2" || data.hasBonus("vatguide1"))
                  {
                     if(upgrade.price <= data.getTipsTotal())
                     {
                        mypanel.purchase_btn.visible = true;
                        mypanel.needmoretips_btn.visible = false;
                     }
                     else
                     {
                        mypanel.purchase_btn.visible = false;
                        mypanel.needmoretips_btn.visible = true;
                     }
                  }
                  else
                  {
                     mypanel.purchase_btn.visible = false;
                     mypanel.needmoretips_btn.visible = false;
                  }
                  try
                  {
                     if(mypanel.thumb.numChildren > 0)
                     {
                        mypanel.thumb.removeChildAt(0);
                     }
                  }
                  catch(err:Error)
                  {
                     class_7.error("Error removing thumb.");
                  }
                  upgradeThumb = new shop_panel_thumb();
                  upgradeThumb.gotoAndStop(upgrade.tag);
                  mypanel.thumb.addChild(upgradeThumb);
                  mypanel.confirm.visible = false;
                  mypanel.cover.visible = false;
                  if(Boolean(alreadyPurchased) && whichTag != "napkin")
                  {
                     mypanel.cover.visible = true;
                  }
                  mypanel.pickswatch.visible = false;
                  mypanel.alreadyown.visible = false;
               }
               else if(screen.mode == "clothing" && screen.gameObj.var_135.isTintGroup(whichTag))
               {
                  tintClothing = screen.gameObj.var_135.getFirstTintVariation(whichTag,screen.filterThemeMonth);
                  if(justPurchased)
                  {
                     class_7.method_1("Just purchased an item from this screen, use " + screen.tintGroupsSelectedTag[i] + " instead of " + tintClothing.tag);
                     tintClothing = screen.gameObj.var_135.getItemFromSKU(screen.tintGroupsSelectedTag[i]);
                  }
                  screen.tintGroupsSelectedTag[i] = tintClothing.tag;
                  mypanel.visible = true;
                  mypanel.title_txt.text = "  " + tintClothing.title;
                  mypanel.info_txt.text = "";
                  mypanel.infopanel.visible = false;
                  mypanel.pointpanel.visible = true;
                  mypanel.pointpanel.points_txt.text = "";
                  mypanel.pointpanel.theme.gotoAndStop(screen.gameObj.var_135.getClothingThemeFrame(tintClothing.tag));
                  if(tintClothing.type == ClothingItem.TYPE_SHIRT)
                  {
                     mypanel.pointpanel.effect_txt.text = "Shirt";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_JACKET)
                  {
                     mypanel.pointpanel.effect_txt.text = "Jacket";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_SHOES)
                  {
                     mypanel.pointpanel.effect_txt.text = "Shoes";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_PANTS)
                  {
                     mypanel.pointpanel.effect_txt.text = "Pants";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_HAIR)
                  {
                     mypanel.pointpanel.effect_txt.text = "Hairstyle";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_ACC_ARMS)
                  {
                     mypanel.pointpanel.effect_txt.text = "Arm Accessory";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_ACC_BELT)
                  {
                     mypanel.pointpanel.effect_txt.text = "Belt Accessory";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_ACC_BODY)
                  {
                     mypanel.pointpanel.effect_txt.text = "Accessory";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_ACC_FACE)
                  {
                     mypanel.pointpanel.effect_txt.text = "Face Accessory";
                  }
                  else if(tintClothing.type == ClothingItem.TYPE_HAT)
                  {
                     mypanel.pointpanel.effect_txt.text = "Hat";
                  }
                  mypanel.own_txt.visible = false;
                  mypanel.own_label.visible = false;
                  mypanel.purchasedbg.visible = false;
                  mypanel.price_txt.text = class_13.method_127(tintClothing.price);
                  if(tintClothing.price <= data.getTipsTotal())
                  {
                     mypanel.purchase_btn.visible = true;
                     mypanel.needmoretips_btn.visible = false;
                  }
                  else
                  {
                     mypanel.purchase_btn.visible = false;
                     mypanel.needmoretips_btn.visible = true;
                  }
                  if(screen.gameObj.var_128.alreadyOwnsClothing(tintClothing.tag))
                  {
                     mypanel.purchase_btn.visible = false;
                     mypanel.needmoretips_btn.visible = false;
                     mypanel.purchasedbg.visible = true;
                     mypanel.alreadyown.visible = true;
                     mypanel.pickswatch.owned.visible = true;
                  }
                  else
                  {
                     mypanel.purchasedbg.visible = false;
                     mypanel.alreadyown.visible = false;
                     mypanel.pickswatch.owned.visible = false;
                  }
                  if(screen.lastPurchaseTag == tintClothing.tag)
                  {
                     mypanel.fireworks.gotoAndPlay(2);
                     screen.lastPurchaseTag = "none";
                  }
                  try
                  {
                     if(mypanel.thumb.numChildren > 0)
                     {
                        mypanel.thumb.removeChildAt(0);
                     }
                  }
                  catch(err:Error)
                  {
                     class_7.error("Error removing thumb.");
                  }
                  mypanel.thumb.addChild(screen.gameObj.var_135.generateClothingThumb(tintClothing.tag,screen.gameObj.workerData.gender));
                  mypanel.confirm.visible = false;
                  mypanel.cover.visible = false;
                  mypanel.pickswatch.visible = true;
                  mypanel.pickswatch.color_swatch.transform.colorTransform = screen.createColorTransform(tintClothing.tintPreviewColor);
               }
               else if(screen.mode == "clothing")
               {
                  clothing = screen.gameObj.var_135.getItemFromSKU(whichTag);
                  mypanel.visible = true;
                  mypanel.title_txt.text = "  " + clothing.title;
                  mypanel.info_txt.text = "";
                  mypanel.infopanel.visible = false;
                  mypanel.pointpanel.visible = true;
                  mypanel.pointpanel.points_txt.text = "";
                  mypanel.pointpanel.theme.gotoAndStop(screen.gameObj.var_135.getClothingThemeFrame(whichTag));
                  if(clothing.type == ClothingItem.TYPE_SHIRT)
                  {
                     mypanel.pointpanel.effect_txt.text = "Shirt";
                  }
                  else if(clothing.type == ClothingItem.TYPE_JACKET)
                  {
                     mypanel.pointpanel.effect_txt.text = "Jacket";
                  }
                  else if(clothing.type == ClothingItem.TYPE_SHOES)
                  {
                     mypanel.pointpanel.effect_txt.text = "Shoes";
                  }
                  else if(clothing.type == ClothingItem.TYPE_PANTS)
                  {
                     mypanel.pointpanel.effect_txt.text = "Pants";
                  }
                  else if(clothing.type == ClothingItem.TYPE_HAIR)
                  {
                     mypanel.pointpanel.effect_txt.text = "Hairstyle";
                  }
                  else if(clothing.type == ClothingItem.TYPE_ACC_ARMS)
                  {
                     mypanel.pointpanel.effect_txt.text = "Arm Accessory";
                  }
                  else if(clothing.type == ClothingItem.TYPE_ACC_BELT)
                  {
                     mypanel.pointpanel.effect_txt.text = "Belt Accessory";
                  }
                  else if(clothing.type == ClothingItem.TYPE_ACC_BODY)
                  {
                     mypanel.pointpanel.effect_txt.text = "Accessory";
                  }
                  else if(clothing.type == ClothingItem.TYPE_ACC_FACE)
                  {
                     mypanel.pointpanel.effect_txt.text = "Face Accessory";
                  }
                  else if(clothing.type == ClothingItem.TYPE_HAT)
                  {
                     mypanel.pointpanel.effect_txt.text = "Hat";
                  }
                  mypanel.own_txt.visible = false;
                  mypanel.own_label.visible = false;
                  mypanel.purchasedbg.visible = false;
                  mypanel.price_txt.text = class_13.method_127(clothing.price);
                  if(clothing.price <= data.getTipsTotal())
                  {
                     mypanel.purchase_btn.visible = true;
                     mypanel.needmoretips_btn.visible = false;
                  }
                  else
                  {
                     mypanel.purchase_btn.visible = false;
                     mypanel.needmoretips_btn.visible = true;
                  }
                  try
                  {
                     if(mypanel.thumb.numChildren > 0)
                     {
                        mypanel.thumb.removeChildAt(0);
                     }
                  }
                  catch(err:Error)
                  {
                     class_7.error("Error removing thumb.");
                  }
                  mypanel.thumb.addChild(screen.gameObj.var_135.generateClothingThumb(clothing.tag,screen.gameObj.workerData.gender));
                  mypanel.confirm.visible = false;
                  mypanel.cover.visible = false;
                  if(alreadyPurchased)
                  {
                     mypanel.cover.visible = true;
                  }
                  mypanel.pickswatch.visible = false;
                  mypanel.alreadyown.visible = false;
               }
            }
            else
            {
               mypanel.visible = false;
            }
            i++;
         }
         if(screen.workingArray.length > offset + screen.panelsPerSet)
         {
            screen.shouldShowNext = true;
         }
         else
         {
            screen.shouldShowNext = false;
         }
         if(screen.whichSet > 1)
         {
            screen.shouldShowPrev = true;
         }
         else
         {
            screen.shouldShowPrev = false;
         }
         totalPages = Math.ceil(screen.workingArray.length / screen.panelsPerSet);
         screen.clip.page_txt.text = "Page " + this.whichSet + " of " + Math.max(1,totalPages);
         if(totalPages == 0)
         {
            screen.clip.noitems.visible = true;
            screen.clip.noitems.gotoAndPlay(1);
         }
      }
      
      private function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
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
            _loc20_.scaleX = 0.285;
            _loc20_.scaleY = 0.285;
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
            _loc20_.scaleX = 0.26;
            _loc20_.scaleY = 0.26;
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
            if(_loc11_.height > 64 || _loc11_.width > 64)
            {
               if(_loc11_.height > _loc11_.width)
               {
                  _loc11_.height = 64;
                  _loc11_.width = _loc11_.height * _loc14_;
               }
               else
               {
                  _loc11_.width = 64;
                  _loc11_.height = _loc11_.width * _loc13_;
               }
            }
            _loc15_ = (64 - _loc11_.width) / 2;
            _loc16_ = (64 - _loc11_.height) / 2;
            _loc17_ = _loc11_.getBounds(_loc11_);
            _loc18_ = _loc17_.y + _loc17_.height;
            _loc19_ = _loc18_ * (_loc11_.height / _loc12_);
            if(param1.type == FurniData.TYPE_FURNI)
            {
               _loc11_.x = _loc15_;
               _loc11_.y = 64 - _loc16_;
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
      
      public function clickBackToGame(param1:Event) : void
      {
         var _loc2_:ShopScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.method_122();
         _loc2_.gameObj.method_191();
      }
      
      public function clickQuit(param1:Event) : void
      {
         var _loc2_:ShopScreen = this;
         _loc2_.gameObj.quitToTitle();
      }
      
      public function clickPrevious(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.noitems.visible = false;
         --_loc2_.whichSet;
         _loc2_.clip.panels.gotoAndPlay("prevset");
         _loc2_.clip.next_btn.visible = false;
         _loc2_.clip.prev_btn.visible = false;
         _loc2_.removeColorPalette();
      }
      
      public function clickNext(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.noitems.visible = false;
         ++_loc2_.whichSet;
         _loc2_.clip.panels.gotoAndPlay("nextset");
         _loc2_.clip.next_btn.visible = false;
         _loc2_.clip.prev_btn.visible = false;
         _loc2_.removeColorPalette();
      }
      
      public function destroy() : void
      {
         var _loc2_:int;
         var _loc1_:ShopScreen = this;
         _loc1_.clip.show_dropdown.btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickOpenShowDropdown);
         _loc1_.clip.theme_dropdown.btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickOpenThemeDropdown);
         _loc1_.removeColorPalette();
         try
         {
            _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         }
         catch(err:Error)
         {
         }
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            _loc1_.clip.panels["panel" + _loc2_].purchase_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickPurchase);
            _loc1_.clip.panels["panel" + _loc2_].confirm.yes_btn.removeEventListener(MouseEvent.CLICK,_loc1_.confirmPurchase);
            _loc1_.clip.panels["panel" + _loc2_].confirm.no_btn.removeEventListener(MouseEvent.CLICK,_loc1_.cancelPurchase);
            _loc1_.clip.panels["panel" + _loc2_].pickswatch.color_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickChooseColor);
            _loc2_++;
         }
         try
         {
            if(Boolean(_loc1_.tipsPanel) && Boolean(_loc1_.tipsPanel.parent))
            {
               _loc1_.tipsPanel.parent.removeChild(_loc1_.tipsPanel);
               _loc1_.tipsPanel = null;
            }
         }
         catch(err:Error)
         {
         }
         _loc1_.clip.upgrades_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.furniture_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.poster_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.wallfloor_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.clothing_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickChangeMode);
         _loc1_.clip.next_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickNext);
         _loc1_.clip.prev_btn.removeEventListener(MouseEvent.CLICK,_loc1_.clickPrevious);
         _loc1_.container.removeEventListener("clickBackToGame",_loc1_.clickBackToGame);
         _loc1_.container.removeEventListener("clickQuit",_loc1_.clickQuit);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function cancelPurchase(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         var _loc3_:Number = -1;
         if(param1.currentTarget == _loc2_.clip.panels.panel1.confirm.no_btn)
         {
            _loc3_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel2.confirm.no_btn)
         {
            _loc3_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel3.confirm.no_btn)
         {
            _loc3_ = 3;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel4.confirm.no_btn)
         {
            _loc3_ = 4;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel5.confirm.no_btn)
         {
            _loc3_ = 5;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel6.confirm.no_btn)
         {
            _loc3_ = 6;
         }
         if(_loc3_ > -1)
         {
            _loc2_.clip.panels["panel" + _loc3_].confirm.visible = false;
         }
      }
      
      public function clickPurchase(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         var _loc3_:Number = -1;
         if(param1.currentTarget == _loc2_.clip.panels.panel1.purchase_btn)
         {
            _loc3_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel2.purchase_btn)
         {
            _loc3_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel3.purchase_btn)
         {
            _loc3_ = 3;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel4.purchase_btn)
         {
            _loc3_ = 4;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel5.purchase_btn)
         {
            _loc3_ = 5;
         }
         else if(param1.currentTarget == _loc2_.clip.panels.panel6.purchase_btn)
         {
            _loc3_ = 6;
         }
         if(_loc3_ > -1)
         {
            _loc2_.clip.panels["panel" + _loc3_].confirm.visible = true;
         }
      }
      
      public function confirmPurchase(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Boolean = false;
         var _loc5_:ShopScreen = this;
         var _loc6_:String = null;
         var _loc7_:Number = -1;
         if(param1.currentTarget == _loc5_.clip.panels.panel1.confirm.yes_btn)
         {
            _loc7_ = 1;
         }
         else if(param1.currentTarget == _loc5_.clip.panels.panel2.confirm.yes_btn)
         {
            _loc7_ = 2;
         }
         else if(param1.currentTarget == _loc5_.clip.panels.panel3.confirm.yes_btn)
         {
            _loc7_ = 3;
         }
         else if(param1.currentTarget == _loc5_.clip.panels.panel4.confirm.yes_btn)
         {
            _loc7_ = 4;
         }
         else if(param1.currentTarget == _loc5_.clip.panels.panel5.confirm.yes_btn)
         {
            _loc7_ = 5;
         }
         else if(param1.currentTarget == _loc5_.clip.panels.panel6.confirm.yes_btn)
         {
            _loc7_ = 6;
         }
         if(_loc7_ > -1)
         {
            _loc2_ = _loc5_.panelsPerSet * (_loc5_.whichSet - 1);
            _loc3_ = _loc7_ - 1 + _loc2_;
            _loc6_ = _loc5_.workingArray[_loc3_];
            if(_loc5_.gameObj.var_135.isTintGroup(_loc6_))
            {
               _loc6_ = _loc5_.tintGroupsSelectedTag[_loc7_ - 1];
               class_7.method_1("Was a TINT GROUP - use this tag instead: " + _loc6_);
            }
            _loc4_ = false;
            if(_loc5_.mode == "clothing")
            {
               _loc4_ = _loc5_.gameObj.var_128.purchaseClothing(_loc6_);
            }
            else if(_loc5_.mode == "upgrades")
            {
               _loc4_ = _loc5_.gameObj.var_128.purchaseBonus(_loc6_);
            }
            else
            {
               _loc4_ = _loc5_.gameObj.var_128.purchaseFurniture(_loc6_);
            }
            if(_loc4_)
            {
               _loc5_.lastPurchaseTag = _loc6_;
               _loc5_.gameObj.var_129.playSound("multicoin.wav");
               _loc5_.purchasedToday[_loc3_] = 1;
               _loc5_.tipsPanel.tips_txt.text = _loc5_.gameObj.var_128.getTipsTotal(true);
               _loc5_.populatePanels(true);
            }
            else
            {
               class_7.error("(Error Purchasing)");
            }
         }
      }
      
      public function clickChooseColor(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:ShopScreen = this;
         var _loc5_:String = null;
         var _loc6_:Number = -1;
         if(param1.currentTarget == _loc4_.clip.panels.panel1.pickswatch.color_btn)
         {
            _loc6_ = 1;
         }
         else if(param1.currentTarget == _loc4_.clip.panels.panel2.pickswatch.color_btn)
         {
            _loc6_ = 2;
         }
         else if(param1.currentTarget == _loc4_.clip.panels.panel3.pickswatch.color_btn)
         {
            _loc6_ = 3;
         }
         else if(param1.currentTarget == _loc4_.clip.panels.panel4.pickswatch.color_btn)
         {
            _loc6_ = 4;
         }
         else if(param1.currentTarget == _loc4_.clip.panels.panel5.pickswatch.color_btn)
         {
            _loc6_ = 5;
         }
         else if(param1.currentTarget == _loc4_.clip.panels.panel6.pickswatch.color_btn)
         {
            _loc6_ = 6;
         }
         if(_loc6_ > -1)
         {
            _loc2_ = _loc4_.panelsPerSet * (_loc4_.whichSet - 1);
            _loc3_ = _loc6_ - 1 + _loc2_;
            _loc5_ = _loc4_.workingArray[_loc3_];
            _loc4_.showColorPalette(_loc6_,_loc5_);
         }
      }
      
      public function showColorPalette(param1:Number, param2:String) : void
      {
         var owned:Boolean;
         var startX:Number;
         var startY:Number;
         var spacingX:Number;
         var spacingY:Number;
         var swatchesPerRow:Number;
         var totalswatches:Number;
         var numRows:Number;
         var itemsPerRow:Array;
         var whichPanel:Number = NaN;
         var i:int = 0;
         var swatch:MovieClip = null;
         var half:Number = Number(NaN);
         var third:Number = Number(NaN);
         var remainder:Number = Number(NaN);
         var perRow:Number = Number(NaN);
         var j:int = 0;
         var padX:Number = Number(NaN);
         var padY:Number = Number(NaN);
         var placeX:Number = Number(NaN);
         var placeY:Number = Number(NaN);
         var swatchIndex:Number = Number(NaN);
         var s:int = 0;
         var useSwatch:MovieClip = null;
         whichPanel = param1;
         var whichGroup:String = param2;
         var screen:ShopScreen = this;
         screen.removeColorPalette();
         if(screen.colorPalette == null)
         {
            screen.colorPalette = new shop_palette();
         }
         screen.colorPalette.visible = true;
         try
         {
            screen.clip.panels["panel" + whichPanel].addChild(screen.colorPalette);
         }
         catch(err:Error)
         {
            class_7.error("Error attaching color palette to panel " + whichPanel);
         }
         screen.colorPalettePanel = whichPanel;
         screen.colorPaletteData = screen.gameObj.var_135.getTintVariations(whichGroup);
         owned = false;
         if(screen.colorSwatches == null)
         {
            screen.colorSwatches = new Vector.<MovieClip>();
         }
         else if(screen.colorSwatches.length > 0)
         {
            class_7.error("There\'s already " + screen.colorSwatches.length + " items in the color swatch vector???");
         }
         i = 0;
         while(i < screen.colorPaletteData.length)
         {
            swatch = new shop_colorswatch();
            swatch.bg.transform.colorTransform = screen.createColorTransform(screen.colorPaletteData[i][1]);
            swatch.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickColorPaletteSwatch);
            swatch.addEventListener(MouseEvent.ROLL_OVER,screen.rolloverColorPaletteSwatch);
            swatch.addEventListener(MouseEvent.ROLL_OUT,screen.rolloutColorPaletteSwatch);
            swatch.mouseEnabled = true;
            swatch.buttonMode = true;
            swatch.useHandCursor = true;
            swatch.gotoAndStop(1);
            swatch.owned.mouseEnabled = false;
            swatch.owned.mouseChildren = false;
            screen.colorSwatches.push(swatch);
            owned = screen.gameObj.var_128.alreadyOwnsClothing(screen.colorPaletteData[i][0]);
            if(owned)
            {
               swatch.owned.visible = true;
            }
            else
            {
               swatch.owned.visible = false;
            }
            i++;
         }
         startX = 6;
         startY = 7;
         spacingX = 50;
         spacingY = 29;
         swatchesPerRow = 6;
         totalswatches = screen.colorSwatches.length;
         numRows = 0;
         itemsPerRow = [];
         if(totalswatches > 2 * swatchesPerRow)
         {
            numRows = 3;
         }
         else if(totalswatches > swatchesPerRow)
         {
            numRows = 2;
         }
         else
         {
            numRows = 1;
         }
         if(numRows == 1)
         {
            itemsPerRow[0] = totalswatches;
         }
         else if(numRows == 2)
         {
            half = Math.floor(totalswatches / 2);
            itemsPerRow[0] = Math.max(half,totalswatches - half);
            itemsPerRow[1] = Math.min(half,totalswatches - half);
         }
         else if(numRows == 3)
         {
            third = Math.floor(totalswatches / 3);
            remainder = totalswatches - third * 3;
            if(remainder == 1)
            {
               itemsPerRow[0] = third;
               itemsPerRow[1] = third + 1;
               itemsPerRow[2] = third;
            }
            else if(remainder == 2)
            {
               itemsPerRow[0] = third + 1;
               itemsPerRow[1] = third + 1;
               itemsPerRow[2] = third;
            }
            else
            {
               itemsPerRow[0] = third;
               itemsPerRow[1] = third;
               itemsPerRow[2] = third;
            }
         }
         i = 0;
         while(i < numRows)
         {
            perRow = Number(itemsPerRow[i]);
            j = 0;
            while(j < perRow)
            {
               padX = (swatchesPerRow * spacingX - perRow * spacingX) / 2;
               padY = (3 * spacingY - itemsPerRow.length * spacingY) / 2;
               if(numRows <= 2)
               {
                  padY += 8;
               }
               placeX = startX + padX + j * spacingX;
               placeY = startY + padY + i * spacingY;
               swatchIndex = 0;
               s = 0;
               while(s < numRows)
               {
                  if(i > s)
                  {
                     swatchIndex += itemsPerRow[s];
                  }
                  else if(i == s)
                  {
                     swatchIndex += j;
                  }
                  s++;
               }
               if(screen.colorSwatches.length > swatchIndex)
               {
                  useSwatch = screen.colorSwatches[swatchIndex];
                  useSwatch.x = placeX;
                  useSwatch.y = placeY;
                  screen.colorPalette.addChild(useSwatch);
               }
               else
               {
                  class_7.error("Tried to place swatch " + swatchIndex + ", only " + screen.colorSwatches.length + " exist!");
               }
               j++;
            }
            i++;
         }
         if(numRows < 3)
         {
            screen.colorPalette.label.visible = true;
         }
         else
         {
            screen.colorPalette.label.visible = false;
         }
      }
      
      public function removeColorPalette() : void
      {
         var screen:ShopScreen = null;
         var i:int = 0;
         screen = null;
         i = 0;
         screen = this;
         if(screen.colorPalette != null)
         {
            if(screen.colorSwatches != null && screen.colorSwatches.length > 0)
            {
               i = screen.colorSwatches.length - 1;
               while(i >= 0)
               {
                  screen.colorSwatches[i].removeEventListener(MouseEvent.MOUSE_DOWN,screen.clickColorPaletteSwatch);
                  screen.colorSwatches[i].removeEventListener(MouseEvent.ROLL_OVER,screen.rolloverColorPaletteSwatch);
                  screen.colorSwatches[i].removeEventListener(MouseEvent.ROLL_OUT,screen.rolloutColorPaletteSwatch);
                  try
                  {
                     if(screen.colorSwatches[i].parent)
                     {
                        screen.colorSwatches[i].parent.removeChild(screen.colorSwatches[i]);
                     }
                  }
                  catch(err:Error)
                  {
                     class_7.error(" ------ ERROR REMOVING A COLOR SWATCH: " + i + " --- " + err.message + " Clip: " + screen.colorSwatches[i]);
                     if(screen.colorSwatches[i] != null)
                     {
                        class_7.error(" ---- >> Parent? :" + screen.colorSwatches[i].parent);
                     }
                  }
                  screen.colorSwatches[i] = null;
                  screen.colorSwatches.splice(i,1);
                  i--;
               }
            }
            if(screen.colorPalette.parent)
            {
               screen.colorPalette.parent.removeChild(screen.colorPalette);
            }
         }
      }
      
      public function clickColorPaletteSwatch(param1:MouseEvent) : void
      {
         var whichTag:String = null;
         var tintClothing:ClothingItem = null;
         var mypanel:MovieClip = null;
         var e:MouseEvent = param1;
         var screen:ShopScreen = this;
         var idx:Number = screen.colorSwatches.indexOf(MovieClip(e.currentTarget));
         var data:UserData = screen.gameObj.var_128;
         if(idx < screen.colorPaletteData.length)
         {
            whichTag = screen.colorPaletteData[idx][0];
            tintClothing = screen.gameObj.var_135.getItemFromSKU(whichTag);
            screen.tintGroupsSelectedTag[screen.colorPalettePanel - 1] = tintClothing.tag;
            mypanel = screen.clip.panels["panel" + screen.colorPalettePanel];
            mypanel.title_txt.text = "  " + tintClothing.title;
            mypanel.info_txt.text = "";
            mypanel.pointpanel.theme.gotoAndStop(screen.gameObj.var_135.getClothingThemeFrame(tintClothing.tag));
            mypanel.price_txt.text = class_13.method_127(tintClothing.price);
            if(tintClothing.price <= data.getTipsTotal())
            {
               mypanel.purchase_btn.visible = true;
               mypanel.needmoretips_btn.visible = false;
            }
            else
            {
               mypanel.purchase_btn.visible = false;
               mypanel.needmoretips_btn.visible = true;
            }
            try
            {
               if(mypanel.thumb.numChildren > 0)
               {
                  mypanel.thumb.removeChildAt(0);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error removing thumb.");
            }
            mypanel.thumb.addChild(screen.gameObj.var_135.generateClothingThumb(tintClothing.tag,screen.gameObj.workerData.gender));
            mypanel.confirm.visible = false;
            mypanel.cover.visible = false;
            if(screen.gameObj.var_128.alreadyOwnsClothing(tintClothing.tag))
            {
               mypanel.purchase_btn.visible = false;
               mypanel.needmoretips_btn.visible = false;
               mypanel.purchasedbg.visible = true;
               mypanel.alreadyown.visible = true;
               mypanel.pickswatch.owned.visible = true;
            }
            else
            {
               mypanel.purchasedbg.visible = false;
               mypanel.alreadyown.visible = false;
               mypanel.pickswatch.owned.visible = false;
            }
            mypanel.pickswatch.visible = true;
            mypanel.pickswatch.color_swatch.transform.colorTransform = screen.createColorTransform(tintClothing.tintPreviewColor);
         }
         screen.colorPalette.visible = false;
      }
      
      public function rolloverColorPaletteSwatch(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      public function rolloutColorPaletteSwatch(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      public function updateDropdowns() : void
      {
         var _loc1_:ShopScreen = this;
         if(_loc1_.mode == "upgrades")
         {
            _loc1_.clip.dropdownlabels.visible = false;
            _loc1_.clip.show_dropdown.visible = false;
            _loc1_.clip.theme_dropdown.visible = false;
         }
         else
         {
            _loc1_.clip.dropdownlabels.visible = true;
            _loc1_.clip.show_dropdown.visible = true;
            _loc1_.clip.theme_dropdown.visible = true;
            _loc1_.clip.show_dropdown.theme.visible = false;
            _loc1_.clip.show_dropdown.label_txt.text = _loc1_.getDropdownLabel(_loc1_.filterShowType);
            _loc1_.clip.theme_dropdown.theme.visible = true;
            _loc1_.clip.theme_dropdown.label_txt.text = _loc1_.getDropdownLabel(_loc1_.filterThemeMonth);
            if(_loc1_.filterThemeMonth == 0 || _loc1_.filterThemeMonth == -1)
            {
               _loc1_.clip.theme_dropdown.theme.gotoAndStop(13);
            }
            else
            {
               _loc1_.clip.theme_dropdown.theme.gotoAndStop(_loc1_.filterThemeMonth);
               _loc1_.clip.theme_dropdown.label_txt.text = "   " + _loc1_.clip.theme_dropdown.label_txt.text;
            }
         }
      }
      
      public function getDropdownLabel(param1:*) : String
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:ShopScreen = this;
         var _loc4_:String = "???";
         switch(param1)
         {
            case -1:
               _loc4_ = "Any Theme";
               break;
            case 0:
               _loc4_ = "No Theme";
               break;
            default:
               if(param1 === 1 || param1 === 2 || param1 === 3 || param1 === 4 || param1 === 5 || param1 === 6 || param1 === 7 || param1 === 8 || param1 === 9 || param1 === 10 || param1 === 11 || param1 === 12)
               {
                  _loc4_ = _loc3_.gameObj.var_133.getHolidayName(param1);
                  break;
               }
               _loc2_ = _loc3_.filterShowTypes.indexOf(param1);
               if(_loc2_ > -1)
               {
                  _loc4_ = _loc3_.filterShowTypeLabels[_loc2_];
               }
         }
         return _loc4_;
      }
      
      public function showDropdown(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:ShopScreen = this;
         _loc3_.removeDropdown();
         _loc3_.dropdownClip = new shop_dropdown_popup();
         if(param1 == "show")
         {
            _loc3_.dropdownClip.label_txt.text = _loc3_.getDropdownLabel(_loc3_.filterShowType);
            _loc3_.dropdownClip.theme.visible = false;
         }
         else if(param1 == "theme")
         {
            _loc3_.dropdownClip.label_txt.text = _loc3_.getDropdownLabel(_loc3_.filterThemeMonth);
            if(_loc3_.filterThemeMonth == 0 || _loc3_.filterThemeMonth == -1)
            {
               _loc3_.dropdownClip.theme.gotoAndStop(13);
            }
            else
            {
               _loc3_.dropdownClip.theme.gotoAndStop(_loc3_.filterThemeMonth);
               _loc3_.dropdownClip.label_txt.text = "   " + _loc3_.dropdownClip.label_txt.text;
            }
         }
         var _loc4_:Array = null;
         if(param1 == "theme")
         {
            _loc4_ = [-1,1,2,3,4,5,6,7,8,9,10,11,12,0];
         }
         else if(param1 == "show")
         {
            if(_loc3_.mode == "clothing")
            {
               _loc4_ = ["all",ClothingItem.TYPE_SHIRT,ClothingItem.TYPE_PANTS,ClothingItem.TYPE_JACKET,ClothingItem.TYPE_SHOES,ClothingItem.TYPE_HAT,ClothingItem.TYPE_ACC_BODY,ClothingItem.TYPE_ACC_BELT,ClothingItem.TYPE_ACC_ARMS,ClothingItem.TYPE_ACC_FACE];
            }
            else if(_loc3_.mode == "wallfloor")
            {
               _loc4_ = ["notowned"];
            }
            else
            {
               _loc4_ = ["all","notowned","owned"];
            }
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = new shop_dropdown_panel();
            _loc2_.buttonMode = true;
            _loc2_.mouseEnabled = true;
            _loc2_.mouseChildren = false;
            if(_loc5_ % 2 == 0)
            {
               _loc2_.gotoAndStop(2);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
            _loc2_.y = 27.5 + _loc5_ * 25;
            if(param1 == "show")
            {
               _loc2_.label_txt.text = _loc3_.getDropdownLabel(_loc4_[_loc5_]);
               _loc2_.theme.visible = false;
            }
            else if(param1 == "theme")
            {
               _loc2_.label_txt.text = _loc3_.getDropdownLabel(_loc4_[_loc5_]);
               if(_loc4_[_loc5_] == 0 || _loc4_[_loc5_] == -1)
               {
                  _loc2_.theme.gotoAndStop(13);
               }
               else
               {
                  _loc2_.theme.gotoAndStop(_loc4_[_loc5_]);
                  _loc2_.label_txt.text = "   " + _loc2_.label_txt.text;
               }
            }
            _loc2_.whichType = _loc4_[_loc5_];
            if(param1 == "show" && _loc4_[_loc5_] == _loc3_.filterShowType)
            {
               _loc2_.arrow.visible = true;
            }
            else if(param1 == "theme" && _loc4_[_loc5_] == _loc3_.filterThemeMonth)
            {
               _loc2_.arrow.visible = true;
            }
            else
            {
               _loc2_.arrow.visible = false;
            }
            _loc2_.hiliter.visible = false;
            _loc2_.hiliter.gotoAndStop(1);
            _loc2_.addEventListener(MouseEvent.MOUSE_UP,_loc3_.chooseDropdownOption);
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,_loc3_.rolloverDropdownOption);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,_loc3_.rolloutDropdownOption);
            _loc3_.dropdownClip.addChild(_loc2_);
            _loc3_.dropdownParts.push(_loc2_);
            _loc5_++;
         }
         _loc3_.dropdownClip.bottomcap.y = _loc3_.dropdownParts[_loc3_.dropdownParts.length - 1].y + _loc3_.dropdownParts[_loc3_.dropdownParts.length - 1].height;
         if(_loc4_.length % 2 == 0)
         {
            _loc3_.dropdownClip.bottomcap.gotoAndStop(1);
         }
         else
         {
            _loc3_.dropdownClip.bottomcap.gotoAndStop(2);
         }
         if(param1 == "show")
         {
            _loc3_.dropdownClip.x = _loc3_.clip.show_dropdown.x;
            _loc3_.dropdownClip.y = _loc3_.clip.show_dropdown.y;
         }
         else
         {
            _loc3_.dropdownClip.x = _loc3_.clip.theme_dropdown.x;
            _loc3_.dropdownClip.y = _loc3_.clip.theme_dropdown.y;
         }
         _loc3_.gameObj.addChild(_loc3_.dropdownClip);
         _loc3_.dropdownClip.cover.x = 0 - _loc3_.dropdownClip.x;
         _loc3_.dropdownClip.cover.y = 0 - _loc3_.dropdownClip.y;
         _loc3_.dropdownClip.cover.addEventListener(MouseEvent.MOUSE_UP,_loc3_.removeDropdown);
         _loc3_.isShowingDropdown = true;
         _loc3_.dropdownClipType = param1;
      }
      
      public function removeDropdown(param1:Event = null) : void
      {
         var _loc2_:* = 0;
         var _loc3_:ShopScreen = this;
         _loc3_.isShowingDropdown = false;
         _loc3_.dropdownClipType = "none";
         if(_loc3_.dropdownClip)
         {
            _loc3_.dropdownClip.cover.removeEventListener(MouseEvent.MOUSE_UP,_loc3_.removeDropdown);
            if(_loc3_.dropdownClip.parent)
            {
               _loc3_.dropdownClip.parent.removeChild(_loc3_.dropdownClip);
            }
         }
         if(Boolean(_loc3_.dropdownParts) && _loc3_.dropdownParts.length > 0)
         {
            _loc2_ = int(_loc3_.dropdownParts.length - 1);
            while(_loc2_ >= 0)
            {
               _loc3_.dropdownParts[_loc2_].removeEventListener(MouseEvent.MOUSE_UP,_loc3_.chooseDropdownOption);
               _loc3_.dropdownParts[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,_loc3_.rolloverDropdownOption);
               _loc3_.dropdownParts[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,_loc3_.rolloutDropdownOption);
               if(_loc3_.dropdownParts[_loc2_].parent)
               {
                  _loc3_.dropdownParts[_loc2_].parent.removeChild(_loc3_.dropdownParts[_loc2_]);
               }
               _loc3_.dropdownParts[_loc2_] = null;
               _loc3_.dropdownParts.splice(_loc2_,1);
               _loc2_--;
            }
            _loc3_.dropdownParts = null;
            _loc3_.dropdownParts = [];
         }
         _loc3_.dropdownClip = null;
      }
      
      public function chooseDropdownOption(param1:MouseEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:ShopScreen = this;
         var _loc3_:Boolean = false;
         _loc4_ = MovieClip(param1.currentTarget);
         var _loc5_:* = _loc4_.whichType;
         if(_loc2_.dropdownClipType == "show")
         {
            if(_loc2_.filterShowType != _loc5_)
            {
               _loc3_ = true;
            }
            _loc2_.filterShowType = _loc5_;
         }
         else if(_loc2_.dropdownClipType == "theme")
         {
            if(_loc2_.filterThemeMonth != _loc5_)
            {
               _loc3_ = true;
            }
            _loc2_.filterThemeMonth = _loc5_;
         }
         if(_loc3_)
         {
            _loc2_.selectMode(_loc2_.mode,false,false);
         }
         _loc2_.removeDropdown();
      }
      
      public function rolloverDropdownOption(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         var _loc3_:String = MovieClip(param1.currentTarget).whichType;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.dropdownParts.length)
         {
            if(_loc2_.dropdownParts[_loc4_].whichType == _loc3_)
            {
               _loc2_.dropdownParts[_loc4_].hiliter.visible = true;
               _loc2_.dropdownParts[_loc4_].hiliter.gotoAndPlay(1);
            }
            else
            {
               _loc2_.dropdownParts[_loc4_].hiliter.visible = false;
               _loc2_.dropdownParts[_loc4_].hiliter.gotoAndStop(1);
            }
            _loc4_++;
         }
      }
      
      public function rolloutDropdownOption(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).hiliter.visible = false;
         MovieClip(param1.currentTarget).hiliter.gotoAndStop(1);
      }
      
      public function clickOpenShowDropdown(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         if(!_loc2_.isShowingDropdown || _loc2_.dropdownClipType != "show")
         {
            _loc2_.showDropdown("show");
         }
      }
      
      public function clickOpenThemeDropdown(param1:MouseEvent) : void
      {
         var _loc2_:ShopScreen = this;
         if(!_loc2_.isShowingDropdown || _loc2_.dropdownClipType != "theme")
         {
            _loc2_.showDropdown("theme");
         }
      }
   }
}

