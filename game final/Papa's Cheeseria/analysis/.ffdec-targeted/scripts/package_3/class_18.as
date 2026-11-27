package package_3
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   import flipline.api.*;
   import flipline.api.events.*;
   import package_2.*;
   import package_5.class_21;
   
   public class class_18 extends MovieClip
   {
      
      private static var var_223:Array = ["api_smallbutton_left","api_smallbutton_middle","api_smallbutton_right"];
      
      private static var var_219:Array = ["api_largebutton_left","api_largebutton_middle","api_largebutton_right"];
      
      private static var var_220:Array = ["api_redbutton_left","api_redbutton_middle","api_redbutton_right"];
      
      private static var var_192:Array = ["api_smallbutton_left_overlay","api_smallbutton_middle_overlay","api_smallbutton_right_overlay"];
      
      private static var var_222:Array = ["api_largebutton_left_overlay","api_largebutton_middle_overlay","api_largebutton_right_overlay"];
      
      private static var var_312:Array = ["api_smallbutton_left_overlay","api_smallbutton_middle_overlay","api_smallbutton_right_overlay"];
      
      private var label:String;
      
      private var size:String;
      
      private var type:String;
      
      private var linkURL:String = null;
      
      private var var_290:*;
      
      private var var_170:Boolean = false;
      
      private var var_230:Boolean = false;
      
      private var var_235:Boolean = false;
      
      private var var_255:Boolean = false;
      
      private var var_232:Number = 0;
      
      private var var_278:String;
      
      private var var_217:String = null;
      
      private var icon:DisplayObject = null;
      
      private var var_184:Number = 16;
      
      private var var_207:Number = 23;
      
      private var var_368:Number = 3;
      
      private var var_338:Number = 3;
      
      private var var_378:Number = 8;
      
      private var var_382:Number = 15;
      
      private var var_196:Number = 3;
      
      private var var_165:MovieClip;
      
      private var var_159:MovieClip;
      
      private var var_137:TextField;
      
      private var var_202:Boolean = true;
      
      private var var_190:Boolean = false;
      
      private var var_172:MovieClip = null;
      
      public function class_18(param1:class_21 = null, param2:String = null, param3:String = null, param4:String = "button", param5:String = null, param6:String = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:* = null, param11:Boolean = false, param12:Number = 0, param13:Boolean = false, param14:String = null)
      {
         super();
         var _loc15_:class_18 = this;
         if(param1 != null)
         {
            _loc15_.label = param1.label;
            _loc15_.size = param1.size;
            _loc15_.type = param1.var_319;
            _loc15_.var_278 = param1.var_278;
            _loc15_.linkURL = param1.linkURL;
            _loc15_.var_230 = param1.var_230;
            _loc15_.var_235 = param1.var_235;
            _loc15_.var_255 = param1.var_255;
            _loc15_.var_290 = param1.var_290;
            _loc15_.var_170 = param1.var_170;
            _loc15_.var_202 = !_loc15_.var_170;
            _loc15_.var_232 = param1.var_232;
            _loc15_.var_190 = param1.var_190;
            _loc15_.var_217 = param1.var_217;
         }
         else
         {
            _loc15_.label = param2;
            _loc15_.size = param3;
            _loc15_.type = param4;
            _loc15_.var_278 = param5;
            _loc15_.linkURL = param6;
            _loc15_.var_230 = param7;
            _loc15_.var_235 = param8;
            _loc15_.var_255 = param9;
            _loc15_.var_290 = param10;
            _loc15_.var_170 = param11;
            _loc15_.var_202 = !param11;
            _loc15_.var_232 = param12;
            _loc15_.var_190 = param13;
            _loc15_.var_217 = param14;
         }
         _loc15_.method_214();
      }
      
      private function method_214() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Class = null;
         var _loc3_:Class = null;
         var _loc4_:Class = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Class = null;
         var _loc9_:Class = null;
         var _loc10_:Class = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         var _loc14_:MovieClip = null;
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         var _loc17_:class_18 = this;
         if(_loc17_.var_235)
         {
            _loc17_.var_232 = 184;
         }
         _loc17_.buttonMode = true;
         _loc17_.useHandCursor = true;
         _loc17_.mouseEnabled = true;
         _loc17_.mouseChildren = false;
         _loc17_.tabEnabled = false;
         _loc17_.addEventListener(MouseEvent.CLICK,_loc17_.method_173);
         _loc17_.addEventListener(MouseEvent.ROLL_OVER,_loc17_.method_193);
         _loc17_.addEventListener(MouseEvent.ROLL_OUT,_loc17_.method_171);
         _loc17_.var_137 = new TextField();
         _loc17_.var_137.embedFonts = true;
         _loc17_.var_137.antiAliasType = AntiAliasType.ADVANCED;
         _loc17_.var_137.gridFitType = GridFitType.SUBPIXEL;
         _loc17_.var_137.wordWrap = false;
         _loc17_.var_137.multiline = false;
         _loc17_.var_137.text = _loc17_.label;
         _loc17_.var_137.setTextFormat(_loc17_.method_140(_loc17_.var_170));
         _loc17_.var_137.height = _loc17_.var_137.textHeight + 4;
         _loc17_.method_151(_loc17_.var_170);
         if(_loc17_.var_217 != null)
         {
            _loc17_.icon = class_12.method_161(_loc17_.var_217,false,false);
         }
         var _loc18_:Number = _loc17_.var_137.textWidth + 4 + _loc17_.var_378 * 2;
         if(_loc17_.size == "large")
         {
            _loc18_ = _loc17_.var_137.textWidth + 4 + _loc17_.var_382 * 2;
         }
         if(_loc17_.icon != null)
         {
            _loc18_ += _loc17_.icon.width + _loc17_.var_196;
         }
         if(_loc17_.var_232 > 0)
         {
            _loc18_ = Number(_loc17_.var_232);
         }
         if(_loc17_.size == "small")
         {
            _loc17_.var_137.width = _loc18_;
            _loc17_.var_137.x = 0;
            _loc17_.var_137.y = _loc17_.var_368;
         }
         else if(_loc17_.size == "large")
         {
            _loc17_.var_137.width = _loc18_;
            _loc17_.var_137.x = 0;
            _loc17_.var_137.y = _loc17_.var_338;
         }
         var _loc19_:Number = Number(_loc17_.var_137.width);
         if(_loc17_.icon != null)
         {
            if(_loc17_.size == "large")
            {
               _loc17_.var_137.width -= _loc17_.icon.width + _loc17_.var_196;
               _loc17_.icon.y = _loc17_.var_137.y + _loc17_.var_137.height / 2 - _loc17_.icon.height / 2;
               _loc17_.icon.x = _loc17_.var_137.x + _loc17_.var_137.width / 2 + _loc17_.var_137.textWidth / 2 + _loc17_.var_196;
            }
            else
            {
               _loc17_.var_137.width -= _loc17_.icon.width + _loc17_.var_196;
               _loc17_.var_137.x += _loc17_.icon.width + _loc17_.var_196;
               _loc17_.icon.y = _loc17_.var_137.y + _loc17_.var_137.height / 2 - _loc17_.icon.height / 2;
               _loc17_.icon.x = _loc17_.var_137.x + _loc17_.var_137.width / 2 - _loc17_.var_137.textWidth / 2 - _loc17_.var_196 - _loc17_.icon.width;
            }
         }
         _loc17_.var_165 = new MovieClip();
         _loc17_.var_159 = new MovieClip();
         _loc17_.var_159.blendMode = "add";
         _loc17_.var_159.alpha = 0;
         _loc17_.addChild(_loc17_.var_165);
         _loc17_.addChild(_loc17_.var_137);
         if(_loc17_.icon)
         {
            _loc17_.addChild(_loc17_.icon);
            if(_loc17_.var_170)
            {
               _loc17_.method_199();
            }
         }
         _loc17_.addChild(_loc17_.var_159);
         if(_loc17_.var_190)
         {
            _loc17_.var_172 = new api_button_flasher();
            _loc17_.var_172.blendMode = "add";
            _loc17_.var_172.alpha = 0.1;
            _loc17_.var_172.visible = true;
            _loc17_.addChild(_loc17_.var_172);
         }
         var _loc20_:Number = 1;
         var _loc21_:Number = 0;
         if(_loc17_.var_230)
         {
            _loc20_ = Math.ceil(_loc19_ / this.var_184) - 2;
            _loc21_ = Math.ceil(_loc19_ - this.var_184 * 2);
            _loc2_ = getDefinitionByName(class_18.var_220[0]) as Class;
            _loc5_ = new _loc2_();
            _loc8_ = getDefinitionByName(class_18.var_192[0]) as Class;
            _loc11_ = new _loc8_();
            _loc17_.var_165.addChild(_loc5_);
            _loc17_.var_159.addChild(_loc11_);
            if(_loc17_.var_170)
            {
               _loc5_.gotoAndStop("disabled");
            }
            else
            {
               _loc5_.gotoAndStop("up");
            }
            _loc3_ = getDefinitionByName(class_18.var_220[1]) as Class;
            _loc10_ = getDefinitionByName(class_18.var_192[1]) as Class;
            _loc12_ = new _loc10_();
            _loc12_.x = _loc17_.var_184;
            _loc12_.width = _loc21_;
            _loc17_.var_159.addChild(_loc12_);
            _loc6_ = new _loc3_();
            _loc6_.x = _loc17_.var_184 - 1;
            _loc6_.width = _loc21_ + 2;
            _loc17_.var_165.addChild(_loc6_);
            if(_loc17_.var_170)
            {
               _loc6_.gotoAndStop("disabled");
            }
            else
            {
               _loc6_.gotoAndStop("up");
            }
            _loc4_ = getDefinitionByName(class_18.var_220[2]) as Class;
            _loc7_ = new _loc4_();
            _loc9_ = getDefinitionByName(class_18.var_192[2]) as Class;
            _loc13_ = new _loc9_();
            _loc7_.x = _loc17_.var_184 + _loc21_;
            _loc13_.x = _loc7_.x;
            _loc17_.var_165.addChild(_loc7_);
            _loc17_.var_159.addChild(_loc13_);
            if(_loc17_.var_170)
            {
               _loc7_.gotoAndStop("disabled");
            }
            else
            {
               _loc7_.gotoAndStop("up");
            }
         }
         else if(_loc17_.size == "small")
         {
            _loc20_ = Math.ceil(_loc19_ / this.var_184) - 2;
            _loc21_ = Math.ceil(_loc19_ - this.var_184 * 2);
            _loc2_ = getDefinitionByName(class_18.var_223[0]) as Class;
            _loc5_ = new _loc2_();
            _loc8_ = getDefinitionByName(class_18.var_192[0]) as Class;
            _loc11_ = new _loc8_();
            _loc17_.var_165.addChild(_loc5_);
            _loc17_.var_159.addChild(_loc11_);
            if(_loc17_.var_170)
            {
               _loc5_.gotoAndStop("disabled");
            }
            else
            {
               _loc5_.gotoAndStop("up");
            }
            _loc3_ = getDefinitionByName(class_18.var_223[1]) as Class;
            _loc10_ = getDefinitionByName(class_18.var_192[1]) as Class;
            _loc12_ = new _loc10_();
            _loc12_.x = _loc17_.var_184;
            _loc12_.width = _loc21_;
            _loc17_.var_159.addChild(_loc12_);
            _loc6_ = new _loc3_();
            _loc6_.x = _loc17_.var_184 - 1;
            _loc6_.width = _loc21_ + 2;
            _loc17_.var_165.addChild(_loc6_);
            if(_loc17_.var_170)
            {
               _loc6_.gotoAndStop("disabled");
            }
            else
            {
               _loc6_.gotoAndStop("up");
            }
            _loc4_ = getDefinitionByName(class_18.var_223[2]) as Class;
            _loc7_ = new _loc4_();
            _loc9_ = getDefinitionByName(class_18.var_192[2]) as Class;
            _loc13_ = new _loc9_();
            _loc7_.x = _loc17_.var_184 + _loc21_;
            _loc13_.x = _loc7_.x;
            _loc17_.var_165.addChild(_loc7_);
            _loc17_.var_159.addChild(_loc13_);
            if(_loc17_.var_170)
            {
               _loc7_.gotoAndStop("disabled");
            }
            else
            {
               _loc7_.gotoAndStop("up");
            }
         }
         else if(_loc17_.size == "large")
         {
            _loc20_ = Math.ceil(_loc19_ / this.var_207) - 2;
            _loc21_ = Math.ceil(_loc19_ - this.var_207 * 2);
            _loc2_ = getDefinitionByName(class_18.var_219[0]) as Class;
            _loc5_ = new _loc2_();
            _loc8_ = getDefinitionByName(class_18.var_222[0]) as Class;
            _loc11_ = new _loc8_();
            _loc17_.var_165.addChild(_loc5_);
            _loc17_.var_159.addChild(_loc11_);
            if(_loc17_.var_190)
            {
               _loc14_ = new _loc8_();
               _loc17_.var_172.inside.addChild(_loc14_);
            }
            if(_loc17_.var_170)
            {
               _loc5_.gotoAndStop("disabled");
            }
            else
            {
               _loc5_.gotoAndStop("up");
            }
            _loc3_ = getDefinitionByName(class_18.var_219[1]) as Class;
            _loc10_ = getDefinitionByName(class_18.var_222[1]) as Class;
            _loc12_ = new _loc10_();
            _loc12_.x = _loc17_.var_207;
            _loc12_.width = _loc21_;
            _loc17_.var_159.addChild(_loc12_);
            if(_loc17_.var_190)
            {
               _loc15_ = new _loc10_();
               _loc15_.x = _loc17_.var_207;
               _loc15_.width = _loc21_;
               _loc17_.var_172.inside.addChild(_loc15_);
            }
            _loc6_ = new _loc3_();
            _loc6_.x = _loc17_.var_207 - 1;
            _loc6_.width = _loc21_ + 2;
            _loc17_.var_165.addChild(_loc6_);
            if(_loc17_.var_170)
            {
               _loc6_.gotoAndStop("disabled");
            }
            else
            {
               _loc6_.gotoAndStop("up");
            }
            _loc4_ = getDefinitionByName(class_18.var_219[2]) as Class;
            _loc7_ = new _loc4_();
            _loc9_ = getDefinitionByName(class_18.var_222[2]) as Class;
            _loc13_ = new _loc9_();
            _loc7_.x = _loc17_.var_207 + _loc21_;
            _loc13_.x = _loc7_.x;
            _loc17_.var_165.addChild(_loc7_);
            _loc17_.var_159.addChild(_loc13_);
            if(_loc17_.var_170)
            {
               _loc7_.gotoAndStop("disabled");
            }
            else
            {
               _loc7_.gotoAndStop("up");
            }
            if(_loc17_.var_190)
            {
               _loc16_ = new _loc9_();
               _loc16_.x = _loc7_.x;
               _loc17_.var_172.inside.addChild(_loc16_);
            }
         }
         if(_loc17_.var_190)
         {
         }
      }
      
      private function method_151(param1:Boolean = false) : void
      {
         var _loc2_:GlowFilter = null;
         var _loc3_:class_18 = this;
         if(param1)
         {
            _loc3_.var_137.filters = [];
         }
         else
         {
            _loc2_ = new GlowFilter(16774818,1,2,2,5);
            if(_loc3_.var_230)
            {
               _loc2_.color = 6684672;
            }
            else if(_loc3_.size == "large")
            {
               _loc2_.color = 1118481;
            }
            _loc3_.var_137.filters = [_loc2_];
         }
      }
      
      private function method_140(param1:Boolean = false) : TextFormat
      {
         var _loc2_:class_18 = this;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = class_17.const_8;
         if(param1)
         {
            if(_loc2_.size == "large")
            {
               _loc3_.color = class_17.const_12;
            }
            else
            {
               _loc3_.color = class_17.const_13;
            }
         }
         else if(_loc2_.var_230)
         {
            _loc3_.color = class_17.const_18;
         }
         else if(_loc2_.size == "large")
         {
            _loc3_.color = class_17.const_25;
         }
         else
         {
            _loc3_.color = class_17.const_21;
         }
         if(_loc2_.size == "large")
         {
            _loc3_.size = class_17.const_20;
         }
         else
         {
            _loc3_.size = class_17.const_16;
         }
         _loc3_.bold = class_17.const_15;
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.kerning = true;
         _loc3_.letterSpacing = -0.5;
         return _loc3_;
      }
      
      public function destroy() : void
      {
         var _loc1_:class_18 = this;
         if(Boolean(_loc1_.parent) && _loc1_.parent.contains(_loc1_))
         {
            _loc1_.parent.removeChild(_loc1_);
         }
         if(_loc1_.icon)
         {
            _loc1_.removeChild(_loc1_.icon);
         }
         _loc1_.removeChild(_loc1_.var_165);
         _loc1_.removeChild(_loc1_.var_159);
         _loc1_.removeChild(_loc1_.var_137);
         if(_loc1_.var_172 != null)
         {
            _loc1_.removeChild(_loc1_.var_172);
            _loc1_.var_172 = null;
         }
         _loc1_.var_165 = null;
         _loc1_.var_159 = null;
         _loc1_.icon = null;
         _loc1_.removeEventListener(MouseEvent.ROLL_OVER,_loc1_.method_193);
         _loc1_.removeEventListener(MouseEvent.ROLL_OUT,_loc1_.method_171);
         _loc1_.removeEventListener(MouseEvent.CLICK,_loc1_.method_173);
      }
      
      private function method_173(param1:MouseEvent) : void
      {
         var _loc2_:class_18 = this;
         if(_loc2_.var_202)
         {
            if(_loc2_.type == "link")
            {
               try
               {
                  navigateToURL(new URLRequest(_loc2_.linkURL),"_blank");
               }
               catch(err:Error)
               {
               }
            }
            else if(_loc2_.type == "button")
            {
               dispatchEvent(new MenuButtonEvent(_loc2_.var_278,true));
            }
            else if(_loc2_.type == "custom")
            {
            }
         }
      }
      
      private function method_193(param1:MouseEvent) : void
      {
         var _loc2_:class_18 = this;
         if(_loc2_.var_202)
         {
            _loc2_.var_159.alpha = 0.1;
            if(Boolean(_loc2_.var_190) && _loc2_.var_172 != null)
            {
               _loc2_.var_172.alpha = 0;
            }
         }
      }
      
      private function method_171(param1:MouseEvent) : void
      {
         var _loc2_:class_18 = this;
         if(_loc2_.var_202)
         {
            _loc2_.var_159.alpha = 0;
            if(Boolean(_loc2_.var_190) && _loc2_.var_172 != null)
            {
               _loc2_.var_172.alpha = 0.1;
            }
         }
      }
      
      public function method_147() : void
      {
         var _loc1_:class_18 = this;
         _loc1_.var_202 = true;
         _loc1_.var_137.setTextFormat(_loc1_.method_140());
         _loc1_.method_151();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.var_165.numChildren)
         {
            MovieClip(_loc1_.var_165.getChildAt(_loc2_)).gotoAndStop("up");
            _loc2_++;
         }
         if(_loc1_.icon)
         {
            _loc1_.icon.filters = [];
         }
      }
      
      public function method_148() : void
      {
         var _loc1_:class_18 = this;
         _loc1_.var_202 = false;
         _loc1_.var_159.visible = false;
         _loc1_.var_137.setTextFormat(_loc1_.method_140(true));
         _loc1_.method_151(true);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.var_165.numChildren)
         {
            MovieClip(_loc1_.var_165.getChildAt(_loc2_)).gotoAndStop("disabled");
            _loc2_++;
         }
         _loc1_.method_199();
      }
      
      public function method_199() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:ColorMatrixFilter = null;
         var _loc7_:class_18 = this;
         if(_loc7_.icon != null)
         {
            _loc1_ = 30;
            _loc2_ = 0.6;
            _loc3_ = 0.212671 * _loc2_;
            _loc4_ = 0.71516 * _loc2_;
            _loc5_ = 0.072169 * _loc2_;
            _loc6_ = new ColorMatrixFilter([_loc3_,_loc4_,_loc5_,0,_loc1_,_loc3_,_loc4_,_loc5_,0,_loc1_,_loc3_,_loc4_,_loc5_,0,_loc1_,0,0,0,1,0]);
            _loc7_.icon.filters = [_loc6_];
         }
      }
      
      public function getLabel() : String
      {
         var _loc1_:class_18 = this;
         return _loc1_.label;
      }
      
      public function method_201(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:class_18 = this;
         if(_loc3_.icon)
         {
            _loc3_.removeChild(_loc3_.icon);
         }
         _loc3_.icon = null;
         if(param2)
         {
            param1 = _loc3_.var_217;
         }
         if(param1 != null)
         {
            _loc3_.icon = class_12.method_161(param1,false,false);
            _loc3_.icon.y = _loc3_.var_137.y + _loc3_.var_137.height / 2 - _loc3_.icon.height / 2;
            _loc3_.icon.x = _loc3_.var_137.x + _loc3_.var_137.width / 2 - _loc3_.var_137.textWidth / 2 - _loc3_.var_196 - _loc3_.icon.width;
            if(_loc3_.size == "large")
            {
               _loc3_.icon.x = _loc3_.var_137.x + _loc3_.var_137.width / 2 + _loc3_.var_137.textWidth / 2 + _loc3_.var_196;
            }
            _loc3_.addChild(_loc3_.icon);
         }
      }
   }
}

