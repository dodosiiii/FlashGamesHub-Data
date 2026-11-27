package package_3
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class class_4
   {
      
      private static var var_36:URLLoader;
      
      private static var var_49:Boolean = true;
      
      private static var var_89:String = "18004800470053005300420095010701051800510103005101030042009501070105170046004500480048004200950106211004700470050005001010105009900420095010701051800470047005000500042009501070105";
      
      private static var var_41:Array = null;
      
      private static var var_30:Boolean = false;
      
      private static var var_26:Boolean = false;
      
      private static var var_50:Number = -1;
      
      private static var var_44:Number = -1;
      
      private static var var_67:Number = 15;
      
      private static var var_56:Number = 15;
      
      private static var var_68:Number = 10;
      
      private static var var_46:Number = 5;
      
      private static var var_69:Number = 5;
      
      private static var var_74:Number = 5;
      
      private static var var_35:Boolean = false;
      
      private static var var_31:Boolean = false;
      
      private static var var_33:Number = -1;
      
      private static var var_21:Timer = null;
      
      private static var var_25:Timer = null;
      
      private static var var_19:Timer = null;
      
      private static var var_14:Timer = null;
      
      private static var var_54:String = null;
      
      private static var var_57:Boolean = false;
      
      private static var var_6:String = null;
      
      private static var loaderInfo:LoaderInfo = null;
      
      private static const const_1:String = "preroll";
      
      private static const const_2:String = "interstitial";
      
      private static const const_3:String = "interAlt";
      
      public static const const_5:String = "newgame";
      
      public static const const_4:String = "promo1";
      
      public static const const_6:String = "promo2";
      
      private static var gameSKU:String = null;
      
      private static var var_38:String = null;
      
      private static var var_11:Number = 640;
      
      private static var var_13:Number = 480;
      
      private static var var_108:String = "23801000112011201080054004300430115011501150042009801040101010801040101010600970093009601110042009501070105004301110097011001140097004300960093011200930043";
      
      private static var data:XML = null;
      
      private static var var_123:uint = 39168;
      
      private static var var_122:uint = 8245629;
      
      private static var var_120:uint = 3815994;
      
      private static var var_124:Number = 10;
      
      private static var var_42:Number = 42;
      
      public static var var_1:MovieClip = null;
      
      public static var var_37:String = null;
      
      public static var var_32:MovieClip = null;
      
      public static var var_3:String = "preroll";
      
      public static var var_27:DisplayObjectContainer = null;
      
      public static var var_8:Loader = null;
      
      public static var var_9:Loader = null;
      
      public static var var_7:Loader = null;
      
      public static var var_16:Loader = null;
      
      public static var var_17:Loader = null;
      
      public static var var_18:Loader = null;
      
      public static var var_2:MovieClip = null;
      
      public static var var_4:MovieClip = null;
      
      public static var var_5:MovieClip = null;
      
      public static var var_24:MovieClip = null;
      
      public static var var_23:MovieClip = null;
      
      public static var var_22:MovieClip = null;
      
      public static var var_63:MovieClip = null;
      
      public static var var_75:MovieClip = null;
      
      public static var var_70:MovieClip = null;
      
      public static var var_34:Function = null;
      
      public static var var_15:Function = null;
      
      private static var var_29:Number = 0;
      
      private static var var_40:Boolean = false;
      
      private static var var_72:String = null;
      
      private static var var_73:String = null;
      
      private static var var_77:String = null;
      
      private static var var_20:MovieClip = null;
      
      private static var var_10:MovieClip = null;
      
      private static var var_12:MovieClip = null;
      
      private static var var_39:Number = 0;
      
      public function class_4()
      {
         super();
      }
      
      public static function method_50(param1:LoaderInfo, param2:String, param3:String, param4:Number, param5:Number, param6:DisplayObjectContainer = null, param7:Boolean = true) : void
      {
         class_4.method_1("Setting Data");
         class_4.loaderInfo = param1;
         class_4.gameSKU = param2;
         class_4.var_38 = param3;
         class_4.var_11 = param4;
         class_4.var_13 = param5;
         class_4.var_27 = param6;
         class_4.var_49 = param7;
         class_4.method_47();
      }
      
      private static function method_47() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(class_4.var_41 == null)
         {
            class_4.var_41 = class_4.method_5(class_4.var_89);
         }
         if(class_4.loaderInfo != null)
         {
            _loc1_ = class_4.loaderInfo.url.split("/")[2];
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < class_4.var_41.length)
            {
               _loc4_ = class_4.var_41[_loc3_];
               _loc5_ = _loc1_.indexOf(_loc4_);
               if(_loc5_ != -1 && _loc5_ == _loc1_.length - _loc4_.length && (_loc5_ == 0 || _loc1_.charAt(_loc5_ - 1) == "."))
               {
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
            if(_loc2_)
            {
               class_4.var_49 = false;
            }
         }
      }
      
      public static function method_18(param1:String, param2:String) : void
      {
         if(param1 == class_4.const_5)
         {
            class_4.var_72 = param2;
         }
         else if(param1 == class_4.const_4)
         {
            class_4.var_73 = param2;
         }
         else if(param1 == class_4.const_6)
         {
            class_4.var_77 = param2;
         }
      }
      
      private static function loadData(param1:Function) : void
      {
         var currtime:Date = null;
         var currtimecode:Number = Number(NaN);
         var url:String = null;
         var urlRequest:URLRequest = null;
         var urlVariables:URLVariables = null;
         var domainName:String = null;
         var playerVersion:String = null;
         var completeFunction:Function = param1;
         class_4.var_15 = completeFunction;
         class_4.var_30 = true;
         class_4.var_50 = getTimer();
         if(Capabilities.playerType.toLowerCase() == "desktop")
         {
            class_4.error("AIR Mode");
            class_4.method_13(null);
         }
         else if(class_4.var_49 == false)
         {
            class_4.method_1("Bypass");
            class_4.method_13(null);
         }
         else if(class_4.loaderInfo == null)
         {
            class_4.method_1("loaderInfo was not set, use default.");
            class_4.method_13(null);
         }
         else
         {
            class_4.method_1("Loading Data");
            Security.allowDomain(class_4.method_12("22601000112011201080054004300430115011501150042009801040101010801040101010600970093009601110042009501070105"));
            Security.allowDomain(class_4.method_12("2220100011201120108005400430043011501150115004201050093011500990104010101060042009501070105"));
            Security.allowDomain(class_4.method_12("221010001120112010800540043004301010042009801040101010801040101010600970042009501070105"));
            Security.allowDomain(class_4.method_12("22301000112011201080054004300430115011501150042009801040101010801040101010600970042009501070105"));
            Security.allowDomain("www.youtube.com");
            currtime = new Date();
            currtimecode = currtime.getTime();
            url = class_4.method_12(class_4.var_108);
            url += gameSKU + ".xml";
            urlRequest = new URLRequest(url);
            urlVariables = new URLVariables();
            urlVariables.v = var_38;
            urlVariables.w = var_11;
            urlVariables.h = var_13;
            urlVariables.t = currtimecode;
            domainName = "na";
            try
            {
               if(class_4.loaderInfo != null)
               {
                  domainName = class_4.loaderInfo.url.split("/")[2];
                  if(domainName == null || domainName == "")
                  {
                     domainName = "local";
                  }
               }
            }
            catch(err:Error)
            {
               class_4.method_1("Error checking loadingInfo: " + err.message);
            }
            urlVariables.d = domainName;
            playerVersion = "na";
            try
            {
               playerVersion = Capabilities.version;
            }
            catch(err:Error)
            {
               class_4.method_1("Error checking player version: " + err.message);
            }
            urlVariables.p = playerVersion;
            urlRequest.data = urlVariables;
            urlRequest.method = "GET";
            class_4.var_36 = new URLLoader();
            class_4.var_36.addEventListener(Event.COMPLETE,class_4.method_56);
            class_4.var_36.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_13);
            class_4.var_36.addEventListener(SecurityErrorEvent.SECURITY_ERROR,class_4.method_52);
            try
            {
               class_4.var_36.load(urlRequest);
            }
            catch(error:Error)
            {
               class_4.error("Error loading data: " + error.message);
               class_4.method_13(null);
               return;
            }
            class_4.var_21 = new Timer(class_4.var_67 * 1000,1);
            class_4.var_21.addEventListener(TimerEvent.TIMER,class_4.method_59);
            class_4.var_21.start();
         }
      }
      
      private static function method_56(param1:Event) : void
      {
         var e:Event = param1;
         class_4.method_1("Data Response");
         if(class_4.var_21 != null)
         {
            class_4.var_21.reset();
         }
         try
         {
            class_4.data = XML((e.target as URLLoader).data);
            if(Boolean(class_4.data != null) && Boolean(class_4.data.hasOwnProperty("success")) && String(class_4.data.success) == "true")
            {
               class_4.var_26 = true;
               class_4.method_1("Data Loaded");
               if(class_4.data.hasOwnProperty("ato"))
               {
                  class_4.var_56 = Number(class_4.data.ato);
               }
               if(class_4.data.hasOwnProperty("bto"))
               {
                  class_4.var_68 = Number(class_4.data.bto);
               }
               if(class_4.data.hasOwnProperty("version"))
               {
                  class_4.var_54 = String(class_4.data.version);
               }
               if(class_4.data.hasOwnProperty("pre_delay"))
               {
                  class_4.var_46 = Number(class_4.data.pre_delay);
               }
               if(class_4.data.hasOwnProperty("int_delay"))
               {
                  class_4.var_69 = Number(class_4.data.int_delay);
               }
               if(class_4.data.hasOwnProperty("alt_delay"))
               {
                  class_4.var_74 = Number(class_4.data.alt_delay);
               }
               if(class_4.var_15 != null)
               {
                  class_4.var_15();
               }
            }
            else
            {
               class_4.error("Error - response did not contain success flag");
               class_4.method_10(true);
               class_4.data = null;
               if(class_4.var_15 != null)
               {
                  class_4.var_15();
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error with data response: " + err.message);
            class_4.method_10(true);
            class_4.data = null;
            if(class_4.var_15 != null)
            {
               class_4.var_15();
            }
         }
      }
      
      private static function method_13(param1:IOErrorEvent) : void
      {
         if(class_4.var_21 != null)
         {
            class_4.var_21.reset();
         }
         if(param1 != null)
         {
            class_4.error("Data Error: " + param1.text);
         }
         class_4.method_10(true);
         if(class_4.var_15 != null)
         {
            class_4.var_15();
         }
      }
      
      private static function method_52(param1:SecurityErrorEvent) : void
      {
         if(class_4.var_21 != null)
         {
            class_4.var_21.reset();
         }
         class_4.error("Data Security Error: " + param1.text);
         class_4.method_10(true);
         if(class_4.var_15 != null)
         {
            class_4.var_15();
         }
      }
      
      private static function method_59(param1:TimerEvent) : void
      {
         var e:TimerEvent = param1;
         class_4.method_1("Data Timeout");
         class_4.method_10(true);
         try
         {
            if(class_4.var_36 != null)
            {
               class_4.var_36.close();
            }
         }
         catch(err:Error)
         {
            class_4.error("Error Closing URLLoader for Timeout: " + err.message);
         }
         if(class_4.var_15 != null)
         {
            class_4.var_15();
         }
      }
      
      public static function method_57(param1:MovieClip, param2:Function) : void
      {
         class_4.var_34 = param2;
         class_4.var_32 = param1;
         class_4.var_40 = false;
         class_4.var_35 = false;
         class_4.var_31 = false;
         class_4.var_33 = -1;
         class_4.var_3 = class_4.const_1;
         class_4.method_26();
      }
      
      private static function method_40() : void
      {
         if(class_4.var_26)
         {
            if(class_4.var_8 != null)
            {
               class_4.method_1("Already loaded");
               class_4.method_3(class_4.var_8);
               class_4.method_4(class_4.const_1);
            }
            else
            {
               class_4.method_1("Load Preroll Content");
               class_4.method_22(class_4.const_1);
            }
         }
         else
         {
            class_4.method_7();
         }
      }
      
      public static function method_78() : void
      {
         class_4.method_1("Prepare Interstitial");
         class_4.method_49(null,null);
      }
      
      public static function method_49(param1:MovieClip, param2:Function) : void
      {
         class_4.var_34 = param2;
         class_4.var_32 = param1;
         if(class_4.var_1 != null && class_4.var_3 != class_4.const_1)
         {
            if(param1 != null)
            {
               class_4.method_1("Already Prepared!");
               param1.addChild(class_4.var_1);
               class_4.var_34 = param2;
               if(class_4.var_40 == true)
               {
                  class_4.method_31(class_4.var_3);
               }
            }
         }
         else
         {
            class_4.var_40 = false;
            class_4.var_35 = false;
            class_4.var_31 = false;
            class_4.var_33 = -1;
            class_4.var_3 = class_4.const_2;
            class_4.method_26();
            class_4.method_42(false,param1);
            if(class_4.var_30 == false)
            {
               class_4.loadData(class_4.method_38);
            }
            else
            {
               class_4.method_38();
            }
         }
      }
      
      private static function method_38() : void
      {
         if(class_4.var_26)
         {
            if(class_4.var_29 == 0)
            {
               class_4.var_3 = class_4.const_2;
               if(class_4.var_9 != null)
               {
                  class_4.method_1("Already loaded");
                  class_4.method_3(class_4.var_9);
                  class_4.method_4(class_4.const_2);
               }
               else
               {
                  class_4.method_1("Load Interstitial Content");
                  class_4.method_22(class_4.const_2);
               }
               class_4.var_29 = 1;
            }
            else
            {
               class_4.var_3 = class_4.const_3;
               if(class_4.var_7 != null)
               {
                  class_4.method_1("Already loaded");
                  class_4.method_3(class_4.var_7);
                  class_4.method_4(class_4.const_3);
               }
               else
               {
                  class_4.method_1("Load Alt Interstitial Content");
                  class_4.method_22(class_4.const_3);
               }
               class_4.var_29 = 0;
            }
         }
         else
         {
            class_4.method_7();
         }
      }
      
      private static function method_26() : void
      {
         var holder:MovieClip = null;
         var fader:MovieClip = null;
         var blackbar:MovieClip = null;
         var button:MovieClip = null;
         try
         {
            if(class_4.var_1 != null)
            {
               class_4.var_1.removeEventListener(Event.ENTER_FRAME,class_4.method_27);
               if(class_4.var_1.parent)
               {
                  class_4.var_1.parent.removeChild(class_4.var_1);
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up clip: " + err.message);
         }
         try
         {
            if(class_4.var_1 != null)
            {
               holder = class_4.var_1.getChildByName("holder") as MovieClip;
               if(holder != null)
               {
                  holder.removeEventListener(MouseEvent.MOUSE_DOWN,class_4.method_16);
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up click: " + err.message);
         }
         try
         {
            if(class_4.var_1 != null)
            {
               fader = class_4.var_1.getChildByName("fader") as MovieClip;
               if(fader != null && fader.parent != null)
               {
                  fader.stop();
                  fader.parent.removeChild(fader);
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up fader: " + err.message);
         }
         try
         {
            if(class_4.var_1 != null)
            {
               blackbar = class_4.var_1.getChildByName("blackbar") as MovieClip;
               if(blackbar != null && blackbar.parent != null)
               {
                  blackbar.parent.removeChild(blackbar);
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up black bar: " + err.message);
         }
         try
         {
            if(class_4.var_8 != null && class_4.var_8.parent != null)
            {
               class_4.var_8.parent.removeChild(class_4.var_8);
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up content 1: " + err.message);
         }
         try
         {
            if(class_4.var_9 != null && class_4.var_9.parent != null)
            {
               class_4.var_9.parent.removeChild(class_4.var_9);
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up content 2: " + err.message);
         }
         try
         {
            if(class_4.var_7 != null && class_4.var_7.parent != null)
            {
               class_4.var_7.parent.removeChild(class_4.var_7);
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up content 3: " + err.message);
         }
         try
         {
            if(class_4.var_24 != null && class_4.var_24.parent != null)
            {
               class_4.var_24.parent.removeChild(class_4.var_24);
            }
            class_4.var_24 = null;
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up content 4: " + err.message);
         }
         try
         {
            if(class_4.var_23 != null && class_4.var_23.parent != null)
            {
               class_4.var_23.parent.removeChild(class_4.var_23);
            }
            class_4.var_23 = null;
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up content 5: " + err.message);
         }
         try
         {
            if(class_4.var_22 != null && class_4.var_22.parent != null)
            {
               class_4.var_22.parent.removeChild(class_4.var_22);
            }
            class_4.var_22 = null;
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up content 6: " + err.message);
         }
         try
         {
            if(class_4.var_1 != null)
            {
               button = class_4.var_1.getChildByName("continue_btn") as MovieClip;
               if(button != null)
               {
                  button.removeEventListener(MouseEvent.MOUSE_DOWN,class_4.clickContinue);
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up continue button: " + err.message);
         }
         class_4.var_1 = null;
         class_4.var_32 = null;
      }
      
      private static function method_42(param1:Boolean, param2:MovieClip) : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         class_4.var_1 = new MovieClip();
         class_4.var_1.graphics.beginFill(0,1);
         class_4.var_1.graphics.drawRect(0,0,class_4.var_11,class_4.var_13);
         class_4.var_1.graphics.endFill();
         var _loc6_:MovieClip = new MovieClip();
         _loc6_.name = "holder";
         class_4.var_1.addChild(_loc6_);
         _loc7_ = new fliplinead_fader();
         _loc7_.x = class_4.var_11 / 2;
         _loc7_.y = class_4.var_13 / 2;
         _loc7_.name = "fader";
         _loc7_.gotoAndStop(1);
         _loc7_.mouseEnabled = false;
         _loc7_.mouseChildren = false;
         class_4.var_1.addChild(_loc7_);
         _loc8_ = new fliplinead_spinner();
         _loc8_.x = class_4.var_11 / 2;
         _loc8_.y = class_4.var_13 / 2;
         _loc8_.name = "spinner";
         class_4.var_1.addChild(_loc8_);
         _loc8_.btn.addEventListener(MouseEvent.MOUSE_DOWN,class_4.method_33);
         _loc9_ = new MovieClip();
         _loc9_.x = 0;
         _loc9_.y = class_4.var_13 - class_4.var_42;
         _loc9_.name = "blackbar";
         _loc9_.graphics.beginFill(0,1);
         _loc9_.graphics.drawRect(0,0,class_4.var_11,class_4.var_42);
         _loc9_.graphics.endFill();
         class_4.var_1.addChild(_loc9_);
         _loc10_ = new fliplinead_continue_btn();
         _loc10_.x = class_4.var_11 - 130;
         _loc10_.y = class_4.var_13 - 36;
         class_4.var_1.addChild(_loc10_);
         _loc10_.name = "continue_btn";
         _loc10_.gotoAndStop(1);
         _loc10_.mouseEnabled = false;
         _loc10_.mouseChildren = false;
         _loc10_.buttonMode = true;
         _loc10_.useHandCursor = false;
         _loc10_.addEventListener(MouseEvent.MOUSE_DOWN,class_4.clickContinue);
         if(param1)
         {
            _loc3_ = new MovieClip();
            _loc3_.graphics.beginFill(class_4.var_120,1);
            _loc3_.graphics.drawRect(0,0,class_4.var_11 - 148,16);
            _loc3_.graphics.endFill();
            _loc4_ = new fliplinead_progressbar_bg();
            _loc4_.x = 1;
            _loc4_.y = 1;
            _loc4_.width = class_4.var_11 - 150;
            _loc4_.height = 14;
            _loc3_.addChild(_loc4_);
            _loc3_.x = 9;
            _loc3_.y = class_4.var_13 - 29;
            _loc3_.name = "loading_bg";
            _loc5_ = new fliplinead_progressbar_bar();
            _loc5_.inside.width = class_4.var_11 - 150;
            _loc5_.x = 10;
            _loc5_.y = class_4.var_13 - 28;
            _loc5_.scaleX = 0;
            _loc5_.name = "loading_bar";
            class_4.var_1.addChild(_loc3_);
            class_4.var_1.addChild(_loc5_);
            class_4.var_1.addEventListener(Event.ENTER_FRAME,class_4.method_27);
         }
         if(param2 != null)
         {
            param2.addChild(class_4.var_1);
         }
      }
      
      private static function method_27(param1:Event) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = 0;
         if(class_4.loaderInfo != null)
         {
            _loc6_ = class_4.loaderInfo.bytesLoaded / class_4.loaderInfo.bytesTotal;
         }
         else
         {
            _loc6_ = 1;
         }
         if(!(Boolean(class_4.var_31) || Boolean(class_4.var_35)))
         {
            if(class_4.var_33 > -1)
            {
               _loc2_ = (getTimer() - class_4.var_33) / (class_4.var_46 * 1000);
               _loc6_ *= 0.6 + _loc2_ * 0.4;
            }
            else if(Boolean(class_4.var_26) && class_4.var_44 > -1)
            {
               _loc3_ = (getTimer() - class_4.var_44) / (class_4.var_56 * 1000);
               _loc6_ *= 0.3 + _loc3_ * 0.3;
            }
            else if(class_4.var_50 > -1)
            {
               _loc4_ = (getTimer() - class_4.var_50) / (class_4.var_67 * 1000);
               _loc6_ *= _loc4_ * 0.3;
            }
            else
            {
               class_4.method_1("Progress hasn\'t started");
               _loc6_ *= 0.1;
            }
         }
         _loc7_ = class_4.var_1.getChildByName("loading_bar");
         if(_loc7_ != null)
         {
            _loc5_ = _loc7_.scaleX;
            _loc7_.scaleX = Math.min(_loc7_.scaleX + 0.01,_loc6_);
            _loc7_.scaleX = Math.max(_loc5_,_loc7_.scaleX);
            if(_loc7_.scaleX >= 1)
            {
               _loc7_.scaleX = 1;
               if(class_4.var_35 == true)
               {
                  class_4.method_17();
               }
               class_4.var_1.removeEventListener(Event.ENTER_FRAME,class_4.method_27);
            }
         }
      }
      
      private static function method_17() : void
      {
         var _loc1_:MovieClip = null;
         if(class_4.var_1 != null && class_4.var_31 == false)
         {
            _loc1_ = class_4.var_1.getChildByName("continue_btn") as MovieClip;
            if(_loc1_ != null)
            {
               _loc1_.gotoAndPlay(2);
               _loc1_.mouseEnabled = true;
               _loc1_.mouseChildren = true;
               _loc1_.useHandCursor = true;
            }
            class_4.var_31 = true;
         }
      }
      
      private static function clickContinue(param1:MouseEvent = null) : void
      {
         if(class_4.var_34 != null)
         {
            class_4.var_34();
         }
         if(class_4.var_14 != null)
         {
            class_4.var_14.reset();
            class_4.var_14 = null;
         }
         class_4.method_26();
         class_4.var_34 = null;
      }
      
      private static function method_16(param1:MouseEvent = null) : void
      {
         if(class_4.var_37 != null)
         {
            navigateToURL(new URLRequest(class_4.var_37),"_blank");
         }
      }
      
      private static function method_22(param1:String) : void
      {
         var url:String = null;
         var type:String = param1;
         if(class_4.var_3 == class_4.const_1)
         {
            url = class_4.method_2("pre_image");
         }
         else if(class_4.var_3 == class_4.const_2)
         {
            url = class_4.method_2("int_image");
         }
         else if(class_4.var_3 == class_4.const_3)
         {
            url = class_4.method_2("alt_image");
         }
         if(url != null)
         {
            if(class_4.var_3 == class_4.const_1)
            {
               if(class_4.method_11(class_4.const_2,url))
               {
                  class_4.method_1("(re-use)");
                  class_4.method_3(class_4.var_9);
                  class_4.method_4(class_4.const_2);
                  return;
               }
               if(class_4.method_11(class_4.const_3,url))
               {
                  class_4.method_1("(re-use)");
                  class_4.method_3(class_4.var_7);
                  class_4.method_4(class_4.const_3);
                  return;
               }
            }
            else if(class_4.var_3 == class_4.const_2)
            {
               if(class_4.method_11(class_4.const_1,url))
               {
                  class_4.method_1("(re-use)");
                  class_4.method_3(class_4.var_8);
                  class_4.method_4(class_4.const_1);
                  return;
               }
               if(class_4.method_11(class_4.const_3,url))
               {
                  class_4.method_1("(re-use)");
                  class_4.method_3(class_4.var_7);
                  class_4.method_4(class_4.const_3);
                  return;
               }
            }
            else if(class_4.var_3 == class_4.const_3)
            {
               if(class_4.method_11(class_4.const_1,url))
               {
                  class_4.method_1("(re-use)");
                  class_4.method_3(class_4.var_8);
                  class_4.method_4(class_4.const_1);
                  return;
               }
               if(class_4.method_11(class_4.const_2,url))
               {
                  class_4.method_1("(re-use)");
                  class_4.method_3(class_4.var_9);
                  class_4.method_4(class_4.const_2);
                  return;
               }
            }
            class_4.var_44 = getTimer();
            if(type == class_4.const_1)
            {
               class_4.var_8 = new Loader();
               class_4.method_3(class_4.var_8);
               class_4.var_8.contentLoaderInfo.addEventListener(Event.INIT,class_4.method_23);
               class_4.var_8.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_21);
               try
               {
                  class_4.var_8.load(new URLRequest(url));
               }
               catch(err:Error)
               {
                  class_4.error("Error loading preroll content: " + err.message);
                  class_4.method_7();
                  return;
               }
            }
            else if(type == class_4.const_2)
            {
               class_4.var_9 = new Loader();
               class_4.method_3(class_4.var_9);
               class_4.var_9.contentLoaderInfo.addEventListener(Event.INIT,class_4.method_23);
               class_4.var_9.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_21);
               try
               {
                  class_4.var_9.load(new URLRequest(url));
               }
               catch(err:Error)
               {
                  class_4.error("Error loading inter content: " + err.message);
                  class_4.method_7();
                  return;
               }
            }
            else if(type == class_4.const_3)
            {
               class_4.var_7 = new Loader();
               class_4.method_3(class_4.var_7);
               class_4.var_7.contentLoaderInfo.addEventListener(Event.INIT,class_4.method_23);
               class_4.var_7.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_21);
               try
               {
                  class_4.var_7.load(new URLRequest(url));
               }
               catch(err:Error)
               {
                  class_4.error("Error loading inter alt content: " + err.message);
                  class_4.method_7();
                  return;
               }
            }
            if(class_4.var_25 == null)
            {
               class_4.var_25 = new Timer(class_4.var_56 * 1000,1);
               class_4.var_25.addEventListener(TimerEvent.TIMER,class_4.method_51);
            }
            else
            {
               class_4.var_25.reset();
            }
            class_4.var_25.start();
         }
         else
         {
            class_4.error("Loading Image URL was null");
            class_4.method_7();
         }
      }
      
      private static function method_7() : void
      {
         var holder:MovieClip;
         class_4.method_10();
         try
         {
            class_4.method_48();
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up failed ads: " + err.message);
         }
         holder = class_4.var_1.getChildByName("holder") as MovieClip;
         if(holder != null)
         {
            if(class_4.var_3 == class_4.const_1)
            {
               class_4.method_1("Attach Default Preroll");
               if(class_4.var_24 == null)
               {
                  class_4.var_24 = new failsafe_ad_preroll();
               }
               if(holder.contains(class_4.var_24) == false)
               {
                  holder.addChild(class_4.var_24);
               }
            }
            else
            {
               if(class_4.var_30 == true && class_4.var_26 == false)
               {
                  if(class_4.var_29 == 0)
                  {
                     class_4.var_3 = class_4.const_2;
                     class_4.var_29 = 1;
                  }
                  else
                  {
                     class_4.var_3 = class_4.const_3;
                     class_4.var_29 = 0;
                  }
               }
               if(class_4.var_3 == class_4.const_2)
               {
                  class_4.method_1("Attach Default Interstitial");
                  if(class_4.var_23 == null)
                  {
                     class_4.var_23 = new failsafe_ad_interstitial();
                  }
                  if(holder.contains(class_4.var_23) == false)
                  {
                     holder.addChild(class_4.var_23);
                  }
               }
               else if(class_4.var_3 == class_4.const_3)
               {
                  class_4.method_1("Attach Default Alternate Interstitial");
                  if(class_4.var_22 == null)
                  {
                     class_4.var_22 = new failsafe_ad_alt_interstitial();
                  }
                  if(holder.contains(class_4.var_22) == false)
                  {
                     holder.addChild(class_4.var_22);
                  }
               }
            }
         }
         class_4.method_4(class_4.var_3,true);
      }
      
      private static function method_3(param1:Loader) : void
      {
         var _loc2_:DisplayObject = class_4.var_1.getChildByName("holder");
         if(_loc2_ != null)
         {
            MovieClip(_loc2_).addChild(param1);
         }
      }
      
      private static function method_2(param1:String) : String
      {
         var _loc2_:String = null;
         if(class_4.data != null && Boolean(class_4.data.hasOwnProperty(param1)))
         {
            _loc2_ = class_4.data[param1];
         }
         return _loc2_;
      }
      
      private static function method_11(param1:String, param2:String) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 == class_4.const_1)
         {
            if(Boolean(class_4.data != null && class_4.data.hasOwnProperty("pre_image")) && Boolean(class_4.data.pre_image == param2) && class_4.var_8 != null)
            {
               _loc3_ = true;
            }
         }
         else if(param1 == class_4.const_2)
         {
            if(Boolean(class_4.data != null && class_4.data.hasOwnProperty("int_image")) && Boolean(class_4.data.int_image == param2) && class_4.var_9 != null)
            {
               _loc3_ = true;
            }
         }
         else if(param1 == class_4.const_3)
         {
            if(Boolean(class_4.data != null && class_4.data.hasOwnProperty("alt_image")) && Boolean(class_4.data.alt_image == param2) && class_4.var_7 != null)
            {
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      private static function method_23(param1:Event) : void
      {
         var dimensions:String = null;
         var useWidth:Number = Number(NaN);
         var useHeight:Number = Number(NaN);
         var loader:Loader = null;
         var split:Array = null;
         var targetHeight:Number = Number(NaN);
         var loadedHeight:Number = Number(NaN);
         var downscale:Number = Number(NaN);
         var diff:Number = Number(NaN);
         var newwidth:Number = Number(NaN);
         var targetWidth:Number = Number(NaN);
         var downscalew:Number = Number(NaN);
         var e:Event = param1;
         class_4.method_1("Image Loaded");
         if(class_4.var_25 != null)
         {
            class_4.var_25.reset();
         }
         try
         {
            if(e.target.content is Bitmap)
            {
               Bitmap(e.target.content).smoothing = true;
            }
         }
         catch(err:Error)
         {
         }
         try
         {
            dimensions = null;
            useWidth = -1;
            useHeight = -1;
            if(class_4.var_3 == class_4.const_1)
            {
               dimensions = class_4.method_2("pre_dim");
               loader = class_4.var_8;
            }
            else if(class_4.var_3 == class_4.const_2)
            {
               dimensions = class_4.method_2("int_dim");
               loader = class_4.var_9;
            }
            else if(class_4.var_3 == class_4.const_3)
            {
               dimensions = class_4.method_2("alt_dim");
               loader = class_4.var_7;
            }
            if(dimensions != null)
            {
               split = dimensions.split("x");
               if(split.length == 2)
               {
                  useWidth = Number(split[0]);
                  useHeight = Number(split[1]);
               }
            }
            if(isNaN(useWidth) == false && useWidth != -1 && isNaN(useHeight) == false && useHeight != -1)
            {
               targetHeight = class_4.var_13 - class_4.var_42;
               loadedHeight = useHeight - class_4.var_42;
               downscale = targetHeight / loadedHeight;
               if(useWidth * downscale > class_4.var_11)
               {
                  newwidth = useWidth * downscale;
                  targetWidth = Number(class_4.var_11);
                  downscalew = targetWidth / newwidth;
                  downscale *= downscalew;
               }
               loader.scaleX = downscale;
               loader.scaleY = downscale;
               diff = class_4.var_11 - useWidth * downscale;
               loader.x = diff / 2;
               class_4.method_1("Loaded Ad " + dimensions + ". Need to fit " + class_4.var_11 + "x" + class_4.var_13 + ". Downscale to " + downscale * 100 + "%");
            }
            else
            {
               class_4.method_1("Did not get ad dimensions. Use as-is.");
            }
         }
         catch(err:Error)
         {
            class_4.error("Error scaling loaded content: " + err.message);
         }
         class_4.method_4(class_4.var_3);
      }
      
      private static function method_21(param1:IOErrorEvent) : void
      {
         class_4.error("Load Image IO Error: " + param1.text);
         if(class_4.var_25 != null)
         {
            class_4.var_25.reset();
         }
         class_4.method_7();
      }
      
      private static function method_51(param1:TimerEvent) : void
      {
         var e:TimerEvent = param1;
         class_4.error("Load Image Timeout");
         try
         {
            if(class_4.var_3 == class_4.const_1)
            {
               if(class_4.var_8 != null)
               {
                  class_4.var_8.close();
               }
            }
            else if(class_4.var_3 == class_4.const_2)
            {
               if(class_4.var_9 != null)
               {
                  class_4.var_9.close();
               }
            }
            else if(class_4.var_3 == class_4.const_3)
            {
               if(class_4.var_7 != null)
               {
                  class_4.var_7.close();
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error Closing Loader for Timeout: " + err.message);
         }
         try
         {
            if(class_4.var_3 == class_4.const_1)
            {
               if(class_4.var_8 != null && class_4.var_8.parent != null)
               {
                  class_4.var_8.parent.removeChild(class_4.var_8);
               }
            }
            else if(class_4.var_3 == class_4.const_2)
            {
               if(class_4.var_9 != null && class_4.var_9.parent != null)
               {
                  class_4.var_9.parent.removeChild(class_4.var_9);
               }
            }
            else if(class_4.var_3 == class_4.const_3)
            {
               if(class_4.var_7 != null && class_4.var_7.parent != null)
               {
                  class_4.var_7.parent.removeChild(class_4.var_7);
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error Removing Loader for Timeout: " + err.message);
         }
         class_4.method_7();
      }
      
      private static function method_48() : void
      {
         if(class_4.var_3 == class_4.const_1)
         {
            if(class_4.var_8 != null && class_4.var_8.parent != null)
            {
               class_4.var_8.parent.removeChild(class_4.var_8);
            }
            class_4.var_8 = null;
         }
         else if(class_4.var_3 == class_4.const_2)
         {
            if(class_4.var_9 != null && class_4.var_9.parent != null)
            {
               class_4.var_9.parent.removeChild(class_4.var_9);
            }
            class_4.var_9 = null;
         }
         else if(class_4.var_3 == class_4.const_3)
         {
            if(class_4.var_7 != null && class_4.var_7.parent != null)
            {
               class_4.var_7.parent.removeChild(class_4.var_7);
            }
            class_4.var_7 = null;
         }
      }
      
      private static function method_4(param1:String, param2:Boolean = false) : void
      {
         var whichLoader:Loader = null;
         var holder:MovieClip = null;
         var loaderType:String = param1;
         var failsafe:Boolean = param2;
         class_4.method_1("Image Displayed");
         class_4.var_40 = true;
         if(!failsafe)
         {
            whichLoader = null;
            if(loaderType == class_4.const_1)
            {
               whichLoader = class_4.var_8;
            }
            else if(loaderType == class_4.const_2)
            {
               whichLoader = class_4.var_9;
            }
            else if(loaderType == class_4.const_3)
            {
               whichLoader = class_4.var_7;
            }
            if(whichLoader != null && whichLoader.parent != null)
            {
               holder = class_4.var_1.getChildByName("holder") as MovieClip;
               if(holder != null)
               {
                  holder.buttonMode = false;
                  holder.useHandCursor = false;
                  if(class_4.var_3 == class_4.const_1)
                  {
                     if(class_4.method_2("pre_uselink") == "true" && class_4.method_2("pre_link") != null && class_4.method_2("pre_link") != "")
                     {
                        class_4.var_37 = class_4.method_2("pre_link");
                        if(holder.hasEventListener(MouseEvent.MOUSE_DOWN) == false)
                        {
                           holder.addEventListener(MouseEvent.MOUSE_DOWN,class_4.method_16);
                           holder.buttonMode = true;
                           holder.useHandCursor = true;
                        }
                     }
                  }
                  else if(class_4.var_3 == class_4.const_2)
                  {
                     if(class_4.method_2("int_uselink") == "true" && class_4.method_2("int_link") != null && class_4.method_2("int_link") != "")
                     {
                        class_4.var_37 = class_4.method_2("int_link");
                        if(holder.hasEventListener(MouseEvent.MOUSE_DOWN) == false)
                        {
                           holder.addEventListener(MouseEvent.MOUSE_DOWN,class_4.method_16);
                           holder.buttonMode = true;
                           holder.useHandCursor = true;
                        }
                     }
                  }
                  else if(class_4.var_3 == class_4.const_3)
                  {
                     if(class_4.method_2("alt_uselink") == "true" && class_4.method_2("alt_link") != null && class_4.method_2("alt_link") != "")
                     {
                        class_4.var_37 = class_4.method_2("alt_link");
                        if(holder.hasEventListener(MouseEvent.MOUSE_DOWN) == false)
                        {
                           holder.addEventListener(MouseEvent.MOUSE_DOWN,class_4.method_16);
                           holder.buttonMode = true;
                           holder.useHandCursor = true;
                        }
                     }
                  }
               }
            }
            else if(whichLoader != null && whichLoader.parent == null)
            {
               class_4.method_1("Content was loaded, but it already timed out and removed it. don\'t do anything here.");
            }
         }
         try
         {
            if(class_4.var_1 != null && class_4.var_1.parent != null)
            {
               class_4.method_31(class_4.var_3);
            }
         }
         catch(err:Error)
         {
            class_4.error("There was an error determining if ad was on screen.  Show the controls anyway.");
            class_4.method_31(class_4.var_3);
         }
      }
      
      private static function method_39(param1:String) : void
      {
         var _loc2_:Number = Number(NaN);
         class_4.method_1("Prepare for Continue - " + param1);
         if(class_4.var_14 != null)
         {
            class_4.var_14.reset();
            class_4.var_14.removeEventListener(TimerEvent.TIMER,class_4.method_37);
            class_4.var_14 = null;
         }
         if(class_4.var_14 == null)
         {
            _loc2_ = Number(class_4.var_46);
            if(param1 == class_4.const_2)
            {
               _loc2_ = Number(class_4.var_69);
            }
            else if(param1 == class_4.const_3)
            {
               _loc2_ = Number(class_4.var_74);
            }
            class_4.var_14 = new Timer(_loc2_ * 1000,1);
            class_4.var_14.addEventListener(TimerEvent.TIMER,class_4.method_37);
         }
         else
         {
            class_4.var_14.reset();
         }
         class_4.var_14.start();
         if(class_4.var_33 == -1)
         {
            class_4.var_33 = getTimer();
         }
      }
      
      private static function method_37(param1:TimerEvent) : void
      {
         class_4.method_1("Ad done, ready to Continue");
         if(class_4.var_14 != null)
         {
            class_4.var_14.reset();
            class_4.var_14 = null;
         }
         if(class_4.var_3 == class_4.const_1 && class_4.var_1 != null && class_4.var_31 == false)
         {
            if(class_4.var_1.getChildByName("loading_bar") != null)
            {
               if(class_4.var_1.getChildByName("loading_bar").scaleX >= 1)
               {
                  class_4.method_17();
               }
               else
               {
                  class_4.var_35 = true;
                  class_4.method_39(class_4.var_3);
               }
            }
            else
            {
               class_4.method_17();
            }
         }
         else if(class_4.var_3 != class_4.const_1)
         {
            class_4.method_17();
         }
      }
      
      private static function method_31(param1:String) : void
      {
         class_4.method_1("Reset Controls");
         class_4.method_39(param1);
         var _loc2_:MovieClip = class_4.var_1.getChildByName("spinner") as MovieClip;
         if(_loc2_ != null)
         {
            try
            {
               _loc2_.btn.removeEventListener(MouseEvent.MOUSE_DOWN,class_4.method_33);
            }
            catch(err:Error)
            {
            }
            class_4.var_1.removeChild(_loc2_);
            _loc2_ = null;
         }
         var _loc3_:MovieClip = class_4.var_1.getChildByName("fader") as MovieClip;
         if(_loc3_ != null)
         {
            _loc3_.gotoAndPlay(2);
         }
         else
         {
            class_4.error("Couldn\'t find fader to fade the ad in.");
         }
      }
      
      private static function method_33(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.flipline.com?utm_source=spinner&utm_medium=spinnerlogo&utm_campaign=" + class_4.gameSKU),"_blank");
      }
      
      public static function method_97(param1:String, param2:MovieClip, param3:Number, param4:Number, param5:Number = 1) : void
      {
         var usex:String;
         var usey:String;
         var usescale:String;
         var type:String = param1;
         var container:MovieClip = param2;
         var x:Number = param3;
         var y:Number = param4;
         var scale:Number = param5;
         class_4.method_1("Show Promo Button - " + type + " at " + x + ", " + y + ", " + scale);
         usex = null;
         usey = null;
         usescale = null;
         if(type == class_4.const_5)
         {
            if(class_4.var_2 == null)
            {
               class_4.method_6(class_4.const_5);
            }
            if(class_4.var_2 != null)
            {
               if(Boolean(class_4.var_63 == null) && Boolean(class_4.data) && Boolean(class_4.data.hasOwnProperty("new_usex")))
               {
                  usex = class_4.method_2("new_usex");
                  usey = class_4.method_2("new_usey");
                  usescale = class_4.method_2("new_usescale");
                  if(usex != null && usey != null && usescale != null)
                  {
                     class_4.var_2.x = Number(usex);
                     class_4.var_2.y = Number(usey);
                     class_4.var_2.scaleX = Number(usescale);
                     class_4.var_2.scaleY = Number(usescale);
                  }
                  else
                  {
                     class_4.var_2.x = x;
                     class_4.var_2.y = y;
                     class_4.var_2.scaleX = scale;
                     class_4.var_2.scaleY = scale;
                  }
               }
               else
               {
                  class_4.var_2.x = x;
                  class_4.var_2.y = y;
                  class_4.var_2.scaleX = scale;
                  class_4.var_2.scaleY = scale;
               }
               if(!container.contains(class_4.var_2))
               {
                  container.addChild(class_4.var_2);
               }
               class_4.var_2.gotoAndPlay(1);
               try
               {
                  if(class_4.var_2.getChildByName("nocontainerclip") != null)
                  {
                     MovieClip(Loader(class_4.var_2.getChildByName("nocontainerclip")).content).gotoAndPlay(1);
                  }
               }
               catch(err:Error)
               {
                  class_4.error("Error playing a no-container clip: " + err.message);
               }
            }
         }
         else if(type == class_4.const_4)
         {
            if(class_4.var_4 == null)
            {
               class_4.method_6(class_4.const_4);
            }
            if(class_4.var_4 != null)
            {
               if(Boolean(class_4.var_75 == null) && Boolean(class_4.data) && Boolean(class_4.data.hasOwnProperty("promo1_usex")))
               {
                  usex = class_4.method_2("promo1_usex");
                  usey = class_4.method_2("promo1_usey");
                  usescale = class_4.method_2("promo1_usescale");
                  if(usex != null && usey != null && usescale != null)
                  {
                     class_4.var_4.x = Number(usex);
                     class_4.var_4.y = Number(usey);
                     class_4.var_4.scaleX = Number(usescale);
                     class_4.var_4.scaleY = Number(usescale);
                  }
                  else
                  {
                     class_4.var_4.x = x;
                     class_4.var_4.y = y;
                     class_4.var_4.scaleX = scale;
                     class_4.var_4.scaleY = scale;
                  }
               }
               else
               {
                  class_4.var_4.x = x;
                  class_4.var_4.y = y;
                  class_4.var_4.scaleX = scale;
                  class_4.var_4.scaleY = scale;
               }
               if(!container.contains(class_4.var_4))
               {
                  container.addChild(class_4.var_4);
               }
               class_4.var_4.gotoAndPlay(1);
               try
               {
                  if(class_4.var_4.getChildByName("nocontainerclip") != null)
                  {
                     MovieClip(Loader(class_4.var_4.getChildByName("nocontainerclip")).content).gotoAndPlay(1);
                  }
               }
               catch(err:Error)
               {
                  class_4.error("Error playing a no-container clip: " + err.message);
               }
            }
         }
         else if(type == class_4.const_6)
         {
            if(class_4.var_5 == null)
            {
               class_4.method_6(class_4.const_6);
            }
            if(class_4.var_5 != null)
            {
               if(Boolean(class_4.var_70 == null) && Boolean(class_4.data) && Boolean(class_4.data.hasOwnProperty("promo2_usex")))
               {
                  usex = class_4.method_2("promo2_usex");
                  usey = class_4.method_2("promo2_usey");
                  usescale = class_4.method_2("promo2_usescale");
                  if(usex != null && usey != null && usescale != null)
                  {
                     class_4.var_5.x = Number(usex);
                     class_4.var_5.y = Number(usey);
                     class_4.var_5.scaleX = Number(usescale);
                     class_4.var_5.scaleY = Number(usescale);
                  }
                  else
                  {
                     class_4.var_5.x = x;
                     class_4.var_5.y = y;
                     class_4.var_5.scaleX = scale;
                     class_4.var_5.scaleY = scale;
                  }
               }
               else
               {
                  class_4.var_5.x = x;
                  class_4.var_5.y = y;
                  class_4.var_5.scaleX = scale;
                  class_4.var_5.scaleY = scale;
               }
               if(!container.contains(class_4.var_5))
               {
                  container.addChild(class_4.var_5);
               }
               class_4.var_5.gotoAndPlay(1);
               try
               {
                  if(class_4.var_5.getChildByName("nocontainerclip") != null)
                  {
                     MovieClip(Loader(class_4.var_5.getChildByName("nocontainerclip")).content).gotoAndPlay(1);
                  }
               }
               catch(err:Error)
               {
                  class_4.error("Error playing a no-container clip: " + err.message);
               }
            }
         }
      }
      
      public static function method_82() : void
      {
         try
         {
            if(class_4.var_2 != null && class_4.var_2.parent != null)
            {
               class_4.var_2.parent.removeChild(class_4.var_2);
            }
         }
         catch(err:Error)
         {
            class_4.error("Error removing newgame promo: " + err.message);
         }
         try
         {
            if(class_4.var_4 != null && class_4.var_4.parent != null)
            {
               class_4.var_4.parent.removeChild(class_4.var_4);
            }
         }
         catch(err:Error)
         {
            class_4.error("Error removing promo1 promo: " + err.message);
         }
         try
         {
            if(class_4.var_5 != null && class_4.var_5.parent != null)
            {
               class_4.var_5.parent.removeChild(class_4.var_5);
            }
         }
         catch(err:Error)
         {
            class_4.error("Error removing promo2 promo: " + err.message);
         }
      }
      
      public static function method_43() : void
      {
         if(class_4.var_30 == false)
         {
            class_4.loadData(class_4.method_43);
         }
         else if(class_4.var_57 == false)
         {
            class_4.method_1("Load Promo Images");
            class_4.var_6 = class_4.const_5;
            class_4.method_30(class_4.var_6);
         }
      }
      
      private static function method_58(param1:String) : void
      {
         var type:String = param1;
         try
         {
            if(type == class_4.const_5)
            {
               if(class_4.var_16 != null)
               {
                  class_4.var_16.close();
               }
            }
            else if(type == class_4.const_4)
            {
               if(class_4.var_17 != null)
               {
                  class_4.var_17.close();
               }
            }
            else if(type == class_4.const_6)
            {
               if(class_4.var_18 != null)
               {
                  class_4.var_18.close();
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error cleaning up failed promo image: " + err.message);
         }
      }
      
      private static function method_30(param1:String) : void
      {
         var url:String = null;
         var type:String = param1;
         if(class_4.var_6 == class_4.const_5)
         {
            url = class_4.method_2("new_image");
         }
         else if(class_4.var_6 == class_4.const_4)
         {
            url = class_4.method_2("promo1_image");
         }
         else if(class_4.var_6 == class_4.const_6)
         {
            url = class_4.method_2("promo2_image");
         }
         if(url != null)
         {
            class_4.method_1("Load Promo Image - " + type);
            if(type == class_4.const_5)
            {
               class_4.var_16 = new Loader();
               class_4.var_16.contentLoaderInfo.addEventListener(Event.INIT,class_4.method_19);
               class_4.var_16.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_29);
               try
               {
                  class_4.var_16.load(new URLRequest(url));
               }
               catch(err:Error)
               {
                  class_4.error("Error loading newgame image: " + err.message);
                  class_4.method_6(class_4.var_6);
                  class_4.method_9();
                  return;
               }
            }
            else if(type == class_4.const_4)
            {
               class_4.var_17 = new Loader();
               class_4.var_17.contentLoaderInfo.addEventListener(Event.INIT,class_4.method_19);
               class_4.var_17.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_29);
               try
               {
                  class_4.var_17.load(new URLRequest(url));
               }
               catch(err:Error)
               {
                  class_4.error("Error loading promo1 image: " + err.message);
                  class_4.method_6(class_4.var_6);
                  class_4.method_9();
                  return;
               }
            }
            else if(type == class_4.const_6)
            {
               class_4.var_18 = new Loader();
               class_4.var_18.contentLoaderInfo.addEventListener(Event.INIT,class_4.method_19);
               class_4.var_18.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,class_4.method_29);
               try
               {
                  class_4.var_18.load(new URLRequest(url));
               }
               catch(err:Error)
               {
                  class_4.error("Error loading promo 2 image: " + err.message);
                  class_4.method_6(class_4.var_6);
                  class_4.method_9();
                  return;
               }
            }
            if(class_4.var_19 == null)
            {
               class_4.var_19 = new Timer(class_4.var_68 * 1000,1);
               class_4.var_19.addEventListener(TimerEvent.TIMER,class_4.method_46);
            }
            else
            {
               class_4.var_19.reset();
            }
            class_4.var_19.start();
         }
         else
         {
            class_4.error("Promo URL was null.");
            class_4.method_6(class_4.var_6);
            class_4.method_9();
         }
      }
      
      private static function method_9() : void
      {
         class_4.method_1("Load Next Image");
         if(class_4.var_57 == false)
         {
            if(class_4.var_6 == class_4.const_5)
            {
               class_4.var_6 = class_4.const_4;
               class_4.method_30(class_4.const_4);
            }
            else if(class_4.var_6 == class_4.const_4)
            {
               class_4.var_6 = class_4.const_6;
               class_4.method_30(class_4.const_6);
            }
            else
            {
               class_4.method_1("Promos Finished Loading.");
               class_4.var_57 = true;
            }
         }
      }
      
      private static function method_6(param1:String) : void
      {
         var url1:String = null;
         var url2:String = null;
         var url3:String = null;
         var img1:MovieClip = null;
         url1 = null;
         var img2:MovieClip = null;
         url2 = null;
         var img3:MovieClip = null;
         url3 = null;
         var type:String = param1;
         class_4.method_1("Create Default Promo: " + type);
         class_4.method_10();
         class_4.method_58(type);
         if(type == class_4.const_5 && class_4.var_2 == null)
         {
            class_4.var_2 = new fliplinead_promobutton_clip();
            class_4.var_63 = class_4.var_2;
            img1 = new failsafe_promo_newgame();
            class_4.var_2.inside.holder.addChild(img1);
            url1 = class_4.var_72;
            if(url1 != null && url1 != "")
            {
               class_4.var_2.inside.btn.addEventListener(MouseEvent.MOUSE_DOWN,function f7(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest(url1),"_blank");
               });
            }
         }
         else if(type == class_4.const_4 && class_4.var_4 == null)
         {
            class_4.var_4 = new fliplinead_promobutton_clip();
            class_4.var_75 = class_4.var_4;
            img2 = new failsafe_promo_promo1();
            class_4.var_4.inside.holder.addChild(img2);
            url2 = class_4.var_73;
            if(url2 != null && url2 != "")
            {
               class_4.var_4.inside.btn.addEventListener(MouseEvent.MOUSE_DOWN,function f8(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest(url2),"_blank");
               });
            }
         }
         else if(type == class_4.const_6 && class_4.var_5 == null)
         {
            class_4.var_5 = new fliplinead_promobutton_clip();
            class_4.var_70 = class_4.var_5;
            img3 = new failsafe_promo_promo2();
            class_4.var_5.inside.holder.addChild(img3);
            url3 = class_4.var_77;
            if(url3 != null && url3 != "")
            {
               class_4.var_5.inside.btn.addEventListener(MouseEvent.MOUSE_DOWN,function f9(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest(url3),"_blank");
               });
            }
         }
      }
      
      private static function method_19(param1:Event) : void
      {
         var useContainer:String;
         var useLink:String;
         var linkURL:String = null;
         linkURL = null;
         var e:Event = param1;
         class_4.method_1("Promo Image Loaded - " + class_4.var_6);
         if(class_4.var_19 != null)
         {
            class_4.var_19.reset();
         }
         useContainer = null;
         useLink = null;
         linkURL = null;
         if(class_4.var_6 == class_4.const_5)
         {
            useContainer = class_4.method_2("new_usecont");
            useLink = class_4.method_2("new_uselink");
            linkURL = class_4.method_2("new_link");
         }
         else if(class_4.var_6 == class_4.const_4)
         {
            useContainer = class_4.method_2("promo1_usecont");
            useLink = class_4.method_2("promo1_uselink");
            linkURL = class_4.method_2("promo1_link");
         }
         else if(class_4.var_6 == class_4.const_6)
         {
            useContainer = class_4.method_2("promo2_usecont");
            useLink = class_4.method_2("promo2_uselink");
            linkURL = class_4.method_2("promo2_link");
         }
         if(useContainer == "false")
         {
            if(class_4.var_6 == class_4.const_5 && class_4.var_2 == null)
            {
               class_4.var_2 = new MovieClip();
               class_4.var_2.addChild(class_4.var_16);
               class_4.var_16.name = "nocontainerclip";
               if(useLink == "true" && linkURL != "" && linkURL != null)
               {
                  class_4.var_2.addEventListener(MouseEvent.MOUSE_DOWN,function f1(param1:MouseEvent = null):void
                  {
                     navigateToURL(new URLRequest(linkURL),"_blank");
                  });
                  class_4.var_2.buttonMode = true;
                  class_4.var_2.useHandCursor = true;
               }
            }
            else if(class_4.var_6 == class_4.const_4 && class_4.var_4 == null)
            {
               class_4.var_4 = new MovieClip();
               class_4.var_4.addChild(class_4.var_17);
               class_4.var_17.name = "nocontainerclip";
               if(useLink == "true" && linkURL != "" && linkURL != null)
               {
                  class_4.var_4.addEventListener(MouseEvent.MOUSE_DOWN,function f2(param1:MouseEvent = null):void
                  {
                     navigateToURL(new URLRequest(linkURL),"_blank");
                  });
                  class_4.var_4.buttonMode = true;
                  class_4.var_4.useHandCursor = true;
               }
            }
            else if(class_4.var_6 == class_4.const_6 && class_4.var_5 == null)
            {
               class_4.var_5 = new MovieClip();
               class_4.var_5.addChild(class_4.var_18);
               class_4.var_18.name = "nocontainerclip";
               if(useLink == "true" && linkURL != "" && linkURL != null)
               {
                  class_4.var_5.addEventListener(MouseEvent.MOUSE_DOWN,function f3(param1:MouseEvent = null):void
                  {
                     navigateToURL(new URLRequest(linkURL),"_blank");
                  });
                  class_4.var_5.buttonMode = true;
                  class_4.var_5.useHandCursor = true;
               }
            }
         }
         else if(class_4.var_6 == class_4.const_5 && class_4.var_2 == null)
         {
            class_4.var_2 = new fliplinead_promobutton_clip();
            class_4.var_2.inside.holder.addChild(class_4.var_16);
            if(useLink == "true" && linkURL != "" && linkURL != null)
            {
               class_4.var_2.inside.btn.addEventListener(MouseEvent.MOUSE_DOWN,function f4(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest(linkURL),"_blank");
               });
            }
            else
            {
               class_4.var_2.inside.btn.mouseEnabled = false;
            }
            try
            {
               if(class_4.var_16.content is Bitmap)
               {
                  Bitmap(class_4.var_16.content).smoothing = true;
               }
            }
            catch(err:Error)
            {
               class_4.error("Error smoothing newgame content: " + err.message);
            }
         }
         else if(class_4.var_6 == class_4.const_4 && class_4.var_4 == null)
         {
            class_4.var_4 = new fliplinead_promobutton_clip();
            class_4.var_4.inside.holder.addChild(class_4.var_17);
            if(useLink == "true" && linkURL != "" && linkURL != null)
            {
               class_4.var_4.inside.btn.addEventListener(MouseEvent.MOUSE_DOWN,function f5(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest(linkURL),"_blank");
               });
            }
            else
            {
               class_4.var_4.inside.btn.mouseEnabled = false;
            }
            try
            {
               if(class_4.var_17.content is Bitmap)
               {
                  Bitmap(class_4.var_17.content).smoothing = true;
               }
            }
            catch(err:Error)
            {
               class_4.error("Error smoothing promo1 content: " + err.message);
            }
         }
         else if(class_4.var_6 == class_4.const_6 && class_4.var_5 == null)
         {
            class_4.var_5 = new fliplinead_promobutton_clip();
            class_4.var_5.inside.holder.addChild(class_4.var_18);
            if(useLink == "true" && linkURL != "" && linkURL != null)
            {
               class_4.var_5.inside.btn.addEventListener(MouseEvent.MOUSE_DOWN,function f6(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest(linkURL),"_blank");
               });
            }
            else
            {
               class_4.var_5.inside.btn.mouseEnabled = false;
            }
            try
            {
               if(class_4.var_18.content is Bitmap)
               {
                  Bitmap(class_4.var_18.content).smoothing = true;
               }
            }
            catch(err:Error)
            {
               class_4.error("Error smoothing promo2 content: " + err.message);
            }
         }
         class_4.method_9();
      }
      
      private static function method_29(param1:IOErrorEvent = null) : void
      {
         if(param1 != null)
         {
            class_4.error("Load Promo Image IO Error: " + param1.text);
         }
         if(class_4.var_19 != null)
         {
            class_4.var_19.reset();
         }
         class_4.method_6(class_4.var_6);
         class_4.method_9();
      }
      
      private static function method_46(param1:TimerEvent) : void
      {
         var e:TimerEvent = param1;
         class_4.error("Button Image Timeout - " + class_4.var_6);
         if(class_4.var_19 != null)
         {
            class_4.var_19.reset();
         }
         try
         {
            if(class_4.var_6 == class_4.const_5)
            {
               if(class_4.var_16 != null)
               {
                  class_4.var_16.close();
               }
            }
            else if(class_4.var_6 == class_4.const_4)
            {
               if(class_4.var_17 != null)
               {
                  class_4.var_17.close();
               }
            }
            else if(class_4.var_6 == class_4.const_6)
            {
               if(class_4.var_18 != null)
               {
                  class_4.var_18.close();
               }
            }
         }
         catch(err:Error)
         {
            class_4.error("Error Closing Loader for Button Timeout: " + err.message);
         }
         class_4.method_6(class_4.var_6);
         class_4.method_9();
      }
      
      public static function method_74(param1:MovieClip, param2:Number, param3:Number, param4:Number) : void
      {
         if(class_4.var_26 == true)
         {
            if(class_4.var_10 == null && class_4.var_38 != null && class_4.var_54 != null)
            {
               class_4.var_10 = new fliplinead_versionbox();
               class_4.var_10.version_txt.text = class_4.var_38;
               if(class_4.method_53(var_38,var_54))
               {
                  class_4.var_10.gotoAndStop(2);
                  class_4.var_10.update_btn.mouseEnabled = true;
               }
               else
               {
                  class_4.var_10.gotoAndStop(1);
                  class_4.var_10.update_btn.mouseEnabled = false;
               }
               class_4.var_10.update_btn.addEventListener(MouseEvent.MOUSE_DOWN,class_4.method_45);
            }
            if(class_4.var_10 != null)
            {
               param1.addChild(class_4.var_10);
               class_4.var_10.x = param2;
               class_4.var_10.y = param4;
               class_4.var_39 = param3;
               if(class_4.var_10.hasEventListener(Event.ENTER_FRAME) == false)
               {
                  class_4.var_10.addEventListener(Event.ENTER_FRAME,class_4.method_32);
               }
            }
         }
      }
      
      private static function method_32(param1:Event) : void
      {
         if(class_4.var_10.y != class_4.var_39)
         {
            class_4.var_10.y += (class_4.var_39 - class_4.var_10.y) / 4;
            if(Math.abs(class_4.var_39 - class_4.var_10.y) <= 1)
            {
               class_4.var_10.y = class_4.var_39;
            }
         }
      }
      
      private static function method_53(param1:String, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = param1.split(".");
         var _loc5_:Array = param2.split(".");
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc3_ == 0)
            {
               _loc6_ += Number(_loc4_[_loc3_]) * 1000000;
            }
            else if(_loc3_ == 1)
            {
               _loc6_ += Number(_loc4_[_loc3_]) * 1000;
            }
            else if(_loc3_ == 2)
            {
               _loc6_ += Number(_loc4_[_loc3_]);
            }
            else if(_loc3_ == 3)
            {
               _loc6_ += Number(_loc4_[_loc3_]) / 1000;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            if(_loc3_ == 0)
            {
               _loc7_ += Number(_loc5_[_loc3_]) * 1000000;
            }
            else if(_loc3_ == 1)
            {
               _loc7_ += Number(_loc5_[_loc3_]) * 1000;
            }
            else if(_loc3_ == 2)
            {
               _loc7_ += Number(_loc5_[_loc3_]);
            }
            else if(_loc3_ == 3)
            {
               _loc7_ += Number(_loc5_[_loc3_]) / 1000;
            }
            _loc3_++;
         }
         class_4.method_1("Current Version: " + _loc6_ + ", Latest Version: " + _loc7_);
         if(Boolean(isNaN(_loc6_)) || Boolean(isNaN(_loc7_)))
         {
            if(param1 != param2)
            {
               return true;
            }
            return false;
         }
         if(_loc7_ > _loc6_)
         {
            return true;
         }
         return false;
      }
      
      private static function method_45(param1:MouseEvent = null) : void
      {
         var e:MouseEvent = param1;
         class_4.method_1("Click Update");
         if(class_4.var_27 != null)
         {
            if(class_4.var_12 == null)
            {
               class_4.var_12 = new fliplinead_versionpopup();
               class_4.var_12.x = class_4.var_11 / 2;
               class_4.var_12.y = class_4.var_13 / 2;
               class_4.var_12.close_btn.addEventListener(MouseEvent.MOUSE_DOWN,class_4.method_36);
               class_4.var_12.link_btn.addEventListener(MouseEvent.MOUSE_DOWN,function func(param1:MouseEvent = null):void
               {
                  navigateToURL(new URLRequest("http://www.flipline.com/freegames.html"),"_blank");
               });
               class_4.var_12.graphics.beginFill(0,0.4);
               class_4.var_12.graphics.drawRect(0 - class_4.var_11 / 2,0 - class_4.var_13 / 2,class_4.var_11,class_4.var_13);
               class_4.var_12.graphics.endFill();
            }
            if(!class_4.var_27.contains(class_4.var_12))
            {
               class_4.var_27.addChild(class_4.var_12);
            }
         }
      }
      
      private static function method_36(param1:MouseEvent = null) : void
      {
         if(class_4.var_12 != null)
         {
            if(class_4.var_12.parent != null)
            {
               class_4.var_12.parent.removeChild(class_4.var_12);
            }
         }
      }
      
      public static function method_77() : void
      {
         if(class_4.var_10 != null)
         {
            if(class_4.var_10.parent != null)
            {
               class_4.var_10.parent.removeChild(class_4.var_10);
            }
            class_4.var_10.removeEventListener(Event.ENTER_FRAME,class_4.method_32);
         }
         class_4.method_36();
      }
      
      private static function method_1(param1:String) : void
      {
         trace(getTimer() + " [AS] " + param1);
      }
      
      private static function error(param1:String) : void
      {
         trace(getTimer() + " [AS] [ERROR] " + param1);
      }
      
      private static function method_12(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:Array = class_4.method_5(param1);
         try
         {
            _loc2_ = _loc3_[0];
         }
         catch(err:Error)
         {
         }
         return _loc2_;
      }
      
      private static function method_5(param1:String) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:String = "";
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:String = "";
         var _loc7_:Number = 0;
         var _loc8_:String = "";
         var _loc9_:int = 0;
         while(_loc9_ < param1.length)
         {
            if(_loc3_.length == 0 && _loc7_ == 0)
            {
               if(_loc4_ == 0)
               {
                  _loc4_ = Number(param1.charAt(_loc9_));
                  _loc5_ = _loc9_;
               }
               else if(_loc7_ == 0)
               {
                  if(_loc9_ <= _loc4_ + _loc5_)
                  {
                     _loc6_ += param1.charAt(_loc9_);
                     if(_loc9_ == _loc4_ + _loc5_)
                     {
                        _loc7_ = Number(_loc6_);
                     }
                  }
               }
            }
            else if(_loc9_ <= _loc5_ + _loc4_ + _loc7_ * 4)
            {
               _loc8_ = _loc8_ + param1.charAt(_loc9_);
               if(_loc8_.length == 4)
               {
                  _loc3_ += String.fromCharCode(Number(_loc8_) + 4);
                  _loc8_ = "";
               }
               if(_loc9_ == _loc5_ + _loc4_ + _loc7_ * 4)
               {
                  _loc2_.push(_loc3_);
                  _loc3_ = "";
                  _loc4_ = 0;
                  _loc5_ = 0;
                  _loc6_ = "";
                  _loc7_ = 0;
                  _loc8_ = "";
               }
            }
            _loc9_++;
         }
         return _loc2_;
      }
      
      private static function method_10(param1:Boolean = false) : void
      {
         if(class_4.var_20 == null)
         {
            class_4.var_20 = new fliplinead_failsafealert();
         }
         class_4.var_20.x = 0;
         class_4.var_20.y = class_4.var_13;
         if(class_4.var_27 != null)
         {
            if(!class_4.var_27.contains(class_4.var_20))
            {
               class_4.var_27.addChild(class_4.var_20);
            }
         }
         else if(class_4.var_32 != null)
         {
            if(!class_4.var_32.contains(class_4.var_20))
            {
               class_4.var_32.addChild(class_4.var_20);
            }
         }
         if(param1 || class_4.var_30 == true && class_4.var_26 == false)
         {
            class_4.var_20.gotoAndPlay(50);
         }
         else
         {
            class_4.var_20.gotoAndPlay(1);
         }
      }
   }
}

