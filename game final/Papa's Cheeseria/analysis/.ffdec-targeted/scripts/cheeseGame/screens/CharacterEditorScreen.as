package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import fl.controls.TextInput;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.ByteArray;
   import package_1.*;
   import package_2.*;
   import package_4.class_5;
   
   public class CharacterEditorScreen
   {
      
      public var gameObj:class_5;
      
      public var workerData:WorkerData;
      
      public var worker:Worker;
      
      public var workerReverse:Worker;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var params:Object;
      
      public var specialBitmap:Bitmap = null;
      
      public var specialBitmapMC:MovieClip = null;
      
      public var endaction:String = "none";
      
      public var sliderStartX:Number = 8.5;
      
      public var sliderRange:Number = 84;
      
      public var draggingWhichSlider:String = null;
      
      public var workerScale:Number = 0.7;
      
      public var workerX:Number = 185;
      
      public var workerY:Number = 104;
      
      public var workerReverseX:Number = 104;
      
      public var workerReverseY:Number = 73;
      
      public var workerStartOffset:Number = -220;
      
      public var available_pants:Array;
      
      public var available_shirt:Array;
      
      public var available_jacket:Array;
      
      public var available_hair:Array;
      
      public var available_hat:Array;
      
      public var available_shoes:Array;
      
      public var available_facialhair:Array;
      
      public var available_bangs:Array;
      
      public var available_acca:Array;
      
      public var available_accb:Array;
      
      public var available_accc:Array;
      
      public var available_accd:Array;
      
      public var which_pants:Number = 0;
      
      public var which_shirt:Number = 0;
      
      public var which_jacket:Number = 0;
      
      public var which_hair:Number = 0;
      
      public var which_hat:Number = 0;
      
      public var which_shoes:Number = 0;
      
      public var which_facialhair:Number = 0;
      
      public var which_bangs:Number = 0;
      
      public var which_acca:Number = 0;
      
      public var which_accb:Number = 0;
      
      public var which_accc:Number = 0;
      
      public var which_accd:Number = 0;
      
      public var numSkinSwatches:Number = 9;
      
      public var numHairSwatches:Number = 32;
      
      public var firsttime:Boolean = false;
      
      public var firstwaiter:Boolean = false;
      
      public var inMenu:Boolean = false;
      
      public var didChange:Boolean = false;
      
      public var didClickChangeName:Boolean = false;
      
      public var mannequinColor:uint = 14540253;
      
      public var backdropBitmap:Bitmap;
      
      public var mirrorBitmap:Bitmap;
      
      public var photoBitmap:Bitmap = null;
      
      public var whichMode:String = "worker";
      
      public var leavingWorker:Worker = null;
      
      public var leavingWorkerReverse:Worker = null;
      
      public var runSpeed:Number = 8;
      
      public var isRunning:Boolean = false;
      
      public var hairPage:Number = 0;
      
      public var bangsPage:Number = 0;
      
      public var clothingPage:Number = 0;
      
      public var hairPerPage:Number = 8;
      
      public var clothingPerPage:Number = 15;
      
      public var clothingMode:String = "shirt";
      
      public var clothingSectionTypes:Array;
      
      public var clothingSectionNames:Array;
      
      public var randomGuyHair:Array;
      
      public var randomGirlHair:Array;
      
      public var randomGirlBangs:Array;
      
      public var randomHairColors:Array;
      
      public var didOpenHairColor:Boolean = false;
      
      public function CharacterEditorScreen(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         var _loc4_:CharacterEditorScreen = null;
         this.available_pants = [];
         this.available_shirt = [];
         this.available_jacket = [];
         this.available_hair = [];
         this.available_hat = [];
         this.available_shoes = [];
         this.available_facialhair = [];
         this.available_bangs = [];
         this.available_acca = [];
         this.available_accb = [];
         this.available_accc = [];
         this.available_accd = [];
         this.clothingSectionTypes = [ClothingItem.TYPE_SHIRT,ClothingItem.TYPE_PANTS,ClothingItem.TYPE_SHOES,ClothingItem.TYPE_HAT,ClothingItem.TYPE_JACKET,ClothingItem.TYPE_ACC_FACE,ClothingItem.TYPE_ACC_BELT,ClothingItem.TYPE_ACC_ARMS,ClothingItem.TYPE_ACC_BODY];
         this.clothingSectionNames = ["SHIRTS","PANTS","SHOES","HATS","JACKETS","GLASSES","BELTS","ARMS","EXTRAS"];
         this.randomGuyHair = ["altback1","altfront1","short02","messyback2","messyfront1","smoothleft","smoothback2","wavyleft"];
         this.randomGirlHair = ["ponytailM","straightM","waveM","waveL","flipM","curlM","swirlL","pigtailsS","pigtailsL","flock","curlback"];
         this.randomGirlBangs = ["arc","beach","blunt","breeze","cheer","drape","fringe","hotrod","pixie","shy","split","sweep","bettie","clip"];
         this.randomHairColors = [4,7,10,11,12,13,14,15,18,19,20,21,22,23];
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.container = param2;
         _loc4_.params = param3;
         if(param3 != null)
         {
            if(param3.hasOwnProperty("firsttime"))
            {
               _loc4_.firsttime = param3.firsttime;
            }
            if(param3.hasOwnProperty("firstwaiter"))
            {
               trace("WAITER MODE!");
               _loc4_.firstwaiter = param3.firstwaiter;
            }
            if(param3.hasOwnProperty("inMenu"))
            {
               _loc4_.inMenu = param3.inMenu;
            }
         }
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:CharacterEditorScreen = this;
         _loc1_.clip = new characterEditorMC();
         if(_loc1_.firsttime || _loc1_.firstwaiter)
         {
            _loc1_.clip.menuMc.customize.genderpanel.visible = true;
            _loc1_.clip.menuMc.switcher.visible = false;
            _loc1_.clip.menuMc.tabs.visible = false;
            _loc1_.clip.menuMc.photo_btn.visible = false;
            _loc1_.clip.menuMc.customize.accd_panel.visible = true;
            _loc1_.clip.menuMc.customize.accd_label.visible = true;
         }
         else
         {
            _loc1_.clip.menuMc.customize.genderpanel.visible = false;
            _loc1_.clip.menuMc.customize.accd_panel.visible = false;
            _loc1_.clip.menuMc.customize.accd_label.visible = false;
         }
         if(_loc1_.firstwaiter)
         {
            _loc1_.whichMode = "waiter";
         }
         else
         {
            _loc1_.whichMode = "worker";
         }
         if(_loc1_.whichMode == "worker")
         {
            _loc1_.workerData = _loc1_.gameObj.workerData;
         }
         else if(_loc1_.whichMode == "waiter")
         {
            _loc1_.workerData = _loc1_.gameObj.var_151;
         }
         if(_loc1_.firsttime || _loc1_.firstwaiter)
         {
            _loc1_.workerData.hat = "";
            _loc1_.randomizeHair();
         }
         _loc1_.worker = new Worker(_loc1_.gameObj,_loc1_.clip.holder,_loc1_.workerData,_loc1_.workerX,_loc1_.workerY,_loc1_.workerScale,false,true);
         _loc1_.workerReverse = new Worker(_loc1_.gameObj,_loc1_.clip.mirror_holder,_loc1_.workerData,_loc1_.workerReverseX,_loc1_.workerReverseY,_loc1_.workerScale,true,true);
         _loc1_.worker.addShadow();
         _loc1_.workerReverse.addShadow();
         _loc1_.getAvailableClothing();
         if(_loc1_.firsttime == false && _loc1_.firstwaiter == false)
         {
            _loc1_.setupStats();
            _loc1_.setupClothingMenu();
         }
         _loc1_.setupCustomizeMenu();
         _loc1_.setupInterface();
         _loc1_.createBackdrop();
         _loc1_.checkRandomItems();
         _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         if(_loc1_.firsttime || _loc1_.firstwaiter)
         {
            _loc1_.container.addEventListener("clickBack",_loc1_.clickBack);
            _loc1_.container.addEventListener("clickContinue",_loc1_.clickContinue);
         }
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.gameObj.var_129.switchMusic("order");
      }
      
      public function checkRandomItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:ClothingData = _loc2_.gameObj.var_135;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.randomGuyHair.length)
         {
            if(_loc3_.clothingExists("hair_" + _loc2_.randomGuyHair[_loc1_]) == false)
            {
               class_7.error("ERROR - Could not find hair_" + _loc2_.randomGuyHair[_loc1_] + " for randomizer");
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.randomGirlHair.length)
         {
            if(_loc3_.clothingExists("hair_" + _loc2_.randomGirlHair[_loc1_]) == false)
            {
               class_7.error("ERROR - Could not find hair_" + _loc2_.randomGirlHair[_loc1_] + " for randomizer");
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.randomGirlBangs.length)
         {
            if(_loc3_.clothingExists("hairparts_b_" + _loc2_.randomGirlBangs[_loc1_]) == false)
            {
               class_7.error("ERROR - Could not find hairparts_b_" + _loc2_.randomGirlBangs[_loc1_] + " for randomizer");
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.randomHairColors.length)
         {
            if(WorkerData.hairColorOptions.length < _loc2_.randomHairColors[_loc1_])
            {
               class_7.error("ERROR - There is no Hair Color at Index " + _loc2_.randomHairColors[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      public function randomizeHair(param1:Boolean = true) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(_loc2_.workerData.gender == WorkerData.GENDER_FEMALE)
         {
            if(_loc2_.randomGirlHair != null && _loc2_.randomGirlHair.length > 0)
            {
               _loc2_.workerData.hair = "hair_" + _loc2_.randomGirlHair[Math.floor(Math.random() * _loc2_.randomGirlHair.length)];
            }
            if(_loc2_.randomGirlBangs != null && _loc2_.randomGirlBangs.length > 0)
            {
               _loc2_.workerData.bangs = "hairparts_b_" + _loc2_.randomGirlBangs[Math.floor(Math.random() * _loc2_.randomGirlBangs.length)];
            }
            if(param1)
            {
               if(_loc2_.randomHairColors != null && _loc2_.randomHairColors.length > 0)
               {
                  _loc2_.workerData.hairColor = WorkerData.hairColorOptions[_loc2_.randomHairColors[Math.floor(Math.random() * _loc2_.randomHairColors.length)]];
               }
            }
            _loc2_.workerData.facialhair = "";
         }
         else
         {
            if(_loc2_.randomGuyHair != null && _loc2_.randomGuyHair.length > 0)
            {
               _loc2_.workerData.hair = "hair_" + _loc2_.randomGuyHair[Math.floor(Math.random() * _loc2_.randomGuyHair.length)];
            }
            _loc2_.workerData.bangs = "";
            if(param1)
            {
               if(_loc2_.randomHairColors != null && _loc2_.randomHairColors.length > 0)
               {
                  _loc2_.workerData.hairColor = WorkerData.hairColorOptions[_loc2_.randomHairColors[Math.floor(Math.random() * _loc2_.randomHairColors.length)]];
               }
            }
         }
      }
      
      public function getAvailableClothing(param1:Boolean = true) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.available_hair = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_HAIR,_loc2_.workerData.gender,false,true);
         _loc2_.which_hair = _loc2_.available_hair.indexOf(_loc2_.workerData.hair);
         _loc2_.available_accd = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_ACC_FACE,_loc2_.workerData.gender,false,_loc2_.firsttime);
         _loc2_.available_accd.unshift("");
         _loc2_.which_accd = _loc2_.available_accd.indexOf(_loc2_.workerData.accd);
         _loc2_.available_facialhair = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_FACIALHAIR,_loc2_.workerData.gender,false,true);
         _loc2_.available_facialhair.unshift("");
         _loc2_.which_facialhair = _loc2_.available_facialhair.indexOf(_loc2_.workerData.facialhair);
         _loc2_.available_bangs = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_BANGS,_loc2_.workerData.gender,false,true);
         _loc2_.available_bangs.unshift("");
         _loc2_.which_bangs = _loc2_.available_bangs.indexOf(_loc2_.workerData.bangs);
         if(_loc2_.firsttime == false)
         {
            _loc2_.available_pants = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_PANTS,_loc2_.workerData.gender,false);
            _loc2_.which_pants = _loc2_.available_pants.indexOf(_loc2_.workerData.pants);
            _loc2_.available_shirt = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_SHIRT,_loc2_.workerData.gender,false);
            _loc2_.which_shirt = _loc2_.available_shirt.indexOf(_loc2_.workerData.shirt);
            _loc2_.available_jacket = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_JACKET,_loc2_.workerData.gender,false);
            _loc2_.available_jacket.unshift("");
            _loc2_.which_jacket = _loc2_.available_jacket.indexOf(_loc2_.workerData.jacket);
            _loc2_.available_shoes = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_SHOES,_loc2_.workerData.gender,false);
            _loc2_.which_shoes = _loc2_.available_shoes.indexOf(_loc2_.workerData.shoes);
            _loc2_.available_acca = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_ACC_BODY,_loc2_.workerData.gender,false);
            _loc2_.available_acca.unshift("");
            _loc2_.which_acca = _loc2_.available_acca.indexOf(_loc2_.workerData.acca);
            _loc2_.available_accb = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_ACC_BELT,_loc2_.workerData.gender,false);
            _loc2_.available_accb.unshift("");
            _loc2_.which_accb = _loc2_.available_accb.indexOf(_loc2_.workerData.accb);
            _loc2_.available_accc = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_ACC_ARMS,_loc2_.workerData.gender,false);
            _loc2_.available_accc.unshift("");
            _loc2_.which_accc = _loc2_.available_accc.indexOf(_loc2_.workerData.accc);
            _loc2_.available_hat = _loc2_.gameObj.var_135.getAvailableClothingTags(ClothingItem.TYPE_HAT,_loc2_.workerData.gender,false);
            _loc2_.available_hat.unshift("");
            _loc2_.which_hat = _loc2_.available_hat.indexOf(_loc2_.workerData.hat);
         }
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:CharacterEditorScreen = this;
         _loc5_.updateModeToggle();
         var _loc6_:Number = 0;
         if(_loc5_.draggingWhichSlider != null)
         {
            if(_loc5_.draggingWhichSlider == "eyeheight")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.eyeheight_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.eyeheight_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = Math.round((_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.EYE_HEIGHT_MAX - WorkerData.EYE_HEIGHT_MIN)) + WorkerData.EYE_HEIGHT_MIN;
               if(_loc5_.workerData.eyeHeight != _loc6_)
               {
                  _loc5_.workerData.adjustValue("eyeHeight",_loc6_);
                  _loc5_.worker.updateFacialLayout();
                  _loc5_.workerReverse.updateFacialLayout();
               }
            }
            else if(_loc5_.draggingWhichSlider == "eyespacing")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.eyespacing_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.eyespacing_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = Math.round((_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.EYE_SPACING_MAX - WorkerData.EYE_SPACING_MIN)) + WorkerData.EYE_SPACING_MIN;
               if(_loc5_.workerData.eyeSpacing != _loc6_)
               {
                  _loc5_.workerData.adjustValue("eyeSpacing",_loc6_);
                  _loc5_.worker.updateFacialLayout();
                  _loc5_.workerReverse.updateFacialLayout();
               }
            }
            else if(_loc5_.draggingWhichSlider == "mouthheight")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.mouthheight_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.mouthheight_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = Math.round((_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.MOUTH_HEIGHT_MAX - WorkerData.MOUTH_HEIGHT_MIN)) + WorkerData.MOUTH_HEIGHT_MIN;
               if(_loc5_.workerData.mouthHeight != _loc6_)
               {
                  _loc5_.workerData.adjustValue("mouthHeight",_loc6_);
                  _loc5_.worker.updateFacialLayout();
                  _loc5_.workerReverse.updateFacialLayout();
               }
            }
            else if(_loc5_.draggingWhichSlider == "headforward")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.headforward_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.headforward_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = Math.round((_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.HEAD_FORWARD_MAX - WorkerData.HEAD_FORWARD_MIN)) + WorkerData.HEAD_FORWARD_MIN;
               if(_loc5_.workerData.headForward != _loc6_)
               {
                  _loc5_.workerData.adjustValue("headForward",_loc6_);
                  _loc5_.worker.updateFacialLayout();
                  _loc5_.workerReverse.updateFacialLayout();
               }
            }
            else if(_loc5_.draggingWhichSlider == "headscale")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.headscale_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.headscale_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = (_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.HEAD_SCALE_MAX - WorkerData.HEAD_SCALE_MIN) + WorkerData.HEAD_SCALE_MIN;
               if(_loc5_.workerData.headScale != _loc6_)
               {
                  _loc5_.workerData.adjustValue("headScale",_loc6_);
                  _loc5_.worker.updateFacialLayout();
                  _loc5_.workerReverse.updateFacialLayout();
               }
            }
            else if(_loc5_.draggingWhichSlider == "weight")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.weight_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.weight_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = (_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.WEIGHT_SCALE_MAX - WorkerData.WEIGHT_SCALE_MIN) + WorkerData.WEIGHT_SCALE_MIN;
               if(_loc5_.workerData.weightScale != _loc6_)
               {
                  _loc5_.workerData.adjustValue("weightScale",_loc6_);
                  _loc5_.worker.updateWeight();
                  _loc5_.workerReverse.updateWeight();
               }
            }
            else if(_loc5_.draggingWhichSlider == "headheight")
            {
               _loc2_ = _loc5_.clip.menuMc.customize.headheight_panel.slider;
               _loc3_ = Number(_loc5_.clip.menuMc.customize.headheight_panel.mouseX);
               _loc2_.x = Math.min(Math.max(_loc3_,_loc5_.sliderStartX),_loc5_.sliderStartX + _loc5_.sliderRange);
               _loc6_ = Math.round((_loc2_.x - _loc5_.sliderStartX) / _loc5_.sliderRange * (WorkerData.HEAD_HEIGHT_MAX - WorkerData.HEAD_HEIGHT_MIN)) + WorkerData.HEAD_HEIGHT_MIN;
               if(_loc5_.workerData.headHeight != _loc6_)
               {
                  _loc5_.workerData.adjustValue("headHeight",_loc6_);
                  _loc5_.worker.updateFacialLayout();
                  _loc5_.workerReverse.updateFacialLayout();
               }
            }
         }
         if(_loc5_.clip.fader.currentFrame == _loc5_.clip.fader.totalFrames)
         {
            if(_loc5_.endaction == "back")
            {
               _loc5_.gameObj.var_132.api.method_106("SlotSelect");
               _loc5_.gameObj.var_132.api.method_105("CharacterEditor");
            }
            else if(_loc5_.firstwaiter)
            {
               _loc5_.gameObj.method_129(true);
               _loc5_.gameObj.method_167();
            }
            else
            {
               _loc5_.gameObj.method_162();
               _loc5_.gameObj.method_167();
            }
         }
         if(_loc5_.worker)
         {
            _loc5_.worker.animateModel();
            if(this.isRunning)
            {
               _loc5_.worker.clip.x += _loc5_.runSpeed;
               _loc5_.workerReverse.clip.x += _loc5_.runSpeed;
               if(_loc5_.worker.clip.x >= _loc5_.workerX)
               {
                  _loc5_.worker.clip.x = _loc5_.workerX;
                  _loc5_.workerReverse.clip.x = _loc5_.workerReverseX;
                  _loc5_.worker.playAnimation("react1");
                  _loc5_.workerReverse.playAnimation("react1_mirror");
                  _loc5_.isRunning = false;
               }
            }
         }
         if(_loc5_.workerReverse)
         {
            _loc5_.workerReverse.animateModel();
         }
         if(_loc5_.leavingWorker)
         {
            _loc5_.leavingWorker.animateModel();
            _loc5_.leavingWorker.clip.x += _loc5_.runSpeed;
         }
         if(_loc5_.leavingWorkerReverse)
         {
            _loc5_.leavingWorkerReverse.animateModel();
            if(_loc5_.leavingWorker.clip.x <= _loc5_.workerX)
            {
               _loc5_.leavingWorkerReverse.clip.x = _loc5_.leavingWorker.clip.x - 71;
               _loc5_.leavingWorkerReverse.clip.y = _loc5_.leavingWorker.clip.y - 31;
            }
            else
            {
               _loc4_ = _loc5_.leavingWorker.clip.x - _loc5_.workerX;
               _loc5_.leavingWorkerReverse.clip.x = _loc5_.workerReverseX - 0.6 * _loc4_;
               _loc5_.leavingWorkerReverse.clip.y = _loc5_.workerReverseY - 0.125 * _loc4_;
               _loc5_.leavingWorkerReverse.clip.scaleY = _loc5_.workerScale - 0.01 * (_loc4_ / this.runSpeed);
               _loc5_.leavingWorkerReverse.clip.scaleX = _loc5_.leavingWorkerReverse.clip.scaleY * -1;
            }
         }
         if(Boolean(_loc5_.leavingWorker) && Boolean(_loc5_.leavingWorkerReverse))
         {
            if(_loc5_.leavingWorker.clip.x >= 320 && _loc5_.leavingWorkerReverse.clip.x < 0)
            {
               trace("LEAVE GONE");
               _loc5_.leavingWorker.destroy();
               _loc5_.leavingWorker = null;
               _loc5_.leavingWorkerReverse.destroy();
               _loc5_.leavingWorkerReverse = null;
            }
         }
      }
      
      public function clickSectionStats(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.menuMc.tabs.gotoAndStop("stats");
         _loc2_.clip.menuMc.stats.visible = true;
         _loc2_.clip.menuMc.clothes.visible = false;
         _loc2_.clip.menuMc.customize.visible = false;
         _loc2_.clip.menuMc.switcher.visible = false;
         _loc2_.clip.menuMc.photo_btn.visible = false;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickSectionClothes(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.menuMc.tabs.gotoAndStop("clothes");
         _loc2_.clip.menuMc.stats.visible = false;
         _loc2_.clip.menuMc.clothes.visible = true;
         _loc2_.clip.menuMc.customize.visible = false;
         _loc2_.clip.menuMc.tabs.newstar.visible = false;
         _loc2_.clip.menuMc.tabs.newstar.stop();
         _loc2_.gameObj.var_128.hasNewClothing = false;
         _loc2_.clip.menuMc.clothes.shirt_tab.newstar.visible = false;
         _loc2_.clip.menuMc.clothes.shirt_tab.newstar.stop();
         _loc2_.gameObj.var_128.removeNewClothingFlag("shirt");
         if(_loc2_.gameObj.var_128.didCreateWaiter)
         {
            _loc2_.clip.menuMc.switcher.visible = true;
         }
         else
         {
            _loc2_.clip.menuMc.switcher.visible = false;
         }
         _loc2_.clip.menuMc.photo_btn.visible = true;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickSectionCustomize(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.menuMc.tabs.gotoAndStop("customize");
         _loc2_.clip.menuMc.stats.visible = false;
         _loc2_.clip.menuMc.clothes.visible = false;
         _loc2_.clip.menuMc.customize.visible = true;
         if(_loc2_.gameObj.var_128.didCreateWaiter)
         {
            _loc2_.clip.menuMc.switcher.visible = true;
         }
         else
         {
            _loc2_.clip.menuMc.switcher.visible = false;
         }
         _loc2_.clip.menuMc.photo_btn.visible = true;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickSlider(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(param1.currentTarget == _loc2_.clip.menuMc.customize.eyeheight_panel.slider)
         {
            _loc2_.draggingWhichSlider = "eyeheight";
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.eyespacing_panel.slider)
         {
            _loc2_.draggingWhichSlider = "eyespacing";
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.mouthheight_panel.slider)
         {
            _loc2_.draggingWhichSlider = "mouthheight";
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.headforward_panel.slider)
         {
            _loc2_.draggingWhichSlider = "headforward";
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.headscale_panel.slider)
         {
            _loc2_.draggingWhichSlider = "headscale";
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.headheight_panel.slider)
         {
            _loc2_.draggingWhichSlider = "headheight";
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.weight_panel.slider)
         {
            _loc2_.draggingWhichSlider = "weight";
         }
         _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseSlider);
         _loc2_.gameObj.stage.addEventListener(Event.MOUSE_LEAVE,_loc2_.releaseSlider);
         _loc2_.didChange = true;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function releaseSlider(param1:Event) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseSlider);
         _loc2_.gameObj.stage.removeEventListener(Event.MOUSE_LEAVE,_loc2_.releaseSlider);
         _loc2_.draggingWhichSlider = null;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function rolloverGender(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(param1.currentTarget == _loc2_.clip.menuMc.customize.genderpanel.male_btn && _loc2_.workerData.gender != WorkerData.GENDER_MALE)
         {
            _loc2_.clip.menuMc.customize.genderpanel.male_btn.gotoAndStop(3);
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.genderpanel.female_btn && _loc2_.workerData.gender != WorkerData.GENDER_FEMALE)
         {
            _loc2_.clip.menuMc.customize.genderpanel.female_btn.gotoAndStop(3);
         }
      }
      
      public function rolloutGender(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(param1.currentTarget == _loc2_.clip.menuMc.customize.genderpanel.male_btn && _loc2_.workerData.gender != WorkerData.GENDER_MALE)
         {
            _loc2_.clip.menuMc.customize.genderpanel.male_btn.gotoAndStop(2);
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.genderpanel.female_btn && _loc2_.workerData.gender != WorkerData.GENDER_FEMALE)
         {
            _loc2_.clip.menuMc.customize.genderpanel.female_btn.gotoAndStop(2);
         }
      }
      
      public function clickGender(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(param1.currentTarget == _loc2_.clip.menuMc.customize.genderpanel.male_btn)
         {
            _loc2_.workerData.setGender(WorkerData.GENDER_MALE);
            _loc2_.randomizeHair(!_loc2_.didOpenHairColor);
            _loc2_.workerData.bangs = "";
            _loc2_.getAvailableClothing(true);
            _loc2_.which_hair = _loc2_.available_hair.indexOf(_loc2_.workerData.hair);
            _loc2_.which_facialhair = _loc2_.available_facialhair.indexOf(_loc2_.workerData.facialhair);
            _loc2_.which_bangs = 0;
            _loc2_.populateHairPanels(true);
            _loc2_.populateBangsPanels(true);
            _loc2_.clip.menuMc.customize.haircolor_swatch.transform.colorTransform = _loc2_.createColorTransform(_loc2_.workerData.hairColor);
            _loc2_.updatePaletteSelection();
            _loc2_.worker.updateModelLook();
            _loc2_.workerReverse.updateModelLook();
            _loc2_.didChange = true;
            _loc2_.worker.playAnimation("react1");
            _loc2_.workerReverse.playAnimation("react1_mirror");
         }
         else if(param1.currentTarget == _loc2_.clip.menuMc.customize.genderpanel.female_btn)
         {
            _loc2_.workerData.setGender(WorkerData.GENDER_FEMALE);
            _loc2_.randomizeHair(!_loc2_.didOpenHairColor);
            _loc2_.workerData.facialhair = "";
            _loc2_.getAvailableClothing(true);
            _loc2_.which_hair = _loc2_.available_hair.indexOf(_loc2_.workerData.hair);
            _loc2_.which_bangs = _loc2_.available_bangs.indexOf(_loc2_.workerData.bangs);
            _loc2_.which_facialhair = 0;
            _loc2_.populateHairPanels(true);
            _loc2_.populateBangsPanels(true);
            _loc2_.clip.menuMc.customize.haircolor_swatch.transform.colorTransform = _loc2_.createColorTransform(_loc2_.workerData.hairColor);
            _loc2_.updatePaletteSelection();
            _loc2_.worker.updateModelLook();
            _loc2_.workerReverse.updateModelLook();
            _loc2_.didChange = true;
            _loc2_.worker.playAnimation("react1");
            _loc2_.workerReverse.playAnimation("react1_mirror");
         }
         if(_loc2_.workerData.gender == WorkerData.GENDER_MALE)
         {
            _loc2_.clip.menuMc.customize.genderpanel.male_btn.gotoAndStop(1);
            _loc2_.clip.menuMc.customize.genderpanel.female_btn.gotoAndStop(2);
         }
         else
         {
            _loc2_.clip.menuMc.customize.genderpanel.male_btn.gotoAndStop(2);
            _loc2_.clip.menuMc.customize.genderpanel.female_btn.gotoAndStop(1);
         }
      }
      
      public function clickChangeName(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(!_loc2_.isRunning)
         {
            _loc2_.didClickChangeName = true;
            _loc2_.clip.changeNameMC.visible = true;
            _loc2_.clip.changeNameMC.input_txt.setFocus();
            param1.stopImmediatePropagation();
            _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickScreenChangingName);
            _loc2_.gameObj.addEventListener(KeyboardEvent.KEY_DOWN,_loc2_.keyListener);
            _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function keyListener(param1:KeyboardEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(param1.keyCode == Keyboard.ENTER)
         {
            _loc2_.clickScreenChangingName(null,true);
         }
      }
      
      public function clickScreenChangingName(param1:MouseEvent = null, param2:Boolean = false) : void
      {
         var _loc3_:CharacterEditorScreen = this;
         if(param2 || param1.target.parent != _loc3_.clip.changeNameMC.input_txt)
         {
            _loc3_.gameObj.stage.focus = _loc3_.gameObj.stage;
            _loc3_.clip.changeNameMC.visible = false;
            _loc3_.clip.name_txt.text = String(_loc3_.clip.changeNameMC.input_txt.text);
            _loc3_.gameObj.removeEventListener(MouseEvent.MOUSE_DOWN,_loc3_.clickScreenChangingName);
            _loc3_.gameObj.removeEventListener(KeyboardEvent.KEY_DOWN,_loc3_.keyListener);
         }
      }
      
      public function clickChangeEyeType(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:CharacterEditorScreen = this;
         var _loc4_:Array = String(param1.currentTarget.name).split("_");
         var _loc5_:Number = 1;
         if(!_loc3_.isRunning)
         {
            if(_loc4_[0] == "prev")
            {
               _loc5_ = -1;
            }
            _loc2_ = _loc3_.workerData.eyeStyle + _loc5_;
            if(_loc2_ > WorkerData.EYE_STYLE_MAX * WorkerData.eyeColorOptionsDark.length)
            {
               _loc2_ = 1;
            }
            else if(_loc2_ < 1)
            {
               _loc2_ = WorkerData.EYE_STYLE_MAX * WorkerData.eyeColorOptionsDark.length;
            }
            if(_loc3_.workerData.eyeStyle != _loc2_)
            {
               _loc3_.workerData.adjustValue("eyeStyle",_loc2_);
               _loc3_.worker.redoClothing(ClothingItem.TYPE_HAIR);
               _loc3_.workerReverse.redoClothing(ClothingItem.TYPE_HAIR);
               _loc3_.didChange = true;
            }
            _loc3_.clip.menuMc.customize.eyetype_panel.amount_txt.text = String(_loc2_ + "/" + WorkerData.EYE_STYLE_MAX * WorkerData.eyeColorOptionsDark.length);
            _loc3_.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function clickChangeEyeDefault(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:CharacterEditorScreen = this;
         var _loc4_:Array = String(param1.currentTarget.name).split("_");
         var _loc5_:Number = 1;
         if(!_loc3_.isRunning)
         {
            if(_loc4_[0] == "prev")
            {
               _loc5_ = -1;
            }
            _loc2_ = WorkerData.eyeDefaultOptions.indexOf(_loc3_.workerData.eyeDefaultExpression) + _loc5_;
            if(_loc2_ >= WorkerData.eyeDefaultOptions.length)
            {
               _loc2_ = 0;
            }
            else if(_loc2_ < 0)
            {
               _loc2_ = WorkerData.eyeDefaultOptions.length - 1;
            }
            if(WorkerData.eyeDefaultOptions.length > _loc2_ && _loc3_.workerData.eyeDefaultExpression != WorkerData.eyeDefaultOptions[_loc2_])
            {
               _loc3_.workerData.adjustValue("eyeDefault",_loc2_);
               _loc3_.worker.updateFacialLayout();
               _loc3_.workerReverse.updateFacialLayout();
               _loc3_.didChange = true;
            }
            _loc3_.clip.menuMc.customize.eyedefault_panel.amount_txt.text = String(_loc2_ + 1 + "/" + WorkerData.eyeDefaultOptions.length);
            _loc3_.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function clickChangeMouthDefault(param1:MouseEvent) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:CharacterEditorScreen = this;
         var _loc4_:Array = String(param1.currentTarget.name).split("_");
         var _loc5_:Number = 1;
         if(!_loc3_.isRunning)
         {
            if(_loc4_[0] == "prev")
            {
               _loc5_ = -1;
            }
            _loc2_ = _loc3_.workerData.mouthDefaultExpression + _loc5_;
            if(_loc2_ > WorkerData.MOUTH_DEFAULT_MAX)
            {
               _loc2_ = 1;
            }
            else if(_loc2_ < 1)
            {
               _loc2_ = Number(WorkerData.MOUTH_DEFAULT_MAX);
            }
            if(_loc3_.workerData.mouthDefaultExpression != _loc2_)
            {
               _loc3_.workerData.adjustValue("mouthDefault",_loc2_);
               _loc3_.worker.updateFacialLayout();
               _loc3_.workerReverse.updateFacialLayout();
               _loc3_.didChange = true;
            }
            _loc3_.clip.menuMc.customize.mouthdefault_panel.amount_txt.text = String(_loc2_ + "/" + WorkerData.MOUTH_DEFAULT_MAX);
            _loc3_.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function clickChangeAccessory(param1:MouseEvent) : void
      {
         var type:String = null;
         var targetIndex:Number = NaN;
         type = null;
         var currentIndex:Number = Number(NaN);
         targetIndex = Number(NaN);
         var tag:String = null;
         var e:MouseEvent = param1;
         var ob:CharacterEditorScreen = this;
         var splitter:Array = String(e.currentTarget.name).split("_");
         var dir:Number = 1;
         if(!ob.isRunning)
         {
            if(splitter[0] == "prev")
            {
               dir = -1;
            }
            type = "accd";
            currentIndex = Number(ob["which_" + type]);
            targetIndex = currentIndex + dir;
            if(targetIndex < 0 && ob["available_" + type].length > 0)
            {
               targetIndex = ob["available_" + type].length - 1;
            }
            else if(targetIndex >= ob["available_" + type].length && ob["available_" + type].length > 0)
            {
               targetIndex = 0;
            }
            ob["which_" + type] = targetIndex;
            tag = "";
            try
            {
               tag = ob["available_" + type][targetIndex];
            }
            catch(err:Error)
            {
               class_7.error("Could not get new tag: type = " + type + ", index = " + targetIndex + ". Error: " + err.message);
            }
            ob.workerData[type] = tag;
            ob.worker.redoClothing(type);
            ob.workerReverse.redoClothing(type);
            ob.clip.menuMc.customize.accd_panel.amount_txt.text = String(targetIndex + 1 + "/" + ob["available_" + type].length);
            ob.didChange = true;
            ob.worker.playAnimation("react2");
            ob.workerReverse.playAnimation("react2_mirror");
            ob.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function clickBack(param1:Event) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(_loc2_.firstwaiter == true)
         {
            _loc2_.gameObj.showNewHireScreen();
            _loc2_.gameObj.var_132.api.method_105("WaiterEditor");
         }
         else
         {
            _loc2_.gameObj.var_132.api.method_106("SlotSelect");
            _loc2_.gameObj.var_132.api.method_105("CharacterEditor");
         }
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickContinue(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:CharacterEditorScreen = this;
         _loc3_.gameObj.var_129.playSound("buttonclick.wav");
         if(_loc3_.endaction == "none")
         {
            _loc2_ = _loc3_.clip.menuMc.customize.genderpanel.input_txt.text;
            if(_loc2_ == "" || _loc2_ == " " || _loc2_ == "  ")
            {
               _loc3_.clip.menuMc.customize.genderpanel.noname.gotoAndPlay(2);
               _loc3_.clip.menuMc.customize.genderpanel.input_txt.setFocus();
            }
            else
            {
               _loc3_.workerData.restoreHat();
               _loc3_.endaction = "continue";
               if(_loc3_.firstwaiter == true)
               {
                  _loc3_.gameObj.var_128.setWaiter(_loc2_,"custom",_loc3_.gameObj.var_135.getSKUsForInventory("custom",_loc3_.gameObj.var_151.gender,true));
               }
               else
               {
                  _loc3_.gameObj.var_128.createNewSlot(_loc3_.params.selectedSlot,_loc2_,"custom");
               }
               _loc3_.clip.mouseEnabled = false;
               _loc3_.clip.mouseChildren = false;
               _loc3_.clip.fader.gotoAndPlay("quickfadeout");
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:String = null;
         var _loc2_:CharacterEditorScreen = this;
         if(_loc2_.firsttime == false && _loc2_.firstwaiter == false)
         {
            _loc2_.setupStats(false);
            _loc2_.setupClothingMenu(false);
         }
         _loc2_.setupInterface(false);
         _loc2_.setupCustomizeMenu(false);
         if(_loc2_.photoBitmap != null)
         {
            _loc2_.photoBitmap.bitmapData.dispose();
            try
            {
               _loc2_.clip.poloroid.holder.removeChild(_loc2_.photoBitmap);
            }
            catch(err:Error)
            {
            }
            _loc2_.photoBitmap = null;
         }
         if(_loc2_.backdropBitmap != null)
         {
            _loc2_.backdropBitmap.bitmapData.dispose();
            try
            {
               _loc2_.clip.bgholder.removeChild(_loc2_.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            _loc2_.backdropBitmap = null;
         }
         if(_loc2_.mirrorBitmap != null)
         {
            _loc2_.mirrorBitmap.bitmapData.dispose();
            try
            {
               _loc2_.clip.mirrorbgholder.removeChild(_loc2_.mirrorBitmap);
            }
            catch(err:Error)
            {
            }
         }
         if(!_loc2_.firsttime && _loc2_.didClickChangeName)
         {
            _loc1_ = _loc2_.clip.changeNameMC.input_txt.text;
            if(_loc1_ != "" && _loc1_ != " " && _loc1_ != "  " && _loc1_ != "   ")
            {
               if(_loc2_.whichMode == "worker")
               {
                  _loc2_.gameObj.var_128.myName = _loc1_;
               }
               else if(_loc2_.whichMode == "waiter")
               {
                  _loc2_.gameObj.var_128.waiterName = _loc1_;
               }
               if(!_loc2_.didChange)
               {
                  class_7.info("SAVE NEW NAME");
                  _loc2_.gameObj.var_128.saveCharacterData();
               }
            }
         }
         if(_loc2_.didChange)
         {
            _loc2_.gameObj.var_132.api.method_175("workerChange");
            if(!_loc2_.firsttime)
            {
               class_7.info("SAVE CHANGE");
               _loc2_.gameObj.var_128.saveCharacterData();
            }
         }
         _loc2_.container.removeEventListener("clickBack",_loc2_.clickBack);
         _loc2_.container.removeEventListener("clickContinue",_loc2_.clickContinue);
         _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.updateScreen);
         _loc2_.worker.destroy();
         _loc2_.worker = null;
         _loc2_.workerReverse.destroy();
         _loc2_.workerReverse = null;
         _loc2_.container.removeChild(_loc2_.clip);
         _loc2_.clip = null;
      }
      
      public function clickBonusFacebook(param1:Event) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(_loc3_.didClickFacebook == false)
         {
            _loc2_.gameObj.var_132.api.method_107("http://www.facebook.com/pages/Flipline-Studios/121045844606187");
            _loc3_.didClickFacebook = true;
            _loc3_.totalTips += 5000;
            _loc3_.saveData();
            _loc2_.clip.menuMc.stats.tipstotal_txt.text = _loc3_.getTipsTotal(true,true);
            _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function clickBonusTwitter(param1:Event) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(_loc3_.didClickTwitter == false)
         {
            _loc2_.gameObj.var_132.api.method_107("http://www.twitter.com/FliplineStudios");
            _loc3_.didClickTwitter = true;
            _loc3_.totalTips += 5000;
            _loc3_.saveData();
            _loc2_.clip.menuMc.stats.tipstotal_txt.text = _loc3_.getTipsTotal(true,true);
            _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         }
      }
      
      public function setupCustomizeMenu(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:TextInput = null;
         var _loc5_:CharacterEditorScreen = this;
         if(param1)
         {
            _loc5_.clip.menuMc.customize.eyeheight_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.eyespacing_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.mouthheight_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.headforward_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.headscale_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.headheight_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.weight_panel.slider.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.eyetype_panel.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeType);
            _loc5_.clip.menuMc.customize.eyetype_panel.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeType);
            _loc5_.clip.menuMc.customize.eyedefault_panel.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeDefault);
            _loc5_.clip.menuMc.customize.eyedefault_panel.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeDefault);
            _loc5_.clip.menuMc.customize.mouthdefault_panel.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeMouthDefault);
            _loc5_.clip.menuMc.customize.mouthdefault_panel.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeMouthDefault);
            _loc5_.clip.menuMc.customize.accd_panel.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeAccessory);
            _loc5_.clip.menuMc.customize.accd_panel.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeAccessory);
            _loc5_.clip.menuMc.customize.haircolor_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.showHairColorPanel);
            _loc5_.clip.menuMc.customize.skincolor_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.showSkinColorPanel);
            _loc5_.setupPalettes();
            _loc5_.clip.menuMc.customize.hairpanel.hair_panel.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickHairPage);
            _loc5_.clip.menuMc.customize.hairpanel.hair_panel.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickHairPage);
            _loc5_.clip.menuMc.customize.hairpanel.hair_panel.notsupported.visible = false;
            _loc5_.clip.menuMc.customize.hairpanel.bang_panel.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickBangsPage);
            _loc5_.clip.menuMc.customize.hairpanel.bang_panel.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickBangsPage);
            _loc5_.clip.menuMc.customize.hairpanel.bang_panel.notsupported.visible = false;
            _loc2_ = 0;
            while(_loc2_ < _loc5_.hairPerPage)
            {
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].buttonMode = true;
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].useHandCursor = true;
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].mouseChildren = false;
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeHair);
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].addEventListener(MouseEvent.ROLL_OVER,_loc5_.rolloverHair);
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,_loc5_.rolloutHair);
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].buttonMode = true;
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].useHandCursor = true;
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].mouseChildren = false;
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeBangs);
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].addEventListener(MouseEvent.ROLL_OVER,_loc5_.rolloverBangs);
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,_loc5_.rolloutBangs);
               _loc2_++;
            }
            if(_loc5_.workerData.gender == WorkerData.GENDER_MALE)
            {
               _loc5_.clip.menuMc.customize.genderpanel.male_btn.gotoAndStop(1);
               _loc5_.clip.menuMc.customize.genderpanel.female_btn.gotoAndStop(2);
            }
            else
            {
               _loc5_.clip.menuMc.customize.genderpanel.male_btn.gotoAndStop(2);
               _loc5_.clip.menuMc.customize.genderpanel.female_btn.gotoAndStop(1);
            }
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.buttonMode = true;
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.useHandCursor = true;
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickGender);
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.addEventListener(MouseEvent.MOUSE_OVER,_loc5_.rolloverGender);
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.addEventListener(MouseEvent.MOUSE_OUT,_loc5_.rolloutGender);
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.buttonMode = true;
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.useHandCursor = true;
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickGender);
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.addEventListener(MouseEvent.MOUSE_OVER,_loc5_.rolloverGender);
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.addEventListener(MouseEvent.MOUSE_OUT,_loc5_.rolloutGender);
            if(_loc5_.firstwaiter)
            {
               _loc5_.clip.menuMc.customize.genderpanel.name_label.text = "SERVER\'S NAME:";
            }
            else
            {
               _loc5_.clip.menuMc.customize.genderpanel.name_label.text = "CHEF\'S NAME:";
            }
            _loc3_ = new TextFormat();
            _loc3_.font = "Arial";
            _loc3_.size = 24;
            _loc3_.bold = true;
            _loc3_.align = TextFormatAlign.CENTER;
            _loc4_ = _loc5_.clip.menuMc.customize.genderpanel.input_txt;
            _loc4_.setStyle("textFormat",_loc3_);
            _loc4_.maxChars = 16;
            _loc4_.restrict = "0-9A-Za-z \'\\-";
            _loc4_.setStyle("upSkin",TextInput_editor_upSkin);
            _loc4_.setStyle("focusRectSkin",editor_focusRectSkin);
            _loc5_.clip.menuMc.customize.genderpanel.noname.gotoAndStop(1);
            if(Boolean(class_3.method_60()) && class_1.method_101() == false)
            {
               _loc4_.editable = false;
               if(_loc5_.firstwaiter)
               {
                  _loc4_.text = "Server";
               }
               else
               {
                  _loc4_.text = "You";
               }
               _loc4_.mouseEnabled = false;
               _loc4_.mouseChildren = false;
            }
            _loc5_.populateCustomizePanels();
         }
         else
         {
            _loc5_.clip.menuMc.customize.eyeheight_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.eyespacing_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.mouthheight_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.headforward_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.headscale_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.headheight_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.weight_panel.slider.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickSlider);
            _loc5_.clip.menuMc.customize.eyetype_panel.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeType);
            _loc5_.clip.menuMc.customize.eyetype_panel.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeType);
            _loc5_.clip.menuMc.customize.eyedefault_panel.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeDefault);
            _loc5_.clip.menuMc.customize.eyedefault_panel.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeEyeDefault);
            _loc5_.clip.menuMc.customize.mouthdefault_panel.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeMouthDefault);
            _loc5_.clip.menuMc.customize.mouthdefault_panel.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeMouthDefault);
            _loc5_.clip.menuMc.customize.accd_panel.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeAccessory);
            _loc5_.clip.menuMc.customize.accd_panel.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeAccessory);
            _loc5_.clip.menuMc.customize.haircolor_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.showHairColorPanel);
            _loc5_.clip.menuMc.customize.skincolor_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.showSkinColorPanel);
            _loc5_.setupPalettes(false);
            _loc5_.clip.menuMc.customize.hairpanel.hair_panel.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickHairPage);
            _loc5_.clip.menuMc.customize.hairpanel.hair_panel.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickHairPage);
            _loc5_.clip.menuMc.customize.hairpanel.bang_panel.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickBangsPage);
            _loc5_.clip.menuMc.customize.hairpanel.bang_panel.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickBangsPage);
            _loc2_ = 0;
            while(_loc2_ < _loc5_.hairPerPage)
            {
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeHair);
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].removeEventListener(MouseEvent.ROLL_OVER,_loc5_.rolloverHair);
               _loc5_.clip.menuMc.customize.hairpanel.hair_panel["thumb" + _loc2_].removeEventListener(MouseEvent.ROLL_OUT,_loc5_.rolloutHair);
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeBangs);
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].removeEventListener(MouseEvent.ROLL_OVER,_loc5_.rolloverBangs);
               _loc5_.clip.menuMc.customize.hairpanel.bang_panel["thumb" + _loc2_].removeEventListener(MouseEvent.ROLL_OUT,_loc5_.rolloutBangs);
               _loc2_++;
            }
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickGender);
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.removeEventListener(MouseEvent.MOUSE_OVER,_loc5_.rolloverGender);
            _loc5_.clip.menuMc.customize.genderpanel.male_btn.removeEventListener(MouseEvent.MOUSE_OUT,_loc5_.rolloutGender);
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickGender);
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.removeEventListener(MouseEvent.MOUSE_OVER,_loc5_.rolloverGender);
            _loc5_.clip.menuMc.customize.genderpanel.female_btn.removeEventListener(MouseEvent.MOUSE_OUT,_loc5_.rolloutGender);
         }
      }
      
      public function updatePaletteSelection() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:CharacterEditorScreen = this;
         _loc1_ = _loc5_.clip.menuMc.customize.skincolor_palette;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.numSkinSwatches)
         {
            _loc3_ = 1118481;
            if(WorkerData.skinToneOptions.length > _loc4_)
            {
               _loc3_ = uint(WorkerData.skinToneOptions[_loc4_]);
            }
            _loc2_ = _loc1_["skincolor" + _loc4_];
            if(_loc5_.workerData.skinTone == _loc3_)
            {
               _loc2_.gotoAndStop(3);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
            _loc4_++;
         }
         _loc1_.visible = false;
         _loc1_ = _loc5_.clip.menuMc.customize.haircolor_palette;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.numHairSwatches)
         {
            _loc3_ = 1118481;
            if(WorkerData.hairColorOptions.length > _loc4_)
            {
               _loc3_ = uint(WorkerData.hairColorOptions[_loc4_]);
            }
            _loc2_ = _loc1_["haircolor" + _loc4_];
            if(_loc5_.workerData.hairColor == _loc3_)
            {
               _loc2_.gotoAndStop(3);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
            _loc4_++;
         }
      }
      
      public function setupPalettes(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:CharacterEditorScreen = this;
         if(param1)
         {
            _loc4_ = _loc8_.clip.menuMc.customize.skincolor_palette;
            _loc2_ = 0;
            while(_loc2_ < _loc8_.numSkinSwatches)
            {
               _loc3_ = 1118481;
               if(WorkerData.skinToneOptions.length > _loc2_)
               {
                  _loc3_ = uint(WorkerData.skinToneOptions[_loc2_]);
               }
               _loc4_.swatchholder.graphics.beginFill(_loc3_);
               _loc4_.swatchholder.graphics.drawRect(_loc2_ * 44,0,44,110);
               _loc4_.swatchholder.graphics.endFill();
               _loc5_ = _loc4_["skincolor" + _loc2_];
               _loc5_.mouseChildren = false;
               _loc5_.buttonMode = true;
               _loc5_.useHandCursor = true;
               if(_loc8_.workerData.skinTone == _loc3_)
               {
                  _loc5_.gotoAndStop(3);
               }
               else
               {
                  _loc5_.gotoAndStop(1);
               }
               _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,_loc8_.clickSkinColor);
               _loc5_.addEventListener(MouseEvent.MOUSE_OVER,_loc8_.rolloverSkinColor);
               _loc5_.addEventListener(MouseEvent.MOUSE_OUT,_loc8_.rolloutSkinColor);
               _loc2_++;
            }
            _loc4_.visible = false;
            _loc4_ = _loc8_.clip.menuMc.customize.haircolor_palette;
            _loc2_ = 0;
            while(_loc2_ < _loc8_.numHairSwatches)
            {
               _loc3_ = 1118481;
               if(WorkerData.hairColorOptions.length > _loc2_)
               {
                  _loc3_ = uint(WorkerData.hairColorOptions[_loc2_]);
               }
               _loc4_.swatchholder.graphics.beginFill(_loc3_);
               _loc6_ = Math.floor(_loc2_ / 8) * 29;
               _loc7_ = _loc2_ % 8 * 49;
               _loc4_.swatchholder.graphics.drawRect(_loc7_,_loc6_,49,26);
               _loc4_.swatchholder.graphics.endFill();
               _loc5_ = _loc4_["haircolor" + _loc2_];
               _loc5_.buttonMode = true;
               _loc5_.mouseChildren = false;
               _loc5_.useHandCursor = true;
               if(_loc8_.workerData.hairColor == _loc3_)
               {
                  _loc5_.gotoAndStop(3);
               }
               else
               {
                  _loc5_.gotoAndStop(1);
               }
               _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,_loc8_.clickHairColor);
               _loc5_.addEventListener(MouseEvent.MOUSE_OVER,_loc8_.rolloverHairColor);
               _loc5_.addEventListener(MouseEvent.MOUSE_OUT,_loc8_.rolloutHairColor);
               _loc2_++;
            }
            _loc4_.visible = false;
         }
         else
         {
            _loc4_ = _loc8_.clip.menuMc.customize.skincolor_palette;
            _loc4_.swatchholder.graphics.clear();
            _loc2_ = 0;
            while(_loc2_ < _loc8_.numSkinSwatches)
            {
               _loc5_ = _loc4_["skincolor" + _loc2_];
               _loc5_.removeEventListener(MouseEvent.MOUSE_DOWN,_loc8_.clickSkinColor);
               _loc5_.removeEventListener(MouseEvent.MOUSE_OVER,_loc8_.rolloverSkinColor);
               _loc5_.removeEventListener(MouseEvent.MOUSE_OUT,_loc8_.rolloutSkinColor);
               _loc2_++;
            }
            _loc4_ = _loc8_.clip.menuMc.customize.haircolor_palette;
            _loc4_.swatchholder.graphics.clear();
            _loc2_ = 0;
            while(_loc2_ < _loc8_.numHairSwatches)
            {
               _loc5_ = _loc4_["haircolor" + _loc2_];
               _loc5_.removeEventListener(MouseEvent.MOUSE_DOWN,_loc8_.clickHairColor);
               _loc5_.removeEventListener(MouseEvent.MOUSE_OVER,_loc8_.rolloverHairColor);
               _loc5_.removeEventListener(MouseEvent.MOUSE_OUT,_loc8_.rolloutHairColor);
               _loc2_++;
            }
         }
      }
      
      public function clickSkinColor(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:CharacterEditorScreen = this;
         var _loc5_:Number = Number(String(param1.currentTarget.name).split("skincolor")[1]);
         if(_loc5_ < WorkerData.skinToneOptions.length && _loc4_.workerData.skinTone != WorkerData.skinToneOptions[_loc5_])
         {
            _loc2_ = uint(WorkerData.skinToneOptions[_loc5_]);
            _loc4_.workerData.skinTone = _loc2_;
            _loc4_.worker.updateSkinTone();
            _loc4_.workerReverse.updateSkinTone();
            _loc4_.didChange = true;
            _loc3_ = 0;
            while(_loc3_ < _loc4_.numSkinSwatches)
            {
               if(_loc3_ < WorkerData.skinToneOptions.length && _loc2_ == WorkerData.skinToneOptions[_loc3_])
               {
                  _loc4_.clip.menuMc.customize.skincolor_palette["skincolor" + _loc3_].gotoAndStop(3);
               }
               else
               {
                  _loc4_.clip.menuMc.customize.skincolor_palette["skincolor" + _loc3_].gotoAndStop(1);
               }
               _loc3_++;
            }
            _loc4_.clip.menuMc.customize.skincolor_swatch.transform.colorTransform = _loc4_.createColorTransform(_loc4_.workerData.skinTone);
         }
         _loc4_.clip.menuMc.customize.skincolor_palette.visible = false;
         _loc4_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function rolloverSkinColor(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("skincolor")[1]);
         if(_loc3_ < WorkerData.skinToneOptions.length && _loc2_.workerData.skinTone != WorkerData.skinToneOptions[_loc3_])
         {
            MovieClip(param1.currentTarget).gotoAndStop(2);
         }
      }
      
      public function rolloutSkinColor(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("skincolor")[1]);
         if(_loc3_ < WorkerData.skinToneOptions.length && _loc2_.workerData.skinTone != WorkerData.skinToneOptions[_loc3_])
         {
            MovieClip(param1.currentTarget).gotoAndStop(1);
         }
      }
      
      public function clickHairColor(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:CharacterEditorScreen = this;
         var _loc5_:Number = Number(String(param1.currentTarget.name).split("haircolor")[1]);
         if(_loc5_ < WorkerData.hairColorOptions.length && _loc4_.workerData.hairColor != WorkerData.hairColorOptions[_loc5_])
         {
            _loc2_ = uint(WorkerData.hairColorOptions[_loc5_]);
            _loc4_.workerData.hairColor = _loc2_;
            _loc4_.worker.updateHairColor();
            _loc4_.workerReverse.updateHairColor();
            _loc4_.didChange = true;
            _loc3_ = 0;
            while(_loc3_ < _loc4_.numHairSwatches)
            {
               if(_loc3_ < WorkerData.hairColorOptions.length && _loc2_ == WorkerData.hairColorOptions[_loc3_])
               {
                  _loc4_.clip.menuMc.customize.haircolor_palette["haircolor" + _loc3_].gotoAndStop(3);
               }
               else
               {
                  _loc4_.clip.menuMc.customize.haircolor_palette["haircolor" + _loc3_].gotoAndStop(1);
               }
               _loc3_++;
            }
            _loc4_.populateHairPanels();
            _loc4_.populateBangsPanels();
            _loc4_.clip.menuMc.customize.haircolor_swatch.transform.colorTransform = _loc4_.createColorTransform(_loc4_.workerData.hairColor);
         }
         _loc4_.clip.menuMc.customize.haircolor_palette.visible = false;
         _loc4_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function rolloverHairColor(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("haircolor")[1]);
         if(_loc3_ < WorkerData.hairColorOptions.length && _loc2_.workerData.hairColor != WorkerData.hairColorOptions[_loc3_])
         {
            MovieClip(param1.currentTarget).gotoAndStop(2);
         }
      }
      
      public function rolloutHairColor(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("haircolor")[1]);
         if(_loc3_ < WorkerData.hairColorOptions.length && _loc2_.workerData.hairColor != WorkerData.hairColorOptions[_loc3_])
         {
            MovieClip(param1.currentTarget).gotoAndStop(1);
         }
      }
      
      public function showHairColorPanel(param1:Event = null) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.menuMc.customize.haircolor_palette.visible = true;
         _loc2_.clip.menuMc.customize.skincolor_palette.visible = false;
         _loc2_.didOpenHairColor = true;
      }
      
      public function showSkinColorPanel(param1:Event = null) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.menuMc.customize.haircolor_palette.visible = false;
         _loc2_.clip.menuMc.customize.skincolor_palette.visible = true;
      }
      
      public function clickHairPage(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_btn")[0];
         var _loc4_:Number = _loc2_.hairPage + 1;
         if(_loc3_ == "prev")
         {
            _loc4_ = _loc2_.hairPage - 1;
         }
         var _loc5_:Number = Math.ceil(_loc2_.available_hair.length / _loc2_.hairPerPage);
         if(_loc4_ >= _loc5_)
         {
            _loc4_ = 0;
         }
         else if(_loc4_ < 0)
         {
            _loc4_ += _loc5_;
         }
         _loc2_.hairPage = _loc4_;
         _loc2_.populateHairPanels();
      }
      
      public function clickBangsPage(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:CharacterEditorScreen = this;
         var _loc4_:String = String(param1.currentTarget.name).split("_btn")[0];
         var _loc5_:Number = _loc3_.bangsPage + 1;
         if(_loc4_ == "prev")
         {
            _loc5_ = _loc3_.bangsPage - 1;
         }
         if(_loc3_.workerData.gender == WorkerData.GENDER_FEMALE)
         {
            _loc2_ = _loc3_.available_bangs;
         }
         else
         {
            _loc2_ = _loc3_.available_facialhair;
         }
         var _loc6_:Number = Math.ceil(_loc2_.length / _loc3_.hairPerPage);
         if(_loc5_ >= _loc6_)
         {
            _loc5_ = 0;
         }
         else if(_loc5_ < 0)
         {
            _loc5_ += _loc6_;
         }
         _loc3_.bangsPage = _loc5_;
         _loc3_.populateBangsPanels();
      }
      
      public function clickChangeHair(param1:MouseEvent) : void
      {
         var tag:String;
         var i:int;
         var idx:Number = NaN;
         var type:String = null;
         idx = Number(NaN);
         type = null;
         var panelIndex:Number = Number(NaN);
         var e:MouseEvent = param1;
         var screen:CharacterEditorScreen = this;
         idx = Number(String(e.currentTarget.name).split("thumb")[1]);
         idx += screen.hairPage * screen.hairPerPage;
         type = "hair";
         screen["which_" + type] = idx;
         tag = "";
         try
         {
            tag = screen["available_" + type][idx];
         }
         catch(err:Error)
         {
            class_7.error("Could not get new tag: type = " + type + ", index = " + idx + ". Error: " + err.message);
         }
         screen.workerData[type] = tag;
         screen.worker.redoClothing(type);
         screen.workerReverse.redoClothing(type);
         screen.didChange = true;
         screen.worker.playAnimation("react2");
         screen.workerReverse.playAnimation("react2_mirror");
         screen.gameObj.var_129.playSound("buttonclick.wav");
         i = 0;
         while(i < screen.hairPerPage)
         {
            panelIndex = screen.hairPage * screen.hairPerPage + i;
            if(panelIndex < screen["available_" + type].length && screen.workerData[type] == screen["available_" + type][panelIndex])
            {
               screen.clip.menuMc.customize.hairpanel.hair_panel["thumb" + i].gotoAndStop(3);
            }
            else if(panelIndex >= screen["available_" + type].length)
            {
               screen.clip.menuMc.customize.hairpanel.hair_panel["thumb" + i].gotoAndStop(4);
            }
            else
            {
               screen.clip.menuMc.customize.hairpanel.hair_panel["thumb" + i].gotoAndStop(1);
            }
            i++;
         }
         if(screen.workerData.gender == WorkerData.GENDER_MALE || screen.gameObj.var_135.clothingHasOption(screen.workerData.hair,ClothingItem.OPTIONS_SUPPORTS_BANGS))
         {
            screen.clip.menuMc.customize.hairpanel.bang_panel.notsupported.visible = false;
         }
         else
         {
            screen.clip.menuMc.customize.hairpanel.bang_panel.notsupported.visible = true;
         }
      }
      
      public function clickChangeBangs(param1:MouseEvent) : void
      {
         var tag:String;
         var i:int;
         var idx:Number = NaN;
         var type:String = null;
         idx = Number(NaN);
         var useArray:Array = null;
         var useVar:String = null;
         type = null;
         var panelIndex:Number = Number(NaN);
         var e:MouseEvent = param1;
         var screen:CharacterEditorScreen = this;
         idx = Number(String(e.currentTarget.name).split("thumb")[1]);
         idx += screen.bangsPage * screen.hairPerPage;
         if(screen.workerData.gender == WorkerData.GENDER_MALE)
         {
            useArray = screen.available_facialhair;
            useVar = ClothingItem.TYPE_FACIALHAIR;
         }
         else
         {
            useArray = screen.available_bangs;
            useVar = ClothingItem.TYPE_BANGS;
         }
         type = useVar;
         screen["which_" + type] = idx;
         tag = "";
         try
         {
            tag = screen["available_" + type][idx];
         }
         catch(err:Error)
         {
            class_7.error("Could not get new tag: type = " + type + ", index = " + idx + ". Error: " + err.message);
         }
         screen.workerData[type] = tag;
         screen.worker.redoClothing(type);
         screen.workerReverse.redoClothing(type);
         screen.didChange = true;
         screen.gameObj.var_129.playSound("buttonclick.wav");
         i = 0;
         while(i < screen.hairPerPage)
         {
            panelIndex = screen.bangsPage * screen.hairPerPage + i;
            if(panelIndex < screen["available_" + type].length && screen.workerData[type] == screen["available_" + type][panelIndex])
            {
               screen.clip.menuMc.customize.hairpanel.bang_panel["thumb" + i].gotoAndStop(3);
            }
            else if(panelIndex >= screen["available_" + type].length)
            {
               screen.clip.menuMc.customize.hairpanel.bang_panel["thumb" + i].gotoAndStop(4);
            }
            else
            {
               screen.clip.menuMc.customize.hairpanel.bang_panel["thumb" + i].gotoAndStop(1);
            }
            i++;
         }
      }
      
      public function rolloverHair(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("thumb")[1]);
         _loc3_ += _loc2_.hairPage * _loc2_.hairPerPage;
         if(_loc3_ < _loc2_.available_hair.length)
         {
            if(_loc2_.workerData.hair != _loc2_.available_hair[_loc3_])
            {
               MovieClip(param1.currentTarget).gotoAndStop(2);
            }
         }
      }
      
      public function rolloutHair(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("thumb")[1]);
         _loc3_ += _loc2_.hairPage * _loc2_.hairPerPage;
         if(_loc3_ < _loc2_.available_hair.length)
         {
            if(_loc2_.workerData.hair != _loc2_.available_hair[_loc3_])
            {
               MovieClip(param1.currentTarget).gotoAndStop(1);
            }
         }
      }
      
      public function rolloverBangs(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("thumb")[1]);
         _loc3_ += _loc2_.bangsPage * _loc2_.hairPerPage;
         var _loc4_:Array = _loc2_.available_bangs;
         var _loc5_:String = ClothingItem.TYPE_BANGS;
         if(_loc2_.workerData.gender == WorkerData.GENDER_MALE)
         {
            _loc4_ = _loc2_.available_facialhair;
            _loc5_ = ClothingItem.TYPE_FACIALHAIR;
         }
         if(_loc3_ < _loc4_.length)
         {
            if(_loc2_.workerData[_loc5_] != _loc4_[_loc3_])
            {
               MovieClip(param1.currentTarget).gotoAndStop(2);
            }
         }
      }
      
      public function rolloutBangs(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("thumb")[1]);
         _loc3_ += _loc2_.bangsPage * _loc2_.hairPerPage;
         var _loc4_:Array = _loc2_.available_bangs;
         var _loc5_:String = ClothingItem.TYPE_BANGS;
         if(_loc2_.workerData.gender == WorkerData.GENDER_MALE)
         {
            _loc4_ = _loc2_.available_facialhair;
            _loc5_ = ClothingItem.TYPE_FACIALHAIR;
         }
         if(_loc3_ < _loc4_.length)
         {
            if(_loc2_.workerData[_loc5_] != _loc4_[_loc3_])
            {
               MovieClip(param1.currentTarget).gotoAndStop(1);
            }
         }
      }
      
      public function clickClothingPage(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         var _loc3_:String = String(param1.currentTarget.name).split("_btn")[0];
         var _loc4_:Number = _loc2_.clothingPage + 1;
         if(_loc3_ == "prev")
         {
            _loc4_ = _loc2_.clothingPage - 1;
         }
         var _loc5_:Array = _loc2_["available_" + _loc2_.clothingMode];
         var _loc6_:Number = Math.ceil(_loc5_.length / _loc2_.clothingPerPage);
         if(_loc4_ >= _loc6_)
         {
            _loc4_ = 0;
         }
         else if(_loc4_ < 0)
         {
            _loc4_ += _loc6_;
         }
         _loc2_.clothingPage = _loc4_;
         _loc2_.populateClothingPanels();
      }
      
      public function clickClothingTab(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         var _loc3_:String = String(param1.currentTarget.name).split("_tab")[0];
         MovieClip(param1.currentTarget).newstar.visible = false;
         MovieClip(param1.currentTarget).newstar.stop();
         _loc2_.gameObj.var_128.removeNewClothingFlag(_loc3_);
         _loc2_.clothingMode = _loc3_;
         _loc2_.populateClothingPanels(true);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.clothingSectionTypes.length)
         {
            if(_loc2_.clothingSectionTypes[_loc4_] == _loc3_)
            {
               _loc2_.clip.menuMc.clothes[_loc2_.clothingSectionTypes[_loc4_] + "_tab"].gotoAndStop(3);
            }
            else
            {
               _loc2_.clip.menuMc.clothes[_loc2_.clothingSectionTypes[_loc4_] + "_tab"].gotoAndStop(1);
            }
            _loc4_++;
         }
      }
      
      public function rolloverClothingTab(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_tab")[0];
         if(_loc3_ != _loc2_.clothingMode)
         {
            MovieClip(param1.currentTarget).gotoAndStop(2);
         }
      }
      
      public function rolloutClothingTab(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:String = String(param1.currentTarget.name).split("_tab")[0];
         if(_loc3_ != _loc2_.clothingMode)
         {
            MovieClip(param1.currentTarget).gotoAndStop(1);
         }
      }
      
      public function setupClothingMenu(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:CharacterEditorScreen = this;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc5_.clothingSectionTypes.length)
            {
               _loc3_ = _loc5_.clip.menuMc.clothes[_loc5_.clothingSectionTypes[_loc2_] + "_tab"];
               _loc3_.buttonMode = true;
               _loc3_.useHandCursor = true;
               _loc3_.mouseChildren = false;
               _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickClothingTab);
               _loc3_.addEventListener(MouseEvent.MOUSE_OVER,_loc5_.rolloverClothingTab);
               _loc3_.addEventListener(MouseEvent.MOUSE_OUT,_loc5_.rolloutClothingTab);
               _loc3_.theme.gotoAndStop(_loc5_.gameObj.var_135.getClothingThemeFrame(_loc5_.workerData[_loc5_.clothingSectionTypes[_loc2_]]));
               _loc3_.newstar.visible = _loc5_.gameObj.var_128.hasNewClothingFlag(_loc5_.clothingSectionTypes[_loc2_]);
               if(_loc3_.newstar.visible == false)
               {
                  _loc3_.newstar.stop();
               }
               if(_loc5_.clothingSectionTypes[_loc2_] == _loc5_.clothingMode)
               {
                  _loc3_.gotoAndStop(3);
               }
               else
               {
                  _loc3_.gotoAndStop(1);
               }
               _loc2_++;
            }
            _loc5_.clip.menuMc.clothes.prev_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickClothingPage);
            _loc5_.clip.menuMc.clothes.next_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickClothingPage);
            _loc2_ = 0;
            while(_loc2_ < _loc5_.clothingPerPage)
            {
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].buttonMode = true;
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].useHandCursor = true;
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].mouseChildren = false;
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeClothes);
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].addEventListener(MouseEvent.ROLL_OVER,_loc5_.rolloverClothes);
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,_loc5_.rolloutClothes);
               _loc2_++;
            }
            _loc5_.populateClothingPanels(true);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc5_.clothingSectionTypes.length)
            {
               _loc4_ = _loc5_.clip.menuMc.clothes[_loc5_.clothingSectionTypes[_loc2_] + "_tab"];
               _loc4_.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickClothingTab);
               _loc4_.removeEventListener(MouseEvent.MOUSE_OVER,_loc5_.rolloverClothingTab);
               _loc4_.removeEventListener(MouseEvent.MOUSE_OUT,_loc5_.rolloutClothingTab);
               _loc2_++;
            }
            _loc5_.clip.menuMc.clothes.prev_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickClothingPage);
            _loc5_.clip.menuMc.clothes.next_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickClothingPage);
            _loc2_ = 0;
            while(_loc2_ < _loc5_.clothingPerPage)
            {
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,_loc5_.clickChangeClothes);
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].removeEventListener(MouseEvent.ROLL_OVER,_loc5_.rolloverClothes);
               _loc5_.clip.menuMc.clothes["thumb" + _loc2_].removeEventListener(MouseEvent.ROLL_OUT,_loc5_.rolloutClothes);
               _loc2_++;
            }
         }
      }
      
      public function setupInterface(param1:Boolean = true) : void
      {
         var _loc2_:TextFormat = null;
         var _loc3_:TextInput = null;
         var _loc4_:CharacterEditorScreen = this;
         if(param1)
         {
            if(_loc4_.firsttime)
            {
               _loc4_.clip.menuMc.customize.visible = true;
               _loc4_.clip.menuMc.stats.visible = false;
               _loc4_.clip.menuMc.clothes.visible = false;
               _loc4_.clip.menuMc.tabs.visible = false;
               _loc4_.clip.menuMc.photo_btn.visible = false;
               _loc4_.clip.menuMc.switcher.visible = false;
               _loc4_.clip.name_txt.visible = false;
               _loc4_.clip.namerollover_btn.visible = false;
            }
            else
            {
               _loc4_.clip.menuMc.customize.visible = false;
               _loc4_.clip.menuMc.clothes.visible = false;
               _loc4_.clip.menuMc.stats.visible = true;
               _loc4_.clip.menuMc.tabs.visible = true;
               _loc4_.clip.menuMc.tabs.gotoAndStop("stats");
               _loc4_.clip.menuMc.photo_btn.visible = false;
               _loc4_.clip.menuMc.switcher.visible = false;
               if(_loc4_.gameObj.var_128.hasNewClothingTypes.length > 0)
               {
                  _loc4_.clip.menuMc.tabs.newstar.visible = true;
               }
               else
               {
                  _loc4_.clip.menuMc.tabs.newstar.visible = false;
                  _loc4_.clip.menuMc.tabs.newstar.stop();
               }
               _loc4_.clip.menuMc.tabs.newstar.mouseEnabled = false;
               _loc4_.clip.menuMc.tabs.newstar.mouseChildren = false;
               _loc4_.clip.name_txt.visible = true;
               _loc4_.clip.namerollover_btn.visible = true;
               if(_loc4_.gameObj.var_128.whichCharacter == "marty" || _loc4_.gameObj.var_128.whichCharacter == "rita")
               {
                  _loc4_.clip.menuMc.tabs.body_btn.visible = false;
                  _loc4_.clip.namerollover_btn.visible = false;
               }
               if(Boolean(class_3.method_60()) && class_1.method_101() == false)
               {
                  _loc4_.clip.namerollover_btn.visible = false;
               }
            }
            _loc4_.clip.changeNameMC.visible = false;
            _loc4_.clip.name_txt.mouseEnabled = false;
            _loc4_.clip.namerollover_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickChangeName);
            _loc4_.clip.name_txt.text = String(_loc4_.gameObj.var_128.myName);
            _loc2_ = new TextFormat();
            _loc2_.font = "Arial";
            _loc2_.size = 14;
            _loc2_.bold = true;
            _loc2_.align = TextFormatAlign.CENTER;
            _loc3_ = _loc4_.clip.changeNameMC.input_txt;
            _loc4_.clip.changeNameMC.input_txt.setStyle("textFormat",_loc2_);
            _loc4_.clip.changeNameMC.input_txt.maxChars = 16;
            _loc4_.clip.changeNameMC.input_txt.restrict = "0-9A-Za-z \'\\-";
            _loc4_.clip.changeNameMC.input_txt.text = String(_loc4_.gameObj.var_128.myName);
            _loc4_.clip.menuMc.tabs.stats_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSectionStats);
            _loc4_.clip.menuMc.tabs.clothes_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSectionClothes);
            _loc4_.clip.menuMc.tabs.body_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSectionCustomize);
            _loc4_.clip.menuMc.photo_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickTakePhoto);
            _loc4_.clip.poloroid.visible = false;
            _loc4_.clip.poloroid.holder.mask = _loc4_.clip.poloroid.masker;
            _loc4_.clip.poloroid.flasher.gotoAndStop(1);
            _loc4_.clip.poloroid.save_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSavePhoto);
            _loc4_.clip.poloroid.close_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickClosePhoto);
            _loc4_.clip.menuMc.switcher.slider.switch_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSwitchWorkerMode);
            if(_loc4_.gameObj.var_128.didCreateWaiter == false)
            {
               _loc4_.clip.menuMc.switcher.visible = false;
            }
         }
         else
         {
            _loc4_.clip.namerollover_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickChangeName);
            _loc4_.gameObj.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickScreenChangingName);
            _loc4_.gameObj.removeEventListener(KeyboardEvent.KEY_DOWN,_loc4_.keyListener);
            _loc4_.clip.menuMc.tabs.stats_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSectionStats);
            _loc4_.clip.menuMc.tabs.clothes_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSectionClothes);
            _loc4_.clip.menuMc.tabs.body_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSectionCustomize);
            _loc4_.clip.menuMc.photo_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickTakePhoto);
            _loc4_.clip.poloroid.save_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSavePhoto);
            _loc4_.clip.poloroid.close_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickClosePhoto);
            _loc4_.clip.menuMc.switcher.slider.switch_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc4_.clickSwitchWorkerMode);
         }
      }
      
      public function setupStats(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Boolean = false;
         var _loc10_:MovieClip = null;
         var _loc11_:CharacterEditorScreen = this;
         var _loc12_:UserData = _loc11_.gameObj.var_128;
         if(param1)
         {
            _loc11_.clip.menuMc.stats.xpbar.bar.mask = _loc11_.clip.menuMc.stats.xpbar.masker;
            _loc11_.clip.menuMc.stats.xpbar.bar.x = _loc12_.getCurrentPointPercentage() * 219;
            if(_loc11_.clip.menuMc.stats.xpbar.bar.x == 219)
            {
               _loc11_.clip.menuMc.stats.xpbar.bar.x = 243;
            }
            _loc3_ = _loc12_.getMonth();
            if(_loc3_ == GameData.STARTER_MONTH && _loc12_.isNewYear() == false)
            {
               _loc3_ = 13;
            }
            _loc11_.clip.menuMc.stats.holiday.gotoAndStop(_loc3_);
            _loc4_ = _loc12_.getDay();
            _loc5_ = (_loc4_ - 1) % 7;
            _loc2_ = 0;
            while(_loc2_ <= 6)
            {
               _loc10_ = _loc11_.clip.menuMc.stats["day" + _loc2_];
               if(_loc2_ == 6)
               {
                  _loc10_.gotoAndStop(2);
                  _loc10_.payday.visible = true;
               }
               else
               {
                  _loc10_.payday.visible = false;
               }
               if(_loc2_ < _loc5_)
               {
                  _loc10_.circle.visible = false;
                  _loc10_.day.visible = false;
                  _loc10_.calx.visible = true;
               }
               else if(_loc2_ == _loc5_)
               {
                  _loc10_.circle.visible = true;
                  _loc10_.day.visible = true;
                  _loc10_.payday.visible = false;
                  _loc10_.calx.visible = false;
                  _loc10_.day.day_txt.text = String(_loc4_);
               }
               else if(_loc2_ > _loc5_)
               {
                  _loc10_.circle.visible = false;
                  _loc10_.day.visible = false;
                  _loc10_.calx.visible = false;
               }
               _loc2_++;
            }
            _loc6_ = _loc12_.getTipsToday();
            _loc7_ = _loc12_.getTodayTotalScore();
            _loc11_.clip.menuMc.stats.tipstoday_txt.text = _loc12_.getTipsToday(true);
            _loc11_.clip.menuMc.stats.tipstotal_txt.text = _loc12_.getTipsTotal(true,true);
            _loc11_.clip.menuMc.stats.pointstoday_txt.text = class_13.method_110(_loc12_.getTodayTotalScore());
            _loc11_.clip.menuMc.stats.pointstotal_txt.text = class_13.method_110(_loc12_.getTotalPoints(true));
            _loc11_.clip.menuMc.stats.rank_txt.text = _loc12_.getRank();
            _loc11_.clip.menuMc.stats.rank_title.text = _loc12_.getRankTitle();
            if(_loc6_ == 0)
            {
               _loc11_.clip.menuMc.stats.tipstoday_txt.text = "--";
            }
            if(_loc7_ == 0)
            {
               _loc11_.clip.menuMc.stats.pointstoday_txt.text = "--";
            }
            _loc8_ = _loc12_.getPointsUntilNextRank(true);
            if(_loc8_ < 0)
            {
               _loc8_ = 0;
            }
            _loc11_.clip.menuMc.stats.morepoints_txt.htmlText = "<b>" + class_13.method_110(_loc8_) + " more points to Rank " + (_loc12_.getRank() + 1) + "</b>";
            _loc11_.clip.menuMc.stats.wage_txt.text = _loc12_.getWeeklyWage(true);
            _loc11_.clip.menuMc.stats.payday_txt.text = _loc12_.getPaydayMessage();
            _loc9_ = true;
            if(_loc11_.inMenu)
            {
               _loc9_ = false;
            }
            if(Boolean(class_3.method_60()) && class_1.method_92() == false)
            {
               _loc9_ = false;
            }
            if(_loc9_)
            {
               if(_loc12_.didClickFacebook != false)
               {
                  if(_loc12_.didClickTwitter == false)
                  {
                  }
               }
               if(_loc12_.didClickFacebook && _loc12_.didClickTwitter)
               {
               }
            }
            _loc11_.clip.menuMc.stats.changespecial_btn.addEventListener(MouseEvent.CLICK,_loc11_.clickChangeSpecial);
            _loc11_.clip.menuMc.stats.viewspecial_btn.addEventListener(MouseEvent.CLICK,_loc11_.clickViewSpecial);
            _loc11_.clip.menuMc.stats.trainspecial.visible = false;
            _loc11_.clip.menuMc.stats.trainspecial.icon.stop();
            _loc11_.clip.menuMc.stats.trainspecial.arrow.stop();
            if(_loc11_.gameObj.var_128.currentSpecial != -1)
            {
               _loc11_.clip.menuMc.stats.nospecial.visible = false;
               _loc11_.specialBitmap = new Bitmap(_loc11_.gameObj.var_133.getSpecialLogo(_loc11_.gameObj.var_128.currentSpecial),"auto",true);
               _loc11_.specialBitmap.scaleX = 0.72;
               _loc11_.specialBitmap.scaleY = 0.72;
               _loc11_.specialBitmapMC = new MovieClip();
               _loc11_.specialBitmapMC.addChild(_loc11_.specialBitmap);
               _loc11_.specialBitmapMC.x = 289;
               _loc11_.specialBitmapMC.y = 45;
               _loc11_.clip.menuMc.stats.addChild(_loc11_.specialBitmapMC);
               _loc11_.specialBitmapMC.buttonMode = true;
               _loc11_.specialBitmapMC.useHandCursor = true;
               _loc11_.specialBitmapMC.addEventListener(MouseEvent.CLICK,_loc11_.clickViewSpecial);
               if(_loc12_.getSpecialStars(_loc11_.gameObj.var_128.currentSpecial) >= _loc12_.starsToMasterSpecial)
               {
                  _loc11_.clip.menuMc.stats.masteredspecial.visible = true;
               }
               else
               {
                  _loc11_.clip.menuMc.stats.masteredspecial.visible = false;
               }
            }
            else
            {
               _loc11_.clip.menuMc.stats.nospecial.visible = true;
               if(_loc11_.gameObj.var_128.hasAnySpecials() == false)
               {
                  _loc11_.clip.menuMc.stats.changespecial_btn.visible = false;
                  _loc11_.clip.menuMc.stats.viewspecial_btn.visible = false;
               }
               else
               {
                  _loc11_.clip.menuMc.stats.viewspecial_btn.visible = false;
                  _loc11_.clip.menuMc.stats.changespecial_btn.x = 317;
                  if(_loc11_.inMenu == false && _loc11_.gameObj.var_128.hasTrained("openspecial") == false)
                  {
                     _loc11_.clip.menuMc.stats.trainspecial.visible = true;
                     _loc11_.clip.menuMc.stats.trainspecial.icon.play();
                     _loc11_.clip.menuMc.stats.trainspecial.arrow.play();
                  }
               }
               _loc11_.clip.menuMc.stats.masteredspecial.visible = false;
            }
            if(_loc11_.inMenu)
            {
               _loc11_.clip.menuMc.stats.changespecial_btn.visible = false;
               _loc11_.clip.menuMc.stats.viewspecial_btn.x = 317;
            }
            if(_loc11_.gameObj.var_128.hasNewSpecials() && !_loc11_.inMenu)
            {
               _loc11_.clip.menuMc.stats.newspecial.visible = true;
               _loc11_.clip.menuMc.stats.newspecial.mouseEnabled = false;
               _loc11_.clip.menuMc.stats.newspecial.mouseChildren = false;
            }
            else
            {
               _loc11_.clip.menuMc.stats.newspecial.stop();
               _loc11_.clip.menuMc.stats.newspecial.visible = false;
            }
         }
         else
         {
            _loc11_.clip.menuMc.stats.changespecial_btn.removeEventListener(MouseEvent.CLICK,_loc11_.clickChangeSpecial);
            _loc11_.clip.menuMc.stats.viewspecial_btn.removeEventListener(MouseEvent.CLICK,_loc11_.clickViewSpecial);
            if(_loc11_.specialBitmap)
            {
               if(_loc11_.specialBitmap.parent)
               {
                  _loc11_.specialBitmap.parent.removeChild(_loc11_.specialBitmap);
               }
               _loc11_.specialBitmap.bitmapData = null;
               _loc11_.specialBitmap = null;
            }
            if(_loc11_.specialBitmapMC)
            {
               _loc11_.specialBitmapMC.removeEventListener(MouseEvent.CLICK,_loc11_.clickViewSpecial);
               if(_loc11_.specialBitmapMC.parent)
               {
                  _loc11_.specialBitmapMC.parent.removeChild(_loc11_.specialBitmapMC);
               }
               _loc11_.specialBitmapMC = null;
            }
         }
      }
      
      public function clickViewSpecial(param1:MouseEvent = null) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.method_184(false);
      }
      
      public function clickChangeSpecial(param1:MouseEvent = null) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_132.api.method_175("clickCookbook");
         _loc2_.clip.menuMc.stats.changespecial_btn.mouseEnabled = false;
         _loc2_.clip.menuMc.stats.viewspecial_btn.mouseEnabled = false;
         _loc2_.gameObj.var_128.setTrained("openspecial");
      }
      
      private function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
      }
      
      private function createLobbyBackdropBitmap() : Bitmap
      {
         var _loc8_:BitmapData = null;
         var _loc1_:Number = Number(NaN);
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Bitmap = null;
         var _loc5_:MovieClip = new nowindowBackdropMC();
         var _loc6_:Number = 1;
         var _loc7_:Number = 1;
         if(!_loc2_.firsttime || _loc2_.firstwaiter)
         {
            _loc6_ = _loc3_.lobbyWallpaper;
            _loc7_ = _loc3_.lobbyFlooring;
         }
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc5_.holder.wallparts["wall" + _loc1_].gotoAndStop(_loc6_);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            _loc5_.holder.floorparts["floor" + _loc1_].gotoAndStop(_loc7_);
            _loc1_++;
         }
         _loc5_.holder.trim.transform.colorTransform = _loc2_.createColorTransform(_loc3_.lobbyTrim);
         _loc5_.holder.wallparts.mask = _loc5_.holder.wallmask;
         _loc5_.holder.floorparts.mask = _loc5_.holder.floormask;
         _loc8_ = new BitmapData(706,552,true,0);
         _loc8_.draw(_loc5_,null,null,null,new Rectangle(0,0,706,552));
         _loc4_ = new Bitmap(_loc8_);
         _loc5_ = null;
         return _loc4_;
      }
      
      public function createBackdrop() : void
      {
         var _loc1_:CharacterEditorScreen = this;
         if(_loc1_.backdropBitmap != null)
         {
            _loc1_.backdropBitmap.bitmapData.dispose();
            try
            {
               _loc1_.clip.bgholder.removeChild(_loc1_.backdropBitmap);
            }
            catch(err:Error)
            {
            }
            _loc1_.backdropBitmap = null;
         }
         _loc1_.backdropBitmap = _loc1_.createLobbyBackdropBitmap();
         _loc1_.clip.bgholder.addChild(_loc1_.backdropBitmap);
         _loc1_.clip.bgholder.mask = _loc1_.clip.bgmask;
         _loc1_.backdropBitmap.x = -3;
         _loc1_.backdropBitmap.y = -20;
         var _loc2_:BitmapData = new BitmapData(100,270,false,4294967295);
         _loc2_.copyPixels(_loc1_.backdropBitmap.bitmapData,new Rectangle(33,80,100,270),new Point(0,0));
         _loc2_.colorTransform(_loc2_.rect,new ColorTransform(1,1,1,1,100,100,100,0));
         _loc1_.mirrorBitmap = new Bitmap(_loc2_);
         _loc1_.mirrorBitmap.smoothing = true;
         var _loc3_:Matrix = new Matrix();
         _loc3_.b = 0.25;
         _loc3_.ty = 25;
         _loc1_.mirrorBitmap.transform.matrix = _loc3_;
         _loc1_.clip.mirrorbgholder.addChild(_loc1_.mirrorBitmap);
      }
      
      public function clickTakePhoto(param1:MouseEvent) : void
      {
         var _loc6_:MovieClip = null;
         var _loc8_:BitmapData = null;
         var _loc2_:CharacterEditorScreen = this;
         if(_loc2_.photoBitmap)
         {
            _loc2_.photoBitmap.bitmapData.dispose();
            _loc2_.photoBitmap.parent.removeChild(_loc2_.photoBitmap);
            _loc2_.photoBitmap = null;
         }
         var _loc3_:MovieClip = new MovieClip();
         var _loc4_:BitmapData = _loc2_.backdropBitmap.bitmapData;
         var _loc5_:Bitmap = new Bitmap(_loc4_);
         _loc3_.addChild(_loc5_);
         _loc5_.x = -300;
         _loc6_ = new MovieClip();
         _loc6_.graphics.beginFill(0,0.25);
         _loc6_.graphics.drawCircle(0,0,55);
         _loc6_.graphics.endFill();
         _loc6_.scaleY = 0.55;
         _loc6_.x = 144;
         _loc6_.y = 328;
         _loc3_.addChild(_loc6_);
         var _loc7_:Worker = new Worker(_loc2_.gameObj,_loc3_,_loc2_.workerData,80,60,0.9);
         _loc8_ = new BitmapData(315,370,false,4278190080);
         _loc8_.draw(_loc3_,null,null,null,new Rectangle(0,0,315,370),true);
         _loc2_.photoBitmap = new Bitmap(_loc8_,"auto",true);
         _loc2_.clip.poloroid.holder.addChild(_loc2_.photoBitmap);
         _loc2_.photoBitmap.scaleX = 0.8;
         _loc2_.photoBitmap.scaleY = 0.8;
         _loc2_.photoBitmap.x = -14;
         _loc2_.photoBitmap.y = 0;
         _loc2_.clip.poloroid.visible = true;
         _loc2_.clip.poloroid.flasher.gotoAndPlay(2);
         _loc2_.clip.poloroid.fader.gotoAndPlay(2);
         _loc2_.gameObj.var_129.playSound("takephoto.wav");
      }
      
      public function clickSavePhoto(param1:MouseEvent) : void
      {
         var jpgEncoder:class_15 = null;
         var byteArray:ByteArray = null;
         var useName:String = null;
         var fileReference:FileReference = null;
         var e:MouseEvent = param1;
         var screen:CharacterEditorScreen = this;
         var saveBMP:BitmapData = screen.photoBitmap.bitmapData.clone();
         var logomc:MovieClip = new poloroid_logo();
         var logobmp:BitmapData = new BitmapData(saveBMP.width,saveBMP.height,true,0);
         logobmp.draw(logomc);
         saveBMP.copyPixels(logobmp,logobmp.rect,new Point(0,0),null,null,true);
         logobmp.dispose();
         logobmp = null;
         try
         {
            jpgEncoder = new class_15(90);
            byteArray = jpgEncoder.method_237(saveBMP);
            useName = screen.gameObj.var_128.myName;
            if(screen.whichMode == "waiter")
            {
               useName = screen.gameObj.var_128.waiterName;
            }
            fileReference = new FileReference();
            fileReference.save(byteArray,useName + ".jpg");
         }
         catch(err:Error)
         {
            class_7.error("Error saving photo: " + err.message);
         }
         screen.clip.poloroid.visible = false;
      }
      
      public function clickClosePhoto(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.poloroid.visible = false;
      }
      
      public function clickSwitchWorkerMode(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         if(!_loc2_.isRunning)
         {
            if(_loc2_.clip.menuMc.switcher.slider.currentFrame == 1 || _loc2_.clip.menuMc.switcher.slider.currentFrame == _loc2_.clip.menuMc.switcher.slider.totalFrames)
            {
               if(_loc2_.whichMode == "worker")
               {
                  _loc2_.switchWorkerMode("waiter");
               }
               else
               {
                  _loc2_.switchWorkerMode("worker");
               }
               _loc2_.gameObj.var_129.playSound("buttonclick.wav");
            }
         }
      }
      
      public function switchWorkerMode(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:CharacterEditorScreen = this;
         if(_loc4_.didClickChangeName)
         {
            _loc2_ = _loc4_.clip.changeNameMC.input_txt.text;
            if(_loc2_ != "" && _loc2_ != " " && _loc2_ != "  " && _loc2_ != "   ")
            {
               if(_loc4_.whichMode == "worker")
               {
                  _loc4_.gameObj.var_128.myName = _loc2_;
               }
               else if(_loc4_.whichMode == "waiter")
               {
                  _loc4_.gameObj.var_128.waiterName = _loc2_;
               }
            }
         }
         _loc4_.whichMode = param1;
         _loc4_.updateModeToggle();
         if(_loc4_.whichMode == "worker")
         {
            _loc4_.workerData = _loc4_.gameObj.workerData;
         }
         else if(_loc4_.whichMode == "waiter")
         {
            _loc4_.workerData = _loc4_.gameObj.var_151;
         }
         if(_loc4_.whichMode == "worker")
         {
            if(_loc4_.gameObj.var_128.whichCharacter == "marty" || _loc4_.gameObj.var_128.whichCharacter == "rita")
            {
               _loc4_.clip.menuMc.tabs.body_btn.visible = false;
               _loc4_.clip.namerollover_btn.visible = false;
               if(_loc4_.clip.menuMc.customize.visible == true)
               {
                  _loc4_.clickSectionClothes(null);
               }
            }
            else
            {
               _loc4_.clip.menuMc.tabs.body_btn.visible = true;
               _loc4_.clip.namerollover_btn.visible = true;
               if(Boolean(class_3.method_60()) && class_1.method_101() == false)
               {
                  _loc4_.clip.namerollover_btn.visible = false;
               }
            }
         }
         else if(_loc4_.whichMode == "waiter")
         {
            if(_loc4_.gameObj.var_128.whichWaiter == "marty" || _loc4_.gameObj.var_128.whichWaiter == "rita")
            {
               _loc4_.clip.menuMc.tabs.body_btn.visible = false;
               _loc4_.clip.namerollover_btn.visible = false;
               if(_loc4_.clip.menuMc.customize.visible == true)
               {
                  _loc4_.clickSectionClothes(null);
               }
            }
            else
            {
               _loc4_.clip.menuMc.tabs.body_btn.visible = true;
               _loc4_.clip.namerollover_btn.visible = true;
               if(Boolean(class_3.method_60()) && class_1.method_101() == false)
               {
                  _loc4_.clip.namerollover_btn.visible = false;
               }
            }
         }
         _loc4_.getAvailableClothing();
         _loc4_.populateCustomizePanels();
         _loc4_.updatePaletteSelection();
         _loc4_.populateClothingPanels(true);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.clothingSectionTypes.length)
         {
            _loc3_ = _loc4_.clip.menuMc.clothes[_loc4_.clothingSectionTypes[_loc5_] + "_tab"];
            _loc3_.theme.gotoAndStop(_loc4_.gameObj.var_135.getClothingThemeFrame(_loc4_.workerData[_loc4_.clothingSectionTypes[_loc5_]]));
            _loc5_++;
         }
         if(_loc4_.whichMode == "worker")
         {
            _loc4_.clip.name_txt.text = _loc4_.gameObj.var_128.myName;
            _loc4_.clip.changeNameMC.input_txt.text = _loc4_.gameObj.var_128.myName;
         }
         else if(_loc4_.whichMode == "waiter")
         {
            _loc4_.clip.name_txt.text = _loc4_.gameObj.var_128.waiterName;
            _loc4_.clip.changeNameMC.input_txt.text = _loc4_.gameObj.var_128.waiterName;
         }
         if(_loc4_.worker)
         {
            if(_loc4_.leavingWorker)
            {
               _loc4_.leavingWorker.destroy();
               _loc4_.leavingWorker = null;
            }
            _loc4_.leavingWorker = _loc4_.worker;
            _loc4_.leavingWorker.playAnimation("run");
            _loc4_.worker = null;
         }
         if(_loc4_.workerReverse)
         {
            if(_loc4_.leavingWorkerReverse)
            {
               _loc4_.leavingWorkerReverse.destroy();
               _loc4_.leavingWorkerReverse = null;
            }
            _loc4_.leavingWorkerReverse = _loc4_.workerReverse;
            _loc4_.leavingWorkerReverse.playAnimation("runreverse");
            _loc4_.workerReverse = null;
         }
         _loc4_.worker = new Worker(_loc4_.gameObj,_loc4_.clip.holder,_loc4_.workerData,_loc4_.leavingWorker.clip.x + _loc4_.workerStartOffset,_loc4_.workerY,_loc4_.workerScale,false,true);
         _loc4_.workerReverse = new Worker(_loc4_.gameObj,_loc4_.clip.mirror_holder,_loc4_.workerData,_loc4_.leavingWorkerReverse.clip.x + _loc4_.workerStartOffset,_loc4_.workerReverseY,_loc4_.workerScale,true,true);
         _loc4_.isRunning = true;
         _loc4_.worker.playAnimation("run");
         _loc4_.workerReverse.playAnimation("runreverse");
         _loc4_.worker.addShadow();
         _loc4_.workerReverse.addShadow();
      }
      
      public function updateModeToggle() : void
      {
         var _loc1_:CharacterEditorScreen = this;
         if(_loc1_.whichMode == "worker")
         {
            if(_loc1_.clip.menuMc.switcher.slider.currentFrame > 1)
            {
               _loc1_.clip.menuMc.switcher.slider.prevFrame();
            }
         }
         else if(_loc1_.whichMode == "waiter")
         {
            if(_loc1_.clip.menuMc.switcher.slider.currentFrame < _loc1_.clip.menuMc.switcher.slider.totalFrames)
            {
               _loc1_.clip.menuMc.switcher.slider.nextFrame();
            }
         }
      }
      
      public function populateCustomizePanels() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:CharacterEditorScreen = this;
         _loc2_.clip.menuMc.customize.eyeheight_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.eyeHeight - WorkerData.EYE_HEIGHT_MIN) / (WorkerData.EYE_HEIGHT_MAX - WorkerData.EYE_HEIGHT_MIN) * _loc2_.sliderRange;
         _loc2_.clip.menuMc.customize.eyespacing_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.eyeSpacing - WorkerData.EYE_SPACING_MIN) / (WorkerData.EYE_SPACING_MAX - WorkerData.EYE_SPACING_MIN) * _loc2_.sliderRange;
         _loc2_.clip.menuMc.customize.mouthheight_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.mouthHeight - WorkerData.MOUTH_HEIGHT_MIN) / (WorkerData.MOUTH_HEIGHT_MAX - WorkerData.MOUTH_HEIGHT_MIN) * _loc2_.sliderRange;
         _loc2_.clip.menuMc.customize.headforward_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.headForward - WorkerData.HEAD_FORWARD_MIN) / (WorkerData.HEAD_FORWARD_MAX - WorkerData.HEAD_FORWARD_MIN) * _loc2_.sliderRange;
         _loc2_.clip.menuMc.customize.headscale_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.headScale - WorkerData.HEAD_SCALE_MIN) / (WorkerData.HEAD_SCALE_MAX - WorkerData.HEAD_SCALE_MIN) * _loc2_.sliderRange;
         _loc2_.clip.menuMc.customize.headheight_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.headHeight - WorkerData.HEAD_HEIGHT_MIN) / (WorkerData.HEAD_HEIGHT_MAX - WorkerData.HEAD_HEIGHT_MIN) * _loc2_.sliderRange;
         _loc2_.clip.menuMc.customize.weight_panel.slider.x = _loc2_.sliderStartX + (_loc2_.workerData.weightScale - WorkerData.WEIGHT_SCALE_MIN) / (WorkerData.WEIGHT_SCALE_MAX - WorkerData.WEIGHT_SCALE_MIN) * _loc2_.sliderRange;
         _loc1_ = _loc2_.workerData.eyeStyle;
         _loc2_.clip.menuMc.customize.eyetype_panel.amount_txt.text = String(_loc1_ + "/" + WorkerData.EYE_STYLE_MAX * WorkerData.eyeColorOptionsDark.length);
         _loc1_ = Number(WorkerData.eyeDefaultOptions.indexOf(_loc2_.workerData.eyeDefaultExpression));
         _loc2_.clip.menuMc.customize.eyedefault_panel.amount_txt.text = String(_loc1_ + 1 + "/" + WorkerData.eyeDefaultOptions.length);
         _loc1_ = _loc2_.workerData.mouthDefaultExpression;
         _loc2_.clip.menuMc.customize.mouthdefault_panel.amount_txt.text = String(_loc1_ + "/" + WorkerData.MOUTH_DEFAULT_MAX);
         _loc1_ = _loc2_.available_accd.indexOf(_loc2_.workerData.accd);
         _loc2_.clip.menuMc.customize.accd_panel.amount_txt.text = String(_loc1_ + 1 + "/" + _loc2_.available_accd.length);
         _loc2_.clip.menuMc.customize.haircolor_swatch.transform.colorTransform = _loc2_.createColorTransform(_loc2_.workerData.hairColor);
         _loc2_.clip.menuMc.customize.skincolor_swatch.transform.colorTransform = _loc2_.createColorTransform(_loc2_.workerData.skinTone);
         _loc2_.populateHairPanels(true);
         _loc2_.populateBangsPanels(true);
      }
      
      public function populateHairPanels(param1:Boolean = false) : void
      {
         var totalPages:Number;
         var maxDots:Number;
         var i:int = 0;
         var currentIndex:Number = Number(NaN);
         var panelIndex:Number = Number(NaN);
         var panel:MovieClip = null;
         var sku:String = null;
         var newThumb:MovieClip = null;
         var reset:Boolean = param1;
         var screen:CharacterEditorScreen = this;
         if(reset)
         {
            currentIndex = screen.available_hair.indexOf(screen.workerData.hair);
            if(currentIndex > -1)
            {
               screen.hairPage = Math.floor(currentIndex / screen.hairPerPage);
            }
         }
         totalPages = Math.ceil(screen.available_hair.length / screen.hairPerPage);
         maxDots = 10;
         i = 0;
         while(i < maxDots)
         {
            if(i == screen.hairPage)
            {
               screen.clip.menuMc.customize.hairpanel.hair_panel["dot" + i].visible = true;
               screen.clip.menuMc.customize.hairpanel.hair_panel["dot" + i].gotoAndStop(2);
            }
            else if(i < totalPages)
            {
               screen.clip.menuMc.customize.hairpanel.hair_panel["dot" + i].visible = true;
               screen.clip.menuMc.customize.hairpanel.hair_panel["dot" + i].gotoAndStop(1);
            }
            else
            {
               screen.clip.menuMc.customize.hairpanel.hair_panel["dot" + i].visible = false;
               screen.clip.menuMc.customize.hairpanel.hair_panel["dot" + i].gotoAndStop(1);
            }
            i++;
         }
         i = 0;
         while(i < screen.hairPerPage)
         {
            panelIndex = screen.hairPage * screen.hairPerPage + i;
            panel = screen.clip.menuMc.customize.hairpanel.hair_panel["thumb" + i];
            try
            {
               if(panel.thumb.numChildren > 0)
               {
                  panel.thumb.removeChildAt(0);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error removing hair thumb.");
            }
            if(panelIndex < screen.available_hair.length)
            {
               sku = screen.available_hair[panelIndex];
               newThumb = screen.gameObj.var_135.generateClothingThumb(sku,screen.workerData.gender,20,20,36,36,screen.workerData.hairColor);
               panel.thumb.addChild(newThumb);
               panel.mouseEnabled = true;
               newThumb.cacheAsBitmap = true;
               if(screen.workerData.hair == sku)
               {
                  panel.gotoAndStop(3);
               }
               else
               {
                  panel.gotoAndStop(1);
               }
            }
            else
            {
               panel.mouseEnabled = false;
               panel.mouseChildren = false;
               panel.gotoAndStop(4);
            }
            i++;
         }
      }
      
      public function populateBangsPanels(param1:Boolean = false) : void
      {
         var totalPages:Number;
         var maxDots:Number;
         var currentIndex:Number = Number(NaN);
         var i:int = 0;
         var useArray:Array = null;
         var useVar:String = null;
         var panelIndex:Number = Number(NaN);
         var panel:MovieClip = null;
         var sku:String = null;
         var useColor:uint = 0;
         var newThumb:MovieClip = null;
         var reset:Boolean = param1;
         var screen:CharacterEditorScreen = this;
         if(screen.workerData.gender == WorkerData.GENDER_FEMALE)
         {
            useArray = screen.available_bangs;
            useVar = ClothingItem.TYPE_BANGS;
         }
         else
         {
            useArray = screen.available_facialhair;
            useVar = ClothingItem.TYPE_FACIALHAIR;
         }
         if(reset)
         {
            if(screen.workerData.gender == WorkerData.GENDER_FEMALE)
            {
               currentIndex = screen.available_bangs.indexOf(screen.workerData.bangs);
               if(currentIndex > -1)
               {
                  screen.bangsPage = Math.floor(currentIndex / screen.hairPerPage);
               }
               if(screen.gameObj.var_135.clothingHasOption(screen.workerData.hair,ClothingItem.OPTIONS_SUPPORTS_BANGS))
               {
                  screen.clip.menuMc.customize.hairpanel.bang_panel.notsupported.visible = false;
               }
               else
               {
                  screen.clip.menuMc.customize.hairpanel.bang_panel.notsupported.visible = true;
               }
            }
            else
            {
               currentIndex = screen.available_facialhair.indexOf(screen.workerData.facialhair);
               if(currentIndex > -1)
               {
                  screen.bangsPage = Math.floor(currentIndex / screen.hairPerPage);
               }
               screen.clip.menuMc.customize.hairpanel.bang_panel.notsupported.visible = false;
            }
         }
         totalPages = Math.ceil(useArray.length / screen.hairPerPage);
         maxDots = 10;
         i = 0;
         while(i < maxDots)
         {
            if(i == screen.bangsPage)
            {
               screen.clip.menuMc.customize.hairpanel.bang_panel["dot" + i].visible = true;
               screen.clip.menuMc.customize.hairpanel.bang_panel["dot" + i].gotoAndStop(2);
            }
            else if(i < totalPages)
            {
               screen.clip.menuMc.customize.hairpanel.bang_panel["dot" + i].visible = true;
               screen.clip.menuMc.customize.hairpanel.bang_panel["dot" + i].gotoAndStop(1);
            }
            else
            {
               screen.clip.menuMc.customize.hairpanel.bang_panel["dot" + i].visible = false;
               screen.clip.menuMc.customize.hairpanel.bang_panel["dot" + i].gotoAndStop(1);
            }
            i++;
         }
         i = 0;
         while(i < screen.hairPerPage)
         {
            panelIndex = screen.bangsPage * screen.hairPerPage + i;
            panel = screen.clip.menuMc.customize.hairpanel.bang_panel["thumb" + i];
            try
            {
               if(panel.thumb.numChildren > 0)
               {
                  panel.thumb.removeChildAt(0);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error removing hair thumb.");
            }
            if(panelIndex < useArray.length)
            {
               sku = useArray[panelIndex];
               useColor = screen.workerData.getHairColor();
               if(screen.workerData.gender == WorkerData.GENDER_MALE)
               {
                  useColor = screen.workerData.getFacialHairColor();
               }
               newThumb = screen.gameObj.var_135.generateClothingThumb(sku,screen.workerData.gender,20,20,36,36,useColor);
               panel.thumb.addChild(newThumb);
               panel.mouseEnabled = true;
               newThumb.cacheAsBitmap = true;
               if(screen.workerData[useVar] == sku)
               {
                  panel.gotoAndStop(3);
               }
               else
               {
                  panel.gotoAndStop(1);
               }
            }
            else
            {
               panel.mouseEnabled = false;
               panel.mouseChildren = false;
               panel.gotoAndStop(4);
            }
            i++;
         }
         if(screen.workerData.gender == WorkerData.GENDER_FEMALE)
         {
            screen.clip.menuMc.customize.hairpanel.label_txt.text = "BANG STYLE";
         }
         else
         {
            screen.clip.menuMc.customize.hairpanel.label_txt.text = "FACIAL HAIR";
         }
      }
      
      public function populateClothingPanels(param1:Boolean = false) : void
      {
         var totalPages:Number;
         var i:int = 0;
         var currentIndex:Number = Number(NaN);
         var panelIndex:Number = Number(NaN);
         var panel:MovieClip = null;
         var sku:String = null;
         var newThumb:MovieClip = null;
         var reset:Boolean = param1;
         var screen:CharacterEditorScreen = this;
         var useArray:Array = screen["available_" + screen.clothingMode];
         var useVar:String = screen.clothingMode;
         if(reset)
         {
            currentIndex = useArray.indexOf(screen.workerData[useVar]);
            if(currentIndex > -1)
            {
               screen.clothingPage = Math.floor(currentIndex / screen.clothingPerPage);
            }
         }
         i = 0;
         while(i < screen.clothingPerPage)
         {
            panelIndex = screen.clothingPage * screen.clothingPerPage + i;
            panel = screen.clip.menuMc.clothes["thumb" + i];
            try
            {
               if(panel.thumb.numChildren > 0)
               {
                  panel.thumb.removeChildAt(0);
               }
            }
            catch(err:Error)
            {
               class_7.error("Error removing hair thumb.");
            }
            if(panelIndex < useArray.length)
            {
               sku = useArray[panelIndex];
               newThumb = screen.gameObj.var_135.generateClothingThumb(sku,screen.workerData.gender,28,28,52,52,screen.workerData.hairColor);
               panel.thumb.addChild(newThumb);
               panel.mouseEnabled = true;
               newThumb.cacheAsBitmap = true;
               if(screen.workerData[useVar] == sku)
               {
                  panel.gotoAndStop(3);
               }
               else
               {
                  panel.gotoAndStop(1);
               }
               panel.theme.gotoAndStop(screen.gameObj.var_135.getClothingThemeFrame(sku));
               if(panel.theme.currentFrameLabel != "g")
               {
                  panel.theme_edge.visible = true;
                  if(screen.workerData[useVar] == sku)
                  {
                     panel.theme_edge.gotoAndStop(2);
                  }
                  else
                  {
                     panel.theme_edge.gotoAndStop(1);
                  }
               }
               else
               {
                  panel.theme_edge.visible = false;
               }
            }
            else
            {
               panel.mouseEnabled = false;
               panel.mouseChildren = false;
               panel.gotoAndStop(4);
               panel.theme.gotoAndStop("g");
               panel.theme_edge.gotoAndStop(1);
               panel.theme_edge.visible = false;
            }
            i++;
         }
         screen.clip.menuMc.clothes.label_txt.text = screen.clothingSectionNames[screen.clothingSectionTypes.indexOf(screen.clothingMode)];
         totalPages = Math.ceil(useArray.length / screen.clothingPerPage);
         screen.clip.menuMc.clothes.amount_txt.text = String(screen.clothingPage + 1 + "/" + totalPages);
      }
      
      public function clickChangeClothes(param1:MouseEvent) : void
      {
         var tag:String;
         var i:int;
         var idx:Number = NaN;
         var type:String = null;
         idx = Number(NaN);
         type = null;
         var panelIndex:Number = Number(NaN);
         var e:MouseEvent = param1;
         var screen:CharacterEditorScreen = this;
         idx = Number(String(e.currentTarget.name).split("thumb")[1]);
         idx += screen.clothingPage * screen.clothingPerPage;
         type = screen.clothingMode;
         screen["which_" + type] = idx;
         tag = "";
         try
         {
            tag = screen["available_" + type][idx];
         }
         catch(err:Error)
         {
            class_7.error("Could not get new tag: type = " + type + ", index = " + idx + ". Error: " + err.message);
         }
         screen.workerData[type] = tag;
         screen.worker.redoClothing(type);
         screen.workerReverse.redoClothing(type);
         screen.clip.menuMc.clothes[screen.clothingMode + "_tab"].theme.gotoAndStop(screen.gameObj.var_135.getClothingThemeFrame(tag));
         screen.didChange = true;
         if(!screen.isRunning)
         {
            if(type == "hair" || type == "accd" || type == "acca" || type == "hat")
            {
               screen.worker.playAnimation("react2");
               screen.workerReverse.playAnimation("react2_mirror");
            }
            else
            {
               screen.worker.playAnimation("react1");
               screen.workerReverse.playAnimation("react1_mirror");
            }
         }
         if(screen.workerData.shirt != "tint_vneck_ring_a" && screen.workerData.pants != "tint_pants_7_e" && screen.workerData.shoes != "tint_darkshoes1_a" && screen.workerData.jacket != "" && screen.workerData.jacket != "tint_workvest_a")
         {
            screen.gameObj.var_142.recordTagged("changeclothes");
         }
         screen.gameObj.var_129.playSound("buttonclick.wav");
         i = 0;
         while(i < screen.clothingPerPage)
         {
            panelIndex = screen.clothingPage * screen.clothingPerPage + i;
            if(panelIndex < screen["available_" + type].length && screen.workerData[type] == screen["available_" + type][panelIndex])
            {
               screen.clip.menuMc.clothes["thumb" + i].gotoAndStop(3);
               if(screen.clip.menuMc.clothes["thumb" + i].theme_edge.visible)
               {
                  screen.clip.menuMc.clothes["thumb" + i].theme_edge.gotoAndStop(2);
               }
            }
            else if(panelIndex >= screen["available_" + type].length)
            {
               screen.clip.menuMc.clothes["thumb" + i].gotoAndStop(4);
            }
            else
            {
               screen.clip.menuMc.clothes["thumb" + i].gotoAndStop(1);
               if(screen.clip.menuMc.clothes["thumb" + i].theme_edge.visible)
               {
                  screen.clip.menuMc.clothes["thumb" + i].theme_edge.gotoAndStop(1);
               }
            }
            i++;
         }
      }
      
      public function rolloverClothes(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("thumb")[1]);
         _loc3_ += _loc2_.clothingPage * _loc2_.clothingPerPage;
         var _loc4_:Array = _loc2_["available_" + _loc2_.clothingMode];
         if(_loc3_ < _loc4_.length)
         {
            if(_loc2_.workerData[_loc2_.clothingMode] != _loc4_[_loc3_])
            {
               MovieClip(param1.currentTarget).gotoAndStop(2);
            }
         }
      }
      
      public function rolloutClothes(param1:MouseEvent) : void
      {
         var _loc2_:CharacterEditorScreen = this;
         var _loc3_:Number = Number(String(param1.currentTarget.name).split("thumb")[1]);
         _loc3_ += _loc2_.clothingPage * _loc2_.clothingPerPage;
         var _loc4_:Array = _loc2_["available_" + _loc2_.clothingMode];
         if(_loc3_ < _loc4_.length)
         {
            if(_loc2_.workerData[_loc2_.clothingMode] != _loc4_[_loc3_])
            {
               MovieClip(param1.currentTarget).gotoAndStop(1);
            }
         }
      }
   }
}

