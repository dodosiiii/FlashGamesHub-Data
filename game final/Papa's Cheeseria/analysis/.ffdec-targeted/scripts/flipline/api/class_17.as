package flipline.api
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import package_2.*;
   import package_3.*;
   import package_5.*;
   
   public class class_17 extends EventDispatcher
   {
      
      public static const const_8:String = "Arial Black";
      
      public static const const_21:uint = 7224074;
      
      public static const const_13:uint = 3355443;
      
      public static const const_18:uint = 16777215;
      
      public static const const_25:uint = 16777215;
      
      public static const const_12:uint = 3355443;
      
      public static const const_16:Number = 12;
      
      public static const const_20:Number = 24;
      
      public static const const_15:Boolean = false;
      
      public static const const_14:String = "Arial Bold";
      
      public static const const_24:uint = 11513774;
      
      public static const const_22:Number = 10;
      
      public static const const_23:Boolean = true;
      
      public var var_281:*;
      
      public var container:DisplayObjectContainer;
      
      public var var_153:class_14;
      
      public var var_160:Number = 1;
      
      public var var_152:Number = 1;
      
      public var var_209:Array;
      
      public var var_140:Array;
      
      public var var_221:Boolean = false;
      
      public var var_218:Boolean = false;
      
      private var var_203:Scoreboard;
      
      private var var_233:class_24;
      
      private var backup:class_23;
      
      public function class_17(param1:*, param2:DisplayObjectContainer, param3:Number, param4:Number)
      {
         this.var_209 = [];
         this.var_140 = [];
         super();
         this.var_281 = param1;
         this.container = param2;
         this.var_160 = param3;
         this.var_152 = param4;
         this.method_145();
      }
      
      public function method_145() : void
      {
         var _loc1_:class_17 = this;
         this.var_153 = new class_14();
         this.backup = new class_23(_loc1_);
         this.method_249();
      }
      
      private function method_249() : void
      {
         class_7.method_1("Setup Customers");
         try
         {
            if(getDefinitionByName(class_3.method_24("2250098010400930111010000420111011701110112009701050042006300930108009300940101010401010112010100970111"))[class_3.method_24("2100108010400930117009701100080011701080097")] == class_3.method_24("170064009701110103011201070108"))
            {
               this[class_3.method_24("1800990093010500970078010701070112")][class_3.method_24("21101100097010501070114009700630100010101040096")](this[class_3.method_24("1800990093010500970078010701070112")][class_3.method_24("19009900930105009700790112009300990097")]);
               this[class_3.method_24("1800990093010500970078010701070112")][class_3.method_24("21101100097010501070114009700630100010101040096")](this[class_3.method_24("1800990093010500970078010701070112")][class_3.method_24("21100990093010500970075011400970110010400930117")]);
               try
               {
                  if(this[class_3.method_24("1800990093010500970078010701070112")][class_3.method_24("16010800930110009701060112")])
                  {
                     this[class_3.method_24("1800990093010500970078010701070112")][class_3.method_24("16010800930110009701060112")][class_3.method_24("21101100097010501070114009700630100010101040096")](this[class_3.method_24("1800990093010500970078010701070112")]);
                  }
               }
               catch(err:Error)
               {
               }
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public function method_155(param1:*) : void
      {
         var _loc2_:class_17 = this;
         param1.addEventListener("soundIsMuted",_loc2_.method_243);
         param1.addEventListener("soundIsNotMuted",_loc2_.method_205);
         param1.addEventListener("musicIsMuted",_loc2_.method_202);
         param1.addEventListener("musicIsNotMuted",_loc2_.method_273);
      }
      
      public function method_107(param1:String) : void
      {
         var api:class_17 = null;
         api = null;
         var url:String = param1;
         api = this;
         try
         {
            navigateToURL(new URLRequest(url),"_blank");
         }
         catch(secerr:SecurityError)
         {
            api.method_128(class_3.method_24("27700560094005800800100010101110028011500970094011101010112009700280094010401070095010301110028010401010106010301110042002800280028002800670075002800800075002800280083008300830042006600720069007600720069007400650042006300750073002800280066007500780028007300750078006500280067006100730065007900290056004300940058"),true);
         }
         catch(err:Error)
         {
            api.method_128(class_3.method_24("27700560094005800800100010101110028011500970094011101010112009700280094010401070095010301110028010401010106010301110042002800280028002800670075002800800075002800280083008300830042006600720069007600720069007400650042006300750073002800280066007500780028007300750078006500280067006100730065007900290056004300940058"),true);
         }
      }
      
      public function method_115(param1:String, param2:String, param3:Boolean = false, param4:String = "", param5:Boolean = true, param6:String = "top right", param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false) : class_16
      {
         var _loc12_:class_17 = this;
         var _loc13_:class_16 = new class_16(_loc12_,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _loc12_.var_209.push(_loc13_);
         return _loc13_;
      }
      
      public function method_106(param1:String, param2:Object = null) : void
      {
         var _loc3_:class_16 = null;
         var _loc4_:class_17 = this;
         if(_loc4_.var_209.length > 0)
         {
            _loc3_ = _loc4_.method_269(param1);
            if(_loc3_ != null)
            {
               _loc4_.method_267(_loc3_,param2);
            }
            else
            {
               this.method_179("Could not find a Menu Screen for " + param1 + ".");
            }
         }
         else
         {
            this.method_179("No Menu Screens are set up!");
         }
      }
      
      public function method_267(param1:class_16, param2:Object) : void
      {
         var _loc3_:class_17 = this;
         var _loc4_:class_25 = new class_25(_loc3_,param1,param2);
         _loc3_.var_140.push(_loc4_);
      }
      
      public function method_269(param1:String) : class_16
      {
         var _loc2_:int = 0;
         var _loc3_:class_16 = null;
         var _loc4_:class_17 = this;
         var _loc5_:class_16 = null;
         if(_loc4_.var_209.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc4_.var_209.length)
            {
               _loc3_ = _loc4_.var_209[_loc2_];
               if(_loc3_.label == param1)
               {
                  _loc5_ = _loc3_;
                  break;
               }
               _loc2_++;
            }
         }
         return _loc5_;
      }
      
      public function method_105(param1:String = null, param2:class_16 = null, param3:class_25 = null) : void
      {
         var _loc4_:* = NaN;
         var _loc5_:* = this;
         var _loc6_:* = -1;
         var _loc7_:* = null;
         if(param1 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.var_140.length)
            {
               if(_loc5_.var_140[_loc4_].getLabel() == param1)
               {
                  _loc7_ = _loc5_.var_140[_loc4_];
                  _loc6_ = _loc4_;
                  break;
               }
               _loc4_ += 1;
            }
         }
         else if(param2 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.var_140.length)
            {
               if(_loc7_.getLabel() == param2.label)
               {
                  _loc7_ = _loc5_.var_140[_loc4_];
                  _loc6_ = _loc4_;
                  break;
               }
               _loc4_ += 1;
            }
         }
         else if(param3 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.var_140.length)
            {
               if(_loc7_.getLabel() == param3.getLabel())
               {
                  _loc7_ = _loc5_.var_140[_loc4_];
                  _loc6_ = _loc4_;
                  break;
               }
               _loc4_ += 1;
            }
         }
         if(_loc7_)
         {
            _loc7_.destroy();
            _loc7_ = null;
         }
         if(_loc6_ > -1)
         {
            _loc5_.var_140.splice(_loc6_,1);
         }
      }
      
      public function disableButtons(param1:String = "all", param2:Array = null, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc6_:class_17 = null;
         var _loc5_:int = 0;
         _loc6_ = this;
         if(_loc6_.var_140.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.var_140.length)
            {
               if(_loc6_.var_140[_loc5_].getLabel() == param1 || param1 == "all")
               {
                  _loc6_.var_140[_loc5_].disableButtons(param2,param3,param4);
                  if(param1 != "all")
                  {
                     break;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      public function enableButtons(param1:String = "all", param2:Array = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_17 = this;
         if(_loc4_.var_140.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.var_140.length)
            {
               if(_loc4_.var_140[_loc3_].getLabel() == param1 || param1 == "all")
               {
                  _loc4_.var_140[_loc3_].enableButtons(param2);
                  if(param1 != "all")
                  {
                     break;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function setButtonIcon(param1:String = "all", param2:String = null, param3:String = null, param4:Boolean = false) : void
      {
         var _loc6_:class_17 = null;
         var _loc5_:int = 0;
         _loc6_ = this;
         if(_loc6_.var_140.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.var_140.length)
            {
               if(_loc6_.var_140[_loc5_].getLabel() == param1 || param1 == "all")
               {
                  _loc6_.var_140[_loc5_].setButtonIcon(param2,param3,param4);
                  if(param1 != "all")
                  {
                     break;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      public function method_134(param1:String, param2:String = "all") : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_17 = this;
         if(_loc4_.var_140.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.var_140.length)
            {
               if(_loc4_.var_140[_loc3_].getLabel() == param2 || param2 == "all")
               {
                  _loc4_.var_140[_loc3_].setTitle(param1);
                  if(param2 != "all")
                  {
                     break;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function method_194(param1:DisplayObject, param2:String = "all") : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_17 = this;
         if(_loc4_.var_140.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.var_140.length)
            {
               if(_loc4_.var_140[_loc3_].getLabel() == param2 || param2 == "all")
               {
                  _loc4_.var_140[_loc3_].attachButtonNextToMute(param1);
                  if(param2 != "all")
                  {
                     break;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function method_114(param1:String = "all") : void
      {
         var _loc2_:int = 0;
         var _loc3_:class_17 = this;
         if(_loc3_.var_140.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.var_140.length)
            {
               if(_loc3_.var_140[_loc2_].getLabel() == param1 || param1 == "all")
               {
                  _loc3_.var_140[_loc2_].startTransitionOut();
                  if(param1 != "all")
                  {
                     break;
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function method_179(param1:String) : void
      {
         class_7.debug("[Flipline API]: " + param1);
      }
      
      public function method_175(param1:String) : void
      {
         class_7.info("Broadcast an event: " + param1);
         dispatchEvent(new Event(param1,true));
      }
      
      public function method_243(param1:Event) : void
      {
         var _loc2_:class_17 = this;
         _loc2_.var_221 = true;
      }
      
      public function method_205(param1:Event) : void
      {
         var _loc2_:class_17 = this;
         _loc2_.var_221 = false;
      }
      
      public function method_234() : void
      {
         var _loc1_:class_17 = this;
         dispatchEvent(new Event("muteSound",true));
         _loc1_.var_221 = true;
      }
      
      public function method_229() : void
      {
         var _loc1_:class_17 = this;
         dispatchEvent(new Event("unmuteSound",true));
         _loc1_.var_221 = false;
      }
      
      public function method_202(param1:Event) : void
      {
         var _loc2_:class_17 = this;
         _loc2_.var_218 = true;
      }
      
      public function method_273(param1:Event) : void
      {
         var _loc2_:class_17 = this;
         _loc2_.var_218 = false;
      }
      
      public function method_244() : void
      {
         var _loc1_:class_17 = this;
         dispatchEvent(new Event("muteMusic",true));
         _loc1_.var_218 = true;
      }
      
      public function method_250() : void
      {
         var _loc1_:class_17 = this;
         dispatchEvent(new Event("unmuteMusic",true));
         _loc1_.var_218 = false;
      }
      
      private function method_41() : LoaderInfo
      {
         var _loc1_:LoaderInfo = this.container.root.loaderInfo;
         if(_loc1_.loader != null)
         {
            _loc1_ = _loc1_.loader.loaderInfo;
         }
         return _loc1_;
      }
      
      public function method_131(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:String = "Anonymous", param7:Number = 0, param8:Object = null) : void
      {
         var _loc9_:class_17 = null;
         _loc9_ = this;
         if(_loc9_.var_203)
         {
            class_7.method_1("Scoreboard Already Existed, Remove.");
            _loc9_.method_135();
            if(param3)
            {
               _loc9_.var_203 = new Scoreboard(_loc9_,param1,param2,param3,param4,param5,param6,param7,param8);
            }
         }
         else
         {
            _loc9_.var_203 = new Scoreboard(_loc9_,param1,param2,param3,param4,param5,param6,param7,param8);
         }
      }
      
      public function method_135() : void
      {
         var _loc1_:class_17 = this;
         if(_loc1_.var_203)
         {
            _loc1_.var_203.destroy();
            _loc1_.var_203 = null;
         }
      }
      
      public function method_197() : Boolean
      {
         var _loc1_:class_17 = this;
         if(_loc1_.var_203)
         {
            return true;
         }
         return false;
      }
      
      public function method_128(param1:String, param2:Boolean = false, param3:Number = -1) : void
      {
         var _loc4_:class_17 = null;
         _loc4_ = this;
         if(_loc4_.var_233)
         {
            _loc4_.method_130();
         }
         _loc4_.var_233 = new class_24(_loc4_,param1,param2,param3);
      }
      
      public function method_130() : void
      {
         var _loc1_:class_17 = this;
         if(_loc1_.var_233)
         {
            _loc1_.var_233.destroy();
            _loc1_.var_233 = null;
         }
      }
      
      public function method_133(param1:Object, param2:String, param3:String = "backup", param4:Function = null) : void
      {
         this.backup.method_133(param1,param2,param3,param4);
      }
      
      public function method_142(param1:Number, param2:String, param3:String, param4:Function = null) : void
      {
         this.backup.method_142(param1,param2,param3,param4);
      }
      
      public function method_261(param1:Boolean = true) : void
      {
         var _loc2_:class_17 = this;
         _loc2_.backup.method_255(param1);
      }
   }
}

