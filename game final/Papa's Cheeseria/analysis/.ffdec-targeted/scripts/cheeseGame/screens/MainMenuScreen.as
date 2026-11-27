package cheeseGame.screens
{
   import cheeseGame.data.CustomerData;
   import cheeseGame.data.GameData;
   import cheeseGame.data.UserData;
   import cheeseGame.managers.ChallengeManager;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_1.*;
   import package_2.*;
   import package_3.*;
   import package_4.class_5;
   
   public class MainMenuScreen
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      private var params:Object;
      
      private var confirmYesButton:class_18;
      
      private var confirmNoButton:class_18;
      
      public var currentSection:String = "";
      
      public var customerThumbClips:Array;
      
      public var customerThumbBitmaps:Array;
      
      public var customerThumbBMP:Array;
      
      public var currentCustomer:Number = 1;
      
      public var currentCustomerPage:Number = 1;
      
      public var totalCustomerPages:Number = 1;
      
      public var customerTweenSpeed:Number = 4;
      
      public var customerStartX:Number = 155;
      
      public var customerClip:MovieClip;
      
      public var backdropBitmap:Bitmap;
      
      private var medalsPage:Number = 0;
      
      private var medalsPerPage:Number = 10;
      
      private var medalsDirection:String = "next";
      
      private var medalsTransitioning:Boolean = true;
      
      private var helpIndex:Number = -1;
      
      private var helpScrollStart:Number = 30;
      
      private var helpScrollRange:Number = 253;
      
      private var helpTabScrollDir:Number = 0;
      
      private var helpMainScrollDir:Number = 0;
      
      private var papalouieLink:String = "http://www.flipline.com/games/papalouie/";
      
      private var pizzeriaLink:String = "http://www.flipline.com/games/papaspizzeria/";
      
      private var burgeriaLink:String = "http://www.flipline.com/games/papasburgeria/";
      
      private var tacomiaLink:String = "http://www.flipline.com/games/papastacomia/";
      
      private var freezeriaLink:String = "http://www.flipline.com/games/papasfreezeria/";
      
      private var pancakeriaLink:String = "http://www.flipline.com/games/papaspancakeria/";
      
      private var wingeriaLink:String = "http://www.flipline.com/games/papaswingeria/";
      
      private var hotdoggeriaLink:String = "http://www.flipline.com/games/papashotdoggeria/";
      
      private var cupcakeriaLink:String = "http://www.flipline.com/games/papascupcakeria/";
      
      private var pastariaLink:String = "http://www.flipline.com/games/papaspastaria/";
      
      private var donuteriaLink:String = "http://www.flipline.com/games/papasdonuteria/";
      
      private var papalouie3Link:String = "http://www.flipline.com/games/papalouie3/";
      
      private var useWhichLink:String = "";
      
      private var useWhichFlipdeckLink:String = "";
      
      private var shouldShowPlayNow:Boolean = false;
      
      private var playnowPadX:Number = 10;
      
      public var cookbook:CookbookScreen;
      
      public var editor:CharacterEditorScreen;
      
      public var didSetupOutroButton:Boolean = false;
      
      public var outroButton:SimpleButton = null;
      
      public function MainMenuScreen(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         this.customerThumbClips = [];
         this.customerThumbBitmaps = [];
         this.customerThumbBMP = [];
         super();
         this.gameObj = param1;
         this.container = param2;
         this.params = param3;
         this.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:MainMenuScreen = this;
         _loc1_.clip = new mainmenuMC();
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.container.addEventListener("clickInfo",_loc1_.clickInfo);
         _loc1_.container.addEventListener("clickCustomers",_loc1_.clickCustomers);
         _loc1_.container.addEventListener("clickMedals",_loc1_.clickMedals);
         _loc1_.container.addEventListener("clickCookbook",_loc1_.clickCookbook);
         _loc1_.container.addEventListener("clickCredits",_loc1_.clickCredits);
         _loc1_.container.addEventListener("clickHelp",_loc1_.clickHelp);
         _loc1_.container.addEventListener("clickBackToGame",_loc1_.clickBackToGame);
         _loc1_.container.addEventListener("clickQuit",_loc1_.clickQuit);
         _loc1_.container.addEventListener("clickBackToSplash",_loc1_.clickBackToSplash);
         _loc1_.container.addEventListener("clickContinueSpecial",_loc1_.clickContinueSpecial);
         _loc1_.setupInfo();
         _loc1_.setupCustomers();
         _loc1_.setupMedals();
         _loc1_.setupCookbook();
         _loc1_.setupHelp();
         _loc1_.setupCredits();
         _loc1_.setupConfirmQuit();
         _loc1_.clip.outro_btn.visible = false;
         if(Boolean(_loc1_.params) && Boolean(_loc1_.params.hasOwnProperty("useSection")))
         {
            _loc1_.setSection(_loc1_.params.useSection);
         }
         else
         {
            _loc1_.setSection("info");
            _loc1_.gameObj.var_129.switchMusic("none");
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.delayOutroButton);
         }
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.adjustMenuIcons);
      }
      
      public function clickInfo(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.setSection("info");
      }
      
      public function clickCustomers(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.setSection("customers");
      }
      
      public function clickMedals(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.setSection("medals");
      }
      
      public function clickHelp(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.setSection("help");
      }
      
      public function clickCredits(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.setSection("credits");
      }
      
      public function clickCookbook(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.setSection("cookbook");
      }
      
      public function clickBackToGame(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.closeMainMenuScreen();
      }
      
      public function clickBackToSplash(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.closeMainMenuScreen(true);
      }
      
      public function clickContinueSpecial(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.method_122();
         _loc2_.closeMainMenuScreen();
      }
      
      public function clickQuit(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.clip.confirmquit.visible = true;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.api.disableButtons();
      }
      
      public function clickConfirmQuit(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.clip.confirmquit.visible = false;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.closeMainMenuScreen(true);
      }
      
      public function clickCancelQuit(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.clip.confirmquit.visible = false;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.api.enableButtons();
      }
      
      public function setSection(param1:String) : void
      {
         var _loc2_:MainMenuScreen = this;
         if(param1 != _loc2_.currentSection)
         {
            _loc2_.currentSection = param1;
            _loc2_.clip.info.visible = false;
            _loc2_.clip.customers.visible = false;
            _loc2_.clip.credits.visible = false;
            _loc2_.clip.help.visible = false;
            _loc2_.clip.medals.visible = false;
            _loc2_.clip.cookbook.visible = false;
            if(_loc2_.currentSection != "" && _loc2_.currentSection != "none")
            {
               _loc2_.clip[_loc2_.currentSection].visible = true;
            }
            _loc2_.gameObj.var_132.api.method_134(_loc2_.getSectionTitle());
            _loc2_.clip.fader.gotoAndPlay("fadein");
            if(param1 == "badges")
            {
               if(!_loc2_.gameObj.var_128.hasVisitedBadgesScreen)
               {
                  _loc2_.gameObj.var_128.hasVisitedBadgesScreen = true;
               }
            }
         }
      }
      
      public function setupInfo(param1:Boolean = true) : void
      {
         var _loc2_:Object = null;
         var _loc3_:MainMenuScreen = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:GameData = _loc3_.gameObj.var_133;
         if(param1)
         {
            _loc2_ = {};
            _loc2_.inMenu = true;
            _loc3_.editor = new CharacterEditorScreen(_loc3_.gameObj,_loc3_.clip.info,_loc2_);
         }
         else
         {
            _loc3_.editor.destroy();
            _loc3_.editor = null;
         }
      }
      
      public function setupCookbook(param1:Boolean = true) : void
      {
         var _loc2_:Object = null;
         var _loc3_:MainMenuScreen = this;
         if(param1)
         {
            _loc2_ = {};
            _loc2_.inMenu = true;
            _loc3_.cookbook = new CookbookScreen(_loc3_.gameObj,_loc3_.clip.cookbook,_loc2_);
         }
         else
         {
            _loc3_.cookbook.destroy();
            _loc3_.cookbook = null;
         }
      }
      
      public function setupCustomers(param1:Boolean = true) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:String = null;
         var _loc9_:BitmapData = null;
         var _loc10_:Boolean = false;
         var _loc11_:Bitmap = null;
         var _loc12_:MovieClip = null;
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:MainMenuScreen = this;
         var _loc19_:UserData = _loc18_.gameObj.var_128;
         var _loc20_:CustomerData = _loc18_.gameObj.var_130;
         if(param1)
         {
            if(!class_3.method_60())
            {
               _loc18_.shouldShowPlayNow = true;
            }
            _loc18_.clip.customers.playnow_btn.visible = false;
            _loc18_.clip.customers.flipdeck_btn.visible = false;
            _loc18_.clip.customers.flipdeck_label.visible = false;
            _loc18_.clip.customers.flipdeck_txt.text = "";
            _loc3_ = 8;
            _loc4_ = 2;
            _loc5_ = 41;
            _loc6_ = 55;
            _loc7_ = 0;
            _loc18_.customerThumbBitmaps = [];
            _loc18_.customerThumbBMP = [];
            _loc18_.customerThumbClips = [];
            _loc18_.totalCustomerPages = Math.ceil((_loc19_.customersUnlocked.length - 1) / (_loc3_ * _loc4_));
            _loc2_ = 1;
            while(_loc2_ < _loc19_.customersUnlocked.length)
            {
               _loc8_ = _loc20_.getCustomerClipName(_loc2_);
               _loc10_ = true;
               if(_loc19_.customersUnlocked[_loc2_] == 0 || _loc19_.customerVisits[_loc2_] == 0)
               {
                  _loc10_ = false;
               }
               _loc9_ = _loc18_.gameObj.var_130.getCustomerBitmap(_loc2_,!_loc10_);
               _loc11_ = new Bitmap(_loc9_,"never",true);
               _loc12_ = new menu_customer_thumb();
               _loc12_.inside.addChild(_loc11_);
               _loc12_.whichCustomer = _loc2_;
               if(_loc19_.customerSeals[_loc2_] > 0)
               {
                  _loc12_.star.visible = true;
                  _loc12_.star.gotoAndStop(_loc19_.customerSeals[_loc2_]);
               }
               else
               {
                  _loc12_.star.visible = false;
               }
               _loc12_.btn.addEventListener(MouseEvent.CLICK,_loc18_.clickCustomerThumb);
               if(!_loc10_)
               {
                  _loc12_.btn.visible = false;
               }
               else
               {
                  _loc7_++;
               }
               _loc12_.bg.gotoAndStop(_loc18_.gameObj.var_130.getCustomerColor(_loc2_));
               if(!_loc10_)
               {
                  _loc12_.bg.gotoAndStop("disabled");
               }
               if(_loc10_)
               {
                  _loc18_.customerThumbClips.unshift(_loc12_);
                  _loc18_.customerThumbBitmaps.unshift(_loc11_);
                  _loc18_.customerThumbBMP.unshift(_loc9_);
               }
               else
               {
                  _loc18_.customerThumbClips.push(_loc12_);
                  _loc18_.customerThumbBitmaps.push(_loc11_);
                  _loc18_.customerThumbBMP.push(_loc9_);
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc18_.customerThumbClips.length)
            {
               _loc13_ = _loc2_ % _loc3_ * _loc5_;
               _loc14_ = _loc2_ % (_loc3_ * _loc4_);
               _loc15_ = 0;
               if(_loc14_ >= _loc3_)
               {
                  _loc15_ = _loc6_;
               }
               _loc16_ = Math.floor(_loc2_ / (_loc3_ * _loc4_)) * (_loc5_ * _loc3_);
               _loc18_.customerThumbClips[_loc2_].x = _loc13_ + _loc16_;
               _loc18_.customerThumbClips[_loc2_].y = _loc15_;
               _loc18_.clip.customers.thumbholder.addChild(_loc18_.customerThumbClips[_loc2_]);
               _loc2_++;
            }
            _loc18_.clip.customers.right_btn.addEventListener(MouseEvent.CLICK,_loc18_.clickCustomerNext);
            _loc18_.clip.customers.left_btn.addEventListener(MouseEvent.CLICK,_loc18_.clickCustomerPrev);
            _loc18_.clip.customers.left_btn.visible = false;
            _loc18_.clip.customers.playnow_btn.addEventListener(MouseEvent.CLICK,_loc18_.clickCustomerPlayGame);
            _loc18_.clip.customers.flipdeck_btn.addEventListener(MouseEvent.CLICK,_loc18_.clickCustomerFlipdeck);
            _loc18_.clip.customers.holder.mask = _loc18_.clip.customers.masker;
            _loc18_.clip.customers.masker.visible = false;
            _loc18_.clip.customers.topfader.mouseEnabled = false;
            if(_loc7_ == 0)
            {
               _loc18_.showCustomerDetails(9);
            }
            else
            {
               _loc18_.showCustomerDetails(_loc18_.customerThumbClips[0].whichCustomer);
            }
         }
         else
         {
            _loc18_.destroyPreviousPhoto();
            _loc17_ = _loc18_.customerThumbClips.length;
            _loc2_ = 0;
            while(_loc2_ < _loc17_)
            {
               _loc18_.customerThumbClips[_loc2_].btn.removeEventListener(MouseEvent.CLICK,_loc18_.clickCustomerThumb);
               _loc18_.clip.customers.thumbholder.removeChild(_loc18_.customerThumbClips[_loc2_]);
               _loc18_.customerThumbClips[_loc2_].inside.removeChild(_loc18_.customerThumbBitmaps[_loc2_]);
               _loc18_.customerThumbClips[_loc2_] = null;
               _loc18_.customerThumbBitmaps[_loc2_] = null;
               _loc18_.customerThumbBMP[_loc2_].dispose();
               _loc18_.customerThumbBMP[_loc2_] = null;
               _loc2_++;
            }
            _loc18_.customerThumbBitmaps = null;
            _loc18_.customerThumbBMP = null;
            _loc18_.customerThumbClips = null;
            _loc18_.clip.customers.right_btn.removeEventListener(MouseEvent.CLICK,_loc18_.clickCustomerNext);
            _loc18_.clip.customers.left_btn.removeEventListener(MouseEvent.CLICK,_loc18_.clickCustomerPrev);
            _loc18_.clip.customers.playnow_btn.removeEventListener(MouseEvent.CLICK,_loc18_.clickCustomerPlayGame);
            _loc18_.clip.customers.flipdeck_btn.removeEventListener(MouseEvent.CLICK,_loc18_.clickCustomerFlipdeck);
            try
            {
               _loc18_.clip.customers.removeEventListener(Event.ENTER_FRAME,_loc18_.animateCustomerPanel);
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function clickCustomerThumb(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         var _loc3_:Number = Number(param1.currentTarget.parent.whichCustomer);
         _loc2_.showCustomerDetails(_loc3_);
      }
      
      public function clickCustomerPlayGame(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         if(_loc2_.useWhichLink != "")
         {
            _loc2_.gameObj.var_132.api.method_107(_loc2_.useWhichLink);
         }
      }
      
      public function clickCustomerFlipdeck(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         if(_loc2_.useWhichFlipdeckLink != "")
         {
            _loc2_.gameObj.var_132.api.method_107(_loc2_.useWhichFlipdeckLink);
         }
      }
      
      public function showCustomerDetails(param1:Number) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:String = null;
         var _loc4_:MainMenuScreen = this;
         var _loc5_:UserData = _loc4_.gameObj.var_128;
         var _loc6_:CustomerData = _loc4_.gameObj.var_130;
         _loc4_.clip.customers.name_txt.text = _loc6_.getCustomerName(param1);
         _loc4_.clip.customers.firstvisit_txt.text = "Day " + _loc5_.getCustomerFirstDay(param1);
         _loc4_.clip.customers.orders_txt.text = _loc5_.getCustomerTotalOrders(param1);
         _loc4_.clip.customers.firstgame_txt.text = _loc6_.getCustomerFirstGame(param1);
         _loc4_.clip.customers.favorites_txt.text = _loc6_.getCustomerToppingString(param1);
         _loc4_.clip.customers.holiday.gotoAndStop(_loc6_.getCustomerFavoriteHoliday(param1));
         if(_loc4_.shouldShowPlayNow)
         {
            _loc4_.clip.customers.playnow_btn.visible = true;
            _loc4_.clip.customers.playnow_btn.x = _loc4_.clip.customers.firstgame_txt.x + _loc4_.clip.customers.firstgame_txt.textWidth + _loc4_.playnowPadX;
            if(_loc6_.getCustomerFirstGame(param1) == "Papa Louie")
            {
               _loc4_.useWhichLink = _loc4_.papalouieLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Pizzeria")
            {
               _loc4_.useWhichLink = _loc4_.pizzeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Burgeria")
            {
               _loc4_.useWhichLink = _loc4_.burgeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Taco Mia!")
            {
               _loc4_.useWhichLink = _loc4_.tacomiaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Freezeria")
            {
               _loc4_.useWhichLink = _loc4_.freezeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Pancakeria")
            {
               _loc4_.useWhichLink = _loc4_.pancakeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Wingeria")
            {
               _loc4_.useWhichLink = _loc4_.wingeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Hot Doggeria")
            {
               _loc4_.useWhichLink = _loc4_.hotdoggeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Cupcakeria")
            {
               _loc4_.useWhichLink = _loc4_.cupcakeriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Pastaria")
            {
               _loc4_.useWhichLink = _loc4_.pastariaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa\'s Donuteria")
            {
               _loc4_.useWhichLink = _loc4_.donuteriaLink;
            }
            else if(_loc6_.getCustomerFirstGame(param1) == "Papa Louie 3")
            {
               _loc4_.useWhichLink = _loc4_.papalouie3Link;
            }
            else
            {
               _loc4_.useWhichLink = "";
               _loc4_.clip.customers.playnow_btn.visible = false;
            }
         }
         else
         {
            _loc4_.clip.customers.playnow_btn.visible = false;
         }
         if(_loc6_.getCustomerFlipdeckNumber(param1) == 0)
         {
            _loc4_.clip.customers.flipdeck_label.visible = false;
            _loc4_.clip.customers.flipdeck_txt.text = "";
            _loc4_.clip.customers.flipdeck_btn.visible = false;
         }
         else
         {
            _loc3_ = String(_loc6_.getCustomerFlipdeckNumber(param1));
            if(_loc3_.length == 1)
            {
               _loc3_ = "0" + _loc3_;
            }
            _loc4_.clip.customers.flipdeck_label.visible = true;
            _loc4_.clip.customers.flipdeck_txt.text = _loc3_;
            if(_loc4_.shouldShowPlayNow)
            {
               _loc4_.clip.customers.flipdeck_btn.visible = true;
               _loc4_.useWhichFlipdeckLink = "http://www.flipline.com/flipdeck/" + _loc3_;
            }
            else
            {
               _loc4_.clip.customers.flipdeck_btn.visible = false;
               _loc4_.useWhichFlipdeckLink = "";
            }
         }
         var _loc7_:Number = _loc5_.getCustomerSeal(param1);
         var _loc8_:Number = _loc5_.getCustomerStars(param1);
         if(_loc7_ > 0)
         {
            _loc4_.clip.customers.sealMC.visible = true;
            _loc4_.clip.customers.sealMC.gotoAndStop(_loc7_);
         }
         else
         {
            _loc4_.clip.customers.sealMC.visible = false;
         }
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            if(_loc8_ >= _loc2_)
            {
               _loc4_.clip.customers["star_" + _loc2_].gotoAndStop(2);
            }
            else
            {
               _loc4_.clip.customers["star_" + _loc2_].gotoAndStop(1);
            }
            _loc2_++;
         }
         _loc4_.buildCustomerPhoto(param1,_loc7_);
         if(_loc6_.isCloser(param1))
         {
            if(param1 == 1)
            {
               _loc4_.clip.customers.typelabel.visible = true;
               _loc4_.clip.customers.typelabel.gotoAndStop(2);
            }
            else
            {
               _loc4_.clip.customers.typelabel.visible = true;
               _loc4_.clip.customers.typelabel.gotoAndStop(1);
            }
         }
         else if(_loc6_.getCustomerName(param1) == "Hope")
         {
            _loc4_.clip.customers.typelabel.visible = true;
            _loc4_.clip.customers.typelabel.gotoAndStop(3);
         }
         else if(_loc6_.getCustomerName(param1) == "Yui")
         {
            _loc4_.clip.customers.typelabel.visible = true;
            _loc4_.clip.customers.typelabel.gotoAndStop(4);
         }
         else
         {
            _loc4_.clip.customers.typelabel.visible = false;
         }
         _loc4_.clip.customers.topfader.gotoAndPlay(1);
      }
      
      public function destroyPreviousPhoto() : void
      {
         var screen:MainMenuScreen = this;
         if(screen.customerClip)
         {
            screen.customerClip.stop();
            try
            {
               screen.customerClip.body.removeChildAt(0);
               screen.customerClip.head.removeChildAt(0);
               screen.customerClip.eyes.removeChildAt(0);
               screen.customerClip.mouth.removeChildAt(0);
               screen.customerClip.neck.removeChildAt(0);
               screen.customerClip.front_shoe.removeChildAt(0);
               screen.customerClip.back_shoe.removeChildAt(0);
               screen.customerClip.fronthand.removeChildAt(0);
               screen.customerClip.backhand.removeChildAt(0);
               screen.customerClip.front_upperarm.removeChildAt(0);
               screen.customerClip.back_upperarm.removeChildAt(0);
               screen.customerClip.front_forearm.removeChildAt(0);
               screen.customerClip.back_forearm.removeChildAt(0);
            }
            catch(err:Error)
            {
               class_7.error("Error removing parts of customer");
            }
            try
            {
               screen.customerClip.hair.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
            try
            {
               screen.customerClip.back_hair.removeChildAt(0);
            }
            catch(err:Error)
            {
            }
            screen.clip.customers.holder.removeChild(screen.customerClip);
            screen.customerClip = null;
         }
      }
      
      public function buildCustomerPhoto(param1:Number, param2:Number) : void
      {
         var _loc9_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:MovieClip = null;
         var _loc12_:Class = null;
         var _loc13_:MovieClip = null;
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         var _loc16_:Class = null;
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
         var _loc4_:MovieClip = null;
         var _loc5_:Class = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MainMenuScreen = this;
         _loc7_.destroyPreviousPhoto();
         _loc7_.customerClip = new customerMC();
         var _loc8_:String = _loc7_.gameObj.var_130.getCustomerClipName(param1);
         _loc10_ = getDefinitionByName("customer_" + _loc8_ + "_body") as Class;
         _loc9_ = new _loc10_();
         _loc9_.name = "clip";
         _loc7_.customerClip.body.addChild(_loc9_);
         _loc12_ = getDefinitionByName("customer_" + _loc8_ + "_head") as Class;
         _loc11_ = new _loc12_();
         _loc11_.name = "clip";
         _loc7_.customerClip.head.addChild(_loc11_);
         _loc13_ = _loc7_.gameObj.var_130.getCustomerPart(_loc8_,"eyes",_loc7_.gameObj.var_128.getHolidayMonth());
         _loc13_.name = "clip";
         _loc7_.customerClip.eyes.addChild(_loc13_);
         _loc14_ = _loc7_.gameObj.var_130.getCustomerPart(_loc8_,"mouth",_loc7_.gameObj.var_128.getHolidayMonth());
         _loc14_.name = "clip";
         _loc7_.customerClip.mouth.addChild(_loc14_);
         _loc16_ = getDefinitionByName("customer_" + _loc8_ + "_neck") as Class;
         _loc15_ = new _loc16_();
         _loc15_.name = "clip";
         _loc7_.customerClip.neck.addChild(_loc15_);
         try
         {
            _loc3_ = getDefinitionByName("customer_" + _loc8_ + "_hair") as Class;
            _loc4_ = new _loc3_();
            _loc4_.name = "clip";
            _loc7_.customerClip.hair.addChild(_loc4_);
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc5_ = getDefinitionByName("customer_" + _loc8_ + "_back_hair") as Class;
            _loc6_ = new _loc5_();
            _loc6_.name = "clip";
            _loc7_.customerClip.back_hair.addChild(_loc6_);
         }
         catch(err:Error)
         {
         }
         _loc17_ = _loc7_.gameObj.var_130.getCustomerPart(_loc8_,"foot",_loc7_.gameObj.var_128.getHolidayMonth());
         _loc17_.name = "clip";
         _loc7_.customerClip.front_shoe.addChild(_loc17_);
         _loc18_ = _loc7_.gameObj.var_130.getCustomerPart(_loc8_,"foot",_loc7_.gameObj.var_128.getHolidayMonth());
         _loc18_.name = "clip";
         _loc7_.customerClip.back_shoe.addChild(_loc18_);
         _loc19_ = _loc7_.gameObj.var_130.getCustomerPart(_loc8_,"hand",_loc7_.gameObj.var_128.getHolidayMonth());
         _loc19_.name = "clip";
         _loc7_.customerClip.fronthand.addChild(_loc19_);
         _loc20_ = _loc7_.gameObj.var_130.getCustomerPart(_loc8_,"hand2",_loc7_.gameObj.var_128.getHolidayMonth());
         _loc20_.name = "clip";
         _loc7_.customerClip.backhand.addChild(_loc20_);
         _loc22_ = getDefinitionByName("customer_" + _loc8_ + "_upperarm") as Class;
         _loc21_ = new _loc22_();
         _loc21_.name = "clip";
         _loc7_.customerClip.front_upperarm.addChild(_loc21_);
         _loc23_ = new _loc22_();
         _loc23_.name = "clip";
         _loc7_.customerClip.back_upperarm.addChild(_loc23_);
         _loc25_ = getDefinitionByName("customer_" + _loc8_ + "_forearm") as Class;
         _loc24_ = new _loc25_();
         _loc24_.name = "clip";
         _loc7_.customerClip.front_forearm.addChild(_loc24_);
         _loc26_ = new _loc25_();
         _loc26_.name = "clip";
         _loc7_.customerClip.back_forearm.addChild(_loc26_);
         _loc27_ = _loc7_.gameObj.var_130.getCustomerHolidayOutfitMonth(param1);
         if(_loc27_ > 0 && _loc7_.gameObj.var_128.getMonth() == _loc27_)
         {
            _loc9_.gotoAndStop(2);
            _loc21_.gotoAndStop(2);
            _loc23_.gotoAndStop(2);
            _loc24_.gotoAndStop(2);
            _loc26_.gotoAndStop(2);
            _loc11_.gotoAndStop(2);
            _loc15_.gotoAndStop(2);
            if(_loc4_)
            {
               _loc4_.gotoAndStop(2);
            }
            if(_loc6_)
            {
               _loc6_.gotoAndStop(2);
            }
         }
         else
         {
            _loc9_.gotoAndStop(1);
            _loc21_.gotoAndStop(1);
            _loc23_.gotoAndStop(1);
            _loc24_.gotoAndStop(1);
            _loc26_.gotoAndStop(1);
            _loc11_.gotoAndStop(1);
            _loc15_.gotoAndStop(1);
            if(_loc4_)
            {
               _loc4_.gotoAndStop(1);
            }
            if(_loc6_)
            {
               _loc6_.gotoAndStop(1);
            }
         }
         if(param2 > 0)
         {
            _loc7_.customerClip.gotoAndStop("overjoyedposter");
         }
         else
         {
            _loc7_.customerClip.gotoAndStop("portrait");
         }
         _loc7_.clip.customers.holder.gotoAndStop(_loc7_.gameObj.var_130.getCustomerColor(param1));
         _loc7_.clip.customers.holder.addChild(_loc7_.customerClip);
         _loc7_.customerClip.x = 20;
      }
      
      public function clickCustomerNext(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         ++_loc2_.currentCustomerPage;
         if(_loc2_.currentCustomerPage > 1)
         {
            _loc2_.clip.customers.left_btn.visible = true;
         }
         else
         {
            _loc2_.clip.customers.left_btn.visible = false;
         }
         if(_loc2_.currentCustomerPage < _loc2_.totalCustomerPages)
         {
            _loc2_.clip.customers.right_btn.visible = true;
         }
         else
         {
            _loc2_.clip.customers.right_btn.visible = false;
         }
         if(!_loc2_.clip.customers.hasEventListener(Event.ENTER_FRAME))
         {
            _loc2_.clip.customers.addEventListener(Event.ENTER_FRAME,_loc2_.animateCustomerPanel);
         }
      }
      
      public function clickCustomerPrev(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc2_.currentCustomerPage > 1)
         {
            --_loc2_.currentCustomerPage;
            if(_loc2_.currentCustomerPage > 1)
            {
               _loc2_.clip.customers.left_btn.visible = true;
            }
            else
            {
               _loc2_.clip.customers.left_btn.visible = false;
            }
            if(_loc2_.currentCustomerPage < _loc2_.totalCustomerPages)
            {
               _loc2_.clip.customers.right_btn.visible = true;
            }
            else
            {
               _loc2_.clip.customers.right_btn.visible = false;
            }
            if(!_loc2_.clip.customers.hasEventListener(Event.ENTER_FRAME))
            {
               _loc2_.clip.customers.addEventListener(Event.ENTER_FRAME,_loc2_.animateCustomerPanel);
            }
         }
      }
      
      public function animateCustomerPanel(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:MainMenuScreen = this;
         _loc3_ = _loc2_.customerStartX - (_loc2_.currentCustomerPage - 1) * 328;
         var _loc4_:Number = _loc3_ - _loc2_.clip.customers.thumbholder.x;
         _loc2_.clip.customers.thumbholder.x += _loc4_ / _loc2_.customerTweenSpeed;
         if(_loc4_ >= -1 && _loc4_ <= 1)
         {
            _loc2_.clip.customers.thumbholder.x = _loc3_;
            _loc2_.clip.customers.removeEventListener(Event.ENTER_FRAME,_loc2_.animateCustomerPanel);
         }
      }
      
      public function setupHelp(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MainMenuScreen = this;
         var _loc4_:Array = ["Taking Orders","Order Tickets","Build Station","Grill Station","Fry Station","Finishing","Ranking","Customers","Closers & Food Critic","Rewards","Server & Dining Room","Earning Specials","Serving Specials","Holiday Seasons","Seasonal Toppings","Holiday Furniture","Holiday Clothing","Buy Upgrades","Buy Furniture","Buy Clothing","Worker Clothing","Decorate Lobby","Lobby Scoring","Mini-Games","Pay Day","Badges","Parade","Saving"];
         if(param1)
         {
            _loc2_ = 1;
            while(_loc2_ <= _loc4_.length)
            {
               _loc3_.clip.help.tabholder["tab" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTab);
               _loc3_.clip.help.tabholder["tab" + _loc2_].addEventListener(MouseEvent.ROLL_OVER,_loc3_.rolloverHelpTab);
               _loc3_.clip.help.tabholder["tab" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,_loc3_.rolloutHelpTab);
               _loc3_.clip.help.tabholder["tab" + _loc2_].mouseEnabled = true;
               _loc3_.clip.help.tabholder["tab" + _loc2_].mouseChildren = false;
               _loc3_.clip.help.tabholder["tab" + _loc2_].buttonMode = true;
               _loc3_.clip.help.tabholder["tab" + _loc2_].useHandCursor = true;
               _loc3_.clip.help.tabholder["tab" + _loc2_].name_txt.htmlText = "<b>" + _loc4_[_loc2_ - 1] + "</b>";
               _loc3_.clip.help.tabholder["tab" + _loc2_].hilite.visible = false;
               _loc3_.clip.help.tabholder["tab" + _loc2_].roll.visible = false;
               _loc3_.clip.help.tabholder["tab" + _loc2_].arrow.visible = false;
               _loc3_.clip.help.tabholder["tab" + _loc2_].bg.gotoAndStop(_loc2_ % 2 + 1);
               _loc2_++;
            }
            _loc3_.clip.help.tabholder.mask = _loc3_.clip.help.tabmasker;
            _loc3_.clip.help.side_scrollpanel.scroll_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTabDragger);
            _loc3_.clip.help.side_scrollpanel.scroll_btn.y = _loc3_.helpScrollStart;
            _loc3_.clip.help.side_scrollpanel.scroll_btn.mouseEnabled = true;
            _loc3_.clip.help.side_scrollpanel.up_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTabArrow);
            _loc3_.clip.help.side_scrollpanel.down_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTabArrow);
            _loc3_.clip.help.mainpanel.mask = _loc3_.clip.help.mainmasker;
            _loc3_.clip.help.main_scrollpanel.scroll_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpMainDragger);
            _loc3_.clip.help.main_scrollpanel.scroll_btn.y = _loc3_.helpScrollStart;
            _loc3_.clip.help.main_scrollpanel.scroll_btn.mouseEnabled = true;
            _loc3_.clip.help.main_scrollpanel.up_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpMainArrow);
            _loc3_.clip.help.main_scrollpanel.down_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpMainArrow);
            _loc3_.showHelp(1);
            if(_loc3_.params != null && Boolean(_loc3_.params.hasOwnProperty("useSection")) && _loc3_.params.useSection == "help")
            {
               _loc3_.showHelp(15);
               _loc3_.clip.help.tabholder.y = _loc3_.clip.help.tabmasker.y - (_loc3_.clip.help.tabholder.height - _loc3_.clip.help.tabmasker.height);
               _loc3_.holdHelpTabArrow(null);
            }
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ <= _loc4_.length)
            {
               _loc3_.clip.help.tabholder["tab" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTab);
               _loc3_.clip.help.tabholder["tab" + _loc2_].removeEventListener(MouseEvent.ROLL_OVER,_loc3_.rolloverHelpTab);
               _loc3_.clip.help.tabholder["tab" + _loc2_].removeEventListener(MouseEvent.ROLL_OUT,_loc3_.rolloutHelpTab);
               _loc2_++;
            }
            _loc3_.clip.help.side_scrollpanel.scroll_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTabDragger);
            _loc3_.clip.help.side_scrollpanel.up_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTabArrow);
            _loc3_.clip.help.side_scrollpanel.down_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpTabArrow);
            _loc3_.clip.help.main_scrollpanel.scroll_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpMainDragger);
            _loc3_.clip.help.main_scrollpanel.up_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpMainArrow);
            _loc3_.clip.help.main_scrollpanel.down_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickHelpMainArrow);
         }
      }
      
      public function clickHelpTabDragger(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.help.side_scrollpanel.scroll_btn.startDrag(false,new Rectangle(0,30,0,_loc2_.helpScrollRange));
         _loc2_.clip.help.side_scrollpanel.scroll_btn.addEventListener(Event.ENTER_FRAME,_loc2_.dragHelpTabDragger);
         _loc2_.gameObj.stage.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpTabDragger);
      }
      
      public function releaseHelpTabDragger(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpTabDragger);
         _loc2_.clip.help.side_scrollpanel.scroll_btn.removeEventListener(Event.ENTER_FRAME,_loc2_.dragHelpTabDragger);
         _loc2_.clip.help.side_scrollpanel.scroll_btn.stopDrag();
      }
      
      public function dragHelpTabDragger(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = (_loc2_.clip.help.side_scrollpanel.scroll_btn.y - _loc2_.helpScrollStart) / _loc2_.helpScrollRange;
         _loc2_.clip.help.tabholder.y = Math.round(_loc2_.clip.help.tabmasker.y - (_loc2_.clip.help.tabholder.height - _loc2_.clip.help.tabmasker.height) * _loc3_);
      }
      
      public function clickHelpTabArrow(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:String = param1.currentTarget.name;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc3_ == "up_btn")
         {
            _loc2_.helpTabScrollDir = -1;
         }
         else if(_loc3_ == "down_btn")
         {
            _loc2_.helpTabScrollDir = 1;
         }
         _loc2_.clip.help.tabholder.addEventListener(Event.ENTER_FRAME,_loc2_.holdHelpTabArrow);
         _loc2_.gameObj.stage.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpTabArrow);
      }
      
      public function releaseHelpTabArrow(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.helpTabScrollDir = 0;
         _loc2_.clip.help.tabholder.removeEventListener(Event.ENTER_FRAME,_loc2_.holdHelpTabArrow);
         _loc2_.gameObj.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpTabArrow);
      }
      
      public function holdHelpTabArrow(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = Number(_loc2_.clip.help.tabmasker.y);
         var _loc4_:Number = _loc2_.clip.help.tabmasker.y - (_loc2_.clip.help.tabholder.height - _loc2_.clip.help.tabmasker.height);
         if(_loc2_.helpTabScrollDir == 1)
         {
            _loc2_.clip.help.tabholder.y -= 8;
         }
         else if(_loc2_.helpTabScrollDir == -1)
         {
            _loc2_.clip.help.tabholder.y += 8;
         }
         if(_loc2_.clip.help.tabholder.y < _loc4_)
         {
            _loc2_.clip.help.tabholder.y = _loc4_;
            _loc2_.helpTabScrollDir = 0;
         }
         else if(_loc2_.clip.help.tabholder.y > _loc3_)
         {
            _loc2_.clip.help.tabholder.y = _loc3_;
            _loc2_.helpTabScrollDir = 0;
         }
         var _loc5_:Number = Math.abs((_loc2_.clip.help.tabholder.y - _loc3_) / (_loc4_ - _loc3_));
         _loc2_.clip.help.side_scrollpanel.scroll_btn.y = _loc2_.helpScrollStart + _loc5_ * _loc2_.helpScrollRange;
      }
      
      public function clickHelpMainDragger(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.clip.help.main_scrollpanel.scroll_btn.startDrag(false,new Rectangle(0,30,0,_loc2_.helpScrollRange));
         _loc2_.clip.help.main_scrollpanel.scroll_btn.addEventListener(Event.ENTER_FRAME,_loc2_.dragHelpMainDragger);
         _loc2_.gameObj.stage.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpMainDragger);
      }
      
      public function releaseHelpMainDragger(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpMainDragger);
         _loc2_.clip.help.main_scrollpanel.scroll_btn.removeEventListener(Event.ENTER_FRAME,_loc2_.dragHelpMainDragger);
         _loc2_.clip.help.main_scrollpanel.scroll_btn.stopDrag();
      }
      
      public function dragHelpMainDragger(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = (_loc2_.clip.help.main_scrollpanel.scroll_btn.y - _loc2_.helpScrollStart) / _loc2_.helpScrollRange;
         _loc2_.clip.help.mainpanel.y = Math.round(_loc2_.clip.help.mainmasker.y - (_loc2_.clip.help.mainpanel.height - _loc2_.clip.help.mainmasker.height) * _loc3_);
      }
      
      public function clickHelpMainArrow(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:String = param1.currentTarget.name;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc3_ == "up_btn")
         {
            _loc2_.helpMainScrollDir = -1;
         }
         else if(_loc3_ == "down_btn")
         {
            _loc2_.helpMainScrollDir = 1;
         }
         _loc2_.clip.help.mainpanel.addEventListener(Event.ENTER_FRAME,_loc2_.holdHelpMainArrow);
         _loc2_.gameObj.stage.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpMainArrow);
      }
      
      public function releaseHelpMainArrow(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.helpTabScrollDir = 0;
         _loc2_.clip.help.mainpanel.removeEventListener(Event.ENTER_FRAME,_loc2_.holdHelpMainArrow);
         _loc2_.gameObj.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseHelpMainArrow);
      }
      
      public function holdHelpMainArrow(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = Number(_loc2_.clip.help.mainmasker.y);
         var _loc4_:Number = _loc2_.clip.help.mainmasker.y - (_loc2_.clip.help.mainpanel.height - _loc2_.clip.help.mainmasker.height);
         if(_loc2_.helpMainScrollDir == 1)
         {
            _loc2_.clip.help.mainpanel.y -= 8;
         }
         else if(_loc2_.helpMainScrollDir == -1)
         {
            _loc2_.clip.help.mainpanel.y += 8;
         }
         if(_loc2_.clip.help.mainpanel.y < _loc4_)
         {
            _loc2_.clip.help.mainpanel.y = _loc4_;
            _loc2_.helpMainScrollDir = 0;
         }
         else if(_loc2_.clip.help.mainpanel.y > _loc3_)
         {
            _loc2_.clip.help.mainpanel.y = _loc3_;
            _loc2_.helpMainScrollDir = 0;
         }
         var _loc5_:Number = Math.abs((_loc2_.clip.help.mainpanel.y - _loc3_) / (_loc4_ - _loc3_));
         _loc2_.clip.help.main_scrollpanel.scroll_btn.y = _loc2_.helpScrollStart + _loc5_ * _loc2_.helpScrollRange;
      }
      
      public function clickHelpTab(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = Number(MovieClip(param1.currentTarget).name.split("tab")[1]);
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         MovieClip(param1.currentTarget).roll.visible = false;
         _loc2_.showHelp(_loc3_);
      }
      
      public function rolloverHelpTab(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = Number(MovieClip(param1.currentTarget).name.split("tab")[1]);
         if(_loc2_.helpIndex != _loc3_)
         {
            MovieClip(param1.currentTarget).roll.visible = true;
         }
      }
      
      public function rolloutHelpTab(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:Number = Number(MovieClip(param1.currentTarget).name.split("tab")[1]);
         if(_loc2_.helpIndex != _loc3_)
         {
            MovieClip(param1.currentTarget).roll.visible = false;
         }
      }
      
      public function showHelp(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MainMenuScreen = this;
         _loc3_.helpIndex = param1;
         _loc2_ = 1;
         while(_loc2_ <= 28)
         {
            try
            {
               if(_loc2_ == param1)
               {
                  _loc3_.clip.help.tabholder["tab" + _loc2_].hilite.visible = true;
                  _loc3_.clip.help.tabholder["tab" + _loc2_].arrow.visible = true;
               }
               else
               {
                  _loc3_.clip.help.tabholder["tab" + _loc2_].hilite.visible = false;
                  _loc3_.clip.help.tabholder["tab" + _loc2_].arrow.visible = false;
               }
            }
            catch(err:Error)
            {
            }
            _loc2_++;
         }
         _loc3_.clip.help.mainpanel.gotoAndStop(_loc3_.helpIndex);
         _loc3_.clip.help.mainpanel.y = _loc3_.clip.help.mainmasker.y;
         _loc3_.clip.help.main_scrollpanel.scroll_btn.y = _loc3_.helpScrollStart;
      }
      
      public function setupCredits(param1:Boolean = true) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:MainMenuScreen = this;
         if(param1)
         {
            _loc3_.clip.credits.flipline1_btn.addEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.flipline2_btn.addEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.flipline_logo_btn.addEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.flipline_btn.addEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.facebook_btn.addEventListener(MouseEvent.CLICK,_loc3_.clickFacebook);
            _loc3_.clip.credits.twitter_btn.addEventListener(MouseEvent.CLICK,_loc3_.clickTwitter);
            _loc2_ = _loc3_.gameObj.var_128.getHolidayMonth();
            if(_loc2_ == 0)
            {
               _loc2_ = 13;
            }
            _loc2_ = _loc2_ * 2 - 1;
            _loc3_.clip.credits.bg.gotoAndStop(_loc2_);
            _loc3_.clip.credits.bg.cacheAsBitmap = true;
            if(Boolean(class_3.method_60()) && class_1.method_98() == false)
            {
               _loc3_.clip.credits.flipline1_btn.visible = false;
               _loc3_.clip.credits.flipline2_btn.visible = false;
               _loc3_.clip.credits.flipline_btn.visible = false;
               _loc3_.clip.credits.facebook_btn.visible = false;
               _loc3_.clip.credits.twitter_btn.visible = false;
            }
            if(Boolean(class_3.method_60()) && class_1.method_85() == false)
            {
               _loc3_.clip.credits.flipline_logo_btn.visible = false;
            }
            if(Boolean(class_3.method_60()) && class_1.method_102() == false)
            {
               _loc3_.clip.credits.flipline_logo_btn.mouseEnabled = false;
            }
         }
         else
         {
            _loc3_.clip.credits.flipline1_btn.removeEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.flipline2_btn.removeEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.flipline_logo_btn.removeEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.flipline_btn.removeEventListener(MouseEvent.CLICK,_loc3_.clickCreditsFlipline);
            _loc3_.clip.credits.facebook_btn.removeEventListener(MouseEvent.CLICK,_loc3_.clickFacebook);
            _loc3_.clip.credits.twitter_btn.removeEventListener(MouseEvent.CLICK,_loc3_.clickTwitter);
         }
      }
      
      public function clickCreditsFlipline(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.api.method_107("http://www.flipline.com");
      }
      
      public function clickCreditsPapaLouie(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickFacebook(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.api.method_107("http://www.facebook.com/pages/Flipline-Studios/121045844606187");
      }
      
      public function clickTwitter(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.api.method_107("http://www.twitter.com/FliplineStudios");
      }
      
      public function setupConfirmQuit(param1:Boolean = true) : void
      {
         var _loc2_:MainMenuScreen = this;
         if(param1)
         {
            _loc2_.confirmYesButton = new class_18(null,"YES","small","button","clickYesQuit",null,false,false,false,null,false,80);
            _loc2_.confirmYesButton.x = 203;
            _loc2_.confirmYesButton.y = 230;
            _loc2_.confirmNoButton = new class_18(null,"NO","small","button","clickNoQuit",null,false,false,false,null,false,80);
            _loc2_.confirmNoButton.x = 356;
            _loc2_.confirmNoButton.y = _loc2_.confirmYesButton.y;
            _loc2_.clip.confirmquit.addChild(_loc2_.confirmYesButton);
            _loc2_.clip.confirmquit.addChild(_loc2_.confirmNoButton);
            _loc2_.confirmYesButton.addEventListener("clickYesQuit",_loc2_.clickConfirmQuit);
            _loc2_.confirmNoButton.addEventListener("clickNoQuit",_loc2_.clickCancelQuit);
            _loc2_.clip.confirmquit.visible = false;
         }
         else
         {
            _loc2_.clip.confirmquit.removeChild(_loc2_.confirmYesButton);
            _loc2_.clip.confirmquit.removeChild(_loc2_.confirmNoButton);
            _loc2_.confirmYesButton.removeEventListener("clickYesQuit",_loc2_.clickConfirmQuit);
            _loc2_.confirmNoButton.removeEventListener("clickNoQuit",_loc2_.clickCancelQuit);
            _loc2_.confirmYesButton.destroy();
            _loc2_.confirmNoButton.destroy();
            _loc2_.confirmYesButton = null;
            _loc2_.confirmNoButton = null;
         }
      }
      
      public function closeMainMenuScreen(param1:Boolean = false) : void
      {
         var _loc2_:MainMenuScreen = this;
         if(param1)
         {
            _loc2_.gameObj.method_137();
            _loc2_.gameObj.method_141();
         }
         else
         {
            try
            {
               if(_loc2_.gameObj.var_145.isActive)
               {
                  _loc2_.gameObj.var_129.switchMusic("order");
                  _loc2_.gameObj.var_145.playFurniMusic();
               }
               else if(_loc2_.gameObj.var_187.isActive)
               {
                  _loc2_.gameObj.var_129.switchMusic("order");
               }
               else if(_loc2_.gameObj.var_199.isActive)
               {
                  _loc2_.gameObj.var_129.switchMusic("order");
               }
               else if(_loc2_.gameObj.var_136.isActive)
               {
                  _loc2_.gameObj.var_129.switchMusic("bake");
               }
               else if(_loc2_.gameObj.var_139.isActive)
               {
                  _loc2_.gameObj.var_129.switchMusic("build");
               }
               else if(_loc2_.gameObj.var_131.isActive)
               {
                  _loc2_.gameObj.var_129.switchMusic("other");
               }
            }
            catch(err:Error)
            {
            }
            _loc2_.gameObj.method_149(true);
         }
      }
      
      public function getSectionTitle() : String
      {
         var _loc1_:MainMenuScreen = this;
         if(_loc1_.currentSection == "info")
         {
            return "INFO";
         }
         if(_loc1_.currentSection == "credits")
         {
            return "CREDITS";
         }
         if(_loc1_.currentSection == "help")
         {
            return "HELP";
         }
         if(_loc1_.currentSection == "customers")
         {
            return "CUSTOMERS";
         }
         if(_loc1_.currentSection == "medals")
         {
            return "BADGES";
         }
         return _loc1_.currentSection.toUpperCase();
      }
      
      public function destroy() : void
      {
         var _loc1_:MainMenuScreen = this;
         _loc1_.setupOutroButton(false);
         _loc1_.container.removeEventListener("clickInfo",_loc1_.clickInfo);
         _loc1_.container.removeEventListener("clickCustomers",_loc1_.clickCustomers);
         _loc1_.container.removeEventListener("clickMedals",_loc1_.clickMedals);
         _loc1_.container.removeEventListener("clickCookbook",_loc1_.clickCookbook);
         _loc1_.container.removeEventListener("clickCredits",_loc1_.clickCredits);
         _loc1_.container.removeEventListener("clickHelp",_loc1_.clickHelp);
         _loc1_.container.removeEventListener("clickBackToGame",_loc1_.clickBackToGame);
         _loc1_.container.removeEventListener("clickQuit",_loc1_.clickQuit);
         _loc1_.container.removeEventListener("clickBackToSplash",_loc1_.clickBackToSplash);
         _loc1_.container.removeEventListener("clickContinueSpecial",_loc1_.clickContinueSpecial);
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.adjustMenuIcons);
         _loc1_.setupInfo(false);
         _loc1_.setupCustomers(false);
         _loc1_.setupMedals(false);
         _loc1_.setupCookbook(false);
         _loc1_.setupHelp(false);
         _loc1_.setupCredits(false);
         _loc1_.setupConfirmQuit(false);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function setupMedals(param1:Boolean = true) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:ChallengeManager = _loc2_.gameObj.var_142;
         _loc2_.medalsPage = 0;
         _loc2_.medalsDirection = "next";
         _loc2_.medalsTransitioning = true;
         if(param1)
         {
            _loc2_.clip.medals.next_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickNextMedals);
            _loc2_.clip.medals.prev_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickPrevMedals);
            _loc2_.clip.medals.prev_btn.visible = false;
            _loc2_.clip.medals.total_txt.text = String(_loc3_.getTotalBadgesEarned() + "/" + _loc4_.getNumberOfBadges());
            _loc2_.populateMedals();
            _loc2_.clip.medals.panel.addEventListener(Event.ENTER_FRAME,_loc2_.animateMedalsTransition);
         }
         else
         {
            _loc2_.clip.medals.next_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickNextMedals);
            _loc2_.clip.medals.prev_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickPrevMedals);
            if(_loc2_.clip.medals.panel.hasEventListener(Event.ENTER_FRAME))
            {
               _loc2_.clip.medals.panel.removeEventListener(Event.ENTER_FRAME,_loc2_.animateMedalsTransition);
            }
         }
      }
      
      public function getDesaturatedFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.212671,0.71516,0.072169,0,0,0.212671,0.71516,0.072169,0,0,0.212671,0.71516,0.072169,0,0,0,0,0,1,0]);
      }
      
      public function populateMedals() : void
      {
         var _loc7_:Number = NaN;
         var _loc1_:MovieClip = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:MainMenuScreen = this;
         var _loc4_:UserData = _loc3_.gameObj.var_128;
         var _loc5_:ChallengeManager = _loc3_.gameObj.var_142;
         var _loc6_:Number = 0 + _loc3_.medalsPage * _loc3_.medalsPerPage;
         _loc7_ = Math.min(_loc5_.getNumberOfBadges() - 1,_loc6_ + (_loc3_.medalsPerPage - 1));
         var _loc8_:Number = _loc7_ - _loc6_ + 1;
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_.medalsPerPage)
         {
            _loc1_ = _loc3_.clip.medals.panel["panel" + (_loc9_ + 1)];
            _loc2_ = _loc9_ + _loc6_;
            if(_loc9_ < _loc8_)
            {
               _loc1_.visible = true;
               _loc1_.title_txt.text = _loc5_.getChallengeTitle(_loc2_);
               _loc1_.description_txt.text = _loc5_.getChallengeDescription(_loc2_) + " " + _loc5_.getBadgeTallyString(_loc2_);
               _loc1_.reward_txt.text = "+ $" + class_13.method_110(_loc5_.getChallengeRewardAmount(_loc2_) / 100);
               if(_loc5_.getChallengeTicketAmount(_loc2_) > 0)
               {
                  _loc1_.tickets_txt.text = String(_loc5_.getChallengeTicketAmount(_loc2_));
                  _loc1_.ticketicon.visible = true;
               }
               else
               {
                  _loc1_.tickets_txt.text = "";
                  _loc1_.ticketicon.visible = false;
               }
               _loc1_.thumb.gotoAndStop(_loc2_ + 1);
               if(_loc4_.hasBadge(_loc2_))
               {
                  _loc1_.earned.visible = true;
                  _loc1_.thumb.filters = [];
               }
               else
               {
                  _loc1_.earned.visible = false;
                  _loc1_.thumb.filters = [_loc3_.getDesaturatedFilter()];
               }
               if(_loc5_.shouldLockBadge(_loc2_))
               {
                  _loc1_.thumb.gotoAndStop("lockicon");
                  _loc1_.title_txt.text = "Hidden Badge";
                  _loc1_.description_txt.text = "You don\'t have this ingredient yet!";
                  _loc1_.reward_txt.text = "";
                  _loc1_.tickets_txt.text = "";
                  _loc1_.ticketicon.visible = false;
               }
            }
            else
            {
               _loc1_.visible = false;
            }
            _loc9_++;
         }
         var _loc10_:Number = Math.ceil(_loc5_.getNumberOfBadges() / _loc3_.medalsPerPage);
         if(_loc3_.medalsPage > 0)
         {
            _loc3_.clip.medals.prev_btn.visible = true;
         }
         else
         {
            _loc3_.clip.medals.prev_btn.visible = false;
         }
         if(_loc3_.medalsPage < _loc10_ - 1)
         {
            _loc3_.clip.medals.next_btn.visible = true;
         }
         else
         {
            _loc3_.clip.medals.next_btn.visible = false;
         }
         _loc3_.clip.medals.page_txt.text = _loc3_.medalsPage + 1 + " / " + _loc10_;
         if(_loc3_.medalsDirection == "next")
         {
            _loc3_.clip.medals.panel.gotoAndPlay("innext");
         }
         else
         {
            _loc3_.clip.medals.panel.gotoAndPlay("inprev");
         }
      }
      
      public function clickNextMedals(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(!_loc2_.medalsTransitioning)
         {
            ++_loc2_.medalsPage;
            _loc2_.medalsDirection = "next";
            _loc2_.medalsTransitioning = true;
            _loc2_.clip.medals.panel.gotoAndPlay("outnext");
            _loc2_.clip.medals.panel.addEventListener(Event.ENTER_FRAME,_loc2_.animateMedalsTransition);
         }
      }
      
      public function clickPrevMedals(param1:MouseEvent) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(!_loc2_.medalsTransitioning)
         {
            --_loc2_.medalsPage;
            _loc2_.medalsDirection = "prev";
            _loc2_.medalsTransitioning = true;
            _loc2_.clip.medals.panel.gotoAndPlay("outprev");
            _loc2_.clip.medals.panel.addEventListener(Event.ENTER_FRAME,_loc2_.animateMedalsTransition);
         }
      }
      
      public function animateMedalsTransition(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         if(_loc2_.clip.medals.panel.currentLabel == "outnextframe" || _loc2_.clip.medals.panel.currentLabel == "outprevframe")
         {
            _loc2_.populateMedals();
         }
         else if(_loc2_.clip.medals.panel.currentLabel == "innextframe" || _loc2_.clip.medals.panel.currentLabel == "inprevframe")
         {
            _loc2_.clip.medals.panel.removeEventListener(Event.ENTER_FRAME,_loc2_.animateMedalsTransition);
            _loc2_.medalsTransitioning = false;
         }
      }
      
      private function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc1_:BitmapData = null;
         var _loc2_:MainMenuScreen = this;
         var _loc3_:GiveOrderScreen = _loc2_.gameObj.var_183;
         var _loc4_:Bitmap = null;
         if(_loc3_ != null && _loc3_.backdropBitmap != null)
         {
            _loc1_ = _loc3_.backdropBitmap.bitmapData.clone();
            _loc4_ = new Bitmap(_loc1_);
         }
         else
         {
            _loc4_ = new Bitmap();
         }
         return _loc4_;
      }
      
      public function adjustMenuIcons(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(_loc3_.hasNewSpecials())
         {
            class_7.method_1("SHOW NEW FOR COOKBOOK");
            _loc2_.gameObj.var_132.api.setButtonIcon("all","COOKBOOK","menuicon_new");
         }
         _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.adjustMenuIcons);
      }
      
      public function clickRewatchOutro(param1:MouseEvent = null) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.gameObj.method_144(true);
      }
      
      public function delayOutroButton(param1:Event) : void
      {
         var _loc2_:MainMenuScreen = this;
         _loc2_.setupOutroButton(true);
         _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.delayOutroButton);
      }
      
      public function setupOutroButton(param1:Boolean = true) : void
      {
         var firstDay:Number = Number(NaN);
         var init:Boolean = param1;
         var screen:MainMenuScreen = this;
         if(!screen.didSetupOutroButton || init == false)
         {
            try
            {
               if(init)
               {
                  class_7.method_1("Setup outro button");
                  screen.outroButton = screen.clip.outro_btn;
                  screen.outroButton.addEventListener(MouseEvent.MOUSE_DOWN,screen.clickRewatchOutro);
                  screen.gameObj.var_132.api.method_194(screen.outroButton,"MainMenu");
                  firstDay = screen.gameObj.var_128.getCustomerFirstDay(screen.gameObj.var_130.getCustomerIndex("Papa Louie"));
                  if(firstDay > 0 && firstDay <= screen.gameObj.var_128.getDay())
                  {
                     screen.outroButton.visible = true;
                  }
                  else
                  {
                     screen.outroButton.visible = false;
                  }
               }
               else
               {
                  class_7.method_1("Cleanup outro button");
                  screen.clip.removeEventListener(Event.ENTER_FRAME,screen.delayOutroButton);
                  if(screen.outroButton)
                  {
                     screen.outroButton.removeEventListener(MouseEvent.MOUSE_DOWN,screen.clickRewatchOutro);
                     if(screen.outroButton.parent)
                     {
                        screen.outroButton.parent.removeChild(screen.outroButton);
                     }
                  }
                  screen.outroButton = null;
               }
            }
            catch(err:Error)
            {
               class_7.error("Error setting up Outro button: " + err.message);
            }
         }
         screen.didSetupOutroButton = true;
      }
   }
}

