package package_3
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flipline.api.*;
   import package_2.*;
   import package_5.class_16;
   import package_5.class_21;
   
   public class class_25
   {
      
      private var api:class_17;
      
      private var data:class_16;
      
      private var var_324:Object = null;
      
      private var clip:MovieClip;
      
      private var var_141:MovieClip;
      
      private var var_144:MovieClip;
      
      private var var_157:MovieClip;
      
      private var var_261:Number = 4;
      
      private var var_375:Number = 0;
      
      private var var_372:Number = 45;
      
      private var var_373:Number = 11;
      
      private var var_346:Number = 6;
      
      private var var_321:Number = -15;
      
      private var var_359:Number = 45;
      
      private var var_374:Number = 7;
      
      private var var_329:Number = 6;
      
      private var var_299:Number = 10;
      
      private var var_327:Number = 10;
      
      private var var_224:Number = 5;
      
      private var var_366:Number = 7;
      
      private var var_387:Number = 10;
      
      private var var_371:Number = 78;
      
      private var var_347:Number = 3;
      
      private var var_370:Number = 6;
      
      private var var_351:Number = 8;
      
      private var var_363:Number = 6;
      
      private var var_301:Number = 8;
      
      private var var_177:class_18 = null;
      
      private var var_191:class_18;
      
      private var var_146:MovieClip;
      
      private var var_148:MovieClip;
      
      private var var_158:MovieClip;
      
      private var var_143:SimpleButton;
      
      private var var_174:SimpleButton;
      
      private var var_156:SimpleButton;
      
      private var var_175:SimpleButton;
      
      private var var_167:MovieClip;
      
      private var var_350:MovieClip;
      
      private var var_295:Boolean = false;
      
      private var var_349:String = "api_menu_top_panel";
      
      private var var_361:String = "api_menu_bottom_panel";
      
      private var var_336:String = "startgame_bg";
      
      private var var_360:Number = -13;
      
      private var var_308:Number = -5;
      
      private var var_385:String = "flip_logo_large";
      
      private var var_358:String = "flip_logo_small";
      
      private var var_352:String = "sponsor_logo_large";
      
      private var var_380:String = "sponsor_logo_small";
      
      private var var_386:String = "license_logo_large";
      
      private var var_343:String = "license_logo_small";
      
      private var var_355:String = "developedby_tag";
      
      private var var_342:String = "sponsoredby_tag";
      
      private var var_356:String = "api_mute_btn";
      
      private var var_383:String = "api_unmute_btn";
      
      private var var_369:String = "api_mute_music_btn";
      
      private var var_357:String = "api_unmute_music_btn";
      
      private var var_340:String = "api_getthisgame_button";
      
      private var var_364:String = "api_getthisgame_bigbutton";
      
      private var var_337:String = "api_promopanel_license";
      
      private var var_384:String = "api_promopanel_sponsor";
      
      private var var_162:MovieClip;
      
      private var var_341:Number = 46;
      
      private var var_201:Number = 12;
      
      private var var_265:Number = 15;
      
      private var var_264:Number = 10;
      
      private var var_392:Number = 2;
      
      private var var_365:Number = 73;
      
      private var var_381:Number = 120;
      
      private var var_335:Number = 43;
      
      private var var_339:Number = 101;
      
      private var var_345:Number = 43;
      
      private var var_362:Number = 60;
      
      private var var_344:Number = 0;
      
      private var var_379:Number = 60;
      
      private var var_377:Number = 73;
      
      private var var_376:Number = 137;
      
      private var var_334:Number = 3;
      
      private var var_353:Number = 3;
      
      private var var_166:Number = 0;
      
      private var var_161:Number = 0;
      
      private var var_304:Number = 4;
      
      private var var_348:Number = 0;
      
      private var var_257:Number = 0;
      
      private var var_322:Boolean = false;
      
      private var var_163:TextField;
      
      private var var_236:*;
      
      public function class_25(param1:class_17, param2:class_16, param3:Object = null)
      {
         super();
         this.api = param1;
         this.data = param2;
         this.var_324 = param3;
         this.setupScreen();
      }
      
      public function setupScreen() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:class_21 = null;
         var _loc4_:class_18 = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Array = null;
         var _loc7_:TextField = null;
         var _loc8_:TextField = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:int = 0;
         var _loc12_:MovieClip = null;
         var _loc13_:class_25 = this;
         _loc13_.clip = new MovieClip();
         _loc13_.var_141 = this.api.var_153.method_103(this.var_349);
         _loc13_.var_144 = this.api.var_153.method_103(this.var_361);
         if(this.data.var_242)
         {
            _loc13_.var_166 = 0 - (_loc13_.var_141.height - this.var_365);
            _loc13_.var_161 = this.api.var_152 - this.var_381;
            _loc13_.var_141.y = 0 - _loc13_.var_141.height + this.api.var_152 / 2 - 30;
            _loc13_.var_144.y = this.api.var_152 - this.api.var_152 / 2 + 30;
         }
         else if(this.data.var_179)
         {
            _loc13_.var_166 = 0 - (_loc13_.var_141.height - this.var_377);
            _loc13_.var_161 = this.api.var_152 - this.var_376;
            _loc13_.var_141.y = 0 - _loc13_.var_141.height + this.api.var_152 / 2 - 30;
            _loc13_.var_144.y = this.api.var_152 - this.api.var_152 / 2 + 30;
         }
         else if(this.data.var_279)
         {
            _loc13_.var_166 = 0 - (_loc13_.var_141.height - this.var_345);
            _loc13_.var_161 = this.api.var_152 - this.var_362;
            _loc13_.var_141.y = 0 - _loc13_.var_141.height;
            _loc13_.var_144.y = this.api.var_152;
         }
         else if(this.data.var_259)
         {
            _loc13_.var_166 = 0 - (_loc13_.var_141.height - this.var_344);
            _loc13_.var_161 = this.api.var_152 - this.var_379;
            _loc13_.var_141.y = 0 - _loc13_.var_141.height;
            _loc13_.var_144.y = this.api.var_152;
         }
         else
         {
            _loc13_.var_166 = 0 - (_loc13_.var_141.height - this.var_335);
            _loc13_.var_161 = this.api.var_152 - this.var_339;
            _loc13_.var_141.y = 0 - _loc13_.var_141.height;
            _loc13_.var_144.y = this.api.var_152;
         }
         _loc13_.var_163 = new TextField();
         _loc13_.var_163.embedFonts = true;
         _loc13_.var_163.antiAliasType = AntiAliasType.ADVANCED;
         _loc13_.var_163.gridFitType = GridFitType.SUBPIXEL;
         _loc13_.var_163.wordWrap = false;
         _loc13_.var_163.multiline = false;
         _loc13_.var_163.defaultTextFormat = _loc13_.method_140();
         _loc13_.var_163.text = "";
         _loc13_.var_163.mouseEnabled = false;
         _loc13_.var_163.y = 0 - _loc13_.var_166 + _loc13_.var_375;
         if(_loc13_.data.var_330)
         {
            _loc13_.var_163.text = _loc13_.data.var_317;
         }
         _loc13_.var_163.height = _loc13_.var_163.textHeight + 4;
         _loc13_.var_163.width = _loc13_.api.var_160;
         _loc13_.var_141.addChild(_loc13_.var_163);
         _loc13_.var_157 = new MovieClip();
         if(this.data.var_242)
         {
            _loc13_.var_157.y = _loc13_.var_372;
         }
         else if(this.data.var_179)
         {
            _loc13_.var_157.y = _loc13_.var_346;
         }
         else
         {
            _loc13_.var_157.y = _loc13_.var_373;
         }
         if(_loc13_.data.var_185.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc13_.data.var_185.length)
            {
               _loc3_ = _loc13_.data.var_185[_loc2_];
               _loc4_ = new class_18(_loc3_);
               if(_loc3_.var_255)
               {
                  _loc4_.x = _loc13_.var_201;
                  _loc4_.y = 0 - _loc13_.var_166 + _loc13_.var_366;
                  _loc13_.var_141.addChild(_loc4_);
                  _loc13_.var_191 = _loc4_;
               }
               else if(_loc3_.size == "large")
               {
                  _loc4_.x = Math.floor((_loc13_.api.var_160 - _loc4_.width) / 2);
                  if(_loc3_.var_235)
                  {
                     _loc4_.y = _loc13_.var_321;
                  }
                  else if(Boolean(this.data.var_279) || Boolean(this.data.var_259))
                  {
                     _loc4_.y = _loc13_.var_374;
                  }
                  else
                  {
                     _loc4_.y = _loc13_.var_359;
                  }
                  if(_loc3_.var_235)
                  {
                     _loc5_ = this.api.var_153.method_103(_loc13_.var_336);
                     _loc5_.x = _loc4_.x + _loc13_.var_360;
                     _loc5_.y = _loc4_.y + _loc13_.var_308;
                     _loc13_.var_144.addChild(_loc5_);
                     _loc13_.var_350 = _loc5_;
                     _loc13_.var_295 = true;
                  }
                  _loc13_.var_144.addChild(_loc4_);
                  _loc13_.var_177 = _loc4_;
                  if(this.data.var_179)
                  {
                     _loc13_.var_157.graphics.lineStyle(0,0,0);
                     _loc13_.var_157.graphics.beginFill(0,0);
                     _loc13_.var_157.graphics.drawRect(0,0,1,1);
                     _loc13_.var_157.graphics.drawRect(this.api.var_160 - 1,0,1,1);
                  }
               }
               else
               {
                  _loc4_.x = _loc13_.var_157.width + _loc13_.var_261;
                  if(_loc13_.var_157.width == 0)
                  {
                     _loc4_.x = 0;
                  }
                  if(Boolean(this.data.var_179) && _loc13_.var_177 != null)
                  {
                     if(_loc2_ == 1)
                     {
                        _loc4_.x = _loc13_.var_177.x - _loc13_.var_261 - _loc4_.width;
                     }
                     else if(_loc2_ == 0)
                     {
                        class_7.error("API ERROR: You must define the Large Button first for a Promo screen.");
                     }
                     else if(_loc2_ == 2)
                     {
                        _loc4_.x = _loc13_.var_177.x + _loc13_.var_177.width + _loc13_.var_261;
                     }
                     else
                     {
                        class_7.error("API ERROR: Too many extra buttons for a Promo screen.");
                        _loc4_.x = 0;
                     }
                  }
                  _loc13_.var_157.addChild(_loc4_);
               }
               _loc2_++;
            }
         }
         _loc13_.var_144.addChild(_loc13_.var_157);
         _loc13_.var_157.x = Math.floor((_loc13_.api.var_160 - _loc13_.var_157.width) / 2);
         if(this.data.var_303)
         {
            _loc6_ = this.data.var_272.split(" ");
            _loc13_.var_143 = _loc13_.api.var_153.method_136(_loc13_.var_356);
            _loc13_.var_174 = _loc13_.api.var_153.method_136(_loc13_.var_383);
            _loc13_.var_143.addEventListener(MouseEvent.CLICK,_loc13_.method_177);
            _loc13_.var_174.addEventListener(MouseEvent.CLICK,_loc13_.method_174);
            if(_loc13_.api.var_221)
            {
               _loc13_.var_143.visible = false;
               _loc13_.var_174.visible = true;
            }
            else
            {
               _loc13_.var_143.visible = true;
               _loc13_.var_174.visible = false;
            }
            if(_loc6_.indexOf("top") > -1)
            {
               _loc13_.var_143.y = 0 - _loc13_.var_166 + _loc13_.var_329;
            }
            else if(_loc6_.indexOf("bottom") > -1)
            {
               _loc13_.var_143.y = _loc13_.api.var_152 - _loc13_.var_161 - _loc13_.var_143.height - _loc13_.var_299;
               if(this.data.var_179)
               {
                  _loc13_.var_143.y = _loc13_.var_301;
               }
            }
            if(_loc6_.indexOf("left") > -1)
            {
               _loc13_.var_143.x = _loc13_.var_327;
            }
            else if(_loc6_.indexOf("right") > -1)
            {
               _loc13_.var_143.x = _loc13_.api.var_160 - _loc13_.var_327 - _loc13_.var_143.width;
               if(this.data.var_179)
               {
                  _loc13_.var_143.x = _loc13_.api.var_160 - _loc13_.var_363 - _loc13_.var_143.width;
               }
            }
            else if(_loc6_.indexOf("center") > -1)
            {
               _loc13_.var_143.x = (_loc13_.api.var_160 - _loc13_.var_143.width) / 2;
            }
            _loc13_.var_174.x = _loc13_.var_143.x;
            _loc13_.var_174.y = _loc13_.var_143.y;
            if(_loc6_.indexOf("top") > -1)
            {
               _loc13_.var_141.addChild(_loc13_.var_174);
               _loc13_.var_141.addChild(_loc13_.var_143);
            }
            else if(_loc6_.indexOf("bottom") > -1)
            {
               _loc13_.var_144.addChild(_loc13_.var_174);
               _loc13_.var_144.addChild(_loc13_.var_143);
            }
            if(this.data.var_286)
            {
               _loc13_.var_156 = _loc13_.api.var_153.method_136(_loc13_.var_369);
               _loc13_.var_175 = _loc13_.api.var_153.method_136(_loc13_.var_357);
               _loc13_.var_156.addEventListener(MouseEvent.CLICK,_loc13_.method_190);
               _loc13_.var_175.addEventListener(MouseEvent.CLICK,_loc13_.method_186);
               if(_loc13_.api.var_218)
               {
                  _loc13_.var_156.visible = false;
                  _loc13_.var_175.visible = true;
               }
               else
               {
                  _loc13_.var_156.visible = true;
                  _loc13_.var_175.visible = false;
               }
               if(_loc6_.indexOf("top") > -1)
               {
                  _loc13_.var_156.y = 0 - _loc13_.var_166 + _loc13_.var_329;
               }
               else if(_loc6_.indexOf("bottom") > -1)
               {
                  _loc13_.var_156.y = _loc13_.api.var_152 - _loc13_.var_161 - _loc13_.var_143.height - _loc13_.var_299;
                  if(this.data.var_179)
                  {
                     _loc13_.var_156.y = _loc13_.var_301;
                  }
               }
               if(_loc6_.indexOf("left") > -1)
               {
                  _loc13_.var_156.x = _loc13_.var_143.x + _loc13_.var_224;
               }
               else if(_loc6_.indexOf("right") > -1)
               {
                  _loc13_.var_156.x = _loc13_.var_143.x - _loc13_.var_224 - _loc13_.var_156.width;
               }
               else if(_loc6_.indexOf("center") > -1)
               {
                  _loc13_.var_156.x = _loc13_.var_143.x + _loc13_.var_224;
               }
               _loc13_.var_175.x = _loc13_.var_156.x;
               _loc13_.var_175.y = _loc13_.var_156.y;
               if(_loc6_.indexOf("top") > -1)
               {
                  _loc13_.var_141.addChild(_loc13_.var_175);
                  _loc13_.var_141.addChild(_loc13_.var_156);
               }
               else if(_loc6_.indexOf("bottom") > -1)
               {
                  _loc13_.var_144.addChild(_loc13_.var_175);
                  _loc13_.var_144.addChild(_loc13_.var_156);
               }
            }
         }
         if(this.data.var_320)
         {
            _loc7_ = new TextField();
            _loc7_.embedFonts = true;
            _loc7_.antiAliasType = AntiAliasType.ADVANCED;
            _loc7_.gridFitType = GridFitType.PIXEL;
            _loc7_.wordWrap = false;
            _loc7_.multiline = false;
            _loc7_.defaultTextFormat = _loc13_.method_170();
            _loc7_.text = this.data.var_309;
            _loc7_.mouseEnabled = false;
            _loc7_.tabEnabled = false;
            _loc7_.height = _loc7_.textHeight + 4;
            _loc7_.width = _loc7_.textWidth + 6;
            _loc7_.y = _loc13_.api.var_152 - _loc13_.var_161 - _loc7_.height - _loc13_.var_347;
            _loc7_.x = (_loc13_.api.var_160 - _loc7_.width) / 2;
            _loc13_.var_144.addChild(_loc7_);
         }
         if(this.data.var_307)
         {
            _loc8_ = new TextField();
            _loc8_.embedFonts = true;
            _loc8_.antiAliasType = AntiAliasType.ADVANCED;
            _loc8_.gridFitType = GridFitType.PIXEL;
            _loc8_.wordWrap = false;
            _loc8_.multiline = false;
            _loc8_.defaultTextFormat = _loc13_.method_170();
            _loc8_.text = this.data.var_293;
            _loc8_.mouseEnabled = false;
            _loc8_.tabEnabled = false;
            _loc8_.height = _loc8_.textHeight + 4;
            _loc8_.width = _loc8_.textWidth + 6;
            _loc8_.y = _loc13_.api.var_152 - _loc13_.var_161 - _loc8_.height - _loc13_.var_353;
            _loc8_.x = _loc13_.var_334;
            _loc13_.var_144.addChild(_loc8_);
         }
         if(this.data.var_316)
         {
            if(this.data.var_325 == "small")
            {
               _loc13_.var_146 = _loc13_.api.var_153.method_103(_loc13_.var_358);
            }
            else
            {
               _loc13_.var_146 = _loc13_.api.var_153.method_103(_loc13_.var_385);
            }
            _loc1_ = this.data.var_332.split(" ");
            if(_loc1_.indexOf("top") > -1)
            {
               _loc13_.var_146.y = _loc13_.var_265 - _loc13_.var_166;
            }
            else if(_loc1_.indexOf("bottom") > -1)
            {
               _loc13_.var_146.y = _loc13_.api.var_152 - _loc13_.var_161 - _loc13_.var_146.height - _loc13_.var_264;
            }
            if(_loc1_.indexOf("left") > -1)
            {
               _loc13_.var_146.x = _loc13_.var_201;
            }
            else if(_loc1_.indexOf("right") > -1)
            {
               _loc13_.var_146.x = _loc13_.api.var_160 - _loc13_.var_146.width - _loc13_.var_201;
            }
            else if(_loc1_.indexOf("center") > -1)
            {
               _loc13_.var_146.x = (_loc13_.api.var_160 - _loc13_.var_146.width) / 2;
            }
            if(this.data.var_208 != null && this.data.var_208 != "")
            {
               _loc13_.var_146.buttonMode = true;
               _loc13_.var_146.mouseEnabled = true;
               _loc13_.var_146.mouseChildren = false;
               _loc13_.var_146.useHandCursor = true;
               _loc13_.var_146.addEventListener(MouseEvent.CLICK,_loc13_.method_198);
            }
            if(this.data.var_289)
            {
               _loc9_ = _loc13_.api.var_153.method_103(_loc13_.var_355);
               _loc9_.y = this.var_146.y - _loc9_.height;
               if(_loc1_.indexOf("left") > -1)
               {
                  _loc9_.x = this.var_146.x;
               }
               else if(_loc1_.indexOf("center") > -1)
               {
                  _loc9_.x = this.var_146.x + (this.var_146.width - _loc9_.width) / 2;
               }
               else if(_loc1_.indexOf("right") > -1)
               {
                  _loc9_.x = this.var_146.x + this.var_146.width - _loc9_.width;
               }
               if(_loc1_.indexOf("top") > -1)
               {
                  _loc13_.var_141.addChild(_loc9_);
               }
               else if(_loc1_.indexOf("bottom") > -1)
               {
                  _loc13_.var_144.addChild(_loc9_);
               }
            }
            if(_loc1_.indexOf("top") > -1)
            {
               _loc13_.var_141.addChild(_loc13_.var_146);
            }
            else if(_loc1_.indexOf("bottom") > -1)
            {
               _loc13_.var_144.addChild(_loc13_.var_146);
            }
         }
         if(this.data.var_326)
         {
            if(this.data.var_311 == "small")
            {
               _loc13_.var_158 = _loc13_.api.var_153.method_103(_loc13_.var_343);
            }
            else
            {
               _loc13_.var_158 = _loc13_.api.var_153.method_103(_loc13_.var_386);
            }
            _loc1_ = this.data.var_310.split(" ");
            if(_loc1_.indexOf("top") > -1)
            {
               _loc13_.var_158.y = _loc13_.var_265 - _loc13_.var_166;
            }
            else if(_loc1_.indexOf("bottom") > -1)
            {
               _loc13_.var_158.y = _loc13_.api.var_152 - _loc13_.var_161 - _loc13_.var_158.height - _loc13_.var_264;
            }
            if(_loc1_.indexOf("left") > -1)
            {
               _loc13_.var_158.x = _loc13_.var_201;
            }
            else if(_loc1_.indexOf("right") > -1)
            {
               _loc13_.var_158.x = _loc13_.api.var_160 - _loc13_.var_158.width - _loc13_.var_201;
            }
            else if(_loc1_.indexOf("center") > -1)
            {
               _loc13_.var_158.x = (_loc13_.api.var_160 - _loc13_.var_158.width) / 2;
            }
            if(this.data.var_212 != null && this.data.var_212 != "")
            {
               _loc13_.var_158.buttonMode = true;
               _loc13_.var_158.mouseEnabled = true;
               _loc13_.var_158.mouseChildren = false;
               _loc13_.var_158.useHandCursor = true;
               _loc13_.var_158.addEventListener(MouseEvent.CLICK,_loc13_.method_165);
            }
            if(_loc1_.indexOf("top") > -1)
            {
               _loc13_.var_141.addChild(_loc13_.var_158);
            }
            else if(_loc1_.indexOf("bottom") > -1)
            {
               _loc13_.var_144.addChild(_loc13_.var_158);
            }
         }
         if(this.data.var_236 != null && this.data.var_236 != "")
         {
            _loc13_.var_236 = _loc13_.api.var_153.method_221(this.data.var_236,_loc13_.api.var_281,_loc13_.clip,_loc13_.var_324);
         }
         _loc13_.clip.addChild(_loc13_.var_141);
         _loc13_.clip.addChild(_loc13_.var_144);
         _loc13_.var_141.addEventListener(Event.ENTER_FRAME,_loc13_.method_146);
         _loc13_.api.container.addChild(_loc13_.clip);
      }
      
      public function startTransitionOut() : void
      {
         var _loc1_:class_25 = this;
         _loc1_.var_322 = true;
         _loc1_.disableButtons();
         _loc1_.var_166 = 0 - _loc1_.var_141.height - 5;
         _loc1_.var_161 = this.api.var_152 + 5;
         if(_loc1_.var_295)
         {
            _loc1_.var_161 += (_loc1_.var_321 + _loc1_.var_308) * -1;
         }
         if(!_loc1_.var_141.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.var_141.addEventListener(Event.ENTER_FRAME,_loc1_.method_146);
         }
      }
      
      public function method_146(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:class_25 = this;
         ++_loc4_.var_257;
         if(_loc4_.var_257 > _loc4_.var_348 || Boolean(_loc4_.var_322))
         {
            _loc2_ = _loc4_.var_166 - _loc4_.var_141.y;
            _loc3_ = _loc4_.var_161 - _loc4_.var_144.y;
            if(Math.abs(_loc2_) > 1)
            {
               _loc4_.var_141.y += _loc2_ / _loc4_.var_304;
            }
            else
            {
               _loc4_.var_141.y = _loc4_.var_166;
            }
            if(Math.abs(_loc3_) > 1)
            {
               _loc4_.var_144.y += _loc3_ / _loc4_.var_304;
            }
            else
            {
               _loc4_.var_144.y = _loc4_.var_161;
            }
            if(_loc4_.var_141.y == _loc4_.var_166 && _loc4_.var_144.y == _loc4_.var_161)
            {
               _loc4_.var_141.removeEventListener(Event.ENTER_FRAME,_loc4_.method_146);
            }
         }
      }
      
      public function method_198(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         if(Boolean(_loc2_.data.var_208) && _loc2_.data.var_208 != "")
         {
            _loc2_.api.method_107(_loc2_.data.var_208);
         }
      }
      
      public function method_187(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         if(Boolean(_loc2_.data.var_210) && _loc2_.data.var_210 != "")
         {
            _loc2_.api.method_107(_loc2_.data.var_210);
         }
      }
      
      public function method_165(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         if(Boolean(_loc2_.data.var_212) && _loc2_.data.var_212 != "")
         {
            _loc2_.api.method_107(_loc2_.data.var_212);
         }
      }
      
      public function method_158(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         if(Boolean(_loc2_.data.var_239) && _loc2_.data.var_239 != "")
         {
            _loc2_.api.method_107(_loc2_.data.var_239);
         }
      }
      
      public function method_177(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         _loc2_.api.method_234();
         _loc2_.var_143.visible = false;
         _loc2_.var_174.visible = true;
      }
      
      public function method_174(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         _loc2_.api.method_229();
         _loc2_.var_143.visible = true;
         _loc2_.var_174.visible = false;
      }
      
      public function method_190(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         _loc2_.api.method_244();
         _loc2_.var_156.visible = false;
         _loc2_.var_175.visible = true;
      }
      
      public function method_186(param1:MouseEvent) : void
      {
         var _loc2_:class_25 = this;
         _loc2_.api.method_250();
         _loc2_.var_156.visible = true;
         _loc2_.var_175.visible = false;
      }
      
      public function method_159(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:class_25 = this;
         if(Boolean(_loc3_.data.var_149) && Boolean(_loc3_.data.var_149.var_247) && _loc3_.data.var_149.var_247 != "")
         {
            _loc2_ = "PromoFacebook";
            if(_loc3_.data.var_149.var_249)
            {
               _loc2_ = "PromoFacebookLicense";
            }
            _loc3_.api.method_107(_loc3_.data.var_149.var_247);
         }
      }
      
      public function method_195(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:class_25 = this;
         if(Boolean(_loc3_.data.var_149) && Boolean(_loc3_.data.var_149.var_238) && _loc3_.data.var_149.var_238 != "")
         {
            _loc2_ = "PromoTwitter";
            if(_loc3_.data.var_149.var_249)
            {
               _loc2_ = "PromoTwitterLicense";
            }
            _loc3_.api.method_107(_loc3_.data.var_149.var_238);
         }
      }
      
      public function method_164(param1:MouseEvent) : void
      {
         var _loc5_:Array = null;
         var _loc2_:String = null;
         var _loc3_:class_25 = this;
         var _loc4_:Number = -1;
         _loc5_ = String(param1.currentTarget.name).split("gamepanel");
         if(_loc5_.length > 1)
         {
            _loc4_ = Number(_loc5_[1]);
         }
         if(_loc4_ > -1)
         {
            if(Boolean(_loc3_.data.var_149) && _loc3_.data.var_149.var_214.length >= _loc4_)
            {
               _loc2_ = _loc3_.data.var_149.var_214[_loc4_ - 1];
               if(_loc2_ != null && _loc2_ != "")
               {
                  _loc3_.api.method_107(_loc2_);
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:int = 0;
         var _loc3_:class_18 = null;
         var _loc4_:class_25 = this;
         if(_loc4_.var_236)
         {
            _loc4_.var_236.destroy();
            _loc4_.var_236 = null;
         }
         if(_loc4_.var_162)
         {
            try
            {
               _loc4_.var_162.facebook_btn.removeEventListener(MouseEvent.CLICK,_loc4_.method_159);
               _loc4_.var_162.twitter_btn.removeEventListener(MouseEvent.CLICK,_loc4_.method_195);
            }
            catch(err:Error)
            {
            }
            try
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_.var_162.inside.numChildren)
               {
                  _loc4_.var_162.inside["gamepanel" + (_loc2_ + 1)].removeEventListener(MouseEvent.CLICK,_loc4_.method_164);
                  _loc2_++;
               }
            }
            catch(err:Error)
            {
            }
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.var_157.numChildren)
         {
            _loc3_ = _loc4_.var_157.getChildAt(_loc1_) as class_18;
            _loc3_.destroy();
            _loc3_ = null;
            _loc1_++;
         }
         if(_loc4_.var_177)
         {
            _loc4_.var_177.destroy();
            _loc4_.var_177 = null;
         }
         if(_loc4_.var_191)
         {
            _loc4_.var_191.destroy();
            _loc4_.var_191 = null;
         }
         if(Boolean(_loc4_.var_146) && Boolean(_loc4_.var_146.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_146.removeEventListener(MouseEvent.CLICK,_loc4_.method_198);
         }
         if(Boolean(_loc4_.var_148) && Boolean(_loc4_.var_148.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_148.removeEventListener(MouseEvent.CLICK,_loc4_.method_187);
         }
         if(Boolean(_loc4_.var_158) && Boolean(_loc4_.var_158.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_158.removeEventListener(MouseEvent.CLICK,_loc4_.method_165);
         }
         if(Boolean(_loc4_.var_143) && Boolean(_loc4_.var_143.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_143.removeEventListener(MouseEvent.CLICK,_loc4_.method_177);
         }
         if(Boolean(_loc4_.var_174) && Boolean(_loc4_.var_174.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_174.removeEventListener(MouseEvent.CLICK,_loc4_.method_174);
         }
         if(Boolean(_loc4_.var_156) && Boolean(_loc4_.var_156.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_156.removeEventListener(MouseEvent.CLICK,_loc4_.method_190);
         }
         if(Boolean(_loc4_.var_175) && Boolean(_loc4_.var_175.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_175.removeEventListener(MouseEvent.CLICK,_loc4_.method_186);
         }
         if(Boolean(_loc4_.var_167) && Boolean(_loc4_.var_167.hasEventListener(MouseEvent.CLICK)))
         {
            _loc4_.var_167.removeEventListener(MouseEvent.CLICK,_loc4_.method_158);
         }
         _loc4_.api.container.removeChild(_loc4_.clip);
      }
      
      public function getLabel() : String
      {
         var _loc1_:class_25 = this;
         return _loc1_.data.label;
      }
      
      public function disableButtons(param1:Array = null, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc5_:class_25 = null;
         var _loc4_:class_18 = null;
         _loc5_ = this;
         if(Boolean(_loc5_.var_177) && param2)
         {
            _loc5_.var_177.method_148();
         }
         if(Boolean(_loc5_.var_191) && param3)
         {
            _loc5_.var_191.method_148();
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.var_157.numChildren)
         {
            _loc4_ = _loc5_.var_157.getChildAt(_loc6_) as class_18;
            if(param1 == null || param1.indexOf(_loc4_.getLabel()) > -1)
            {
               _loc4_.method_148();
            }
            _loc6_++;
         }
      }
      
      public function enableButtons(param1:Array = null) : void
      {
         var _loc2_:class_18 = null;
         var _loc3_:class_25 = this;
         if(_loc3_.var_177)
         {
            _loc3_.var_177.method_147();
         }
         if(_loc3_.var_191)
         {
            _loc3_.var_191.method_147();
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.var_157.numChildren)
         {
            _loc2_ = _loc3_.var_157.getChildAt(_loc4_) as class_18;
            if(param1 == null || param1.indexOf(_loc2_.getLabel()) > -1)
            {
               _loc2_.method_147();
            }
            _loc4_++;
         }
      }
      
      public function setButtonIcon(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc4_:class_18 = null;
         var _loc5_:class_25 = this;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.var_157.numChildren)
         {
            _loc4_ = _loc5_.var_157.getChildAt(_loc6_) as class_18;
            if(_loc4_.getLabel() == param1)
            {
               _loc4_.method_201(param2,param3);
            }
            _loc6_++;
         }
      }
      
      public function setTitle(param1:String) : void
      {
         var _loc2_:class_25 = this;
         _loc2_.var_163.text = param1;
         _loc2_.var_163.height = _loc2_.var_163.textHeight + 4;
      }
      
      private function method_140() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = class_17.const_8;
         _loc1_.color = 11447982;
         _loc1_.size = 30;
         _loc1_.align = TextFormatAlign.CENTER;
         _loc1_.kerning = true;
         _loc1_.letterSpacing = -0.5;
         return _loc1_;
      }
      
      private function method_170() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = class_17.const_14;
         _loc1_.color = class_17.const_24;
         _loc1_.size = class_17.const_22;
         _loc1_.bold = class_17.const_23;
         _loc1_.align = TextFormatAlign.CENTER;
         _loc1_.kerning = true;
         _loc1_.letterSpacing = 0;
         return _loc1_;
      }
      
      public function attachButtonNextToMute(param1:DisplayObject) : void
      {
         var targetX:Number = Number(NaN);
         var targetY:Number = Number(NaN);
         var splitMute:Array = null;
         var button:DisplayObject = param1;
         var screen:class_25 = this;
         try
         {
            targetX = 0;
            targetY = 0;
            if(this.data.var_286)
            {
               targetX = screen.var_156.x - button.width - screen.var_224;
               targetY = Number(screen.var_156.y);
            }
            else
            {
               targetX = screen.var_143.x - button.width - screen.var_224;
               targetY = Number(screen.var_143.y);
            }
            button.x = targetX;
            button.y = targetY;
            splitMute = this.data.var_272.split(" ");
            if(splitMute.indexOf("top") > -1)
            {
               screen.var_141.addChild(button);
            }
            else if(splitMute.indexOf("bottom") > -1)
            {
               screen.var_144.addChild(button);
            }
         }
         catch(err:Error)
         {
            class_7.error("Error attaching button next to mute: " + err.message);
         }
      }
   }
}

