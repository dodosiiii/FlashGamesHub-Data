package cheeseGame.models
{
   import cheeseGame.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.ColorTransform;
   import package_2.*;
   import package_4.class_5;
   
   public class Worker
   {
      
      public var gameObj:class_5;
      
      public var workerData:WorkerData;
      
      public var holder:MovieClip;
      
      public var clip:MovieClip;
      
      public var x:Number;
      
      public var y:Number;
      
      public var scale:Number;
      
      public var flipped:Boolean = false;
      
      public var backwards:Boolean = false;
      
      public var skinToneTransform:ColorTransform = null;
      
      public var hairColorTransform:ColorTransform = null;
      
      public var facialHairColorTransform:ColorTransform = null;
      
      public var blinkTimer:Number = 0;
      
      public var blinkTimerMax:Number = 100;
      
      public var eyesOffsetY:Number = -23;
      
      public var eyesOffsetX:Number = -18;
      
      public var mouthOffsetY:Number = -9;
      
      public var mouthOffsetX:Number = -26;
      
      public var beardBackwardsX:Number = -13;
      
      public var mouthClip:MovieClip;
      
      public var eyeLeftClip:MovieClip;
      
      public var eyeRightClip:MovieClip;
      
      public var eyeBaseLeftClip:MovieClip;
      
      public var eyeBaseRightClip:MovieClip;
      
      public var hairClip:MovieClip = null;
      
      public var backHairClip:MovieClip = null;
      
      public var facialHairMouthClip:MovieClip = null;
      
      public var facialHairBaseClip:MovieClip = null;
      
      public var faceAccClip:MovieClip = null;
      
      public var faceAccBackClip:MovieClip = null;
      
      public var hatClip:MovieClip = null;
      
      public var bangsClip:MovieClip = null;
      
      public var backBangsClip:MovieClip = null;
      
      public var lastEyeFrame:Number = 0;
      
      public var lastMouthFrame:Number = 0;
      
      public var lastFrontShoeFrame:Number = 1;
      
      public var lastBackShoeFrame:Number = 1;
      
      public var lastFrontHandFrame:Number = 1;
      
      public var lastBackHandFrame:Number = 1;
      
      public function Worker(param1:class_5, param2:MovieClip, param3:WorkerData, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false)
      {
         var _loc9_:Worker = null;
         super();
         _loc9_ = this;
         _loc9_.gameObj = param1;
         _loc9_.holder = param2;
         _loc9_.workerData = param3;
         _loc9_.x = param4;
         _loc9_.y = param5;
         _loc9_.scale = param6;
         _loc9_.flipped = param8;
         _loc9_.backwards = param7;
         _loc9_.createModel();
      }
      
      public function playAnimation(param1:String) : void
      {
         var _loc2_:Worker = this;
         _loc2_.clip.gotoAndPlay(param1);
      }
      
      public function createModel() : void
      {
         var _loc1_:Worker = this;
         _loc1_.clip = new workerModel();
         if(_loc1_.workerData.gender == WorkerData.GENDER_MALE)
         {
            _loc1_.clip.body.male_skin.visible = true;
            _loc1_.clip.body.female_skin.visible = false;
         }
         else
         {
            _loc1_.clip.body.male_skin.visible = false;
            _loc1_.clip.body.female_skin.visible = true;
         }
         _loc1_.updateSkinTone();
         _loc1_.updateHairColor();
         _loc1_.updateFacialParts();
         if(_loc1_.backwards)
         {
            _loc1_.lastFrontHandFrame = 3;
            _loc1_.lastBackHandFrame = 4;
         }
         else
         {
            _loc1_.lastFrontHandFrame = 1;
            _loc1_.lastBackHandFrame = 1;
         }
         _loc1_.redoClothing(ClothingItem.TYPE_SHIRT);
         _loc1_.redoClothing(ClothingItem.TYPE_HAIR);
         _loc1_.redoClothing(ClothingItem.TYPE_SHOES);
         if(_loc1_.backwards)
         {
            _loc1_.clip.body.male_skin.gotoAndStop(2);
            _loc1_.clip.body.female_skin.gotoAndStop(2);
            _loc1_.clip.neck.skin.gotoAndStop(2);
            _loc1_.clip.front_hand.skin.gotoAndStop(3);
            _loc1_.clip.back_hand.skin.gotoAndStop(4);
            _loc1_.clip.front_hand.gotoAndStop(3);
            _loc1_.clip.back_hand.gotoAndStop(4);
            _loc1_.clip.gotoAndPlay("turnaround");
         }
         else
         {
            _loc1_.clip.body.male_skin.gotoAndStop(1);
            _loc1_.clip.body.female_skin.gotoAndStop(1);
            _loc1_.clip.neck.skin.gotoAndStop(1);
            _loc1_.clip.front_hand.skin.gotoAndStop(1);
            _loc1_.clip.back_hand.skin.gotoAndStop(1);
            _loc1_.clip.front_hand.gotoAndStop(1);
            _loc1_.clip.back_hand.gotoAndStop(1);
            _loc1_.clip.gotoAndPlay("stand");
         }
         _loc1_.clip.x = _loc1_.x;
         _loc1_.clip.y = _loc1_.y;
         _loc1_.clip.scaleX = _loc1_.scale;
         _loc1_.clip.scaleY = _loc1_.scale;
         if(_loc1_.flipped)
         {
            _loc1_.clip.scaleX *= -1;
         }
         _loc1_.holder.addChild(_loc1_.clip);
         _loc1_.clip.eyeFrame = 0;
         _loc1_.clip.mouthFrame = 0;
         _loc1_.clip.frontShoeFrame = 1;
         _loc1_.clip.backShoeFrame = 1;
         _loc1_.clip.frontHandFrame = _loc1_.lastFrontHandFrame;
         _loc1_.clip.backHandFrame = _loc1_.lastBackHandFrame;
         _loc1_.lastEyeFrame = 0;
         _loc1_.lastMouthFrame = 0;
         _loc1_.lastFrontShoeFrame = 1;
         _loc1_.lastBackShoeFrame = 1;
         _loc1_.gameObj.var_132.api.addEventListener("workerChange",_loc1_.updateModelLook);
      }
      
      public function animateModel(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Worker = this;
         if(_loc4_.clip.eyeFrame != _loc4_.lastEyeFrame)
         {
            _loc4_.lastEyeFrame = _loc4_.clip.eyeFrame;
            if(_loc4_.lastEyeFrame == 0)
            {
               _loc4_.eyeLeftClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.eyeRightClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.eyeBaseLeftClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.eyeBaseRightClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
            }
            else
            {
               _loc4_.eyeLeftClip.gotoAndStop(_loc4_.lastEyeFrame);
               _loc4_.eyeRightClip.gotoAndStop(_loc4_.lastEyeFrame);
               _loc4_.eyeBaseLeftClip.gotoAndStop(_loc4_.lastEyeFrame);
               _loc4_.eyeBaseRightClip.gotoAndStop(_loc4_.lastEyeFrame);
            }
         }
         if(_loc4_.clip.mouthFrame != _loc4_.lastMouthFrame)
         {
            _loc4_.lastMouthFrame = _loc4_.clip.mouthFrame;
            if(_loc4_.lastMouthFrame == 0)
            {
               _loc4_.mouthClip.gotoAndStop(_loc4_.workerData.mouthDefaultExpression);
            }
            else
            {
               _loc4_.mouthClip.gotoAndStop(_loc4_.lastMouthFrame);
            }
            if(_loc4_.facialHairMouthClip != null && !_loc4_.backwards)
            {
               if(_loc4_.lastMouthFrame == 0)
               {
                  _loc4_.facialHairMouthClip.gotoAndStop(_loc4_.workerData.mouthDefaultExpression);
               }
               else
               {
                  _loc4_.facialHairMouthClip.gotoAndStop(_loc4_.lastMouthFrame);
               }
            }
         }
         if(_loc4_.clip.frontHandFrame != _loc4_.lastFrontHandFrame)
         {
            _loc4_.lastFrontHandFrame = _loc4_.clip.frontHandFrame;
            _loc4_.clip.front_hand.gotoAndStop(_loc4_.lastFrontHandFrame);
            _loc4_.clip.front_hand.skin.gotoAndStop(_loc4_.lastFrontHandFrame);
            _loc2_ = 0;
            while(_loc2_ < _loc4_.clip.front_hand.gloveholder.numChildren)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc4_.clip.front_hand.gloveholder.getChildAt(_loc2_).numChildren)
               {
                  if(_loc4_.clip.front_hand.gloveholder.getChildAt(_loc2_).getChildAt(_loc3_) is MovieClip)
                  {
                     _loc4_.clip.front_hand.gloveholder.getChildAt(_loc2_).getChildAt(_loc3_).gotoAndStop(_loc4_.lastFrontHandFrame);
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         if(_loc4_.clip.backHandFrame != _loc4_.lastBackHandFrame)
         {
            _loc4_.lastBackHandFrame = _loc4_.clip.backHandFrame;
            _loc4_.clip.back_hand.gotoAndStop(_loc4_.lastBackHandFrame);
            _loc4_.clip.back_hand.skin.gotoAndStop(_loc4_.lastBackHandFrame);
            _loc2_ = 0;
            while(_loc2_ < _loc4_.clip.back_hand.gloveholder.numChildren)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc4_.clip.back_hand.gloveholder.getChildAt(_loc2_).numChildren)
               {
                  if(_loc4_.clip.back_hand.gloveholder.getChildAt(_loc2_).getChildAt(_loc3_) is MovieClip)
                  {
                     _loc4_.clip.back_hand.gloveholder.getChildAt(_loc2_).getChildAt(_loc3_).gotoAndStop(_loc4_.lastBackHandFrame);
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         if(_loc4_.clip.frontShoeFrame != _loc4_.lastFrontShoeFrame && !_loc4_.backwards)
         {
            _loc4_.lastFrontShoeFrame = _loc4_.clip.frontShoeFrame;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.clip.front_foot.numChildren)
            {
               _loc4_.clip.front_foot.getChildAt(_loc2_).gotoAndStop(_loc4_.lastFrontShoeFrame);
               if(_loc2_ > 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_.clip.front_foot.getChildAt(_loc2_).numChildren)
                  {
                     if(_loc4_.clip.front_foot.getChildAt(_loc2_).getChildAt(_loc3_) is MovieClip)
                     {
                        _loc4_.clip.front_foot.getChildAt(_loc2_).getChildAt(_loc3_).gotoAndStop(_loc4_.lastFrontShoeFrame);
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
         }
         if(_loc4_.clip.backShoeFrame != _loc4_.lastBackShoeFrame && !_loc4_.backwards)
         {
            _loc4_.lastBackShoeFrame = _loc4_.clip.backShoeFrame;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.clip.back_foot.numChildren)
            {
               _loc4_.clip.back_foot.getChildAt(_loc2_).gotoAndStop(_loc4_.lastBackShoeFrame);
               if(_loc2_ > 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_.clip.back_foot.getChildAt(_loc2_).numChildren)
                  {
                     if(_loc4_.clip.front_foot.getChildAt(_loc2_).getChildAt(_loc3_) is MovieClip)
                     {
                        _loc4_.clip.back_foot.getChildAt(_loc2_).getChildAt(_loc3_).gotoAndStop(_loc4_.lastBackShoeFrame);
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
         }
         if(_loc4_.lastEyeFrame == 0)
         {
            ++_loc4_.blinkTimer;
            if(_loc4_.blinkTimer == _loc4_.blinkTimerMax || _loc4_.blinkTimer == _loc4_.blinkTimerMax + 3)
            {
               _loc4_.eyeLeftClip.gotoAndStop(2);
               _loc4_.eyeRightClip.gotoAndStop(2);
               _loc4_.eyeBaseLeftClip.gotoAndStop(2);
               _loc4_.eyeBaseRightClip.gotoAndStop(2);
            }
            else if(_loc4_.blinkTimer == _loc4_.blinkTimerMax + 1 || _loc4_.blinkTimer == _loc4_.blinkTimerMax + 2)
            {
               _loc4_.eyeLeftClip.gotoAndStop(3);
               _loc4_.eyeRightClip.gotoAndStop(3);
               _loc4_.eyeBaseLeftClip.gotoAndStop(3);
               _loc4_.eyeBaseRightClip.gotoAndStop(3);
            }
            else if(_loc4_.blinkTimer == _loc4_.blinkTimerMax + 4)
            {
               _loc4_.eyeLeftClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.eyeRightClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.eyeBaseLeftClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.eyeBaseRightClip.gotoAndStop(_loc4_.workerData.eyeDefaultExpression);
               _loc4_.blinkTimer = 0;
            }
         }
      }
      
      public function runOwnAnimations() : void
      {
         var _loc1_:Worker = this;
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.animateModel);
         }
      }
      
      public function updateModelLook(param1:Event = null) : void
      {
         var _loc2_:Worker = this;
         if(_loc2_.workerData.gender == WorkerData.GENDER_MALE)
         {
            _loc2_.clip.body.male_skin.visible = true;
            _loc2_.clip.body.female_skin.visible = false;
         }
         else
         {
            _loc2_.clip.body.male_skin.visible = false;
            _loc2_.clip.body.female_skin.visible = true;
         }
         _loc2_.updateSkinTone();
         _loc2_.updateHairColor();
         _loc2_.updateFacialParts();
         _loc2_.redoClothing(ClothingItem.TYPE_SHIRT);
         _loc2_.redoClothing(ClothingItem.TYPE_HAIR);
         _loc2_.redoClothing(ClothingItem.TYPE_SHOES);
      }
      
      public function destroy() : void
      {
         var _loc1_:Worker = this;
         _loc1_.gameObj.var_132.api.removeEventListener("workerChange",_loc1_.updateModelLook);
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.animateModel);
         _loc1_.clip.stop();
         _loc1_.removeExistingHeadItems();
         _loc1_.removeExistingClothing(_loc1_.clip.front_foot);
         _loc1_.removeExistingClothing(_loc1_.clip.back_foot);
         _loc1_.removeExistingClothing(_loc1_.clip.body);
         _loc1_.removeExistingClothing(_loc1_.clip.front_bicep);
         _loc1_.removeExistingClothing(_loc1_.clip.front_forearm);
         _loc1_.removeExistingClothing(_loc1_.clip.back_bicep);
         _loc1_.removeExistingClothing(_loc1_.clip.back_forearm);
         _loc1_.removeExistingClothing(_loc1_.clip.neck);
         _loc1_.removeExistingClothing(_loc1_.clip.back_acca);
         _loc1_.removeExistingClothing(_loc1_.clip.front_acca);
         _loc1_.removeExistingClothing(_loc1_.clip.front_hand.cuffholder);
         _loc1_.removeExistingClothing(_loc1_.clip.back_hand.cuffholder);
         if(_loc1_.holder)
         {
            try
            {
               _loc1_.holder.removeChild(_loc1_.clip);
            }
            catch(err:Error)
            {
            }
         }
         _loc1_.clip = null;
      }
      
      public function updateSkinTone() : void
      {
         var _loc1_:Worker = this;
         _loc1_.skinToneTransform = _loc1_.createColorTransform(_loc1_.workerData.skinTone);
         _loc1_.clip.head.inside.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.neck.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.front_bicep.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.back_bicep.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.front_forearm.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.back_forearm.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.front_hand.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.back_hand.skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.body.male_skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.clip.body.female_skin.transform.colorTransform = _loc1_.skinToneTransform;
         _loc1_.redoClothing(ClothingItem.TYPE_HAIR);
      }
      
      public function updateHairColor() : void
      {
         var _loc1_:Worker = this;
         _loc1_.hairColorTransform = _loc1_.createColorTransform(_loc1_.workerData.getHairColor());
         _loc1_.facialHairColorTransform = _loc1_.createColorTransform(_loc1_.workerData.getFacialHairColor());
         if(_loc1_.hairClip != null)
         {
            try
            {
               _loc1_.hairClip.hair.transform.colorTransform = _loc1_.hairColorTransform;
            }
            catch(err:Error)
            {
            }
         }
         if(_loc1_.backHairClip != null)
         {
            try
            {
               _loc1_.backHairClip.hair.transform.colorTransform = _loc1_.hairColorTransform;
            }
            catch(err:Error)
            {
            }
         }
         if(_loc1_.facialHairBaseClip != null)
         {
            try
            {
               _loc1_.facialHairBaseClip.transform.colorTransform = _loc1_.facialHairColorTransform;
            }
            catch(err:Error)
            {
            }
         }
         if(_loc1_.facialHairMouthClip != null)
         {
            try
            {
               _loc1_.facialHairMouthClip.transform.colorTransform = _loc1_.facialHairColorTransform;
            }
            catch(err:Error)
            {
            }
         }
         if(_loc1_.bangsClip != null)
         {
            try
            {
               _loc1_.bangsClip.hair.transform.colorTransform = _loc1_.hairColorTransform;
            }
            catch(err:Error)
            {
            }
         }
         if(_loc1_.backBangsClip != null)
         {
            try
            {
               _loc1_.backBangsClip.hair.transform.colorTransform = _loc1_.hairColorTransform;
            }
            catch(err:Error)
            {
            }
         }
         try
         {
            _loc1_.eyeLeftClip.hair.inside.transform.colorTransform = _loc1_.facialHairColorTransform;
            _loc1_.eyeRightClip.hair.inside.transform.colorTransform = _loc1_.facialHairColorTransform;
         }
         catch(err:Error)
         {
         }
      }
      
      public function updateFacialParts(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:uint = 0;
         var _loc9_:Worker = this;
         var _loc10_:Number = Number(WorkerData.skinToneOptions.indexOf(_loc9_.workerData.skinTone));
         var _loc11_:String = "light";
         var _loc12_:String = "light";
         if(_loc10_ == 3 || _loc10_ == 5 || _loc10_ == 6)
         {
            _loc11_ = "med";
         }
         else if(_loc10_ == 4)
         {
            _loc11_ = "dark";
            _loc12_ = "dark";
         }
         if(_loc9_.workerData.gender == WorkerData.GENDER_FEMALE)
         {
            _loc12_ = "female";
         }
         if(param1)
         {
            if(_loc9_.eyeLeftClip != null)
            {
               _loc9_.eyeLeftClip.parent.removeChild(_loc9_.eyeLeftClip);
               _loc9_.eyeLeftClip = null;
            }
            if(_loc9_.eyeRightClip != null)
            {
               _loc9_.eyeRightClip.parent.removeChild(_loc9_.eyeRightClip);
               _loc9_.eyeRightClip = null;
            }
            if(_loc9_.eyeBaseLeftClip != null)
            {
               _loc9_.eyeBaseLeftClip.parent.removeChild(_loc9_.eyeBaseLeftClip);
               _loc9_.eyeBaseLeftClip = null;
            }
            if(_loc9_.eyeBaseRightClip != null)
            {
               _loc9_.eyeBaseRightClip.parent.removeChild(_loc9_.eyeBaseRightClip);
               _loc9_.eyeBaseRightClip = null;
            }
            _loc6_ = (_loc9_.workerData.eyeStyle - 1) % WorkerData.EYE_STYLE_MAX + 1;
            _loc7_ = Math.ceil(_loc9_.workerData.eyeStyle / WorkerData.EYE_STYLE_MAX) - 1;
            _loc8_ = 0;
            if(_loc11_ == "light")
            {
               _loc8_ = uint(WorkerData.eyeColorOptionsLight[_loc7_]);
            }
            else if(_loc11_ == "med")
            {
               _loc8_ = uint(WorkerData.eyeColorOptionsMedium[_loc7_]);
            }
            else if(_loc11_ == "dark")
            {
               _loc8_ = uint(WorkerData.eyeColorOptionsDark[_loc7_]);
            }
            _loc9_.eyeBaseLeftClip = class_12.method_103("worker_eyes_L_base",false,false);
            _loc9_.eyeBaseRightClip = class_12.method_103("worker_eyes_R_base",false,false);
            _loc9_.eyeBaseLeftClip.transform.colorTransform = _loc9_.createColorTransform(_loc8_);
            _loc9_.eyeBaseRightClip.transform.colorTransform = _loc9_.createColorTransform(_loc8_);
            _loc9_.eyeBaseLeftClip.stop();
            _loc9_.eyeBaseRightClip.stop();
            _loc9_.clip.head.inside.addChild(_loc9_.eyeBaseLeftClip);
            _loc9_.clip.head.inside.addChild(_loc9_.eyeBaseRightClip);
            _loc9_.eyeLeftClip = class_12.method_103("worker_eyes_" + _loc11_ + "_L_" + _loc6_,false,false);
            _loc9_.eyeRightClip = class_12.method_103("worker_eyes_" + _loc11_ + "_R_" + _loc6_,false,false);
            _loc9_.eyeLeftClip.stop();
            _loc9_.eyeRightClip.stop();
            _loc9_.clip.head.inside.addChild(_loc9_.eyeLeftClip);
            _loc9_.clip.head.inside.addChild(_loc9_.eyeRightClip);
         }
         if(param2)
         {
            if(_loc9_.mouthClip != null)
            {
               _loc9_.mouthClip.parent.removeChild(_loc9_.mouthClip);
               _loc9_.mouthClip = null;
            }
            _loc9_.mouthClip = class_12.method_103("worker_mouth_" + _loc12_ + "_" + _loc9_.workerData.mouthStyle);
            _loc9_.mouthClip.stop();
            _loc9_.clip.head.inside.addChild(_loc9_.mouthClip);
         }
         _loc9_.updateFacialLayout();
      }
      
      public function updateFacialLayout() : void
      {
         var _loc1_:Worker = this;
         _loc1_.eyeLeftClip.x = _loc1_.eyesOffsetX - _loc1_.workerData.eyeSpacing;
         _loc1_.eyeLeftClip.y = _loc1_.eyesOffsetY + _loc1_.workerData.eyeHeight;
         _loc1_.eyeBaseLeftClip.x = _loc1_.eyeLeftClip.x;
         _loc1_.eyeBaseLeftClip.y = _loc1_.eyeLeftClip.y;
         _loc1_.eyeRightClip.x = _loc1_.eyesOffsetX + _loc1_.workerData.eyeSpacing;
         _loc1_.eyeRightClip.y = _loc1_.eyesOffsetY + _loc1_.workerData.eyeHeight;
         _loc1_.eyeBaseRightClip.x = _loc1_.eyeRightClip.x;
         _loc1_.eyeBaseRightClip.y = _loc1_.eyeRightClip.y;
         _loc1_.mouthClip.x = _loc1_.mouthOffsetX;
         _loc1_.mouthClip.y = _loc1_.mouthOffsetY + _loc1_.workerData.mouthHeight;
         _loc1_.clip.head.inside.y = _loc1_.workerData.headHeight;
         _loc1_.clip.head.inside.x = _loc1_.workerData.headForward;
         _loc1_.clip.head.inside.scaleX = _loc1_.workerData.headScale;
         _loc1_.clip.head.inside.scaleY = _loc1_.workerData.headScale;
         _loc1_.clip.back_hair.inside.y = _loc1_.workerData.headHeight;
         _loc1_.clip.back_hair.inside.x = _loc1_.workerData.headForward;
         _loc1_.clip.back_hair.inside.scaleX = _loc1_.workerData.headScale;
         _loc1_.clip.back_hair.inside.scaleY = _loc1_.workerData.headScale;
         _loc1_.clip.back_beard.inside.y = _loc1_.workerData.headHeight;
         _loc1_.clip.back_beard.inside.x = _loc1_.workerData.headForward;
         _loc1_.clip.back_beard.inside.scaleX = _loc1_.workerData.headScale;
         _loc1_.clip.back_beard.inside.scaleY = _loc1_.workerData.headScale;
         _loc1_.clip.back_hat.inside.y = _loc1_.workerData.headHeight;
         _loc1_.clip.back_hat.inside.x = _loc1_.workerData.headForward;
         _loc1_.clip.back_hat.inside.scaleX = _loc1_.workerData.headScale;
         _loc1_.clip.back_hat.inside.scaleY = _loc1_.workerData.headScale;
         _loc1_.eyeLeftClip.gotoAndStop(_loc1_.workerData.eyeDefaultExpression);
         _loc1_.eyeRightClip.gotoAndStop(_loc1_.workerData.eyeDefaultExpression);
         _loc1_.eyeBaseLeftClip.gotoAndStop(_loc1_.workerData.eyeDefaultExpression);
         _loc1_.eyeBaseRightClip.gotoAndStop(_loc1_.workerData.eyeDefaultExpression);
         _loc1_.mouthClip.gotoAndStop(_loc1_.workerData.mouthDefaultExpression);
         if(_loc1_.facialHairMouthClip != null)
         {
            if(!_loc1_.backwards)
            {
               _loc1_.facialHairMouthClip.gotoAndStop(_loc1_.workerData.mouthDefaultExpression);
            }
            else
            {
               _loc1_.facialHairMouthClip.gotoAndStop(23);
            }
            _loc1_.facialHairMouthClip.x = _loc1_.mouthOffsetX;
            _loc1_.facialHairMouthClip.y = _loc1_.mouthOffsetY + _loc1_.workerData.mouthHeight;
         }
         if(_loc1_.faceAccClip != null && _loc1_.gameObj.var_135.clothingHasOption(_loc1_.workerData.accd,ClothingItem.OPTIONS_TRACKEYES))
         {
            _loc1_.faceAccClip.y = _loc1_.workerData.eyeHeight;
            _loc1_.faceAccBackClip.y = _loc1_.workerData.eyeHeight;
         }
         if(_loc1_.backwards)
         {
            _loc1_.eyeLeftClip.visible = false;
            _loc1_.eyeRightClip.visible = false;
            _loc1_.eyeBaseLeftClip.visible = false;
            _loc1_.eyeBaseRightClip.visible = false;
            _loc1_.mouthClip.visible = false;
            _loc1_.clip.head.inside.x = _loc1_.workerData.headForward * -1;
            _loc1_.clip.back_hair.inside.x = _loc1_.workerData.headForward * -1;
            _loc1_.clip.back_beard.inside.x = _loc1_.workerData.headForward * -1;
            _loc1_.clip.back_hat.inside.x = _loc1_.workerData.headForward * -1;
         }
      }
      
      public function updateWeight() : void
      {
         var i:int = 0;
         var useNeckScale:Number = Number(NaN);
         var rangePercent:Number = Number(NaN);
         var ob:Worker = this;
         try
         {
            i = 0;
            while(i < ob.clip.body.numChildren)
            {
               ob.clip.body.getChildAt(i).scaleX = ob.workerData.weightScale;
               i++;
            }
            i = 1;
            while(i < ob.clip.neck.numChildren)
            {
               ob.clip.neck.getChildAt(i).scaleX = ob.workerData.weightScale;
               i++;
            }
            ob.clip.neck.getChildAt(0).scaleX = ob.workerData.neckScale * ob.workerData.weightScale;
            useNeckScale = Number(ob.clip.neck.getChildAt(0).scaleX);
            rangePercent = (useNeckScale - WorkerData.WEIGHT_SCALE_MIN) / (WorkerData.WEIGHT_SCALE_MAX - WorkerData.WEIGHT_SCALE_MIN);
            if(rangePercent < 0)
            {
               rangePercent = 0;
            }
            else if(rangePercent > 1)
            {
               rangePercent = 1;
            }
            ob.clip.neck.getChildAt(0).x = 0 - (-0.7 + rangePercent * 2.8);
         }
         catch(err:Error)
         {
            class_7.error("Error updating body weight: " + err.message);
         }
      }
      
      private function createColorTransform(param1:Number, param2:Boolean = false) : ColorTransform
      {
         var _loc3_:Worker = this;
         return _loc3_.gameObj.var_135.createColorTransform(param1,param2);
      }
      
      public function redoClothing(param1:String) : void
      {
         var _loc2_:ClothingItem = null;
         var _loc3_:Number = Number(NaN);
         var _loc4_:Worker = this;
         var _loc5_:ClothingData = _loc4_.gameObj.var_135;
         if(param1 == ClothingItem.TYPE_FACIALHAIR || param1 == ClothingItem.TYPE_HAIR || param1 == ClothingItem.TYPE_BANGS || param1 == ClothingItem.TYPE_ACC_FACE || param1 == ClothingItem.TYPE_HAT)
         {
            _loc4_.removeExistingHeadItems();
            if(_loc4_.workerData.facialhair != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.facialhair,ClothingItem.OPTIONS_HAS_BASE_FACIALHAIR) && !_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_FULLMASK))
               {
                  _loc4_.facialHairBaseClip = class_12.method_103("worker_" + _loc4_.workerData.facialhair + "_base",false,false);
                  _loc4_.clip.head.inside.addChild(_loc4_.facialHairBaseClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.facialHairBaseClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.facialHairBaseClip.gotoAndStop(1);
                  }
               }
            }
            _loc4_.updateFacialParts();
            if(_loc4_.workerData.facialhair != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.facialhair,ClothingItem.OPTIONS_HAS_MOUTH_FACIALHAIR) && !_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_FULLMASK))
               {
                  _loc4_.facialHairMouthClip = class_12.method_103("worker_" + _loc4_.workerData.facialhair + "_mouth",false,false);
                  if(_loc4_.backwards)
                  {
                     _loc4_.facialHairMouthClip.gotoAndStop(23);
                     _loc4_.clip.back_beard.inside.addChild(_loc4_.facialHairMouthClip);
                  }
                  else
                  {
                     _loc4_.facialHairMouthClip.gotoAndStop(_loc4_.workerData.mouthDefaultExpression);
                     _loc4_.clip.head.inside.addChild(_loc4_.facialHairMouthClip);
                  }
                  _loc4_.facialHairMouthClip.x = _loc4_.mouthOffsetX;
                  _loc4_.facialHairMouthClip.y = _loc4_.mouthOffsetY + _loc4_.workerData.mouthHeight;
               }
            }
            if(_loc4_.workerData.accd != "" && !_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_FULLMASK))
            {
               _loc4_.faceAccClip = class_12.method_103("worker_" + _loc5_.formatTag(_loc4_.workerData.accd,_loc4_.workerData.gender),false,false);
               _loc4_.clip.head.inside.addChild(_loc4_.faceAccClip);
               _loc4_.faceAccBackClip = class_12.method_103("worker_" + _loc5_.formatTag(_loc4_.workerData.accd,_loc4_.workerData.gender) + "_back",false,false);
               _loc4_.clip.head.inside.addChildAt(_loc4_.faceAccBackClip,0);
               if(_loc4_.backwards)
               {
                  _loc4_.faceAccClip.gotoAndStop(2);
                  _loc4_.faceAccBackClip.gotoAndStop(2);
               }
               else
               {
                  _loc4_.faceAccClip.gotoAndStop(1);
                  _loc4_.faceAccBackClip.gotoAndStop(1);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.accd,ClothingItem.OPTIONS_TRACKEYES))
               {
                  _loc4_.faceAccClip.y = _loc4_.workerData.eyeHeight;
                  _loc4_.faceAccBackClip.y = _loc4_.workerData.eyeHeight;
               }
               if(_loc5_.clothingIsTinting(_loc4_.workerData.accd))
               {
                  _loc5_.tintThumbnailPart(true,_loc4_.faceAccClip,_loc5_.getItemFromSKU(_loc4_.workerData.accd));
                  _loc5_.tintThumbnailPart(true,_loc4_.faceAccBackClip,_loc5_.getItemFromSKU(_loc4_.workerData.accd));
               }
            }
            if(_loc4_.workerData.hair != "")
            {
               _loc4_.hairClip = class_12.method_103("worker_" + _loc4_.workerData.hair + "_fg",false,false);
               _loc4_.clip.head.inside.addChild(_loc4_.hairClip);
               if(_loc4_.backwards)
               {
                  _loc4_.hairClip.gotoAndStop(2);
               }
               else
               {
                  _loc4_.hairClip.gotoAndStop(1);
               }
               try
               {
                  _loc4_.hairClip.hair.gotoAndStop(1);
               }
               catch(err:Error)
               {
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.hair,ClothingItem.OPTIONS_HAS_BACK_HAIR))
               {
                  _loc4_.backHairClip = class_12.method_103("worker_" + _loc4_.workerData.hair + "_bg",false,false);
                  _loc4_.clip.back_hair.inside.addChild(_loc4_.backHairClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.backHairClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.backHairClip.gotoAndStop(1);
                  }
                  try
                  {
                     _loc4_.backHairClip.hair.gotoAndStop(1);
                  }
                  catch(err:Error)
                  {
                  }
               }
            }
            if(_loc4_.workerData.bangs != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.hair,ClothingItem.OPTIONS_SUPPORTS_BANGS))
               {
                  _loc4_.bangsClip = class_12.method_103("worker_" + _loc4_.workerData.bangs + "_fg",false,false);
                  _loc4_.clip.head.inside.addChild(_loc4_.bangsClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.bangsClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.bangsClip.gotoAndStop(1);
                  }
                  try
                  {
                     _loc4_.bangsClip.hair.gotoAndStop(1);
                  }
                  catch(err:Error)
                  {
                  }
                  if(_loc5_.clothingHasOption(_loc4_.workerData.bangs,ClothingItem.OPTIONS_HAS_BACK_HAIR))
                  {
                     _loc4_.backBangsClip = class_12.method_103("worker_" + _loc4_.workerData.bangs + "_bg",false,false);
                     _loc4_.clip.back_hair.inside.addChild(_loc4_.backBangsClip);
                     if(_loc4_.backwards)
                     {
                        _loc4_.backBangsClip.gotoAndStop(2);
                     }
                     else
                     {
                        _loc4_.backBangsClip.gotoAndStop(1);
                     }
                     try
                     {
                        _loc4_.backBangsClip.hair.gotoAndStop(1);
                     }
                     catch(err:Error)
                     {
                     }
                  }
               }
            }
            if(_loc4_.workerData.hat != "")
            {
               _loc4_.hatClip = class_12.method_103("worker_" + _loc5_.formatTag(_loc4_.workerData.hat,_loc4_.workerData.gender),false,false);
               if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_CAP))
               {
                  _loc4_.clip.head.inside.addChild(_loc4_.hatClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.hatClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.hatClip.gotoAndStop(1);
                  }
                  try
                  {
                     if(_loc4_.hairClip != null)
                     {
                        _loc4_.hairClip.hair.gotoAndStop(2);
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backHairClip != null)
                     {
                        _loc4_.backHairClip.hair.gotoAndStop(2);
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.bangsClip != null)
                     {
                        _loc4_.bangsClip.hair.gotoAndStop(2);
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backBangsClip != null)
                     {
                        _loc4_.backBangsClip.hair.gotoAndStop(2);
                     }
                  }
                  catch(err:Error)
                  {
                  }
               }
               else if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_HELMET))
               {
                  _loc4_.clip.head.inside.addChild(_loc4_.hatClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.hatClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.hatClip.gotoAndStop(1);
                  }
                  try
                  {
                     if(_loc4_.hairClip != null)
                     {
                        _loc4_.hairClip.hair.gotoAndStop(3);
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backHairClip != null)
                     {
                        _loc4_.backHairClip.hair.gotoAndStop(3);
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.bangsClip != null)
                     {
                        _loc4_.bangsClip.hair.gotoAndStop(3);
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backBangsClip != null)
                     {
                        _loc4_.backBangsClip.hair.gotoAndStop(3);
                     }
                  }
                  catch(err:Error)
                  {
                  }
               }
               else if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_FULLMASK))
               {
                  _loc4_.clip.head.inside.addChild(_loc4_.hatClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.hatClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.hatClip.gotoAndStop(1);
                  }
                  try
                  {
                     if(_loc4_.hairClip != null)
                     {
                        _loc4_.hairClip.hair.gotoAndStop(3);
                        _loc4_.hairClip.visible = false;
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backHairClip != null)
                     {
                        _loc4_.backHairClip.hair.gotoAndStop(3);
                        _loc4_.backHairClip.visible = false;
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.bangsClip != null)
                     {
                        _loc4_.bangsClip.hair.gotoAndStop(3);
                        _loc4_.bangsClip.visible = false;
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backBangsClip != null)
                     {
                        _loc4_.backBangsClip.hair.gotoAndStop(3);
                        _loc4_.backBangsClip.visible = false;
                     }
                  }
                  catch(err:Error)
                  {
                  }
               }
               else if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_HAIRCLIP))
               {
                  _loc4_.clip.head.inside.addChild(_loc4_.hatClip);
                  if(_loc4_.backwards)
                  {
                     _loc4_.hatClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.hatClip.gotoAndStop(1);
                  }
               }
               else
               {
                  if(_loc4_.backwards)
                  {
                     _loc4_.clip.head.inside.addChild(_loc4_.hatClip);
                     _loc4_.hatClip.gotoAndStop(2);
                  }
                  else
                  {
                     _loc4_.clip.back_hat.addChild(_loc4_.hatClip);
                     _loc4_.hatClip.gotoAndStop(1);
                  }
                  try
                  {
                     if(_loc4_.hairClip != null)
                     {
                        if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_SOMBRERO))
                        {
                           _loc4_.hairClip.hair.gotoAndStop(2);
                        }
                        else
                        {
                           _loc4_.hairClip.hair.gotoAndStop(1);
                        }
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backHairClip != null)
                     {
                        if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_SOMBRERO))
                        {
                           _loc4_.backHairClip.hair.gotoAndStop(2);
                        }
                        else
                        {
                           _loc4_.backHairClip.hair.gotoAndStop(1);
                        }
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.bangsClip != null)
                     {
                        if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_SOMBRERO))
                        {
                           _loc4_.bangsClip.hair.gotoAndStop(2);
                        }
                        else
                        {
                           _loc4_.bangsClip.hair.gotoAndStop(1);
                        }
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  try
                  {
                     if(_loc4_.backBangsClip != null)
                     {
                        if(_loc5_.clothingHasOption(_loc4_.workerData.hat,ClothingItem.OPTIONS_HAT_SOMBRERO))
                        {
                           _loc4_.backBangsClip.hair.gotoAndStop(2);
                        }
                        else
                        {
                           _loc4_.backBangsClip.hair.gotoAndStop(1);
                        }
                     }
                  }
                  catch(err:Error)
                  {
                  }
               }
               if(_loc5_.clothingIsTinting(_loc4_.workerData.hat))
               {
                  _loc5_.tintThumbnailPart(true,_loc4_.hatClip,_loc5_.getItemFromSKU(_loc4_.workerData.hat));
               }
               _loc2_ = _loc5_.getItemFromSKU(_loc4_.workerData.hat);
               if(_loc2_ != null && _loc2_.tintDecal != null)
               {
                  _loc5_.handleDecal(_loc4_.hatClip,_loc2_,_loc4_.workerData.gender,"hat",_loc4_.hatClip.currentFrame);
               }
               _loc2_ = null;
            }
            _loc4_.updateHairColor();
         }
         else if(param1 == ClothingItem.TYPE_SHOES)
         {
            _loc4_.removeExistingClothing(_loc4_.clip.front_foot);
            _loc4_.removeExistingClothing(_loc4_.clip.back_foot);
            if(_loc4_.workerData.shoes != "")
            {
               _loc3_ = 1;
               if(_loc4_.backwards)
               {
                  _loc3_ = 4;
               }
               _loc4_.addClothing(_loc4_.clip.front_foot,_loc5_.formatTag(_loc4_.workerData.shoes,_loc4_.workerData.gender),_loc3_,_loc4_.workerData.shoes);
               _loc4_.addClothing(_loc4_.clip.back_foot,_loc5_.formatTag(_loc4_.workerData.shoes,_loc4_.workerData.gender),_loc3_,_loc4_.workerData.shoes);
               _loc4_.clip.front_foot.skin.visible = false;
               _loc4_.clip.back_foot.skin.visible = false;
            }
         }
         else
         {
            _loc4_.removeExistingClothing(_loc4_.clip.body);
            _loc4_.removeExistingClothing(_loc4_.clip.front_bicep);
            _loc4_.removeExistingClothing(_loc4_.clip.front_forearm);
            _loc4_.removeExistingClothing(_loc4_.clip.back_bicep);
            _loc4_.removeExistingClothing(_loc4_.clip.back_forearm);
            _loc4_.removeExistingClothing(_loc4_.clip.neck);
            _loc4_.removeExistingClothing(_loc4_.clip.back_acca);
            _loc4_.removeExistingClothing(_loc4_.clip.front_acca);
            _loc4_.removeExistingClothing(_loc4_.clip.front_hand.cuffholder);
            _loc4_.removeExistingClothing(_loc4_.clip.back_hand.cuffholder);
            _loc4_.removeExistingClothing(_loc4_.clip.front_hand.gloveholder);
            _loc4_.removeExistingClothing(_loc4_.clip.back_hand.gloveholder);
            if(_loc4_.workerData.acca != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HAS_BACKBODY))
               {
                  if(_loc4_.backwards && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACCSTAYSBACK))
                  {
                     _loc4_.addClothing(_loc4_.clip.front_acca,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_back",-1,_loc4_.workerData.acca);
                  }
                  else
                  {
                     _loc4_.addClothing(_loc4_.clip.back_acca,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_back",-1,_loc4_.workerData.acca);
                  }
               }
            }
            if(!_loc5_.clothingExists(_loc4_.workerData.pants))
            {
               if(_loc4_.workerData.gender == WorkerData.GENDER_FEMALE)
               {
                  _loc4_.workerData.pants = "donuteria_pants_1";
               }
               else
               {
                  _loc4_.workerData.pants = "donuteria_pants_1";
               }
            }
            if(_loc4_.workerData.pants != "")
            {
               _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.pants,_loc4_.workerData.gender),-1,_loc4_.workerData.pants);
            }
            if(_loc4_.workerData.accb != "")
            {
               if(!_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACCBEHINDBELT))
               {
                  _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.accb,_loc4_.workerData.gender),-1,_loc4_.workerData.accb);
               }
            }
            if(_loc4_.workerData.acca != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HAS_NECK) && _loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_BEHINDCOLLAR))
               {
                  _loc4_.addClothing(_loc4_.clip.neck,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_neck",-1,_loc4_.workerData.acca);
               }
            }
            if(_loc4_.workerData.accc != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_ACCSTAYSBACK) || _loc4_.hasClothingCondition("gloveflare") || _loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_HOCKEYSLEEVES))
               {
                  if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.SHIRT_LONG))
                  {
                     _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.accc);
                     _loc4_.addClothing(_loc4_.clip.front_bicep,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.accc);
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                     }
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand",_loc4_.lastFrontHandFrame,_loc4_.workerData.accc);
                     }
                     if(!_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_ONLYONEARM))
                     {
                        _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.accc);
                        _loc4_.addClothing(_loc4_.clip.back_bicep,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.accc);
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                        }
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand2",_loc4_.lastBackHandFrame,_loc4_.workerData.accc);
                        }
                     }
                  }
                  else
                  {
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_ALTERNATEGLOVE))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_alternate",-1,_loc4_.workerData.accc);
                     }
                     else
                     {
                        _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender),-1,_loc4_.workerData.accc);
                     }
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                     }
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand",_loc4_.lastFrontHandFrame,_loc4_.workerData.accc);
                     }
                     if(!_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_ONLYONEARM))
                     {
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_ALTERNATEGLOVE))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_alternate",-1,_loc4_.workerData.accc);
                        }
                        else
                        {
                           _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender),-1,_loc4_.workerData.accc);
                        }
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                        }
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand2",_loc4_.lastBackHandFrame,_loc4_.workerData.accc);
                        }
                     }
                  }
               }
            }
            if(!_loc5_.clothingExists(_loc4_.workerData.shirt))
            {
               if(_loc4_.workerData.gender == WorkerData.GENDER_FEMALE)
               {
                  _loc4_.workerData.shirt = "donuteria_shirt_1";
               }
               else
               {
                  _loc4_.workerData.shirt = "donuteria_shirt_1";
               }
            }
            if(_loc4_.workerData.shirt != "")
            {
               _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_body",-1,_loc4_.workerData.shirt);
               if(_loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_NECK) && !_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HIDE_SHIRTNECK) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HIDE_SHIRTNECK))
               {
                  _loc4_.addClothing(_loc4_.clip.neck,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_neck",-1,_loc4_.workerData.shirt);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_BICEP) && (!_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HIDE_SHIRTBICEP) || _loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_FOREARM)) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HIDE_SHIRTBICEP))
               {
                  _loc4_.addClothing(_loc4_.clip.front_bicep,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.shirt);
                  _loc4_.addClothing(_loc4_.clip.back_bicep,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.shirt);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_FOREARM) && !_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HIDE_SHIRTFOREARM) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HIDE_SHIRTFOREARM))
               {
                  _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.shirt);
                  _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.shirt);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_CUFF) && !_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HIDE_SHIRTFOREARM) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HIDE_SHIRTFOREARM))
               {
                  _loc4_.addClothing(_loc4_.clip.front_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.shirt);
                  _loc4_.addClothing(_loc4_.clip.back_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.shirt,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.shirt);
               }
            }
            if(_loc4_.workerData.accc != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_ACCSTAYSBACK) == false && !_loc4_.hasClothingCondition("gloveflare") && _loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HAS_HOCKEYSLEEVES) == false)
               {
                  if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.SHIRT_LONG))
                  {
                     _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.accc);
                     _loc4_.addClothing(_loc4_.clip.front_bicep,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.accc);
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                     }
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand",_loc4_.lastFrontHandFrame,_loc4_.workerData.accc);
                     }
                     if(!_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_ONLYONEARM))
                     {
                        _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.accc);
                        _loc4_.addClothing(_loc4_.clip.back_bicep,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.accc);
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                        }
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand2",_loc4_.lastBackHandFrame,_loc4_.workerData.accc);
                        }
                     }
                  }
                  else
                  {
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_ALTERNATEGLOVE) && _loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HAS_FOREARM))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_alternate",-1,_loc4_.workerData.accc);
                     }
                     else
                     {
                        _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender),-1,_loc4_.workerData.accc);
                     }
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                     }
                     if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                     {
                        _loc4_.addClothing(_loc4_.clip.front_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand",_loc4_.lastFrontHandFrame,_loc4_.workerData.accc);
                     }
                     if(!_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_ONLYONEARM))
                     {
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_ALTERNATEGLOVE) && _loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HAS_FOREARM))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_alternate",-1,_loc4_.workerData.accc);
                        }
                        else
                        {
                           _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender),-1,_loc4_.workerData.accc);
                        }
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_CUFF))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.accc);
                        }
                        if(_loc5_.clothingHasOption(_loc4_.workerData.accc,ClothingItem.OPTIONS_HAS_HAND))
                        {
                           _loc4_.addClothing(_loc4_.clip.back_hand.gloveholder,_loc5_.formatTag(_loc4_.workerData.accc,_loc4_.workerData.gender) + "_hand2",_loc4_.lastBackHandFrame,_loc4_.workerData.accc);
                        }
                     }
                  }
               }
            }
            if(_loc4_.workerData.acca != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACC_BEHINDJACKET) == true)
               {
                  if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HAS_FRONTBODY))
                  {
                     _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_front",-1,_loc4_.workerData.acca);
                  }
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HAS_NECK) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_BEHINDCOLLAR) && _loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACC_BEHINDJACKETNECK))
               {
                  _loc4_.addClothing(_loc4_.clip.neck,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_neck",-1,_loc4_.workerData.acca);
               }
            }
            if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACCBEHINDBELT))
            {
               if(_loc4_.workerData.accb != "")
               {
                  _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.accb,_loc4_.workerData.gender),-1,_loc4_.workerData.accb);
               }
            }
            if(_loc4_.workerData.jacket != "")
            {
               _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_body",-1,_loc4_.workerData.jacket);
               if(_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HAS_NECK) && !_loc5_.clothingHasOption(_loc4_.workerData.shirt,ClothingItem.OPTIONS_HIDE_JACKETNECK) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HIDE_JACKETNECK))
               {
                  _loc4_.addClothing(_loc4_.clip.neck,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_neck",-1,_loc4_.workerData.jacket);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HAS_BICEP))
               {
                  _loc4_.addClothing(_loc4_.clip.front_bicep,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.jacket);
                  _loc4_.addClothing(_loc4_.clip.back_bicep,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_upperarm",-1,_loc4_.workerData.jacket);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HAS_FOREARM))
               {
                  _loc4_.addClothing(_loc4_.clip.front_forearm,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.jacket);
                  _loc4_.addClothing(_loc4_.clip.back_forearm,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_forearm",-1,_loc4_.workerData.jacket);
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.jacket,ClothingItem.OPTIONS_HAS_CUFF))
               {
                  _loc4_.addClothing(_loc4_.clip.front_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.jacket);
                  _loc4_.addClothing(_loc4_.clip.back_hand.cuffholder,_loc5_.formatTag(_loc4_.workerData.jacket,_loc4_.workerData.gender) + "_cuff",-1,_loc4_.workerData.jacket);
               }
            }
            if(_loc4_.workerData.acca != "")
            {
               if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACC_BEHINDJACKET) == false)
               {
                  if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HAS_FRONTBODY))
                  {
                     _loc4_.addClothing(_loc4_.clip.body,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_front",-1,_loc4_.workerData.acca);
                  }
               }
               if(_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_HAS_NECK) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_BEHINDCOLLAR) && !_loc5_.clothingHasOption(_loc4_.workerData.acca,ClothingItem.OPTIONS_ACC_BEHINDJACKETNECK))
               {
                  _loc4_.addClothing(_loc4_.clip.neck,_loc5_.formatTag(_loc4_.workerData.acca,_loc4_.workerData.gender) + "_neck",-1,_loc4_.workerData.acca);
               }
            }
         }
         _loc4_.clip.neck.getChildAt(0).scaleX = _loc4_.workerData.neckScale;
         if(_loc4_.workerData.neckScale != 1)
         {
            _loc4_.clip.neck.getChildAt(0).x = -2;
         }
         _loc4_.updateWeight();
      }
      
      public function removeExistingHeadItems() : void
      {
         var _loc1_:Worker = this;
         if(_loc1_.hairClip != null)
         {
            _loc1_.clip.head.inside.removeChild(_loc1_.hairClip);
            _loc1_.hairClip = null;
         }
         if(_loc1_.hatClip != null)
         {
            _loc1_.hatClip.parent.removeChild(_loc1_.hatClip);
            _loc1_.hatClip = null;
         }
         if(_loc1_.facialHairBaseClip != null)
         {
            _loc1_.clip.head.inside.removeChild(_loc1_.facialHairBaseClip);
            _loc1_.facialHairBaseClip = null;
         }
         if(_loc1_.facialHairMouthClip != null)
         {
            _loc1_.facialHairMouthClip.parent.removeChild(_loc1_.facialHairMouthClip);
            _loc1_.facialHairMouthClip = null;
         }
         if(_loc1_.faceAccClip != null)
         {
            _loc1_.clip.head.inside.removeChild(_loc1_.faceAccClip);
            _loc1_.faceAccClip = null;
         }
         if(_loc1_.faceAccBackClip != null)
         {
            _loc1_.clip.head.inside.removeChild(_loc1_.faceAccBackClip);
            _loc1_.faceAccBackClip = null;
         }
         if(_loc1_.backHairClip != null)
         {
            _loc1_.clip.back_hair.inside.removeChild(_loc1_.backHairClip);
            _loc1_.backHairClip = null;
         }
         if(_loc1_.bangsClip != null)
         {
            _loc1_.clip.head.inside.removeChild(_loc1_.bangsClip);
            _loc1_.bangsClip = null;
         }
         if(_loc1_.backBangsClip != null)
         {
            _loc1_.clip.back_hair.inside.removeChild(_loc1_.backBangsClip);
            _loc1_.backBangsClip = null;
         }
      }
      
      public function removeExistingClothing(param1:MovieClip) : void
      {
         var _loc2_:* = int(param1.numChildren - 1);
         while(_loc2_ >= 0)
         {
            if(param1.getChildAt(_loc2_).name.indexOf("skin") == -1)
            {
               param1.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
      }
      
      public function addClothing(param1:MovieClip, param2:String, param3:Number = -1, param4:String = null) : void
      {
         var whichClip:MovieClip = null;
         var tag:String = null;
         var part:MovieClip = null;
         var item:ClothingItem = null;
         var clipName:String = null;
         var decal:MovieClip = null;
         whichClip = param1;
         tag = param2;
         var forceFrame:Number = param3;
         var sku:String = param4;
         var ob:Worker = this;
         var isTinting:Boolean = ob.gameObj.var_135.clothingIsTinting(sku);
         tag = "worker_" + tag;
         try
         {
            part = class_12.method_103(tag,false,false);
            if(forceFrame > -1)
            {
               part.gotoAndStop(forceFrame);
            }
            else if(ob.backwards)
            {
               part.gotoAndStop(2);
            }
            else
            {
               part.gotoAndStop(1);
            }
            whichClip.addChild(part);
            if(isTinting)
            {
               item = ob.gameObj.var_135.getItemFromSKU(sku);
               if(item.tintColor1 != -1 && part.getChildByName("color1") != null)
               {
                  part.getChildByName("color1").transform.colorTransform = ob.createColorTransform(item.tintColor1,true);
                  MovieClip(part.getChildByName("color1")).gotoAndStop(part.currentFrame);
               }
               if(item.tintColor2 != -1 && part.getChildByName("color2") != null)
               {
                  part.getChildByName("color2").transform.colorTransform = ob.createColorTransform(item.tintColor2,true);
                  MovieClip(part.getChildByName("color2")).gotoAndStop(part.currentFrame);
               }
               if(item.tintColor3 != -1 && part.getChildByName("color3") != null)
               {
                  part.getChildByName("color3").transform.colorTransform = ob.createColorTransform(item.tintColor3,true);
                  MovieClip(part.getChildByName("color3")).gotoAndStop(part.currentFrame);
               }
               if(item.tintDecal != null && (whichClip == ob.clip.body || whichClip == ob.clip.front_bicep || whichClip == ob.clip.back_bicep || whichClip == ob.clip.head))
               {
                  clipName = item.tintDecal;
                  if(item.type != ClothingItem.TYPE_HAT)
                  {
                     if(ob.workerData.gender == ClothingItem.GENDER_MALE)
                     {
                        clipName += "_M_";
                     }
                     else
                     {
                        clipName += "_F_";
                     }
                     if(whichClip == ob.clip.body)
                     {
                        clipName += "body";
                     }
                     else
                     {
                        clipName += "upperarm";
                     }
                  }
                  try
                  {
                     decal = class_12.method_103(clipName,false,false);
                     if(decal != null)
                     {
                        decal.gotoAndStop(part.currentFrame);
                        if(item.tintDecalColor != -1)
                        {
                           decal.transform.colorTransform = ob.createColorTransform(item.tintDecalColor,true);
                        }
                        part.addChild(decal);
                     }
                  }
                  catch(err:Error)
                  {
                  }
               }
            }
         }
         catch(err:Error)
         {
            class_7.error("Error adding clothing " + tag + " to " + whichClip + ": Error: " + err.message);
         }
      }
      
      public function addShadow() : void
      {
         var _loc1_:Worker = this;
         if(_loc1_.backwards)
         {
            _loc1_.clip.graphics.beginFill(0,0.2);
            _loc1_.clip.graphics.drawEllipse(25,250,128,69);
            _loc1_.clip.graphics.endFill();
         }
         else
         {
            _loc1_.clip.graphics.beginFill(0,0.3);
            _loc1_.clip.graphics.drawEllipse(15,256,128,69);
            _loc1_.clip.graphics.endFill();
         }
      }
      
      public function hasClothingCondition(param1:String) : Boolean
      {
         var _loc2_:Worker = this;
         var _loc3_:ClothingData = _loc2_.gameObj.var_135;
         var _loc4_:Boolean = false;
         if(param1 == "gloveflare" && _loc3_.clothingHasOption(_loc2_.workerData.accc,ClothingItem.OPTIONS_HAS_ALTERNATEGLOVE) && _loc3_.clothingHasOption(_loc2_.workerData.shirt,ClothingItem.OPTIONS_HAS_FLAREDSLEEVES))
         {
            _loc4_ = true;
         }
         else if(param1 == "glovejacket" && _loc3_.clothingHasOption(_loc2_.workerData.accc,ClothingItem.OPTIONS_HAS_ALTERNATEGLOVE) && _loc3_.clothingHasOption(_loc2_.workerData.jacket,ClothingItem.OPTIONS_HAS_FOREARM))
         {
            _loc4_ = true;
         }
         return _loc4_;
      }
   }
}

