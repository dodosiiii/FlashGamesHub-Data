package cheeseGame.screens
{
   import cheeseGame.data.*;
   import cheeseGame.models.*;
   import fl.controls.TextInput;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   import flash.ui.*;
   import package_2.*;
   import package_3.*;
   import package_4.class_5;
   
   public class SlotSelectScreen
   {
      
      public var gameObj:class_5;
      
      public var container:MovieClip;
      
      public var clip:MovieClip;
      
      public var selectedSlot:Number = 0;
      
      public var isClosing:Boolean = false;
      
      public var isNewSlot:Boolean = false;
      
      public var currentMode:String = "slots";
      
      public var nameContinueButton:class_18;
      
      public var nameBackButton:class_18;
      
      public var selectedCharacter:String = "marty";
      
      public var workerChuck:Worker = null;
      
      public var workerMandi:Worker = null;
      
      public var workerCustom1:Worker = null;
      
      public var workerCustom2:Worker = null;
      
      public var missingWidget:MovieClip;
      
      public function SlotSelectScreen(param1:class_5, param2:MovieClip, param3:Object = null)
      {
         var _loc4_:SlotSelectScreen = null;
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.container = param2;
         _loc4_.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:SlotSelectScreen = this;
         _loc2_.clip = new slotSelectMC();
         var _loc3_:int = 1;
         while(_loc3_ <= 3)
         {
            _loc1_ = _loc2_.clip.slots["slot" + _loc3_ + "MC"];
            _loc1_.new_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickNewSlot);
            _loc1_.select_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickExistingSlot);
            _loc1_.delete_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickDeleteSlot);
            _loc1_.new_btn.tabEnabled = false;
            _loc1_.select_btn.tabEnabled = false;
            _loc1_.delete_btn.tabEnabled = false;
            _loc1_.confirmMC.yes_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickDeleteYes);
            _loc1_.confirmMC.no_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickDeleteNo);
            _loc1_.confirmMC.yes_btn.tabEnabled = false;
            _loc1_.confirmMC.no_btn.tabEnabled = false;
            _loc1_.savebackup_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickSaveBackup);
            _loc1_.loadbackup_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickLoadBackup);
            _loc1_.savebackup_btn.tabEnabled = false;
            _loc1_.loadbackup_btn.tabEnabled = false;
            _loc1_.confirmMC.visible = false;
            _loc3_++;
         }
         _loc2_.nameBackButton = new class_18(null,"< BACK","small","button","clickNameCancel",null,false,false,false,null,false,112);
         _loc2_.nameBackButton.x = 0;
         _loc2_.nameBackButton.y = 75;
         _loc2_.nameContinueButton = new class_18(null,"CONTINUE >","small","button","clickNameOK",null,false,false,false,null,false,112);
         _loc2_.nameContinueButton.x = 181;
         _loc2_.nameContinueButton.y = 75;
         _loc2_.clip.entername.input_holder.addChild(_loc2_.nameBackButton);
         _loc2_.clip.entername.input_holder.addChild(_loc2_.nameContinueButton);
         _loc2_.nameContinueButton.addEventListener("clickNameOK",_loc2_.clickEnterNameOK);
         _loc2_.nameBackButton.addEventListener("clickNameCancel",_loc2_.clickEnterNameCancel);
         _loc2_.clip.character.marty_panel.select_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickMarty);
         _loc2_.clip.character.rita_panel.select_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickRita);
         _loc2_.clip.character.custom_panel.select_btn.addEventListener(MouseEvent.CLICK,_loc2_.clickCustom);
         _loc2_.clip.character.marty_panel.name_txt.text = WorkerData.PREMADE_MALE_NAME;
         _loc2_.clip.character.marty_panel.name_txt.visible = true;
         _loc2_.clip.character.marty_panel.custom_txt.visible = false;
         _loc2_.clip.character.rita_panel.name_txt.text = WorkerData.PREMADE_FEMALE_NAME;
         _loc2_.clip.character.rita_panel.name_txt.visible = true;
         _loc2_.clip.character.rita_panel.custom_txt.visible = false;
         _loc2_.clip.character.custom_panel.name_txt.text = "Custom";
         _loc2_.clip.character.custom_panel.name_txt.visible = false;
         _loc2_.clip.character.custom_panel.custom_txt.visible = true;
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.font = "Arial";
         _loc4_.size = 24;
         _loc4_.bold = true;
         _loc4_.align = TextFormatAlign.CENTER;
         var _loc5_:TextInput = _loc2_.clip.entername.input_holder.input_txt;
         _loc2_.clip.entername.input_holder.input_txt.setStyle("textFormat",_loc4_);
         _loc2_.clip.entername.input_holder.input_txt.maxChars = 16;
         _loc2_.clip.entername.input_holder.input_txt.restrict = "0-9A-Za-z \'\\-";
         _loc2_.container.addEventListener("clickBack",_loc2_.clickBack);
         _loc2_.container.addChild(_loc2_.clip);
         _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.animateScreen);
         _loc2_.clip.addEventListener(KeyboardEvent.KEY_DOWN,_loc2_.keyListener);
         _loc2_.clip.entername.gotoAndStop(1);
         _loc2_.clip.slots.gotoAndStop(1);
         _loc2_.clip.character.gotoAndStop(1);
         _loc2_.missingWidget = _loc2_.clip.missing;
         _loc2_.gameObj.addChild(_loc2_.missingWidget);
         _loc2_.missingWidget.visible = false;
         _loc2_.missingWidget.mouseEnabled = true;
         _loc2_.missingWidget.mouseChildren = true;
         _loc2_.missingWidget.buttonMode = true;
         _loc2_.missingWidget.useHandCursor = true;
         _loc2_.missingWidget.addEventListener(MouseEvent.CLICK,_loc2_.clickMissingWidget);
         _loc2_.showSlots();
         class_4.method_74(_loc2_.gameObj,6,387,480);
      }
      
      public function keyListener(param1:KeyboardEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         if(_loc2_.currentMode == "entername" && param1.keyCode == Keyboard.ENTER)
         {
            _loc2_.clickEnterNameOK();
         }
      }
      
      public function clickBack(param1:Event) : void
      {
         var _loc2_:SlotSelectScreen = this;
         class_4.method_77();
         _loc2_.gameObj.var_132.api.method_106("SplashScreen");
         _loc2_.gameObj.var_132.api.method_105("SlotSelect");
      }
      
      public function getSlotData() : void
      {
         var _loc1_:Object = null;
         var _loc2_:MovieClip = null;
         var _loc3_:SlotSelectScreen = this;
         var _loc4_:Boolean = true;
         var _loc5_:int = 1;
         while(_loc5_ <= 3)
         {
            _loc1_ = _loc3_.gameObj.var_128.loadLabelsForSlot(_loc5_);
            _loc2_ = _loc3_.clip.slots["slot" + _loc5_ + "MC"];
            if(_loc1_)
            {
               _loc2_.name_txt.text = String(_loc1_.name);
               _loc2_.textclip.visible = true;
               _loc2_.textclip.points_txt.text = class_13.method_110(Number(_loc1_.score)) + " POINTS";
               _loc2_.textclip.rank_txt.text = _loc1_.rank;
               _loc2_.textclip.rank_title.text = _loc1_.title;
               _loc2_.select_btn.visible = true;
               _loc2_.new_btn.visible = false;
               _loc2_.delete_btn.visible = true;
               if(_loc3_.gameObj.var_132.method_126())
               {
                  _loc2_.savebackup_btn.visible = true;
                  _loc2_.loadbackup_btn.visible = false;
               }
               else
               {
                  _loc2_.savebackup_btn.visible = false;
                  _loc2_.loadbackup_btn.visible = false;
               }
               _loc4_ = false;
            }
            else
            {
               _loc2_.name_txt.text = "Empty Slot";
               _loc2_.textclip.visible = false;
               _loc2_.new_btn.visible = true;
               _loc2_.select_btn.visible = false;
               _loc2_.delete_btn.visible = false;
               if(_loc3_.gameObj.var_132.method_126())
               {
                  _loc2_.savebackup_btn.visible = false;
                  _loc2_.loadbackup_btn.visible = true;
               }
               else
               {
                  _loc2_.savebackup_btn.visible = false;
                  _loc2_.loadbackup_btn.visible = false;
               }
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            _loc3_.missingWidget.visible = true;
         }
         else
         {
            _loc3_.missingWidget.visible = false;
         }
      }
      
      public function clickNewSlot(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Number = 0;
         if(param1.currentTarget == _loc2_.clip.slots.slot1MC.new_btn)
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot2MC.new_btn)
         {
            _loc4_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot3MC.new_btn)
         {
            _loc4_ = 3;
         }
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.selectedSlot = _loc4_;
         _loc2_.isNewSlot = true;
         _loc2_.showCharacter();
      }
      
      public function clickExistingSlot(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Number = 0;
         if(param1.currentTarget == _loc2_.clip.slots.slot1MC.select_btn)
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot2MC.select_btn)
         {
            _loc4_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot3MC.select_btn)
         {
            _loc4_ = 3;
         }
         _loc3_.loadData(_loc4_);
         _loc2_.isNewSlot = false;
         _loc2_.gameObj.var_129.playSound("dropticket.wav");
         _loc2_.clip.slots.gotoAndPlay("hide");
         _loc2_.startClosingScreen();
      }
      
      public function clickSaveBackup(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Number = 0;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(param1.currentTarget == _loc2_.clip.slots.slot1MC.savebackup_btn)
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot2MC.savebackup_btn)
         {
            _loc4_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot3MC.savebackup_btn)
         {
            _loc4_ = 3;
         }
         if(_loc4_ != 0)
         {
            _loc2_.gameObj.var_132.api.method_133(_loc3_.loadSlotDataForBackup(_loc4_),_loc3_.saveSlotPrefix,"papascheeseria_backup_" + _loc4_,null);
         }
      }
      
      public function clickLoadBackup(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Number = 0;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         if(param1.currentTarget == _loc2_.clip.slots.slot1MC.loadbackup_btn)
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot2MC.loadbackup_btn)
         {
            _loc4_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot3MC.loadbackup_btn)
         {
            _loc4_ = 3;
         }
         if(_loc4_ != 0)
         {
            _loc2_.gameObj.var_132.api.method_142(_loc4_,_loc3_.saveSlotPrefix,"/",_loc2_.showSlots);
         }
      }
      
      public function clickMissingWidget(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.gameObj.var_132.api.method_261(_loc2_.gameObj.var_132.method_126());
      }
      
      public function clickDeleteSlot(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         if(param1.currentTarget == _loc2_.clip.slots.slot1MC.delete_btn)
         {
            _loc2_.clip.slots.slot1MC.confirmMC.visible = true;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot2MC.delete_btn)
         {
            _loc2_.clip.slots.slot2MC.confirmMC.visible = true;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot3MC.delete_btn)
         {
            _loc2_.clip.slots.slot3MC.confirmMC.visible = true;
         }
      }
      
      public function clickDeleteYes(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         var _loc3_:UserData = _loc2_.gameObj.var_128;
         var _loc4_:Number = 0;
         if(param1.currentTarget == _loc2_.clip.slots.slot1MC.confirmMC.yes_btn)
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot2MC.confirmMC.yes_btn)
         {
            _loc4_ = 2;
         }
         else if(param1.currentTarget == _loc2_.clip.slots.slot3MC.confirmMC.yes_btn)
         {
            _loc4_ = 3;
         }
         if(_loc4_ > 0)
         {
            _loc2_.gameObj.var_129.playSound("droptopping.wav");
            _loc3_.eraseSlot(_loc4_);
            _loc2_.showSlots();
         }
         else
         {
            trace("Unknown Target: " + param1.currentTarget);
         }
      }
      
      public function clickDeleteNo(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.clip.slots.slot1MC.confirmMC.visible = false;
         _loc2_.clip.slots.slot2MC.confirmMC.visible = false;
         _loc2_.clip.slots.slot3MC.confirmMC.visible = false;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
      }
      
      public function clickEnterNameOK(param1:Event = null) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.gameObj.var_128.createNewSlot(_loc2_.selectedSlot,_loc2_.clip.entername.input_holder.input_txt.text,_loc2_.selectedCharacter);
         _loc2_.clip.entername.gotoAndPlay("hide");
         _loc2_.startClosingScreen();
      }
      
      public function clickEnterNameCancel(param1:Event = null) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.showSlots();
      }
      
      public function clickMarty(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.selectedCharacter = "marty";
         _loc2_.gameObj.var_128.createNewSlot(_loc2_.selectedSlot,WorkerData.PREMADE_MALE_NAME,_loc2_.selectedCharacter);
         _loc2_.clip.character.gotoAndPlay("hide");
         _loc2_.startClosingScreen();
      }
      
      public function clickRita(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.selectedCharacter = "rita";
         _loc2_.gameObj.var_128.createNewSlot(_loc2_.selectedSlot,WorkerData.PREMADE_FEMALE_NAME,_loc2_.selectedCharacter);
         _loc2_.clip.character.gotoAndPlay("hide");
         _loc2_.startClosingScreen();
      }
      
      public function clickCustom(param1:MouseEvent) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.gameObj.var_129.playSound("buttonclick.wav");
         _loc2_.selectedCharacter = "custom";
         _loc2_.gameObj.workerData.setupDefaults();
         _loc2_.clip.character.gotoAndPlay("hide");
         _loc2_.startClosingScreen();
      }
      
      public function showSlots() : void
      {
         var _loc1_:SlotSelectScreen = this;
         _loc1_.currentMode = "slots";
         _loc1_.clip.slots.slot1MC.confirmMC.visible = false;
         _loc1_.clip.slots.slot2MC.confirmMC.visible = false;
         _loc1_.clip.slots.slot3MC.confirmMC.visible = false;
         _loc1_.getSlotData();
         if(_loc1_.clip.entername.currentFrame > 1 && _loc1_.clip.entername.currentFrame < _loc1_.clip.entername.totalFrames)
         {
            _loc1_.clip.entername.gotoAndPlay("hide");
         }
         if(_loc1_.clip.character.currentFrame > 1 && _loc1_.clip.character.currentFrame < _loc1_.clip.character.totalFrames)
         {
            _loc1_.clip.character.gotoAndPlay("hide");
         }
         _loc1_.gameObj.var_129.playSound("trayslide.wav");
         _loc1_.clip.slots.gotoAndPlay("show");
      }
      
      public function showCharacter() : void
      {
         var _loc4_:WorkerData = null;
         var _loc5_:WorkerData = null;
         var _loc1_:SlotSelectScreen = this;
         _loc1_.currentMode = "character";
         var _loc2_:WorkerData = new WorkerData();
         _loc2_.setupPremadeMale();
         _loc2_.hat = "";
         _loc1_.workerChuck = new Worker(_loc1_.gameObj,_loc1_.clip.character.marty_panel,_loc2_,134,70,0.55,false,true);
         _loc1_.workerChuck.clip.stop();
         var _loc3_:WorkerData = new WorkerData();
         _loc3_.setupPremadeFemale();
         _loc1_.workerMandi = new Worker(_loc1_.gameObj,_loc1_.clip.character.rita_panel,_loc3_,42,70,0.55);
         _loc1_.workerMandi.clip.stop();
         _loc4_ = new WorkerData();
         _loc4_.setupDefaults();
         _loc4_.setGender(WorkerData.GENDER_MALE);
         _loc4_.skinTone = 13537877;
         _loc4_.eyeStyle = 2;
         _loc4_.eyeDefaultExpression = 1;
         _loc4_.mouthDefaultExpression = 12;
         _loc4_.hairColor = 5718573;
         _loc4_.hair = "hair_messyfront2";
         _loc4_.facialhair = "goatee2";
         _loc4_.accd = "tint_glasses03_a";
         _loc4_.eyeHeight = 2;
         _loc4_.eyeSpacing = 0;
         _loc4_.mouthHeight = -2;
         _loc4_.headHeight = -3;
         _loc4_.headForward = 6;
         _loc1_.workerCustom1 = new Worker(_loc1_.gameObj,_loc1_.clip.character.custom_panel,_loc4_,92,70,0.55,false,true);
         _loc1_.workerCustom1.clip.stop();
         _loc5_ = new WorkerData();
         _loc5_.setupDefaults();
         _loc5_.setGender(WorkerData.GENDER_FEMALE);
         _loc5_.skinTone = 15511933;
         _loc5_.eyeStyle = 9;
         _loc5_.eyeDefaultExpression = 15;
         _loc5_.mouthDefaultExpression = 1;
         _loc5_.hairColor = 16239685;
         _loc5_.hair = "hair_waveM";
         _loc5_.bangs = "hairparts_b_clip";
         _loc5_.eyeHeight = 4;
         _loc5_.mouthHeight = 3;
         _loc1_.workerCustom2 = new Worker(_loc1_.gameObj,_loc1_.clip.character.custom_panel,_loc5_,83,70,0.55);
         _loc1_.workerCustom2.clip.stop();
         if(_loc1_.clip.entername.currentFrame > 1 && _loc1_.clip.entername.currentFrame < _loc1_.clip.entername.totalFrames)
         {
            _loc1_.clip.entername.gotoAndPlay("hide");
         }
         if(_loc1_.clip.slots.currentFrame > 1 && _loc1_.clip.slots.currentFrame < _loc1_.clip.slots.totalFrames)
         {
            _loc1_.clip.slots.gotoAndPlay("hide");
         }
         _loc1_.clip.character.gotoAndPlay("show");
         _loc1_.gameObj.var_132.api.method_134("CHOOSE YOUR CHARACTER");
      }
      
      public function showEnterName() : void
      {
         var _loc1_:SlotSelectScreen = this;
         _loc1_.currentMode = "entername";
         _loc1_.clip.entername.input_holder.input_txt.text = "";
         _loc1_.clip.entername.input_holder.input_txt.setFocus();
         if(_loc1_.clip.slots.currentFrame > 1 && _loc1_.clip.slots.currentFrame < _loc1_.clip.slots.totalFrames)
         {
            _loc1_.clip.slots.gotoAndPlay("hide");
         }
         if(_loc1_.clip.character.currentFrame > 1 && _loc1_.clip.character.currentFrame < _loc1_.clip.character.totalFrames)
         {
            _loc1_.clip.character.gotoAndPlay("hide");
         }
         _loc1_.clip.entername.gotoAndPlay("show");
         _loc1_.gameObj.var_132.api.method_134("ENTER YOUR NAME");
      }
      
      public function animateScreen(param1:Event) : void
      {
         var _loc2_:SlotSelectScreen = this;
         if(_loc2_.isClosing)
         {
            if(_loc2_.currentMode == "character" && _loc2_.clip.character.currentFrame == _loc2_.clip.character.totalFrames)
            {
               _loc2_.closeSlotSelectScreen();
            }
            else if(_loc2_.currentMode == "slots" && _loc2_.clip.slots.currentFrame == _loc2_.clip.slots.totalFrames)
            {
               _loc2_.closeSlotSelectScreen();
            }
         }
      }
      
      public function clickStart(param1:Event) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.clip.iris.gotoAndPlay("irisout");
         _loc2_.gameObj.var_132.api.method_114("SlotSelectScreen");
      }
      
      public function destroy() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:SlotSelectScreen = this;
         if(_loc2_.workerChuck)
         {
            _loc2_.workerChuck.destroy();
            _loc2_.workerChuck = null;
         }
         if(_loc2_.workerMandi)
         {
            _loc2_.workerMandi.destroy();
            _loc2_.workerMandi = null;
         }
         if(_loc2_.workerCustom1)
         {
            _loc2_.workerCustom1.destroy();
            _loc2_.workerCustom1 = null;
         }
         if(_loc2_.workerCustom2)
         {
            _loc2_.workerCustom2.destroy();
            _loc2_.workerCustom2 = null;
         }
         _loc2_.missingWidget.removeEventListener(MouseEvent.CLICK,_loc2_.clickMissingWidget);
         _loc2_.missingWidget.parent.removeChild(_loc2_.missingWidget);
         _loc2_.missingWidget = null;
         if(_loc2_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.animateScreen);
         }
         _loc2_.container.removeEventListener("clickBack",_loc2_.clickBack);
         var _loc3_:int = 1;
         while(_loc3_ <= 3)
         {
            _loc1_ = _loc2_.clip.slots["slot" + _loc3_ + "MC"];
            _loc1_.new_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickNewSlot);
            _loc1_.select_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickExistingSlot);
            _loc1_.delete_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickDeleteSlot);
            _loc1_.confirmMC.yes_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickDeleteYes);
            _loc1_.confirmMC.no_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickDeleteNo);
            _loc1_.savebackup_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickSaveBackup);
            _loc1_.loadbackup_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickLoadBackup);
            _loc3_++;
         }
         _loc2_.clip.entername.input_holder.removeChild(_loc2_.nameContinueButton);
         _loc2_.clip.entername.input_holder.removeChild(_loc2_.nameBackButton);
         _loc2_.nameContinueButton.removeEventListener("clickNameOK",_loc2_.clickEnterNameOK);
         _loc2_.nameBackButton.removeEventListener("clickNameCancel",_loc2_.clickEnterNameCancel);
         _loc2_.nameContinueButton.destroy();
         _loc2_.nameBackButton.destroy();
         _loc2_.nameContinueButton = null;
         _loc2_.nameBackButton = null;
         _loc2_.clip.character.marty_panel.select_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickMarty);
         _loc2_.clip.character.rita_panel.select_btn.removeEventListener(MouseEvent.CLICK,_loc2_.clickRita);
         _loc2_.clip.removeEventListener(KeyboardEvent.KEY_DOWN,_loc2_.keyListener);
         _loc2_.container.removeChild(_loc2_.clip);
         _loc2_.clip = null;
      }
      
      public function startClosingScreen() : void
      {
         var _loc1_:SlotSelectScreen = this;
         _loc1_.isClosing = true;
         _loc1_.missingWidget.visible = false;
         _loc1_.gameObj.var_132.api.method_114();
         class_4.method_77();
      }
      
      public function closeSlotSelectScreen(param1:MouseEvent = null) : void
      {
         var _loc2_:SlotSelectScreen = this;
         _loc2_.clip.removeEventListener(Event.ENTER_FRAME,_loc2_.animateScreen);
         if(_loc2_.isNewSlot && _loc2_.selectedCharacter == "custom")
         {
            _loc2_.gameObj.method_196(_loc2_.selectedSlot);
         }
         else if(_loc2_.isNewSlot && _loc2_.gameObj.var_128.currentDay == 1)
         {
            _loc2_.gameObj.method_162();
         }
         else
         {
            _loc2_.gameObj.method_154();
         }
         _loc2_.gameObj.var_132.api.method_105("SlotSelect");
      }
   }
}

