package package_2
{
   import flash.system.*;
   import flash.utils.*;
   
   public class class_7
   {
      
      public static var var_245:Boolean = false;
      
      public static var var_226:Function = null;
      
      public static var var_188:Number = 99;
      
      public static const ALL:Number = 99;
      
      public static const const_17:Number = 5;
      
      public static const const_11:Number = 4;
      
      public static const const_9:Number = 3;
      
      public static const const_10:Number = 2;
      
      public static const const_7:Number = 1;
      
      public static const const_19:Number = 0;
      
      public static var var_240:Boolean = false;
      
      public function class_7()
      {
         super();
      }
      
      public static function debug(... rest) : void
      {
         if(class_7.var_188 >= class_7.const_11)
         {
            class_7.traceMessage(class_7.method_121() + rest);
         }
      }
      
      public static function method_1(... rest) : void
      {
         class_7.debug(rest);
      }
      
      public static function info(... rest) : void
      {
         if(class_7.var_188 >= class_7.const_9)
         {
            class_7.traceMessage(class_7.method_121() + rest);
         }
      }
      
      public static function warn(... rest) : void
      {
         if(class_7.var_188 >= class_7.const_10)
         {
            class_7.traceMessage(class_7.method_121() + rest);
         }
      }
      
      public static function error(... rest) : void
      {
         if(class_7.var_188 >= class_7.const_7)
         {
            class_7.traceMessage("3:" + class_7.method_121() + rest);
         }
      }
      
      public static function output(... rest) : void
      {
         if(class_7.var_188 >= class_7.const_17)
         {
            class_7.traceMessage(class_7.method_121() + rest);
         }
      }
      
      public static function method_285(param1:String, param2:Number = 99) : void
      {
         if(class_7.var_188 >= param2)
         {
            class_7.traceMessage(class_7.method_121() + param1);
         }
      }
      
      private static function traceMessage(... rest) : void
      {
         trace(rest);
         if(class_7.var_240 == true)
         {
            class_7.method_218(rest);
         }
      }
      
      private static function method_218(... rest) : void
      {
      }
      
      private static function method_121() : String
      {
         var _loc1_:String = "";
         if(class_7.var_245 == true)
         {
            _loc1_ += "[" + class_7.method_274() + "]   ";
         }
         if(class_7.var_226 != null)
         {
            _loc1_ += class_7.var_226();
         }
         return _loc1_;
      }
      
      private static function method_274() : String
      {
         var _loc1_:Number = Number(getTimer());
         var _loc2_:Number = Math.floor(_loc1_ / 1000);
         _loc1_ -= _loc2_ * 1000;
         var _loc3_:Number = Math.floor(_loc2_ / 60);
         _loc2_ -= _loc3_ * 60;
         var _loc4_:String = "";
         if(_loc3_ < 10)
         {
            _loc4_ += "0" + _loc3_ + ":";
         }
         else
         {
            _loc4_ += _loc3_ + ":";
         }
         if(_loc2_ < 10)
         {
            _loc4_ += "0" + _loc2_ + ":";
         }
         else
         {
            _loc4_ += _loc2_ + ":";
         }
         if(_loc1_ < 10)
         {
            _loc4_ += "00" + _loc1_;
         }
         else if(_loc1_ < 100)
         {
            _loc4_ += "0" + _loc1_;
         }
         else
         {
            _loc4_ += _loc1_;
         }
         return _loc4_;
      }
      
      public static function method_143(param1:Number, param2:Boolean = true) : void
      {
         class_7.var_188 = param1;
         class_7.var_245 = param2;
      }
      
      public static function method_240(param1:Function) : void
      {
         class_7.var_226 = param1;
      }
      
      public static function method_276() : void
      {
         class_7.var_240 = true;
         Security.allowDomain("*");
      }
   }
}

